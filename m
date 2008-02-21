From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] hash-object: cleanup handling of command line options
Date: Thu, 21 Feb 2008 10:06:47 +0000
Message-ID: <20080221100647.27841.qmail@2fb9ba03eba069.315fe32.mid.smarden.org>
References: <20080213190338.7393.qmail@d70c5cbe18d4bd.315fe32.mid.smarden.org> <7v7ih8pre6.fsf@gitster.siamese.dyndns.org> <20080213224941.18121.qmail@c0fdbb95c1b5f1.315fe32.mid.smarden.org> <7v8x1oo2w8.fsf@gitster.siamese.dyndns.org> <20080214201355.6021.qmail@6a68c4de06516f.315fe32.mid.smarden.org> <7vskzugm8x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 11:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS8KZ-0007V1-0G
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 11:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756994AbYBUKGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 05:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756786AbYBUKGa
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 05:06:30 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:32776 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756714AbYBUKG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 05:06:29 -0500
Received: (qmail 27848 invoked by uid 1000); 21 Feb 2008 10:06:47 -0000
Content-Disposition: inline
In-Reply-To: <7vskzugm8x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74610>

git hash-object used to process the --stdin command line argument
before reading subsequent arguments.  This caused 'git hash-object
--stdin -w' to fail to actually write the object into the
database, while '-w --stdin' properly did.  Now git hash-object
first reads all arguments, and then processes them.

This regresses one insane use case.  git hash-object used to allow
multiple --stdin arguments on the command line:

   $ git hash-object --stdin --stdin
     foo
     ^D
     bar
     ^D

Now git hash-object errors out if --stdin is given more than once.

Reported by Josh Triplett through
 http://bugs.debian.org/464432

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Fri, Feb 15, 2008 at 09:31:10AM -0800, Junio C Hamano wrote:
> Having said all that, I think "--stdin file2 <file1" behaviour
> can be kept without regressing by a patch like this on top of
> your fix, and we can drop the first "regression warning" in the
> commit log message if we did so.

Yes, this seems the better choice.  I adapted the commit message a bit,
and swapped file0 and file1 in the test description and the selftest
where appropriate, it's been mixed up.

Regards, Gerrit.


 hash-object.c          |   12 +++++++++++-
 t/t5303-hash-object.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletions(-)
 create mode 100755 t/t5303-hash-object.sh

diff --git a/hash-object.c b/hash-object.c
index 0a58f3f..61e7160 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -41,6 +41,7 @@ int main(int argc, char **argv)
 	const char *prefix = NULL;
 	int prefix_length = -1;
 	int no_more_flags = 0;
+	int hashstdin = 0;
 
 	git_config(git_default_config);
 
@@ -65,13 +66,20 @@ int main(int argc, char **argv)
 			else if (!strcmp(argv[i], "--help"))
 				usage(hash_object_usage);
 			else if (!strcmp(argv[i], "--stdin")) {
-				hash_stdin(type, write_object);
+				if (hashstdin)
+					die("Multiple --stdin arguments are not supported");
+				hashstdin = 1;
 			}
 			else
 				usage(hash_object_usage);
 		}
 		else {
 			const char *arg = argv[i];
+
+			if (hashstdin) {
+				hash_stdin(type, write_object);
+				hashstdin = 0;
+			}
 			if (0 <= prefix_length)
 				arg = prefix_filename(prefix, prefix_length,
 						      arg);
@@ -79,5 +87,7 @@ int main(int argc, char **argv)
 			no_more_flags = 1;
 		}
 	}
+	if (hashstdin)
+		hash_stdin(type, write_object);
 	return 0;
 }
diff --git a/t/t5303-hash-object.sh b/t/t5303-hash-object.sh
new file mode 100755
index 0000000..543c078
--- /dev/null
+++ b/t/t5303-hash-object.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description=git-hash-object
+
+. ./test-lib.sh
+
+test_expect_success \
+    'git hash-object -w --stdin saves the object' \
+    'obname=$(echo foo | git hash-object -w --stdin) &&
+    obpath=$(echo $obname | sed -e "s/\(..\)/\1\//") &&
+    test -r .git/objects/"$obpath" &&
+    rm -f .git/objects/"$obpath"'
+    
+test_expect_success \
+    'git hash-object --stdin -w saves the object' \
+    'obname=$(echo foo | git hash-object --stdin -w) &&
+    obpath=$(echo $obname | sed -e "s/\(..\)/\1\//") &&
+    test -r .git/objects/"$obpath" &&
+    rm -f .git/objects/"$obpath"'    
+
+test_expect_success \
+    'git hash-object --stdin file1 <file0 first operates on file0, then file1' \
+    'echo foo > file1 &&
+    obname0=$(echo bar | git hash-object --stdin) &&
+    obname1=$(git hash-object file1) &&
+    obname0new=$(echo bar | git hash-object --stdin file1 | sed -n -e 1p) &&
+    obname1new=$(echo bar | git hash-object --stdin file1 | sed -n -e 2p) &&
+    test "$obname0" = "$obname0new" &&
+    test "$obname1" = "$obname1new"'
+
+test_expect_success \
+    'git hash-object refuses multiple --stdin arguments' \
+    '! git hash-object --stdin --stdin < file1'
+
+test_done
-- 
1.5.4.2
