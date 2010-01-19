From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] post-receive-email: allow customizing of subject/intro/footer
Date: Tue, 19 Jan 2010 00:12:11 -0500
Message-ID: <1263877931-26047-1-git-send-email-vapier@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 06:12:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX6Nv-0000iF-SL
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 06:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab0ASFMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 00:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803Ab0ASFMG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 00:12:06 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55816 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab0ASFMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 00:12:05 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 529576778F
	for <git@vger.kernel.org>; Tue, 19 Jan 2010 05:12:00 +0000 (UTC)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137426>

The format of the subject/intro/footer are noise imo, but rather than
debate the issue, let the user customize the output using the existing
git config hooks section.  The default output is retained for each part.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 contrib/hooks/post-receive-email |   76 +++++++++++++++++++++++++++++---------
 1 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 58a35c8..79ab6b1 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -38,6 +38,15 @@
 # hooks.emailprefix
 #   All emails have their subjects prefixed with this prefix, or "[SCM]"
 #   if emailprefix is unset, to aid filtering
+# hooks.emailsubject
+#   Allow customizing of the subject.  Default is a description of what
+#   ref changed and how/why.
+# hooks.emailbodyintro
+#   Allow customizing of the body intro.  Default is friendly paragraph that
+#   explains why the user is receiving this e-mail and what has changed.
+# hooks.emailfooter
+#   Allow customizing of the footer.  Default is name of the script and the
+#   repo description.
 # hooks.showrev
 #   The shell command used to format each revision in the email, with
 #   "%s" replaced with the commit id.  Defaults to "git rev-list -1
@@ -55,6 +64,10 @@
 # "X-Git-Newrev", and "X-Git-Reftype" to enable fine tuned filtering and
 # give information for debugging.
 #
+# All variables that start with 'email' have substitution performed on them.
+# Patterns like @foo@ are replaced with the contents of the variable foo.
+# See subst_vars() for the specific keywords available for substitution.
+#
 
 # ---------------------------- Functions
 
@@ -190,36 +203,47 @@ generate_email()
 	generate_email_footer
 }
 
+subst_vars()
+{
+	sep=$(printf '\001')
+	# let this be used in a pipeline or by itself
+	( [ "$#" -ne 0 ] && echo "$@" || cat ) | sed \
+		-e "s${sep}@change_type@${sep}${change_type}${sep}g" \
+		-e "s${sep}@describe@${sep}${describe}${sep}g" \
+		-e "s${sep}@newrev@${sep}${newrev}${sep}g" \
+		-e "s${sep}@oldrev@${sep}${oldrev}${sep}g" \
+		-e "s${sep}@projectdesc@${sep}${projectdesc}${sep}g" \
+		-e "s${sep}@refname@${sep}${refname}${sep}g" \
+		-e "s${sep}@refname_type@${sep}${refname_type}${sep}g" \
+		-e "s${sep}@oldrev@${sep}${oldrev}${sep}g" \
+		-e "s${sep}@short_refname@${sep}${short_refname}${sep}g"
+}
+
 generate_email_header()
 {
 	# --- Email (all stdout will be the email)
 	# Generate header
+	(
 	cat <<-EOF
 	To: $recipients
-	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
-	X-Git-Refname: $refname
-	X-Git-Reftype: $refname_type
-	X-Git-Oldrev: $oldrev
-	X-Git-Newrev: $newrev
+	Subject: ${emailprefix}${emailsubject}
+	X-Git-Refname: @refname@
+	X-Git-Reftype: @refname_type@
+	X-Git-Oldrev: @oldrev@
+	X-Git-Newrev: @newrev@
+	EOF
 
-	This is an automated email from the git hooks/post-receive script. It was
-	generated because a ref change was pushed to the repository containing
-	the project "$projectdesc".
+	if [ -n "${emailbodyintro}" ] ; then
+		printf '\n%s\n' "${emailbodyintro}"
+	fi
 
-	The $refname_type, $short_refname has been ${change_type}d
-	EOF
+	printf '\n%s\n' "The @refname_type@, @short_refname@ has been @change_type@d"
+	) | subst_vars
 }
 
 generate_email_footer()
 {
-	SPACE=" "
-	cat <<-EOF
-
-
-	hooks/post-receive
-	--${SPACE}
-	$projectdesc
-	EOF
+	subst_vars "${emailfooter}"
 }
 
 # --------------- Branches
@@ -671,6 +695,22 @@ recipients=$(git config hooks.mailinglist)
 announcerecipients=$(git config hooks.announcelist)
 envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
+emailsubject=$(git config hooks.emailsubject || \
+	echo '@projectdesc@ @refname_type@, @short_refname@, @change_type@d. @describe@')
+emailbodyintro=$(git config hooks.emailbodyintro || cat <<-EOF
+	This is an automated email from the git hooks/post-receive script. It was
+	generated because a ref change was pushed to the repository containing
+	the project "@projectdesc@".
+	EOF
+)
+emailfooter=$(git config hooks.emailfooter || SPACE=" " cat <<-EOF
+
+
+	hooks/post-receive
+	--${SPACE}
+	@projectdesc@
+	EOF
+)
 custom_showrev=$(git config hooks.showrev)
 
 # --- Main loop
-- 
1.6.6
