From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v3] post-receive-email: explicitly set Content-Type header
Date: Wed,  9 Nov 2011 15:00:58 +0400
Message-ID: <1320836458-24088-1-git-send-email-Alex.Crezoff@gmail.com>
References: <20111007201932.GC29712@elie.hsd1.il.comcast.net>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 12:01:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO5ua-0005DD-Ni
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 12:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab1KILBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 06:01:39 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52935 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab1KILBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 06:01:37 -0500
Received: by bke11 with SMTP id 11so1221551bke.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bGv5PgAjwrsD2kXoUWIhiStXn8diXTtgIUe6Wvu3ick=;
        b=WhSBpYlB2uHlOsqecubBnWmclNSMSXEnb65nMal/GdE5yAG5OOfJ8G8xcZ1z5EGe2W
         X1e8U0ugzeBRE0oybu71n1l+OHW+k5/XvOZY9pwsWqL/ILtdc1dlLYJ8KQwPK/nrZCvJ
         3LzMdAifoSnvPCAWAYLsYS6X7xSStM6gvZ6PU=
Received: by 10.204.141.65 with SMTP id l1mr1291036bku.82.1320836495428;
        Wed, 09 Nov 2011 03:01:35 -0800 (PST)
Received: from zappedws (ppp91-77-16-7.pppoe.mtu-net.ru. [91.77.16.7])
        by mx.google.com with ESMTPS id e8sm4441549bkd.7.2011.11.09.03.01.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 03:01:32 -0800 (PST)
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <Alex@zappedws>)
	id 1RO5u6-0006Hg-J7; Wed, 09 Nov 2011 15:01:14 +0400
X-Mailer: git-send-email 1.7.7.3.5.g55178
In-Reply-To: <20111007201932.GC29712@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185151>

Some email clients (e.g. claws-mail) incorrectly display
message body when there is no Content-Type header and charset
explicitly defined.
So, set explicitly Content-Type header. Its charset
can be defined with hooks.emailcharset config variable.

NB: This above-mentioned charset may differ from i18n.logOutputEncoding,
because e.g. gitweb expects (for now) i18n.logOutputEncoding set to UTF-8
to display logs correctly.

Also, introduce hooks.gitopts config variable
with the default '-c core.quotepath=false'.
This takes into account that we want to see pretty email-message
with well-looking messages and list of changed filenames.
And usually non-ASCII filenames are in the same
encoding that commit messages are.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 contrib/hooks/post-receive-email |   43 ++++++++++++++++++++++++++-----------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index ba077c1..913be89 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -65,6 +65,14 @@
 #   Default is "--stat --summary --find-copies-harder". Add -p to those
 #   options to include a unified diff of changes in addition to the usual
 #   summary output.
+# hooks.gitopts
+#   git options for the git diff-tree invocation that shows changes.
+#   Default is '-c core.quotepath=false' to be able to see non-ASCII filenames
+#   used in a project.
+# hooks.emailcharset
+#   The charset used in Content-Type header. UTF-8, if not specified.
+#   It can differ from i18n.logOutputEncoding (not to mess-up with gitweb
+#   which expects i18n.logOutputEncoding to be set to UTF-8)
 #
 # Notes
 # -----
@@ -234,6 +242,9 @@ generate_email_header()
 	cat <<-EOF
 	To: $recipients
 	Subject: ${emailprefix}$projectdesc $refname_type $short_refname ${change_type}d. $describe
+	MIME-Version: 1.0
+	Content-Type: text/plain; charset=$emailcharset
+	Content-Transfer-Encoding: 8bit
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
@@ -241,7 +252,7 @@ generate_email_header()
 
 	This is an automated email from the git hooks/post-receive script. It was
 	generated because a ref change was pushed to the repository containing
-	the project "$projectdesc".
+	the project "$projectdesc_e".
 
 	The $refname_type, $short_refname has been ${change_type}d
 	EOF
@@ -255,7 +266,7 @@ generate_email_footer()
 
 	hooks/post-receive
 	--${SPACE}
-	$projectdesc
+	$projectdesc_e
 	EOF
 }
 
@@ -451,7 +462,7 @@ generate_update_branch_email()
 	# non-fast-forward updates.
 	echo ""
 	echo "Summary of changes:"
-	git diff-tree $diffopts $oldrev..$newrev
+	git $gitopts diff-tree $diffopts $oldrev..$newrev
 }
 
 #
@@ -656,14 +667,15 @@ show_new_revisions()
 		revspec=$oldrev..$newrev
 	fi
 
+	revlistopts="-c i18n.logOutputEncoding=$emailcharset"
 	other_branches=$(git for-each-ref --format='%(refname)' refs/heads/ |
 	    grep -F -v $refname)
 	git rev-parse --not $other_branches |
 	if [ -z "$custom_showrev" ]
 	then
-		git rev-list --pretty --stdin $revspec
+		git $revlistopts rev-list --pretty --stdin $revspec
 	else
-		git rev-list --stdin $revspec |
+		git $revlistopts $rev-list --stdin $revspec |
 		while read onerev
 		do
 			eval $(printf "$custom_showrev" $onerev)
@@ -714,14 +726,6 @@ if [ -z "$GIT_DIR" ]; then
 	exit 1
 fi
 
-projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
-# Check if the description is unchanged from it's default, and shorten it to
-# a more manageable length if it is
-if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
-then
-	projectdesc="UNNAMED PROJECT"
-fi
-
 recipients=$(git config hooks.mailinglist)
 announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
@@ -730,6 +734,19 @@ custom_showrev=$(git config hooks.showrev)
 maxlines=$(git config hooks.emailmaxlines)
 diffopts=$(git config hooks.diffopts)
 : ${diffopts:="--stat --summary --find-copies-harder"}
+gitopts=$(git config hooks.gitopts || echo '-c core.quotepath=false')
+emailcharset=$(git config hooks.emailcharset || echo 'UTF-8')
+
+projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
+# Check if the description is unchanged from it's default, and shorten it to
+# a more manageable length if it is
+if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
+then
+	projectdesc="UNNAMED PROJECT"
+fi
+# Leave description in UTF-8 to be used in the Subject header
+# But convert it to an hooks.emailcharset encoding to be used in a message body
+projectdesc_e=$(echo $projectdesc | iconv -f UTF-8 -t $emailcharset 2>/dev/null)
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.7.7.3.5.g55178
