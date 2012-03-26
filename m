From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 26 Mar 2012 15:20:01 -0400
Message-ID: <20120326192001.GB32387@gmail.com>
References: <20120320043133.GA2755@gmail.com>
 <20120323214114.GB18198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:20:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFSj-00054U-LS
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab2CZTUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:20:11 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64785 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab2CZTUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:20:09 -0400
Received: by qcqw6 with SMTP id w6so3554498qcq.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QiFq75r2MnaoSTIY2vpQo5TKL/1mIaLWS58lNAQXl/4=;
        b=qP4NHT+HJbZSYTVzDzoUMBCyBPzauVbJK127o8KvcgA2nZHsHf9ErYVpQTW+TZZL1W
         9vqp+CbEl6p/WDSsJcw0lkKKf6ov6bwI+cedTv++S4zcuwr6cfopFGaQZ4dkoAAmtim9
         TDHkFqBRyLlvsgGBCRuPoeGapkqaFo4tBU6xWmcdwpD3vgpl+GA5y2zt04a1snYsaK+m
         yWo6aegY+4k+VOS47Yt1d2eYmU86R493npsDgAaa8M5oQRKU16L0SeMgXt/V40nNA2/7
         8eE0jwX8iil6o9vESGF2O9b0Mh5dXffy3u0FDzCbiHEOiV+IWRuqseihT0guRuO5+bPv
         4h3A==
Received: by 10.224.116.19 with SMTP id k19mr29321453qaq.59.1332789608624;
        Mon, 26 Mar 2012 12:20:08 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id dm8sm31396314qab.18.2012.03.26.12.20.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 12:20:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120323214114.GB18198@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193960>

On Fri, Mar 23, 2012 at 05:41:14PM -0400, Jeff King wrote:
> The only time we use the enum values is via the "int nonfastforward"
> passed to transport_push.  I think it would be a lot clearer to leave
> nonfastforward as a single bit in the ref, and then define the enum
> elsewhere (or even just use #define if we are not going to use the enum
> type).

I used the REF_STATUS_* enum as a template for what I wanted to accomplish
when authoring v1, but did notice there was no other place my new
options made much sense (Junio helped me remove one other call between v1
and v2). I like the readability fixup, but it won't compile as both push.c
and transport.c need to see these. Would something like the following
work? It simply moves the define statements to cache.h, so that both push and
transport can use them.

diff --git a/cache.h b/cache.h
index 427b600..cb960c6 100644
--- a/cache.h
+++ b/cache.h
@@ -1009,6 +1009,7 @@ struct ref {
 	char *symref;
 	unsigned int force:1,
 		merge:1,
+		nonfastforward:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
@@ -1019,15 +1020,14 @@ struct ref {
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT
 	} status;
-	enum {
-		NON_FF_HEAD = 1,
-		NON_FF_OTHER
-	} nonfastforward;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
 
+#define NON_FF_HEAD  1
+#define NON_FF_OTHER 2
+
 #define REF_NORMAL	(1u << 0)
 #define REF_HEADS	(1u << 1)
 #define REF_TAGS	(1u << 2)


It tests fine locally for me using the same test cases I've been using
all along.

--
Christopher Tiwald
