From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] commit --amend: cope with missing display name
Date: Sun, 2 May 2010 03:57:12 -0500
Message-ID: <20100502085712.GB1767@progeny.tock>
References: <20100502084827.GA1690@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 10:57:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8UzK-0003jT-Hu
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 10:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab0EBI5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 04:57:18 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:56204 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab0EBI5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 04:57:16 -0400
Received: by iwn12 with SMTP id 12so2017867iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4jFtdJnmKlbW7kStvr6e+EJgsVrfEjZHF0+hGUjfTts=;
        b=SI0EuI/O9mwtW341zn7dID1qzfBJiXamUfjDYR90FS0ZliFkc9UFYJ2GJHcn5PlgGD
         aKjzJgICdNNeX+L5Ijzf4CJUkGEN9l5iZYo4UrbUNRnuFkaoWHNjBMgMDqdmCWGBphHV
         VhqO3XEN2aQFAanN47yyOdMsJZKHz7lScAmyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xLM1iZX7ZZoZcpuNgLJsTDmag4D4KJBGg3IYUPiE1KIS8lhy/gkXY4jIhrGr7N02Yw
         6y2SGFLDPrMto7dEGMzr5Ic8JhdkiSjSMVON4q0RRMc16REtB1z5s5PXMMhPY/GWY8qf
         ZEx1Nq6ZNEQSQWAmyzNxiKJ7Ovcb5BZMdvr78=
Received: by 10.231.148.84 with SMTP id o20mr5620784ibv.94.1272790635736;
        Sun, 02 May 2010 01:57:15 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3263256iwn.8.2010.05.02.01.57.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 01:57:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100502084827.GA1690@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146146>

Though I have not seen this in the wild, it has been said that there
are likely to be git repositories converted from other version control
systems with an invalid ident line like this one:

  author <user@example.com> 18746342 +0000

Because there is no space between the (empty) user name and the email
address, commit --amend chokes.  When searching for a
space-left-bracket sequence on the ident line, it finds it in the
committer line, ending up utterly confused.

Better for commit --amend to treat this like a valid ident line with
empty username and complain.

The tests remove the questionable commit objects after use so there is
no chance for them to confuse later tests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.  I look forward to your thoughts.

 builtin/commit.c  |   20 +++++++++++++-------
 t/t7509-commit.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..a3b6fc4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -455,15 +455,21 @@ static void determine_author_info(void)
 		if (!a)
 			die("invalid commit: %s", use_message);
 
-		lb = strstr(a + 8, " <");
-		rb = strstr(a + 8, "> ");
-		eol = strchr(a + 8, '\n');
-		if (!lb || !rb || !eol)
+		lb = strchrnul(a + strlen("\nauthor "), '<');
+		rb = strchrnul(lb, '>');
+		eol = strchrnul(rb, '\n');
+		if (!*lb || !*rb || !*eol)
 			die("invalid commit: %s", use_message);
 
-		name = xstrndup(a + 8, lb - (a + 8));
-		email = xstrndup(lb + 2, rb - (lb + 2));
-		date = xstrndup(rb + 2, eol - (rb + 2));
+		if (lb == a + strlen("\nauthor "))
+			/* \nauthor <foo@example.com> */
+			name = xcalloc(1, 1);
+		else
+			name = xmemdupz(a + strlen("\nauthor "),
+			                (lb - strlen(" ") -
+			                 (a + strlen("\nauthor "))));
+		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
+		date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
 	}
 
 	if (force_author) {
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index d52c060..3ea33db 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -83,6 +83,52 @@ test_expect_success '--amend option copies authorship' '
 	test_cmp expect actual
 '
 
+sha1_file() {
+	echo "$*" | sed "s#..#.git/objects/&/#"
+}
+remove_object() {
+	rm -f $(sha1_file "$*")
+}
+no_reflog() {
+	cp .git/config .git/config.saved &&
+	echo "[core] logallrefupdates = false" >>.git/config &&
+	test_when_finished "mv -f .git/config.saved .git/config" &&
+
+	if test -e .git/logs
+	then
+		mv .git/logs . &&
+		test_when_finished "mv logs .git/"
+	fi
+}
+
+test_expect_success '--amend option with empty author' '
+	git cat-file commit Initial >tmp &&
+	sed "s/author [^<]* </author  </" tmp >empty-author &&
+	no_reflog &&
+	sha=$(git hash-object -t commit -w empty-author) &&
+	test_when_finished "remove_object $sha" &&
+	git checkout $sha &&
+	test_when_finished "git checkout Initial" &&
+	echo "Empty author test" >>foo &&
+	test_tick &&
+	! git commit -a -m "empty author" --amend 2>err &&
+	grep "empty ident" err
+'
+
+test_expect_success '--amend option with missing author' '
+	git cat-file commit Initial >tmp &&
+	sed "s/author [^<]* </author </" tmp >malformed &&
+	no_reflog &&
+	sha=$(git hash-object -t commit -w malformed) &&
+	test_when_finished "remove_object $sha" &&
+	git checkout $sha &&
+	test_when_finished "git checkout Initial" &&
+	echo "Missing author test" >>foo &&
+	test_tick &&
+	! git commit -a -m "malformed author" --amend 2>err &&
+	grep "empty ident" err
+'
+
 test_expect_success '--reset-author makes the commit ours even with --amend option' '
 	git checkout Initial &&
 	echo "Test 6" >>foo &&
-- 
1.7.1
