From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 22/22] update-ref --stdin: pass transaction around explicitly
Date: Tue, 2 Sep 2014 14:11:21 -0700
Message-ID: <20140902211121.GW18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
 <20140902205841.GA18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvMP-0007JR-4W
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbaIBVLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:11:25 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:47627 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbaIBVLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:11:24 -0400
Received: by mail-pa0-f45.google.com with SMTP id bj1so15577850pad.32
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TP+Dv1cttV/7vCTNMWvpZoQWFHo86UppCcBlNpGynzQ=;
        b=UKlOwChF/q8IVd0C3PCFVRupYxei3IojVBBcNp5p/IMifdj9YhHUWzBoWonXmkh/uT
         YBDSi2qkPm8n8RxsLVihGb9hvp7UM9wshk1q5zG6Day/+LfuywUsfP2XxjOEyB2MFvJc
         mvQc7zBWaE/3mL2Q5M2tjOhMzMXDrEEE9KcFNcop+fI5c9xr0+pV/bc9bzpsNzhAnLY3
         8+bTe4In9xclfVGr9BjuxXq+sPZ7tjylleObP9xZK5DdsgpLt66FFHu65uLfTNqaJfYq
         qlgp3/9Z6hN3KRTd/YF+BC08KuS2yPUBOvrm8ox3thOmdEcDiQCN7eha+urdM/gJ6Aj/
         OVhg==
X-Received: by 10.66.119.174 with SMTP id kv14mr50840126pab.52.1409692284281;
        Tue, 02 Sep 2014 14:11:24 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ou6sm4833925pbb.88.2014.09.02.14.11.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:11:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256369>

This makes it more obvious at a glance where the output of functions
parsing the --stdin stream goes.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Thanks for reading.

 builtin/update-ref.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 866bbee..54a48c0 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -12,8 +12,6 @@ static const char * const git_update_ref_usage[] = {
 	NULL
 };
 
-static struct ref_transaction *transaction;
-
 static char line_termination = '\n';
 static int update_flags;
 
@@ -176,7 +174,8 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
  * depending on how line_termination is set.
  */
 
-static const char *parse_cmd_update(struct strbuf *input, const char *next)
+static const char *parse_cmd_update(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -209,7 +208,8 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	return next;
 }
 
-static const char *parse_cmd_create(struct strbuf *input, const char *next)
+static const char *parse_cmd_create(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -239,7 +239,8 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	return next;
 }
 
-static const char *parse_cmd_delete(struct strbuf *input, const char *next)
+static const char *parse_cmd_delete(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -273,7 +274,8 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	return next;
 }
 
-static const char *parse_cmd_verify(struct strbuf *input, const char *next)
+static const char *parse_cmd_verify(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -317,7 +319,7 @@ static const char *parse_cmd_option(struct strbuf *input, const char *next)
 	return next + 8;
 }
 
-static void update_refs_stdin(void)
+static void update_refs_stdin(struct ref_transaction *transaction)
 {
 	struct strbuf input = STRBUF_INIT;
 	const char *next;
@@ -332,13 +334,13 @@ static void update_refs_stdin(void)
 		else if (isspace(*next))
 			die("whitespace before command: %s", next);
 		else if (starts_with(next, "update "))
-			next = parse_cmd_update(&input, next + 7);
+			next = parse_cmd_update(transaction, &input, next + 7);
 		else if (starts_with(next, "create "))
-			next = parse_cmd_create(&input, next + 7);
+			next = parse_cmd_create(transaction, &input, next + 7);
 		else if (starts_with(next, "delete "))
-			next = parse_cmd_delete(&input, next + 7);
+			next = parse_cmd_delete(transaction, &input, next + 7);
 		else if (starts_with(next, "verify "))
-			next = parse_cmd_verify(&input, next + 7);
+			next = parse_cmd_verify(transaction, &input, next + 7);
 		else if (starts_with(next, "option "))
 			next = parse_cmd_option(&input, next + 7);
 		else
@@ -373,6 +375,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 
 	if (read_stdin) {
 		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
 
 		transaction = ref_transaction_begin(&err);
 		if (!transaction)
@@ -381,7 +384,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
-		update_refs_stdin();
+		update_refs_stdin(transaction);
 		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
-- 
2.1.0.rc2.206.gedb03e5
