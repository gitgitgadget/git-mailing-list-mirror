From: Andy Whitcroft <apw@shadowen.org>
Subject: send-pack: limit on negative references
Date: Tue, 05 Sep 2006 13:45:03 +0100
Message-ID: <44FD714F.9040003@shadowen.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000707060100020409040800"
X-From: git-owner@vger.kernel.org Tue Sep 05 14:45:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKaJ2-0003Yo-RA
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 14:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWIEMp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 08:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWIEMp2
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 08:45:28 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:60941 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964778AbWIEMp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 08:45:27 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GKaIZ-0003GT-9d
	for git@vger.kernel.org; Tue, 05 Sep 2006 13:45:03 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26475>

This is a multi-part message in MIME format.
--------------000707060100020409040800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've been having trouble with git push apparently resending the entire
commit trace for the branch each and every time I push; even with short
branch names.  This seems to be related to the changes made to handle
the case where the remote end has a large number of branches (>900).

The problem there seemed to be that we would fill list-revs' argument
list in reference order with negative and positive limits.  This could
lead to us to exceed the limit 900 argument limit and bomb.  The changes
made in commit 797656e58ddbd82ac461a5142ed726db3a4d0ac0 split the
parameter loading into two phases.  First we load the +ve and -ve
references for the branches we are definatly trying to send; bailing if
we cannot fit those references onto the command line.  Second we load up
the remaining remote references as -ve references to limit duplicate
object sends.

This second phase loads up to 16 additional references onto the command
line.  Now this effectively limits you to 16 branchs in your remote
repository if you wish to ensure you catch a parental head to copy from.
 This can lead us to send the entire commit stream for the branch even
though the branch may contain no new commits.

It seems to me that any and all negative references we have are helpful
and as such we should be loading as many as we can into the list.  If we
cannot fit them all we should _not_ error out, but we should not limit
ourselves to any less than as many as we can fit.

Can anyone see a downside to the patch below?

-apw

--------------000707060100020409040800
Content-Type: text/plain;
 name*0="send-pack-supply-as-many-negative-references-as-we-can-fit"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="send-pack-supply-as-many-negative-references-as-we-can-fit"

send-pack: supply as many negative references as we can fit

In commit 797656e58ddbd82ac461a5142ed726db3a4d0ac0 list-revs' command
line was reordered to ensure the branches we are pushing are first on
the list, and then a subset of the remaining remote references are
passed to limit our push.  Given that we now have the needed positive
references on the list first, it seems reasonable to load as many
negative references onto the list as will fit without error.

Signed-off-by: Andy Whitcroft <andyw@uk.ibm.com>
---
diff --git a/send-pack.c b/send-pack.c
index 10bc8bc..5d55241 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -40,7 +40,7 @@ static void exec_rev_list(struct ref *re
 {
 	struct ref *ref;
 	static const char *args[1000];
-	int i = 0, j;
+	int i = 0;
 
 	args[i++] = "rev-list";	/* 0 */
 	if (use_thin_pack)	/* 1 */
@@ -69,8 +69,8 @@ static void exec_rev_list(struct ref *re
 	/* Then a handful of the remainder
 	 * NEEDSWORK: we would be better off if used the newer ones first.
 	 */
-	for (ref = refs, j = i + 16;
-	     i < 900 && i < j && ref;
+	for (ref = refs;
+	     i < 900 && ref;
 	     ref = ref->next) {
 		if (is_zero_sha1(ref->new_sha1) &&
 		    !is_zero_sha1(ref->old_sha1) &&

--------------000707060100020409040800--
