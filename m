From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Make hash-object more robust against malformed
 objects
Date: Sat, 12 Feb 2011 21:47:06 +0700
Message-ID: <20110212144706.GA25124@do>
References: <1296903141-27075-1-git-send-email-pclouds@gmail.com>
 <1296903141-27075-2-git-send-email-pclouds@gmail.com>
 <201102121242.21339.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 12 15:48:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoGmB-0004Nh-83
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 15:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab1BLOsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 09:48:38 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:58046 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab1BLOsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 09:48:37 -0500
Received: by pxi15 with SMTP id 15so587388pxi.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 06:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Tg1I1iNyWAUQtfwIk6BD/AKdzmE/1VtmvPK0GyrFBEw=;
        b=XNHb+lndQUNgGgpQ1ywAMbBb6pTPC/bfDh3IFItKzqfSM4erdP7bd+0KGPvSFKOihQ
         xcAQxBk9RxeFUEzg4I0zZWkPv/aWZOLRqKn8DSZHAMaFpGVX/r8dGpiEEurEIR0uST11
         SSihAJq/edTXT6eFbFqcMFaXMJrYSfwAjVh4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q7tWR0uNEtaQCpHBeQfyM3Reu48w4Lhfhv9EeMG5crVt25JOybppQhOdQQT6FOkInH
         uVxIyg93wmMtYEQcY0FwjPB+0pCTZeypOFFxVHrTjiRTxQ2+SBk0B0nCASIftucyRfcA
         F5sCdn0pfSpM+Ax3pfyUr9XXdrCp5CrJzxveA=
Received: by 10.143.40.9 with SMTP id s9mr1357666wfj.366.1297522117085;
        Sat, 12 Feb 2011 06:48:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id y42sm903156wfd.22.2011.02.12.06.48.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 06:48:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 12 Feb 2011 21:47:06 +0700
Content-Disposition: inline
In-Reply-To: <201102121242.21339.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166615>

On Sat, Feb 12, 2011 at 12:42:21PM +0100, Thomas Rast wrote:
> This patch makes t9350 fail under valgrind:
> 
> expecting success: 
> 
>         TAG=$(git hash-object -t tag -w tag-content) &&
>         git update-ref refs/tags/sonnenschein $TAG &&
>         git fast-export -C -C --signed-tags=strip --all > output &&
>         test $(grep -c "^tag " output) = 4 &&
>         ! grep "Unspecified Tagger" output &&
>         git fast-export -C -C --signed-tags=strip --all \
>                 --fake-missing-tagger > output &&
>         test $(grep -c "^tag " output) = 4 &&
>         grep "Unspecified Tagger" output
> 
> 
> ==2862== Invalid read of size 1
> ==2862==    at 0x4F0C34: prefixcmp (strbuf.c:9)
> ==2862==    by 0x4F4FB3: parse_tag_buffer (tag.c:109)

Nice. Does this fix it?

--8<--
diff --git a/tag.c b/tag.c
index ecf7c1e..9318ae5 100644
--- a/tag.c
+++ b/tag.c
@@ -97,7 +97,9 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 		item->tagged = NULL;
 	}
 
-	if (prefixcmp(bufptr, "tag "))
+	if (bufptr + 5 < tail && !prefixcmp(bufptr, "tag "))
+		; 		/* good */
+	else
 		return -1;
 	bufptr += 4;
 	nl = memchr(bufptr, '\n', tail - bufptr);
@@ -106,7 +108,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	item->tag = xmemdupz(bufptr, nl - bufptr);
 	bufptr = nl + 1;
 
-	if (!prefixcmp(bufptr, "tagger "))
+	if (bufptr + 8 < tail && !prefixcmp(bufptr, "tagger "))
 		item->date = parse_tag_date(bufptr, tail);
 	else
 		item->date = 0;
--8<--
-- 
Duy
