From: Simon Sasburg <simon.sasburg@gmail.com>
Subject: [PATCH] Make git-mailsplit strip whitespace from the start of the mailbox file.
Date: Thu,  1 Nov 2007 23:57:45 +0100
Message-ID: <1193957865-3904-1-git-send-email-Simon.Sasburg@gmail.com>
References: <7vr6j98uw5.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Simon Sasburg <Simon.Sasburg@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 01 23:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InizM-00084K-4p
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbXKAW56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbXKAW55
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:57:57 -0400
Received: from hu-out-0506.google.com ([72.14.214.233]:43949 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXKAW55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:57:57 -0400
Received: by hu-out-0506.google.com with SMTP id 19so269688hue
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 15:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=mFZp+3KFR7O0B6Ux0uaoqz4EEZgYP3VEKkHCLA7pYx0=;
        b=jnVU7bMVAASprdzqI5MERXEChmgiH+pJcme4oMr1es46OTxwJ5gN59cShUte8qmdYEAEgtzIcLhs5eQZbsr7sfg7I1Tbb+ydmFgocuYp6QPQkD0UP+T2JmJ18HgqDw6lqGejEmrUf3QqEdgivd++5dUW/Ui4ZVlSQTt009y/R1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=J1JI9NCxWMpW+nEqpjkmZsnBv33YHBaip6Rp+UEBd6VNaEsG57lR65LxPZb3tgzL9lBN8f9ySdKZKFTBJvguES+s7gcj09o9OZLs1LgF+YTYeZW5dp1Dcjq75zAlNDwHgVx4Wx0wFXDsbqxkbqlKy8KPydOgUU2xLibAFDF0yLw=
Received: by 10.67.19.17 with SMTP id w17mr298075ugi.1193957875428;
        Thu, 01 Nov 2007 15:57:55 -0700 (PDT)
Received: from localhost ( [86.85.232.104])
        by mx.google.com with ESMTPS id s1sm2593336uge.2007.11.01.15.57.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 15:57:53 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.504.gdf75-dirty
In-Reply-To: <7vr6j98uw5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63033>

Signed-off-by: Simon Sasburg <Simon.Sasburg@gmail.com>
---

Ah, i see.

Well, this patch also fixes the problem in my case.

 builtin-mailsplit.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 43fc373..3fdeb23 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -164,6 +164,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 {
 	char name[PATH_MAX];
 	int ret = -1;
+	int peek;
 
 	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
 	int file_done = 0;
@@ -173,6 +174,11 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 		goto out;
 	}
 
+	do {
+		peek = fgetc(f);
+	} while (peek == ' ' || peek == '\r' || peek == '\n');
+	ungetc(peek, f);
+
 	if (fgets(buf, sizeof(buf), f) == NULL) {
 		/* empty stdin is OK */
 		if (f != stdin) {
-- 
1.5.3.4.504.gdf75-dirty
