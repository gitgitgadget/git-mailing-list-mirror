From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [test failure] Re: t4114 binary file becomes symlink
Date: Sun, 19 Jul 2009 00:51:35 +0200
Message-ID: <20090718225135.GJ16708@vidovic>
References: <20090718134551.GC16708@vidovic> <20090718135649.GA6759@sigill.intra.peff.net> <20090718141658.GE16708@vidovic> <200907182106.06776.j6t@kdbg.org> <20090718222947.GA31147@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 19 00:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSIky-0007E6-Qj
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 00:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbZGRWvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 18:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbZGRWvl
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 18:51:41 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:1240 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbZGRWvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 18:51:40 -0400
Received: by ey-out-2122.google.com with SMTP id 9so384131eyd.37
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 15:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=gzOP4hX8VUi3kXAjNijgPAsCUC3SofEpEcnU2hfismI=;
        b=NLd+Oek6ox1B+VYJOLyTUZu//qJuiH1lbFabiZGvvlPJM6vkMt/+UWcabUNXUQgNBH
         BtYrJFkr0mhgBVHD+ta5HxrmFYw5Svn4kEKSGjeXflh1OPPjqR3+CI++gAmy5AltRnQr
         083Zp6AJUkBybVSgcI0LrTv3ZGyMz1epnjMMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GsKH9E1bYLinkdV+ffy/cf6kUIBgOWChLFomvIkXagtVdt/cfpnQxZIRvsAP5SfxU5
         rAjCTpAEv8BwqUICYyAap1idGRHB1v/KMnZ9wsqmpLs7CkZ3gOLcfvlZLDSNgUBvgk0r
         nqLqoltNH+55lmbzknWdbS4kgtcR4uTTXvTP4=
Received: by 10.210.70.14 with SMTP id s14mr1625066eba.67.1247957498892;
        Sat, 18 Jul 2009 15:51:38 -0700 (PDT)
Received: from @ (91-164-151-27.rev.libertysurf.net [91.164.151.27])
        by mx.google.com with ESMTPS id 5sm2062065eyf.37.2009.07.18.15.51.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 15:51:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090718222947.GA31147@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123540>

The 18/07/09, Jeff King wrote:
> On Sat, Jul 18, 2009 at 09:06:06PM +0200, Johannes Sixt wrote:
> 
> Ah, that's what I was missing. I can reproduce it by setting
> SNPRINTF_RETURNS_BOGUS. I think the problem is in the git_vsnprintf
> code, and it just by coincidence triggers in this test because of the
> exact string we are trying to format.
> 
> Look at compat/snprintf.c. In git_vsnprintf, we are passed a "va_list
> ap", which we then repeatedly call vsnprintf on, checking the return to
> make sure we have enough space. But using a va_list repeatedly without a
> va_end and va_start in the middle invokes undefined behavior. So we need
> to va_copy it and use the copy.
> 
> A patch is below, which fixes the problem for me. However, va_copy is
> C99, so we would generally try to avoid it. But I don't think there is a
> portable way of writing this function without it. And most systems
> shouldn't need to use our snprintf at all, so maybe it is portable
> enough. I dunno.

My investigations made me realize I was building a 64-bits git version
in a 32-bits userland (gentoo flag multilib set) which is not the best
thing to do. So, another possible fix is to export CFLAGS with '-m32'.
Mixing 32 and 64-bits applications is bad. :-)

I confirm this patch does fix the failure for the 64 bits version. Thank
you all.

Now, I wonder if it is safe to run a 32-bits git version on repositories
built with a 64-bits version. It should be safe but do you think it
actually is?

-- 
Nicolas Sebrecht
