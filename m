From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase loses author name/email if given bad email address
Date: Wed, 14 Dec 2005 16:33:01 -0800
Message-ID: <7virtrurlu.fsf@assigned-by-dhcp.cox.net>
References: <20051214224818.GA5362@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mostrows@watson.ibm.com
X-From: git-owner@vger.kernel.org Thu Dec 15 01:37:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emh6D-0002nl-2z
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 01:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVLOAef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 19:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbVLOAdU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 19:33:20 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47102 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932667AbVLOAdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 19:33:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215003306.FNPG25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 19:33:06 -0500
To: Amos Waterland <apw@us.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13663>

Amos Waterland <apw@us.ibm.com> writes:

> If GIT_AUTHOR_EMAIL is of a certain form, `git rebase master' will blow
> away the author name and email when fast-forward merging commits.

True.

> +export GIT_AUTHOR_EMAIL=bogus_email_address

Do not do that, then ;-).

The rebasing involves extracting the patch as an e-mail form and
feeding it to the normal e-mail patch acceptance mechanism, and
mailinfo.c::handle_from() rejects "A U Thor <bogus_address>"
hence you lose the authorship information.

Having said that, maybe e-mail acceptance machinery should
reject such patch.

-- >8 --
Subject: [PATCH] mailinfo and git-am: allow "John Doe <johndoe>"

An isolated developer could have a local-only e-mail, which will
be stripped out by mailinfo because it lacks '@'.  Define a
fallback parser to accomodate that.

At the same time, reject authorless patch in git-am.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-am.sh  |    7 +++++++
 mailinfo.c |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletions(-)

e0e3ba208d235ab5623a86204fbd20b449520764
diff --git a/git-am.sh b/git-am.sh
index 343bee9..1a114bc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -249,6 +249,13 @@ do
 	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
 	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
 	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
+
+	if test -z "$GIT_AUTHOR_EMAIL"
+	then
+		echo "Patch does not have a valid e-mail address."
+		stop_here $this
+	fi
+
 	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
 
 	SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
diff --git a/mailinfo.c b/mailinfo.c
index d4b4163..9f95f37 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -40,13 +40,43 @@ static char *sanity_check(char *name, ch
 	return name;
 }
 
+static int bogus_from(char *line)
+{
+	/* John Doe <johndoe> */
+	char *bra, *ket, *dst, *cp;
+
+	/* This is fallback, so do not bother if we already have an
+	 * e-mail address.
+	 */ 
+	if (*email)
+		return 0;
+
+	bra = strchr(line, '<');
+	if (!bra)
+		return 0;
+	ket = strchr(bra, '>');
+	if (!ket)
+		return 0;
+
+	for (dst = email, cp = bra+1; cp < ket; )
+		*dst++ = *cp++;
+	*dst = 0;
+	for (cp = line; isspace(*cp); cp++)
+		;
+	for (bra--; isspace(*bra); bra--)
+		*bra = 0;
+	cp = sanity_check(cp, email);
+	strcpy(name, cp);
+	return 1;
+}
+
 static int handle_from(char *line)
 {
 	char *at = strchr(line, '@');
 	char *dst;
 
 	if (!at)
-		return 0;
+		return bogus_from(line);
 
 	/*
 	 * If we already have one email, don't take any confusing lines
-- 
0.99.9m
