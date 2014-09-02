From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/22] replace.c: use the ref transaction functions for
 updates
Date: Tue, 2 Sep 2014 14:01:48 -0700
Message-ID: <20140902210148.GG18279@google.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 02 23:01:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvDA-0001g8-G4
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbaIBVBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:01:52 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:53294 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbaIBVBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:01:52 -0400
Received: by mail-pd0-f177.google.com with SMTP id r10so9404526pdi.8
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GHoZgts0LgtNowBT3bWvSX6TvuoJ92dprZ8tu6LKRNQ=;
        b=wICb6Sfd/SFe56RipZRZVZoyRw8GFH+XkBSnc6VHLaxizk3AEhi7cB1iZazV4f/X8f
         pEYph4Y6etoyUYxaImn9goxYIiKLdYlNZ2fSu0TlliXrLRdXS21mVzDQc3nJcZihrkkJ
         eycbQ22s/Tp61yLh4q1A1CJqckjSIdr0Iuc13S4BjKjaFNp6JmZEaveu/4tHR1tgbB5v
         SLH0BZMYsMZrsdsQq0KoBHbUf6zvVU456vdYAdFYFXUJYeD6DmdRPZAxsf97fN7zv13p
         XW0ctJcreu921LDbbwn9Vbde8CVF5SRFHMmKCEB9HGlNyXzgftpt1rk4dq8CN/h1W8zo
         i6uA==
X-Received: by 10.70.45.74 with SMTP id k10mr49600887pdm.78.1409691711797;
        Tue, 02 Sep 2014 14:01:51 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id yw4sm4850946pbc.69.2014.09.02.14.01.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:01:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256352>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Apr 2014 15:32:29 -0700

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/replace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 1bb491d..1fcd06d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -153,7 +153,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
@@ -166,12 +167,13 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev, 0, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.1.0.rc2.206.gedb03e5
