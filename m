From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 1/8] compat: provide a fallback va_copy definition
Date: Thu, 24 Feb 2011 14:33:17 -0600
Message-ID: <20110224203317.GC17412@elie>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142647.GA15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 21:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pshtb-0002Mh-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 21:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab1BXUej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 15:34:39 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39597 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab1BXUeh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 15:34:37 -0500
Received: by vws12 with SMTP id 12so794209vws.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 12:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6UFflCKYhypxtDdMeXfmGjy6CeujOZe1LagJ148Y3tA=;
        b=NugP8Lcs8MLRBwG9W2sfCthNLZx06ISw6K7hND1HiChlOuKiZvPI6SOn4mhvKoHh0Y
         0zU/YOUNQ8IRrUS1dPzaDx73Hhwnb9eIlthbzzKGXiSUR94TvXdi6xpKRtBgl+DX/Rx1
         9OpZ5i2USw56fRWfKNROfJIZYKiF4Mlw5zqjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u7Lir6NTZ2fQo8Esx0wiIp27T590ev6xoDCw/xVcmXZpcxfWp7HQCs9Z8fon19vVh7
         8YybYZD6J8gfdkVqcLCWjWfngjd3yb/k0I9VED2Ft6zyWn5nS/gTL6+6jslAPA/MWkwI
         yZIxB4cgFCU4Aw+w5x9/oRJ5KuJAQwcv2S7Ig=
Received: by 10.52.164.168 with SMTP id yr8mr2494255vdb.107.1298579605399;
        Thu, 24 Feb 2011 12:33:25 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id i1sm137432vby.11.2011.02.24.12.33.21
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 12:33:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110224142647.GA15477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167858>

Jeff King wrote:

> So my guess is that this will be sufficient, but I we won't really know
> for sure until somebody reports a problem. :(

Sounds like a good approach to me.

The POSIX rationale hints that some historical implementations used
arrays of size 1.  Assignment would error out on such an
implementation, which is not a big deal (since we could switch to
memcpy then).  I would be more worried about a historical
implementation using dynamic allocation with va_list being a pointer
but I haven't heard of any.

> +#ifndef va_copy
> +#define va_copy(dst,src) (dst) = (src)
> +#endif

The following (as Erik mentinoed) might be a nice cleanup on top.  The
duplicate va_copy definition is just redundant rather than causing
compilation errors because it comes before git-compat-util's
ifndef-guarded one.

diff --git a/compat/msvc.h b/compat/msvc.h
index 023aba0..a33b01c 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -9,7 +9,6 @@
 #define inline __inline
 #define __inline__ __inline
 #define __attribute__(x)
-#define va_copy(dst, src)     ((dst) = (src))
 #define strncasecmp  _strnicmp
 #define ftruncate    _chsize
 
