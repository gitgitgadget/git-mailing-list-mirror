From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] empty ident?
Date: Sat, 18 Feb 2006 00:44:14 -0800
Message-ID: <7vzmkpqco1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 18 09:44:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FANhT-0006E4-KA
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 09:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWBRIoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 03:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWBRIoQ
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 03:44:16 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38030 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750796AbWBRIoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 03:44:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218084303.HUAQ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 03:43:03 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16401>

It appears that some people who did not care about having bogus
names in their own commit messages are bitten by the recent
change to require a sane environment [*1*].

While it was a good idea to prevent people from using bogus
names to create commits and doing sign-offs, the error message
is not very informative.  This patch attempts to warn things
upfront and hint people how to fix their environments.

Likes, dislikes, don't cares?

[Footnote]

*1* The thread is this one.

    http://marc.theaimsgroup.com/?t=113868084800004

    Especially this message.

    http://marc.theaimsgroup.com/?m=113932830015032

---
diff --git a/ident.c b/ident.c
index 23b8cfc..09d4d71 100644
--- a/ident.c
+++ b/ident.c
@@ -46,6 +46,15 @@ static void copy_gecos(struct passwd *w,
 
 }
 
+static const char au_env[] = "GIT_AUTHOR_NAME";
+static const char co_env[] = "GIT_COMMITTER_NAME";
+static const char env_hint[] =
+"\n*** Environment problem:\n"
+"*** Your name cannot be determined from your system services (gecos).\n"
+"*** You would need to set %s and %s\n"
+"*** environment variables; otherwise you won't be able to perform\n"
+"*** certain operations because of \"empty ident\" errors.\n\n";
+
 int setup_ident(void)
 {
 	int len;
@@ -57,6 +66,11 @@ int setup_ident(void)
 	/* Get the name ("gecos") */
 	copy_gecos(pw, git_default_name, sizeof(git_default_name));
 
+	if (!*git_default_name) {
+		if (!getenv(au_env) || !getenv(co_env))
+			fprintf(stderr, env_hint, au_env, co_env);
+	}
+
 	/* Make up a fake email address (name + '@' + hostname [+ '.' + domainname]) */
 	len = strlen(pw->pw_name);
 	if (len > sizeof(git_default_email)/2)
