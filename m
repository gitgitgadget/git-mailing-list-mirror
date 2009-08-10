From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH (resend) 3/3] Check return value of ftruncate call in http.c
Date: Tue, 11 Aug 2009 00:05:06 +0800
Message-ID: <20090811000506.c63eb8f1.rctay89@gmail.com>
References: <be6fef0d0908100847h7e9b53a2ofdf318e9958be3b2@mail.gmail.com>
 <20090810235548.110c43a6.rctay89@gmail.com>
 <20090810235955.1a659e6c.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff Lasslett <jeff.lasslett@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 10 18:05:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXNh-00076K-UP
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbZHJQFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755584AbZHJQFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:05:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:25184 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588AbZHJQFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:05:15 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1031784rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=L+9Ksp+V6m6esLPfear0WENV14vUFrh0FgQCZhv0iho=;
        b=c/LsWuj3rhHp09LkkRluWk4O2ttqBHRuMoug4HyqzJEfYnhrqHkZIzSPSWhBvhC1qR
         31Xuh9kMp1/NYJh5N0GprBHVHvzAlJTW+Dc8u8RQGJtEoeTSMigcV8ye2m8lBnAN6eLY
         wd1vS2oaiST1aTwuNIsl5xD0rjoVNpDwBqfDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=Xv4fLFhO8IfLpOWhsW5bKRykjiqzBrNtq0GZToGM+6icxE+T3RkeirsWTI0GBDmU56
         8O9U6Qtl/ZH7LzRCkU/9zaP5Assh7q57sOoIzKUzCQluJVEmZq5H85L1m0/PLgHKwNRo
         tyurT9sz3nVIxfXlWkyhYImMKWNRNtsMXe4yQ=
Received: by 10.140.166.20 with SMTP id o20mr1899257rve.75.1249920316394;
        Mon, 10 Aug 2009 09:05:16 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta152.maxonline.com.sg [116.87.152.189])
        by mx.google.com with ESMTPS id k41sm22925970rvb.18.2009.08.10.09.05.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 09:05:15 -0700 (PDT)
In-Reply-To: <20090810235955.1a659e6c.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125474>

From: Jeff Lasslett <jeff.lasslett@gmail.com>

In new_http_object_request(), check ftruncate() call return value and
handle possible errors.

Signed-off-by: Jeff Lasslett <jeff.lasslett@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

 Jeff, I took out all the url-specific cleanups and expanded their
 scope (see earlier patches). You can safely focus on ftruncate() and
 do an abort there. :)

 http.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 98f9707..14d5357 100644
--- a/http.c
+++ b/http.c
@@ -1187,7 +1187,11 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		if (prev_posn>0) {
 			prev_posn = 0;
 			lseek(freq->localfile, 0, SEEK_SET);
-			ftruncate(freq->localfile, 0);
+			if (ftruncate(freq->localfile, 0) < 0) {
+				error("Couldn't truncate temporary file %s for %s: %s",
+					  freq->tmpfile, freq->filename, strerror(errno));
+				goto abort;
+			}
 		}
 	}

--
1.6.3.1
