From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] pretty: Respect --abbrev option
Date: Mon, 3 May 2010 22:18:57 -0500
Message-ID: <20100504031856.GF7322@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
 <20100504002526.GA7061@progeny.tock>
 <20100504015635.GA7258@progeny.tock>
 <20100504025217.GA7322@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 05:18:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O98en-00019i-VG
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 05:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537Ab0EDDSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 23:18:44 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:63062 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab0EDDSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 23:18:43 -0400
Received: by iwn40 with SMTP id 40so4282562iwn.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 20:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cLHRyIJF0Cv4OHOT8TFlUhc/3wvmfst35sYfLMbBm18=;
        b=M0HXfJR9jnCOKVoIWPscgN3+U8G42/rZdgnp/Y6mtzCj69MWgAkRuvVB3tEURFR/TZ
         1y9uCyS2eeiLLbmzKiMoFn/9k+I8sMys0jL/PAK2vZ+qB6JPPPhfbGtu7OJt7HpOKurr
         tMciADd4bF68h1PJO3ydzHuZh1cO4y3NMbgGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AzWVZFiLLmChoNyOP55DXRFkyKgBB0Fe+6I6Ue+LR05EClrC50VvrWtSNdHJu3xCo0
         1omB6JQCN7F2NjVvueJFi6JFRAMgSLRDrscwz/u4mjJgPV7y3KOBlYV3wU9pnKFFzVET
         kZqq3l4T7hDTZDGkhOcA+zKRBLih4nKZ6A+WY=
Received: by 10.231.159.210 with SMTP id k18mr1358753ibx.59.1272943122789;
        Mon, 03 May 2010 20:18:42 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4881793iwn.4.2010.05.03.20.18.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 20:18:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100504025217.GA7322@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146287>

Prior to this, the output of git log -1 --format=%h was always 7
characters long, without regard to whether --abbrev had been passed.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
incorporating some tests by Will Palmer:
http://thread.gmane.org/gmane.comp.version-control.git/146054/focus=146057

 builtin/shortlog.c         |    3 ++-
 pretty.c                   |    7 ++++---
 shortlog.h                 |    1 +
 t/t4201-shortlog.sh        |    2 +-
 t/t6006-rev-list-format.sh |   31 +++++++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 06320f5..5089502 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -162,7 +162,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		    sha1_to_hex(commit->object.sha1));
 	if (log->user_format) {
 		struct pretty_print_context ctx = {0};
-		ctx.abbrev = DEFAULT_ABBREV;
+		ctx.abbrev = log->abbrev;
 		ctx.subject = "";
 		ctx.after_subject = "";
 		ctx.date_mode = DATE_NORMAL;
@@ -290,6 +290,7 @@ parse_done:
 	}
 
 	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
+	log.abbrev = rev.abbrev;
 
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
diff --git a/pretty.c b/pretty.c
index 7cb3a2a..1430616 100644
--- a/pretty.c
+++ b/pretty.c
@@ -716,7 +716,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		if (add_again(sb, &c->abbrev_commit_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
-		                                     DEFAULT_ABBREV));
+		                                     c->pretty_ctx->abbrev));
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
@@ -726,7 +726,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		if (add_again(sb, &c->abbrev_tree_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
-		                                     DEFAULT_ABBREV));
+		                                     c->pretty_ctx->abbrev));
 		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
 		return 1;
 	case 'P':		/* parent hashes */
@@ -743,7 +743,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, find_unique_abbrev(
-					p->item->object.sha1, DEFAULT_ABBREV));
+					p->item->object.sha1,
+					c->pretty_ctx->abbrev));
 		}
 		c->abbrev_parent_hashes.len = sb->len -
 		                              c->abbrev_parent_hashes.off;
diff --git a/shortlog.h b/shortlog.h
index bc02cc2..de4f86f 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -12,6 +12,7 @@ struct shortlog {
 	int in1;
 	int in2;
 	int user_format;
+	int abbrev;
 
 	char *common_repo_prefix;
 	int email;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 899ddbe..c49ca98 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -79,7 +79,7 @@ test_expect_success 'pretty format' '
 	test_cmp expect log.predictable
 '
 
-test_expect_failure '--abbrev' '
+test_expect_success '--abbrev' '
 	sed s/SUBJECT/OBJID/ expect.template >expect &&
 	git shortlog --format="%h" --abbrev=5 >log &&
 	fuzz log >log.predictable &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a49b7c5..42a77ff 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -191,6 +191,31 @@ test_expect_success 'add LF before non-empty (2)' '
 	grep "^$" actual
 '
 
+test_expect_success '--abbrev' '
+	echo SHORT SHORT SHORT >expect2 &&
+	echo LONG LONG LONG >expect3 &&
+	git log -1 --format="%h %h %h" HEAD >actual1 &&
+	git log -1 --abbrev=5 --format="%h %h %h" HEAD >actual2 &&
+	git log -1 --abbrev=5 --format="%H %H %H" HEAD >actual3 &&
+	sed -e "s/$_x40/LONG/g" -e "s/$_x05/SHORT/g" <actual2 >fuzzy2 &&
+	sed -e "s/$_x40/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
+	test_cmp expect2 fuzzy2 &&
+	test_cmp expect3 fuzzy3 &&
+	! test_cmp actual1 actual2
+'
+
+test_expect_success '%H is not affected by --abbrev-commit' '
+	git log -1 --format=%H --abbrev-commit --abbrev=20 HEAD >actual &&
+	len=$(wc -c <actual) &&
+	test $len = 40
+'
+
+test_expect_success '%h is not affected by --abbrev-commit' '
+	git log -1 --format=%h --abbrev-commit --abbrev=20 HEAD >actual &&
+	len=$(wc -c <actual) &&
+	test $len = 20
+'
+
 test_expect_success '"%h %gD: %gs" is same as git-reflog' '
 	git reflog >expect &&
 	git log -g --format="%h %gD: %gs" >actual &&
@@ -203,6 +228,12 @@ test_expect_success '"%h %gD: %gs" is same as git-reflog (with date)' '
 	test_cmp expect actual
 '
 
+test_expect_success '"%h %gD: %gs" is same as git-reflog (with --abbrev)' '
+	git reflog --abbrev=13 --date=raw >expect &&
+	git log -g --abbrev=13 --format="%h %gD: %gs" --date=raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '%gd shortens ref name' '
 	echo "master@{0}" >expect.gd-short &&
 	git log -g -1 --format=%gd refs/heads/master >actual.gd-short &&
-- 
1.7.1
