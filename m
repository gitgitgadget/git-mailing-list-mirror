Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65440201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 21:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbdBUVZV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 16:25:21 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33146 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbdBUVYv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 16:24:51 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so20053105pgj.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4ri07Kc7zKS46lkKJryL+52TsDCGlAEZ0ZrwxGGaaqo=;
        b=AZUCAKkjmRXwDg5sZbEZi/AqdAWLEhWfFsjIGSmbzIGMmYwRbmZ4GDjWSIlw/69Nc9
         3OdvQyNsHnBGiJNspQ/XGo4dQRrUh8XJj9nUktbRBI5eDImbqvmAfGBeL5HqDiZ0Ayqb
         CU4XJ08K+MJH+9a/2a1qSRSdA5rk3g+i1Ec/WJjrBaxTeVDBcp0v7fw7b/a9F6Cptp5O
         HgQt1OngSD9ehUXkMDr6KAMyM2YMfCkkJ7mvYle8h2FTHcp2kZ61ZCQzXydmBIqcHqRr
         dKoVYRzIJoZyhYC39CpVQyaM4fhC+ZdG/HNf6On6ACmRvuwPL0OrLTwQhrryLUcuMGq1
         drjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4ri07Kc7zKS46lkKJryL+52TsDCGlAEZ0ZrwxGGaaqo=;
        b=XcJ/zHDBLjV94vpovyuGzdKZLUElYfUoap5geosura1wBRtE0/LM8VyvmyHmhcanJt
         mvRQLvFeju9yloRa9APSjdPUPsDUcWI3uOBEjsM2MQ0JYhV5ENJ25Jaz1HOQxCxPW/W/
         u6SfeXW17Kw7+hmwXrdRb4wOAbmHtuFHvaXj4hBZ4YJqQ5OKHz2XGHnxMfn8mkIxyn+W
         YfZ+SyqRrPXH8iVqL8i9+N59wGQ5ewwRMys1NzkdEuWRnZ5nxdONYj7zFw4q9TXmIbkH
         XI4ViyQY9hUsk4EyRKMAeg5uL4Cs5YEiClm9YKe62PQ5mNa4raOWwVbAi5UW/RQQa/xw
         iamQ==
X-Gm-Message-State: AMke39npSbuFDlmzaW12wKFPI8vfl1l7jRo7aoD9WXBw0hKvNT2tgWoquvJA/+fRphG3Fw==
X-Received: by 10.84.213.137 with SMTP id g9mr43004817pli.114.1487712280048;
        Tue, 21 Feb 2017 13:24:40 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id j127sm19538784pfg.89.2017.02.21.13.24.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 13:24:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "git\@vger.kernel.org" <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
        <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
        <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 21 Feb 2017 13:24:38 -0800
In-Reply-To: <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 21 Feb 2017 12:33:59 -0800")
Message-ID: <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parsing of one-shot assignments of configuration variables that
come from the command line historically was quite loose and allowed
anything to pass.

The configuration variable names that come from files are validated
in git_config_parse_source(), which uses get_base_var() that grabs
the <section> (and subsection) while making sure that <section>
consists of iskeychar() letters, the function itself that makes sure
that the first letter in <variable> is isalpha(), and get_value()
that grabs the remainder of the <variable> name while making sure
that it consists of iskeychar() letters.

Perform an equivalent check in canonicalize_config_variable_name()
to catch invalid configuration variable names that come from the
command line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Now with an updated test; while writing it it uncovered a bug in
   the original test that expected to fail---they failed alright but
   sometimes failed for a wrong reason.

 config.c               | 48 +++++++++++++++++++++++++++++++++++++-----------
 t/t1300-repo-config.sh | 16 ++++++++++++++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 4128debc71..e7f7ff1938 100644
--- a/config.c
+++ b/config.c
@@ -199,32 +199,62 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
+static inline int iskeychar(int c)
+{
+	return isalnum(c) || c == '-';
+}
+
 /*
  * downcase the <section> and <variable> in <section>.<variable> or
  * <section>.<subsection>.<variable> and do so in place.  <subsection>
  * is left intact.
+ *
+ * The configuration variable names that come from files are validated
+ * in git_config_parse_source(), which uses get_base_var() that grabs
+ * the <section> (and subsection) while making sure that <section>
+ * consists of iskeychar() letters, the function itself that makes
+ * sure that the first letter in <variable> is isalpha(), and
+ * get_value() that grabs the remainder of the <variable> name while
+ * making sure that it consists of iskeychar() letters.  Perform a
+ * matching validation for configuration variables that come from
+ * the command line.
  */
-static void canonicalize_config_variable_name(char *varname)
+static int canonicalize_config_variable_name(char *varname)
 {
-	char *cp, *last_dot;
+	char *cp, *first_dot, *last_dot;
 
 	/* downcase the first segment */
 	for (cp = varname; *cp; cp++) {
 		if (*cp == '.')
 			break;
+		if (!iskeychar(*cp))
+			return -1;
 		*cp = tolower(*cp);
 	}
 	if (!*cp)
-		return;
+		return -1; /* no dot anywhere? */
+
+	first_dot = cp;
+	if (first_dot == varname)
+		return -1; /* no section? */
 
 	/* find the last dot (we start from the first dot we just found) */
-	for (last_dot = cp; *cp; cp++)
+	for (; *cp; cp++)
 		if (*cp == '.')
 			last_dot = cp;
 
+	if (!last_dot[1])
+		return -1; /* no variable? */
+
 	/* downcase the last segment */
-	for (cp = last_dot; *cp; cp++)
+	for (cp = last_dot + 1; *cp; cp++) {
+		if (cp == last_dot + 1 && !isalpha(*cp))
+			return -1;
+		else if (!iskeychar(*cp))
+			return -1;
 		*cp = tolower(*cp);
+	}
+	return 0;
 }
 
 int git_config_parse_parameter(const char *text,
@@ -249,7 +279,8 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	canonicalize_config_variable_name(pair[0]->buf);
+	if (canonicalize_config_variable_name(pair[0]->buf))
+		return error("bogus config parameter: %s", text);
 	if (fn(pair[0]->buf, value, data) < 0) {
 		strbuf_list_free(pair);
 		return -1;
@@ -382,11 +413,6 @@ static char *parse_value(void)
 	}
 }
 
-static inline int iskeychar(int c)
-{
-	return isalnum(c) || c == '-';
-}
-
 static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 {
 	int c;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 7a16f66a9d..ea371020fa 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1143,6 +1143,22 @@ test_expect_success 'last one wins: three level vars' '
 	test_cmp expect actual
 '
 
+for VAR in a .a a. a.0b a."b c". a."b c".0d
+do
+	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
+		test_must_fail git -c "$VAR=VAL" config -l
+	'
+done
+
+for VAR in a.b a."b c".d
+do
+	test_expect_success "git -c $VAR=VAL works with valid '$VAR'" '
+		echo VAL >expect &&
+		git -c "$VAR=VAL" config --get "$VAR" >actual &&
+		test_cmp expect actual
+	'
+done
+
 test_expect_success 'git -c is not confused by empty environment' '
 	GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list
 '
-- 
2.12.0-rc2-222-gff02733afe

