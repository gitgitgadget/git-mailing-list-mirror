From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [Cogito] less verbose cg-clone/cg-update?
Date: Sun, 26 Jun 2005 00:19:40 -0600
Message-ID: <42BE48FC.40504@tuxrocks.com>
References: <pan.2005.06.24.06.46.32.339572@automagically.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 26 08:15:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmQQ0-0000gg-BK
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 08:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFZGV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 02:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFZGV0
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 02:21:26 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:12300 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261262AbVFZGTv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 02:19:51 -0400
Received: from [10.0.0.10] (216-190-206-130.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j5Q6JfvN015178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Jun 2005 00:19:44 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Markus Dahms <mad@automagically.de>
In-Reply-To: <pan.2005.06.24.06.46.32.339572@automagically.de>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Markus Dahms wrote:
> Hi there,
> 
> as a person just following the development process of Linux/GIT/etc.
> I'm normally not interested in SHA-1 sums on updating my local tree.
> IMHO the default output should be less verbose (like in most VCSs),
> especially in file changes the type of change (N/M/...) and the
> file name may be enough.
> Given an option (e.g. "-v") there could be a lot more...
> 
> If there's no time, I'd do the patch...
> 
> Markus
> 
> P.S.: I didn't really look at the source, maybe it's a git not
>       a cg-* change...

Here is a patch that implements a cogito-based "quiet" output option
(-q) for cg-pull.  This could easily be inverted to default to quiet
and allow the verbose option instead.  Also, with the option in there,
it wouldn't be hard to quiet up other portions of cg-pull.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

diff --git a/cg-pull b/cg-pull
- --- a/cg-pull
+++ b/cg-pull
@@ -11,15 +11,21 @@
 # -------
 # -f::
 #	Force the complete pull even if the heads are the same.
+#
+# -q::
+#	Display quieter output
 
- -USAGE="cg-pull [-f] [BRANCH_NAME]"
+USAGE="cg-pull [-f] [-q] [BRANCH_NAME]"
 
 . ${COGITO_LIB}cg-Xlib
 
 force=
+quiet=
 while optparse; do
 	if optparse -f; then
 		force=1
+	elif optparse -q; then
+		quiet=1
 	else
 		optfail
 	fi
@@ -309,8 +315,11 @@ if [ ! "$orig_head" ]; then
 
 elif [ "$orig_head" != "$new_head" ]; then
 	echo "Tree change: $orig_head:$new_head"
- -	git-diff-tree -r $(tree-id $orig_head) $(tree-id $new_head)
- -
+	if [ "$quiet" ] ; then
+		git-diff-tree -r $(tree-id $orig_head) $(tree-id $new_head) | awk '{ print $5"\t"$6 }'
+	else
+		git-diff-tree -r $(tree-id $orig_head) $(tree-id $new_head)
+	fi
 else
 	echo "Up to date."
 	exit


Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCvkj8aI0dwg4A47wRAuOvAKCllJCjte1ITkPCtKOfAqd8zY1fzgCgscg2
EZ5jKuLBFF+0lb5ZoOd6bHE=
=YC02
-----END PGP SIGNATURE-----
