From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v22 0/22] rs/ref-transaction-1 (Re: Transaction patch series
 overview)
Date: Tue, 2 Sep 2014 13:58:42 -0700
Message-ID: <20140902205841.GA18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvAE-0008KD-5L
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 22:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbaIBU6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 16:58:49 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39927 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176AbaIBU6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 16:58:48 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so15667459pac.11
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r+lMFB4vTCR6Bam59nIlKamkH0bERTyX76IvrSqhiNg=;
        b=NEZL6i35JCHU//ai2OeQ5BYtTMtWqve7fugESrRmM8wtAdi+sY9CaN57PJZUQ+6xb/
         J78d/jt55SGIdV9dfHNUt5iTAxEkRTpPRmnmv6TiCu4NVKvzD5nbJ6VP7oV+cKbPDqC8
         YCAHYdXTXg0zF43AtOMbFJI/yLN+xGVgnyArZ87GO8uNXet/L9NmrZBVB9KDbc+AB4WA
         cYLsZH/8CEhdh1dZ94ObogPBZ7nxJleAGGD6ifJXlkPCazO3aKVyC3157IzrA7Dr3Wcb
         zCV55br1PMXlYuliN3DsXOEjYvz0eLgtugjfl36r1QQX4hyUlsrikaPfP9VrZfbnq3/b
         JYNg==
X-Received: by 10.70.64.196 with SMTP id q4mr23403863pds.131.1409691528182;
        Tue, 02 Sep 2014 13:58:48 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id n4sm6722218pdk.57.2014.09.02.13.58.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 13:58:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256346>

Hi Junio,

Michael reviewed the rest of rs/ref-transaction-1 (thanks!) and some
more small tweaks resulted --- in particular, there was a missing call
to ref_transaction_free.  Interdiff below.  This is meant to replace
rs/ref-transaction-1 in 'pu' and should be ready for 'next'.

These patches are also available from the git repository at

  git://repo.or.cz/git/jrn.git tags/rs/ref-transaction-1

"Use ref transactions", early part

Ronnie explains:

	This patch series expands on the transaction API. It converts
	ref updates, inside refs.c as well as external, to use the
	transaction API for updates. This makes most ref updates
	atomic when there are failures locking or writing to a ref.

This series teaches the tag, replace, commit, cherry-pick, fast-import,
checkout -b, branch, receive-pack, and http-fetch commands and all
update_ref and delete_ref callers to use the ref transaction API instead
of lock_ref_sha1.

The main user-visible change should be some cosmetic changes to error
messages.  The series also combines multiple ref updates into a single
transaction in 'git http-fetch -w' and when writing tags in fast-import
but otherwise doesn't change the granularity of transactions.

Jonathan Nieder (2):
      update-ref --stdin: narrow scope of err strbuf
      update-ref --stdin: pass transaction around explicitly

Ronnie Sahlberg (20):
      refs.c: change ref_transaction_create to do error checking and return status
      refs.c: update ref_transaction_delete to check for error and return status
      refs.c: make ref_transaction_begin take an err argument
      refs.c: add transaction.status and track OPEN/CLOSED
      tag.c: use ref transactions when doing updates
      replace.c: use the ref transaction functions for updates
      commit.c: use ref transactions for updates
      sequencer.c: use ref transactions for all ref updates
      fast-import.c: change update_branch to use ref transactions
      branch.c: use ref transaction for all ref updates
      refs.c: change update_ref to use a transaction
      receive-pack.c: use a reference transaction for updating the refs
      fast-import.c: use a ref transaction when dumping tags
      walker.c: use ref transaction for ref updates
      refs.c: make lock_ref_sha1 static
      refs.c: remove the update_ref_lock function
      refs.c: remove the update_ref_write function
      refs.c: remove lock_ref_sha1
      refs.c: make prune_ref use a transaction to delete the ref
      refs.c: make delete_ref use a transaction

 branch.c               |  31 ++++---
 builtin/commit.c       |  25 +++--
 builtin/receive-pack.c |  25 +++--
 builtin/replace.c      |  14 +--
 builtin/tag.c          |  16 ++--
 builtin/update-ref.c   |  52 +++++++----
 fast-import.c          |  54 +++++++----
 refs.c                 | 245 ++++++++++++++++++++++++++++---------------------
 refs.h                 |  77 ++++++++++++----
 sequencer.c            |  26 ++++--
 walker.c               |  70 ++++++++------
 11 files changed, 393 insertions(+), 242 deletions(-)
---
Changes since v21:

 builtin/update-ref.c | 38 +++++++++++++++++++++++++-------------
 refs.c               |  1 +
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git c/builtin/update-ref.c w/builtin/update-ref.c
index 96a53b9..54a48c0 100644
--- c/builtin/update-ref.c
+++ w/builtin/update-ref.c
@@ -12,11 +12,8 @@ static const char * const git_update_ref_usage[] = {
 	NULL
 };
 
-static struct ref_transaction *transaction;
-
 static char line_termination = '\n';
 static int update_flags;
-static struct strbuf err = STRBUF_INIT;
 
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
@@ -177,8 +174,10 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
  * depending on how line_termination is set.
  */
 
-static const char *parse_cmd_update(struct strbuf *input, const char *next)
+static const char *parse_cmd_update(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
@@ -204,12 +203,15 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 
 	update_flags = 0;
 	free(refname);
+	strbuf_release(&err);
 
 	return next;
 }
 
-static const char *parse_cmd_create(struct strbuf *input, const char *next)
+static const char *parse_cmd_create(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	unsigned char new_sha1[20];
 
@@ -232,12 +234,15 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 
 	update_flags = 0;
 	free(refname);
+	strbuf_release(&err);
 
 	return next;
 }
 
-static const char *parse_cmd_delete(struct strbuf *input, const char *next)
+static const char *parse_cmd_delete(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	unsigned char old_sha1[20];
 	int have_old;
@@ -264,12 +269,15 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 
 	update_flags = 0;
 	free(refname);
+	strbuf_release(&err);
 
 	return next;
 }
 
-static const char *parse_cmd_verify(struct strbuf *input, const char *next)
+static const char *parse_cmd_verify(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
+	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
@@ -297,6 +305,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 
 	update_flags = 0;
 	free(refname);
+	strbuf_release(&err);
 
 	return next;
 }
@@ -310,7 +319,7 @@ static const char *parse_cmd_option(struct strbuf *input, const char *next)
 	return next + 8;
 }
 
-static void update_refs_stdin(void)
+static void update_refs_stdin(struct ref_transaction *transaction)
 {
 	struct strbuf input = STRBUF_INIT;
 	const char *next;
@@ -325,13 +334,13 @@ static void update_refs_stdin(void)
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
@@ -365,6 +374,9 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
+		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
+
 		transaction = ref_transaction_begin(&err);
 		if (!transaction)
 			die("%s", err.buf);
@@ -372,7 +384,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
-		update_refs_stdin();
+		update_refs_stdin(transaction);
 		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
diff --git c/refs.c w/refs.c
index 7996be9..7235574 100644
--- c/refs.c
+++ w/refs.c
@@ -3511,6 +3511,7 @@ int update_ref(const char *action, const char *refname,
 		return 1;
 	}
 	strbuf_release(&err);
+	ref_transaction_free(t);
 	return 0;
 }
 
