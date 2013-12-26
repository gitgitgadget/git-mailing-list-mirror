From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] rename_ref(): fix a mkdir()/rmdir() race
Date: Thu, 26 Dec 2013 15:20:23 -0800
Message-ID: <20131226232023.GA20443@google.com>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
 <1387696451-32224-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 27 00:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwKEE-0000kH-5b
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 00:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab3LZXUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 18:20:30 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:37257 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab3LZXU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 18:20:29 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so1860055yhz.8
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iAT05vzT66hThtkMhixnDMnnGmZiqtZVcJ6dHkE2nYk=;
        b=F39gqi+mW0LV1LrFh274uyc1yOb5/gvLCASbSAHxLjPHSsEGMyEKDjDywmEeFlHlZN
         YSaOIzGM540YnwiM08R1Lksl2c1mFpxkCjNDAXN8BMnCe3Mwoe4jFbmJQBO2d2UzUd01
         TkCN0CcbCaki/ukAlKmTUzGtBULbpFQ/XFrfUltRvuYLeGWo387Pz/e/hX7/Nk+WmLCT
         zgQpSTZ4FIhSFYGqSwyPKlVf9nQgMvjrm6M2qalFpOZ+E/fo/NfdKndbihSKJ9Yi013I
         hS3sO9ZK97MkYCm32aMZregsi0I/t6CekO27CH7wAVxB7TYOgOM1tz+KKkog+TCdobxN
         Qgig==
X-Received: by 10.236.148.107 with SMTP id u71mr884654yhj.150.1388100027023;
        Thu, 26 Dec 2013 15:20:27 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c44sm43723585yho.20.2013.12.26.15.20.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 15:20:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387696451-32224-6-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239718>

Michael Haggerty wrote:

>  refs.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

A test or example reproduction recipe would be nice.  (But I can
understand not having one --- races are hard to test.)

[...]
> --- a/refs.c
> +++ b/refs.c
[...]
> @@ -2574,6 +2575,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  			}
>  			goto retry;
>  		} else {
> +			if (errno == ENOENT && --attempts)
> +				/*
> +				 * Perhaps somebody just pruned the empty
> +				 * directory into which we wanted to move the
> +				 * file.
> +				 */
> +				goto retry;

Style nit: it's easier to read a test of errno when the 'else's
cascade (i.e., using 'else if' here).

This patch doesn't depend on any of the others from the series.  For
what it's worth, with or without the following squashed in,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git i/refs.c w/refs.c
index 3ab1491..ea62395 100644
--- i/refs.c
+++ w/refs.c
@@ -2574,14 +2574,14 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 				goto rollback;
 			}
 			goto retry;
+		} else if (errno == ENOENT && --attempts)
+			/*
+			 * Perhaps somebody just pruned the empty
+			 * directory into which we wanted to move the
+			 * file.
+			 */
+			goto retry;
 		} else {
-			if (errno == ENOENT && --attempts)
-				/*
-				 * Perhaps somebody just pruned the empty
-				 * directory into which we wanted to move the
-				 * file.
-				 */
-				goto retry;
 			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
 				newrefname, strerror(errno));
 			goto rollback;
