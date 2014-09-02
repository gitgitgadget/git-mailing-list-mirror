From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/22] update-ref --stdin: narrow scope of err strbuf
Date: Tue, 2 Sep 2014 14:10:52 -0700
Message-ID: <20140902211052.GV18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:11:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvLv-00075J-JC
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbaIBVKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:10:55 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59759 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbaIBVKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:10:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so15713427pac.33
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+CCwSH2m2bVhNuPpCkWbbNsxpgzoygCDNFkuP29aM2c=;
        b=WTrj7Ck6pzx3c5wq6Z4yKbpdd6KHL4al1py3ySBwxZgWLgvT7AITm3qjVQKho7n0pD
         EZndQVFNdHau7ZFX4IM2eqHJfC0dj24L2FnYVygMCWaYBK3pA09I1/SMtAg3zlr5PTJs
         3RkI+1h7QGfVM62E/YOjne3xsS+aGidzh/53u7F2FzvC8w7CoqAFPYhkjbIgqXfZ7Ywd
         4T612dMWHnNniPRQ17yFEwXbgP6/5vJ2+xoKDc7SbDLEXtwJg0J1BUZN0bcfA4o+er/Q
         3VYWgfqpllyqjaAyxq94tWMQHLlgPGcUP2X9K8QLttPLVXTtBQ2YmakatmMm3V5BZ24B
         2axg==
X-Received: by 10.66.136.12 with SMTP id pw12mr30229699pab.71.1409692254648;
        Tue, 02 Sep 2014 14:10:54 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id bn4sm4904222pbc.40.2014.09.02.14.10.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:10:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256367>

Making the strbuf local in each function that needs to print errors
saves the reader from having to think about action at a distance,
such as

 * errors piling up and being concatenated with no newline between
   them
 * errors unhandled in one function, to be later handled in another
 * concurrency issues, if this code starts using threads some day

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 96a53b9..866bbee 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -16,7 +16,6 @@ static struct ref_transaction *transaction;
 
 static char line_termination = '\n';
 static int update_flags;
-static struct strbuf err = STRBUF_INIT;
 
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
@@ -179,6 +178,7 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
 
 static const char *parse_cmd_update(struct strbuf *input, const char *next)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
@@ -204,12 +204,14 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 
 	update_flags = 0;
 	free(refname);
+	strbuf_release(&err);
 
 	return next;
 }
 
 static const char *parse_cmd_create(struct strbuf *input, const char *next)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	unsigned char new_sha1[20];
 
@@ -232,12 +234,14 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 
 	update_flags = 0;
 	free(refname);
+	strbuf_release(&err);
 
 	return next;
 }
 
 static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	unsigned char old_sha1[20];
 	int have_old;
@@ -264,12 +268,14 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 
 	update_flags = 0;
 	free(refname);
+	strbuf_release(&err);
 
 	return next;
 }
 
 static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
@@ -297,6 +303,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 
 	update_flags = 0;
 	free(refname);
+	strbuf_release(&err);
 
 	return next;
 }
@@ -365,6 +372,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
+		struct strbuf err = STRBUF_INIT;
+
 		transaction = ref_transaction_begin(&err);
 		if (!transaction)
 			die("%s", err.buf);
-- 
2.1.0.rc2.206.gedb03e5
