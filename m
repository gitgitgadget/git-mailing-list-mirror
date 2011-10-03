From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] ident: check /etc/mailname if email is unknown
Date: Sun, 2 Oct 2011 23:57:46 -0500
Message-ID: <20111003045745.GA17604@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 06:58:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAabP-00077W-Hs
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 06:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab1JCE6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 00:58:02 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59947 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab1JCE6B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 00:58:01 -0400
Received: by yxl31 with SMTP id 31so3123271yxl.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 21:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=S1+mot5cWK5FDXAESQn2tDb0zYAvF3i64bNnKtVtzt4=;
        b=FKLAddnY1EF4DlpO9BgMkweMwoy2vALWztYyWN8xAiXN//s7aIfleP8TZDbeJdpk9b
         kuxujcXjKLXqcKItkjkh7tg4zeU6lZ8TbsJrHOQDb0y0tEm5EikTdINMlIgb3Vxql+HO
         Pwu0tmtW8wFM9v+a+oN7dBsDH3KQWetGw8w9E=
Received: by 10.236.46.168 with SMTP id r28mr2195372yhb.119.1317617880720;
        Sun, 02 Oct 2011 21:58:00 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id u21sm2425853yhe.1.2011.10.02.21.57.58
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Oct 2011 21:58:00 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182621>

From: Gerrit Pape <pape@smarden.org>

Before falling back to gethostname(), check /etc/mailname if
GIT_AUTHOR_EMAIL is not set in the environment or through config
files.  Only fall back if /etc/mailname cannot be opened or read.

The /etc/mailname convention comes from Debian policy section 11.6
("mail transport, delivery and user agents"), though it seems more
widely useful.  The lack of this support was noticed by various people
in different ways:

 - Ian observed that git was choosing the address
   'ian@anarres.relativity.greenend.org.uk' rather than
   'ian@davenant.greenend.org.uk' as it should have done.

 - Jonathan noticed that operations like "git commit" were needlessly
   slow when the using a resolver that was slow to handle reverse DNS
   lookups.

On the other hand, this means that if /etc/mailname is set up and the
[user] name and email configuration aren't, the committer email will
not provide a charming reminder of which machine commits were made on
any more.  I think that cost is worth it.

Requested-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Debian has been using something like this patch for years now (see
<http://bugs.debian.org/448655>) but I thought it might be useful
to others, too.  A similar patch visited the list three years ago:
<http://thread.gmane.org/gmane.comp.version-control.git/51800>.

Thoughts of all kinds welcome, of course.

Thanks,
Jonathan

 Documentation/git-commit-tree.txt |    8 +++++++-
 ident.c                           |   23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 0fdb82ee..02133d5f 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -68,7 +68,9 @@ if set:
 
 In case (some of) these environment variables are not set, the information
 is taken from the configuration items user.name and user.email, or, if not
-present, system user name and fully qualified hostname.
+present, system user name and the hostname used for outgoing mail (taken
+from `/etc/mailname` and falling back to the fully qualified hostname when
+that file does not exist).
 
 A commit comment is read from stdin. If a changelog
 entry is not provided via "<" redirection, 'git commit-tree' will just wait
@@ -90,6 +92,10 @@ Discussion
 
 include::i18n.txt[]
 
+FILES
+-----
+/etc/mailname
+
 SEE ALSO
 --------
 linkgit:git-write-tree[1]
diff --git a/ident.c b/ident.c
index 35a6f264..87f0a37e 100644
--- a/ident.c
+++ b/ident.c
@@ -52,6 +52,8 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 
 static void copy_email(const struct passwd *pw)
 {
+	FILE *mailname;
+
 	/*
 	 * Make up a fake email address
 	 * (name + '@' + hostname [+ '.' + domainname])
@@ -61,6 +63,27 @@ static void copy_email(const struct passwd *pw)
 		die("Your sysadmin must hate you!");
 	memcpy(git_default_email, pw->pw_name, len);
 	git_default_email[len++] = '@';
+
+	/*
+	 * The domain part comes from /etc/mailname if it is readable,
+	 * or the current hostname and domain name otherwise.
+	 */
+	mailname = fopen("/etc/mailname", "r");
+	if (!mailname) {
+		if (errno != ENOENT)
+			warning("cannot open /etc/mailname: %s",
+				strerror(errno));
+	} else if (fgets(git_default_email + len,
+			 sizeof(git_default_email) - len, mailname)) {
+		/* success! */
+		fclose(mailname);
+		return;
+	} else {
+		if (ferror(mailname))
+			warning("cannot read /etc/mailname: %s",
+				strerror(errno));
+		fclose(mailname);
+	}
 	gethostname(git_default_email + len, sizeof(git_default_email) - len);
 	if (!strchr(git_default_email+len, '.')) {
 		struct hostent *he = gethostbyname(git_default_email + len);
-- 
1.7.7.rc1
