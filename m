From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC jn/ident-from-etc-mailname] ident: do not retrieve
 default ident when unnecessary
Date: Thu, 6 Oct 2011 12:17:19 -0500
Message-ID: <20111006171719.GB6946@elie>
References: <20111003045745.GA17604@elie>
 <7v8vp2iqvc.fsf@alter.siamese.dyndns.org>
 <20111003061633.GB17289@elie>
 <4E895FBD.8020904@viscovery.net>
 <20111003074433.GD17289@elie>
 <7vty7pga7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrZc-0001GX-Ju
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758684Ab1JFRR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:17:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39404 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab1JFRR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:17:27 -0400
Received: by ywb5 with SMTP id 5so2813299ywb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Dbz5KbRSpVmy4C2W/FklsJLj23D/OLV5qNDaZYnQqYU=;
        b=tqtYCfRlZ1v2cvKy47IM91pj3E2HF4IK5LMTV8B1YFTI/BqGXaevIllN7cUAB0T9C3
         ODkdP6bOeWZN/aTrdJ/Fk1vQP37OE3QYHmA7j6ZNQSbZKWcDOLtsa/FppTAiBwb2V6//
         ZpAQ+/198Ic5cMC68bz/xHBH2VmiIO/ySwmKY=
Received: by 10.236.197.104 with SMTP id s68mr5052740yhn.20.1317921446772;
        Thu, 06 Oct 2011 10:17:26 -0700 (PDT)
Received: from elie (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id r30sm8486432yhj.20.2011.10.06.10.17.24
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 10:17:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vty7pga7y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182986>

Avoid a getpwuid() call (which contacts the network if the password
database is not local), read of /etc/mailname, gethostname() call, and
reverse DNS lookup if the user has already chosen a name and email
through configuration, the environment, or the command line.

This should slightly speed up commands like "git commit".  More
importantly, it improves error reporting when computation of the
default ident string does not go smoothly.  For example, after
detecting a problem (e.g., "warning: cannot open /etc/mailname:
Permission denied") in retrieving the default committer identity:

	touch /etc/mailname;	# as root
	chmod -r /etc/mailname;	# as root
	git commit -m 'test commit'

you can squelch the warning while waiting for your sysadmin to fix the
permissions problem.

	echo '[user] email = me@example.com' >>~/.gitconfig

Inspired-by: Johannes Sixt <j6t@kdgb.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> --- a/ident.c
> +++ b/ident.c
> @@ -239,6 +239,10 @@ const char *fmt_ident(const char *name, const char *email,
>  	int warn_on_no_name = (flag & IDENT_WARN_ON_NO_NAME);
>  	int name_addr_only = (flag & IDENT_NO_DATE);
>  
> +	if (name && !git_default_name[0])
> +		strcpy(git_default_name, name);
> +	if (email && !git_default_email[0])
> +		strcpy(git_default_email, email);

That poisons the "git_default_foo" variables for the next fmt_ident
call.  But something similar should work.

 ident.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/ident.c b/ident.c
index edb43144..f619619b 100644
--- a/ident.c
+++ b/ident.c
@@ -117,19 +117,21 @@ static void copy_email(const struct passwd *pw)
 			sizeof(git_default_email) - len);
 }
 
-static void setup_ident(void)
+static void setup_ident(const char **name, const char **emailp)
 {
 	struct passwd *pw = NULL;
 
 	/* Get the name ("gecos") */
-	if (!git_default_name[0]) {
+	if (!*name && !git_default_name[0]) {
 		pw = getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
 		copy_gecos(pw, git_default_name, sizeof(git_default_name));
 	}
+	if (!*name)
+		*name = git_default_name;
 
-	if (!git_default_email[0]) {
+	if (!*emailp && !git_default_email[0]) {
 		const char *email = getenv("EMAIL");
 
 		if (email && email[0]) {
@@ -144,6 +146,8 @@ static void setup_ident(void)
 			copy_email(pw);
 		}
 	}
+	if (!*emailp)
+		*emailp = git_default_email;
 
 	/* And set the default date */
 	if (!git_default_date[0])
@@ -239,11 +243,7 @@ const char *fmt_ident(const char *name, const char *email,
 	int warn_on_no_name = (flag & IDENT_WARN_ON_NO_NAME);
 	int name_addr_only = (flag & IDENT_NO_DATE);
 
-	setup_ident();
-	if (!name)
-		name = git_default_name;
-	if (!email)
-		email = git_default_email;
+	setup_ident(&name, &email);
 
 	if (!*name) {
 		struct passwd *pw;
-- 
1.7.7.rc1
