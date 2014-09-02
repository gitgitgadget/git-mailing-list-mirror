From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/22] refs.c: make ref_transaction_begin take an err argument
Date: Tue, 2 Sep 2014 14:00:39 -0700
Message-ID: <20140902210039.GD18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:00:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvC2-0000zV-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbaIBVAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:00:43 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:41604 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbaIBVAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:00:42 -0400
Received: by mail-pd0-f180.google.com with SMTP id p10so9512664pdj.39
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+y9Aiv2xkD+nEMB3WvD2Hy5UvT+UBei++Zf/POiAys4=;
        b=ND6PkncWTSX2s/JyhJY64QSAYFv/XWx3W8zZ/Fs8IPyabAvUravYbbCCLaf6Q3CeJg
         ZR1XvLyICBVfHFGBXqIzvcPkft2TmYjRPdor4QMbaNx4p4SEp3r9uatFhzcFH4FqN/Up
         Jn8n5cTV1idEPhIvehpZE01tqdzymYsQxGEbPX4tJJ4NhywgdmC3h3ABYxtRj8cRm+6Q
         pe07f8C4v0OsPsgaWFAQU20R3AT7IS/k3n6S0w1qgltguzBv2/QFn1rHGlYu9IPBlIWx
         s6RefQuVgB8R57cYZUY/7S/cMJgsyGn583uT1zBwS3OGiZPQE3YclG3wZh6+iULvSVb3
         K18A==
X-Received: by 10.68.105.197 with SMTP id go5mr50135356pbb.73.1409691642360;
        Tue, 02 Sep 2014 14:00:42 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id mx3sm6679687pdb.81.2014.09.02.14.00.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:00:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256349>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 19 May 2014 10:42:34 -0700

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _begin with
"Can not connect to MySQL server. No route to host".

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/update-ref.c | 5 ++++-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7c9c248..96a53b9 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,9 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
+		if (!transaction)
+			die("%s", err.buf);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
@@ -374,6 +376,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return 0;
 	}
 
diff --git a/refs.c b/refs.c
index 40f04f4..9cb7908 100644
--- a/refs.c
+++ b/refs.c
@@ -3397,7 +3397,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index 71389a1..3f37c65 100644
--- a/refs.h
+++ b/refs.h
@@ -262,7 +262,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.1.0.rc2.206.gedb03e5
