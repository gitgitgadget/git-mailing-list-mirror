From: Jim Bauer <jfbauer@comcast.net>
Subject: [PATCH] post-receive-email: Add diffattachment and replyto config options
Date: Sat, 18 Jul 2009 21:44:57 -0400
Message-ID: <1247967897-14166-1-git-send-email-jfbauer@comcast.net>
Cc: jfbauer@comcast.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 03:46:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSLTX-0002Fy-0c
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 03:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbZGSBpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 21:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbZGSBpS
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 21:45:18 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:39247
	"EHLO QMTA03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754091AbZGSBpR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2009 21:45:17 -0400
Received: from OMTA15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by QMTA03.westchester.pa.mail.comcast.net with comcast
	id Hdif1c0091swQuc53dlH0D; Sun, 19 Jul 2009 01:45:17 +0000
Received: from localhost.localdomain ([98.218.188.112])
	by OMTA15.westchester.pa.mail.comcast.net with comcast
	id HdnW1c0032Rwbnm3bdnWVT; Sun, 19 Jul 2009 01:47:30 +0000
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123545>

This is for those who need or want to have the patches
(from post-receive-email) sent as attachments.

Setting hooks.diffattachment (to anything) will cause a 'git diff'
to be included in the email as an attachment.  The email will be
sent via mutt which must be installed.

Setting hooks.replyto will add the Reply-To header to
the email messages.
---
 contrib/hooks/post-receive-email |   72 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 2a66063..f113969 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -48,6 +48,14 @@
 #     "t=%s; printf 'http://.../?id=%%s' \$t; echo;echo; git show -C \$t; echo"
 #   Be careful if "..." contains things that will be expanded by shell "eval"
 #   or printf.
+# hooks.diffattachment
+#   To include patches as an attachment set this to anything.
+#   If you set this, you probably don't want to use the "git show..."
+#   example above in hooks.showrev that also caused patches to be included
+#   inline as that would duplicate the patch in emails.
+#   This requires mutt to work.  So it must be installed and in $PATH
+# hooks.replyto
+#   If set then the Reply-To email header is set to this value.
 #
 # Notes
 # -----
@@ -173,7 +181,10 @@ generate_email()
 		describe=$rev
 	fi
 
+	subject="${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe"
+
 	generate_email_header
+	generate_email_announce
 
 	# Call the correct body generation function
 	fn_name=general
@@ -192,16 +203,31 @@ generate_email()
 
 generate_email_header()
 {
+	if [ -n "$diffattachment" ]; then
+		return;
+	fi
+
 	# --- Email (all stdout will be the email)
 	# Generate header
 	cat <<-EOF
 	To: $recipients
-	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
+	Subject: $subject
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
 	X-Git-Newrev: $newrev
+	EOF
+
+	if [ -n "$replyto" ]; then
+		echo "Reply-To: $replyto"
+	fi
+
+	echo ""
+}
 
+generate_email_announce()
+{
+	cat <<-EOF
 	This is an automated email from the git hooks/post-receive script. It was
 	generated because a ref change was pushed to the repository containing
 	the project "$projectdesc".
@@ -632,6 +658,12 @@ show_new_revisions()
 			eval $(printf "$custom_showrev" $onerev)
 		done
 	fi
+
+	# Put patch in attachment if desired
+	if [ -n "$diffattachment" ]; then
+		attachment=$temp_dir/diff.txt
+		git diff $revspec > $attachment
+	fi
 }
 
 
@@ -644,12 +676,24 @@ send_mail()
 	fi
 }
 
+
+cleanup()
+{
+	rm -rf $temp_dir
+}
+
+
 # ---------------------------- main()
 
 # --- Constants
 LOGBEGIN="- Log -----------------------------------------------------------------"
 LOGEND="-----------------------------------------------------------------------"
 
+# Create place for temp files and make sure we remove then on exit
+temp_dir=$(mktemp -d /tmp/post-receive.XXXXXXXXXX)
+trap cleanup 0 2 15
+
+
 # --- Config
 # Set GIT_DIR either from the working directory, or from the environment
 # variable.
@@ -672,6 +716,9 @@ announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
 custom_showrev=$(git config hooks.showrev)
+diffattachment=$(git config hooks.diffattach)
+replyto=$(git config hooks.replyto)
+
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
@@ -684,6 +731,27 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 else
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname | send_mail
+		if [ -z "$diffattachment" ]; then
+			generate_email $oldrev $newrev $refname | send_mail
+		else
+			body=$temp_dir/body
+			generate_email $oldrev $newrev $refname > $body
+			if [ -n "$attachment" ]; then
+				attach_args="-a $attachment"
+			fi
+
+			if [ -n "$replyto" ]; then
+				export REPLYTO="$replyto"
+			fi
+
+			mutt -f /dev/null -s "$subject" \
+			    -e "my_hdr X-Git-Refname: $refname" \
+			    -e "my_hdr X-Git-Reftype: $refname_type" \
+			    -e "my_hdr X-Git-Oldrev: $oldrev" \
+			    -e "my_hdr X-Git-Newrev: $newrev" \
+			    $attach_args $recipients < $body
+			rm -f $body $attachment
+			unset attachment
+		fi
 	done
 fi
-- 
1.6.3.3
