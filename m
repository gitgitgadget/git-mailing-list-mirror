From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/20] replace.c: use the ref transaction functions for
 updates
Date: Tue, 26 Aug 2014 17:31:21 -0700
Message-ID: <20140827003121.GG20185@google.com>
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
X-From: git-owner@vger.kernel.org Wed Aug 27 02:31:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMR98-0005zJ-2o
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211AbaH0Ab0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:31:26 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57739 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbaH0AbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:31:25 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so24579844pab.12
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eRxUHEsSiEwJD2jdWnw98OC3M0S/QmZKZ3j9Km6LItI=;
        b=W/61rNw/bj7dzJoYhJhE7Va1U1jDzd+955Gh1OZ6Icwk5b/Zs2RaEEGIqJRARNAqgb
         nS+LqQCTiIruxrPHocwuFPClKGIXhdY+HOJb8xxegzljZy0Qw6G/qGrxrCFbzdvbI/U8
         O1H3JA1BPNofdWNiZDCGr4/4q5PFXHtpac3sw6itCGQRZKT66Ad4EXYTwLc5KebgchMX
         hOSJBA0IPnncJdx2Mml+Sdj3H1Aulzlx62mtPKC5n+XjW3dm+qTgnTUEOWySnQxwlpPD
         3lzVMsE54ysOeTboVWt1gHG5xEKMfOuAI0atJQDodULaY4aC85BHlDgs93ItOZu2H4WQ
         LX9w==
X-Received: by 10.68.104.98 with SMTP id gd2mr41747820pbb.13.1409099485565;
        Tue, 26 Aug 2014 17:31:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id pm1sm6864075pdb.58.2014.08.26.17.31.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:31:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255962>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Apr 2014 15:32:29 -0700

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
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
