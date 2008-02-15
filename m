From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hash-object: cleanup handling of command line options
Date: Fri, 15 Feb 2008 09:31:10 -0800
Message-ID: <7vskzugm8x.fsf@gitster.siamese.dyndns.org>
References: <20080213190338.7393.qmail@d70c5cbe18d4bd.315fe32.mid.smarden.org>
 <7v7ih8pre6.fsf@gitster.siamese.dyndns.org>
 <20080213224941.18121.qmail@c0fdbb95c1b5f1.315fe32.mid.smarden.org>
 <7v8x1oo2w8.fsf@gitster.siamese.dyndns.org>
 <20080214201355.6021.qmail@6a68c4de06516f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ4QH-0007v5-8p
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYBORbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753978AbYBORbx
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:31:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbYBORbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:31:52 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 925E430AB;
	Fri, 15 Feb 2008 12:31:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 A233530AA; Fri, 15 Feb 2008 12:31:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73964>

Gerrit Pape <pape@smarden.org> writes:

> This regresses the use case of running:
>
>    $ git hash-object --stdin Makefile <cache.h
>
> to obtain hash values for cache.h and then Makefile.  It used to
> report the object names in order, but now it always processes
> --stdin at the end.

Isn't this change of behaviour more serious than the made up
"--stdin --stdin" example?  The made-up insane usage is rejected
with your patch now, so it would be fine, but that is so insane
that we probably even did not need to explicitly reject.  On the
other hand, running "--stdin file2 <file1" and expecting the
output to be given for file1 first and then file2 is much less
insane, and it would make more sense to reject it if we cannot
support that earlier behaviour.  Not rejecting such a use and
doing different thing from what we used to will break existing
uses silently.

I suppose we could first see if there is -w in the first pass
and then in the second pass do exactly what we used to do, if we
want to fix this without regressing at all.  Then there won't
be any regression, even "--stdin --stdin" would keep working.

Except for one case.

Earlier you could "hash-object --stdin -w cache.h <Makefile" to
get the hash of Makefile without writing to the object store,
and get the hash of cache.h and write that to the object store.

With such a fix with less regression, we will get the two object
names in the right order (--stdin first and then explicit
filename, as the user wanted to have), but now we write what we
get from --stdin to the object database, even though the user
did _not_ want to (that is why he wrote -w after --stdin, not
before).

Hmmmm.  Why is it so bad if "--stdin -w" and "-w --stdin" works
differently?

Having said all that, I think "--stdin file2 <file1" behaviour
can be kept without regressing by a patch like this on top of
your fix, and we can drop the first "regression warning" in the
commit log message if we did so.

---

 hash-object.c          |    5 +++++
 t/t5303-hash-object.sh |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hash-object.c b/hash-object.c
index 67d9922..61e7160 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -75,6 +75,11 @@ int main(int argc, char **argv)
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
diff --git a/t/t5303-hash-object.sh b/t/t5303-hash-object.sh
index 14be455..7c4f9fa 100755
--- a/t/t5303-hash-object.sh
+++ b/t/t5303-hash-object.sh
@@ -21,8 +21,8 @@ test_expect_success \
 test_expect_success \
     'git hash-object --stdin file0 <file1 first operates on file0, then file1' \
     'echo foo > file0 &&
-    obname0=$(git hash-object file0) &&
-    obname1=$(echo bar | git hash-object --stdin) &&
+    obname0=$(echo bar | git hash-object --stdin) &&
+    obname1=$(git hash-object file0) &&
     obname0new=$(echo bar | git hash-object --stdin file0 | sed -n -e 1p) &&
     obname1new=$(echo bar | git hash-object --stdin file0 | sed -n -e 2p) &&
     test "$obname0" = "$obname0new" &&
