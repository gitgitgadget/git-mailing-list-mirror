From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] hash-object: cleanup handling of command line options
Date: Thu, 14 Feb 2008 20:13:55 +0000
Message-ID: <20080214201355.6021.qmail@6a68c4de06516f.315fe32.mid.smarden.org>
References: <20080213190338.7393.qmail@d70c5cbe18d4bd.315fe32.mid.smarden.org> <7v7ih8pre6.fsf@gitster.siamese.dyndns.org> <20080213224941.18121.qmail@c0fdbb95c1b5f1.315fe32.mid.smarden.org> <7v8x1oo2w8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 21:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPkTN-0007An-P3
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 21:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbYBNUNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbYBNUNj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 15:13:39 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:60716 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932296AbYBNUNh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 15:13:37 -0500
Received: (qmail 6022 invoked by uid 1000); 14 Feb 2008 20:13:55 -0000
Content-Disposition: inline
In-Reply-To: <7v8x1oo2w8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73912>

git hash-object used to process the --stdin command line argument
before reading subsequent arguments.  This caused 'git hash-object
--stdin -w' to fail to actually write the object into the
database, while '-w --stdin' properly did.  Now git hash-object
processes --stdin at the end, after all other arguments.

This regresses the use case of running:

   $ git hash-object --stdin Makefile <cache.h

to obtain hash values for cache.h and then Makefile.  It used to
report the object names in order, but now it always processes
--stdin at the end.  It is not an issue if everything is file
(i.e.  "git hash-object cache.h Makefile" is an easy replacement),
but if existing scripts used the option to read from a pipe, this
might become problematic.

Furthermore git hash-object used to allow multiple --stdin
arguments on the command line, supporting insane usage, such as

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
 hash-object.c          |    7 ++++++-
 t/t5303-hash-object.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletions(-)
 create mode 100755 t/t5303-hash-object.sh

diff --git a/hash-object.c b/hash-object.c
index 0a58f3f..67d9922 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -41,6 +41,7 @@ int main(int argc, char **argv)
 	const char *prefix = NULL;
 	int prefix_length = -1;
 	int no_more_flags = 0;
+	int hashstdin = 0;
 
 	git_config(git_default_config);
 
@@ -65,7 +66,9 @@ int main(int argc, char **argv)
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
@@ -79,5 +82,7 @@ int main(int argc, char **argv)
 			no_more_flags = 1;
 		}
 	}
+	if (hashstdin)
+		hash_stdin(type, write_object);
 	return 0;
 }
diff --git a/t/t5303-hash-object.sh b/t/t5303-hash-object.sh
new file mode 100755
index 0000000..14be455
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
+    'git hash-object --stdin file0 <file1 first operates on file0, then file1' \
+    'echo foo > file0 &&
+    obname0=$(git hash-object file0) &&
+    obname1=$(echo bar | git hash-object --stdin) &&
+    obname0new=$(echo bar | git hash-object --stdin file0 | sed -n -e 1p) &&
+    obname1new=$(echo bar | git hash-object --stdin file0 | sed -n -e 2p) &&
+    test "$obname0" = "$obname0new" &&
+    test "$obname1" = "$obname1new"'
+
+test_expect_success \
+    'git hash-object refuses multiple --stdin arguments' \
+    '! git hash-object --stdin --stdin < file0'
+
+test_done
-- 
1.5.4.1
