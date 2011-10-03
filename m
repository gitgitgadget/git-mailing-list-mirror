From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] ident: check /etc/mailname if email is unknown
Date: Mon, 3 Oct 2011 01:16:33 -0500
Message-ID: <20111003061633.GB17289@elie>
References: <20111003045745.GA17604@elie>
 <7v8vp2iqvc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt Kraai <kraai@ftbfs.org>,
	Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 08:16:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAbpd-0005Tc-LY
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 08:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab1JCGQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 02:16:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42749 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab1JCGQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 02:16:41 -0400
Received: by iaqq3 with SMTP id q3so4658938iaq.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5K5NffsNCW1U5vISpDLBzRL5P1/YDWv+9o/jw9P9Yq0=;
        b=jSV1hFOAJGTl6XjmsX5nbdx6WpWqRSAzTfhI78R9cuIs72/7dzjn4AWhJ4QfgMtpIA
         6Gm+5YOxs4GgrWf0NA7HT90SFautWUkTMiRVU2y4fNgEDOtaRub9+4f/oZees8k1PIsB
         g71TLpcqMjSOv0pXaynSn8E52yHwAT7hSwtMU=
Received: by 10.42.115.198 with SMTP id l6mr3622479icq.132.1317622600345;
        Sun, 02 Oct 2011 23:16:40 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id ek22sm27193434ibb.12.2011.10.02.23.16.38
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Oct 2011 23:16:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8vp2iqvc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182624>

Before falling back to gethostname(), check /etc/mailname if
GIT_AUTHOR_EMAIL is not set in the environment or through config
files.  Only fall back if /etc/mailname cannot be opened or read.

The /etc/mailname convention comes from Debian policy section 11.6
("mail transport, delivery and user agents"), though maybe it could be
useful sometimes on other machines, too.  The lack of this support was
noticed by various people in different ways:

 - Ian observed that git was choosing the address
   'ian@anarres.relativity.greenend.org.uk' rather than
   'ian@davenant.greenend.org.uk' as it should have done.

 - Jonathan noticed that operations like "git commit" were needlessly
   slow when using a resolver that was slow to handle reverse DNS
   lookups.

Alas, after this patch, if /etc/mailname is set up and the [user] name
and email configuration aren't, the committer email will not provide a
charming reminder of which machine commits were made on any more.  But
I think it's worth it.

Mechanics: the functionality of reading mailname goes in its own
function, so people who care about other distros can easily add an
implementation to a similar location without making copy_email() too
long and losing clarity.  While at it, we split out the fallback
default logic that does gethostname(), too (rearranging it a little
and adding a check for errors from gethostname while at it).

Based on a patch by Gerrit Pape <pape@smarden.org>.

Requested-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano wrote:

> I do not think this would hurt, even though I see /etc/mailname on only
> one of my boxes (i.e. Debian). For maintainability for the future,
> however, I would prefer to see the above hunk separated into a helper
> function to keep addition to copy_email() to the minimum, e.g.

Makes sense.  How about this?

 Documentation/git-commit-tree.txt |    8 ++++-
 ident.c                           |   66 +++++++++++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 14 deletions(-)

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
index 35a6f264..edb43144 100644
--- a/ident.c
+++ b/ident.c
@@ -50,6 +50,54 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 
 }
 
+static int add_mailname_host(char *buf, size_t len)
+{
+	FILE *mailname;
+
+	mailname = fopen("/etc/mailname", "r");
+	if (!mailname) {
+		if (errno != ENOENT)
+			warning("cannot open /etc/mailname: %s",
+				strerror(errno));
+		return -1;
+	}
+	if (!fgets(buf, len, mailname)) {
+		if (ferror(mailname))
+			warning("cannot read /etc/mailname: %s",
+				strerror(errno));
+		fclose(mailname);
+		return -1;
+	}
+	/* success! */
+	fclose(mailname);
+	return 0;
+}
+
+static void add_domainname(char *buf, size_t len)
+{
+	struct hostent *he;
+	size_t namelen;
+	const char *domainname;
+
+	if (gethostname(buf, len)) {
+		warning("cannot get host name: %s", strerror(errno));
+		strlcpy(buf, "(none)", len);
+		return;
+	}
+	namelen = strlen(buf);
+	if (memchr(buf, '.', namelen))
+		return;
+
+	he = gethostbyname(buf);
+	buf[namelen++] = '.';
+	buf += namelen;
+	len -= namelen;
+	if (he && (domainname = strchr(he->h_name, '.')))
+		strlcpy(buf, domainname + 1, len);
+	else
+		strlcpy(buf, "(none)", len);
+}
+
 static void copy_email(const struct passwd *pw)
 {
 	/*
@@ -61,20 +109,12 @@ static void copy_email(const struct passwd *pw)
 		die("Your sysadmin must hate you!");
 	memcpy(git_default_email, pw->pw_name, len);
 	git_default_email[len++] = '@';
-	gethostname(git_default_email + len, sizeof(git_default_email) - len);
-	if (!strchr(git_default_email+len, '.')) {
-		struct hostent *he = gethostbyname(git_default_email + len);
-		char *domainname;
 
-		len = strlen(git_default_email);
-		git_default_email[len++] = '.';
-		if (he && (domainname = strchr(he->h_name, '.')))
-			strlcpy(git_default_email + len, domainname + 1,
-				sizeof(git_default_email) - len);
-		else
-			strlcpy(git_default_email + len, "(none)",
-				sizeof(git_default_email) - len);
-	}
+	if (!add_mailname_host(git_default_email + len,
+				sizeof(git_default_email) - len))
+		return;	/* read from "/etc/mailname" (Debian) */
+	add_domainname(git_default_email + len,
+			sizeof(git_default_email) - len);
 }
 
 static void setup_ident(void)
-- 
1.7.7.rc1
