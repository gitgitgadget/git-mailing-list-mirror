From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] sequencer: write useful reflog message for fast-forward
Date: Wed, 19 Jun 2013 00:05:18 +0530
Message-ID: <1371580518-32455-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up0nZ-0004uj-HQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734Ab3FRSi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:38:29 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:52100 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab3FRSi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:38:28 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so4151582pbc.40
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=x8CkSYJ1OmcjQXH8jIcu6aCXtt/NWl3ocD5yg4QaZ+8=;
        b=OltOLJwAlMHSCt7fzEkF7dh75Bt0dum+0v9VQDLhVJfDQl3TypDOcSEt/+zloVHoUr
         bZHIUplfZEC0KxodKqZvdUY3uRL2ewJodh73Upcd9b6FToYeUU1OVhXgHN4dualqOiyH
         FdY63XedBp3xlwXsoDxJRu5TWOVero7Gun3cn8P8RJN0kziUaqAeyXRYUtaWEVRP5pFP
         5HvnnWqM02Sbj9PkSFrM6UDug3RhGnfjAl1Plrb+7znHq91nYANhM/556rUZN0PpilIF
         UJgLWJWqhAXxnKErD9aOrdp25EMLm5pmC4VCKkKxnU3uluFPakX3ADnNdX/ID2uZl70r
         8FFw==
X-Received: by 10.68.224.136 with SMTP id rc8mr18223354pbc.109.1371580708279;
        Tue, 18 Jun 2013 11:38:28 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id o10sm19346579pbq.39.2013.06.18.11.38.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:38:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.457.gd1408e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228292>

The following command

  $ git cherry-pick --ff b8bb3f

writes the following uninformative message to the reflog

  cherry-pick

Improve it to

  cherry-pick: fast-forward to b8bb3f

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index ab6f8a7..ae63ff3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -273,12 +273,14 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			   int unborn)
 {
 	struct ref_lock *ref_lock;
+	struct strbuf sb = STRBUF_INIT;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
 	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from, 0);
-	return write_ref_sha1(ref_lock, to, "cherry-pick");
+	strbuf_addf(&sb, "cherry-pick: fast-forward to %s", find_unique_abbrev(to, DEFAULT_ABBREV));
+	return write_ref_sha1(ref_lock, to, sb.buf);
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
1.8.3.1.457.gd1408e5
