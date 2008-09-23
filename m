From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 01:11:24 +0400
Message-ID: <20080923211124.GT21650@dpotapov.dyndns.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <200809232103.09133.johannes.sixt@telecom.at> <20080923194802.GQ21650@dpotapov.dyndns.org> <200809232241.42649.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:12:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFBZ-00056P-10
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbYIWVLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbYIWVLa
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:11:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:17205 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbYIWVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:11:29 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1725889ugf.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NAQayZ63z2JqVRcr9lbx8geBICI9As37ICXgKjn59Xg=;
        b=iS9TvkSXRgwDxPj60epUYXYTsyku/yQy/LpPEcW3uf5WlKArTTNElaHNhLadZJHIHb
         4w4+GLxedUAJYmPTW6Dnci8Ac1UNM/Fan50BB2TzAw65xaZh/cwlno1ZscZOPzHKy4RL
         Sp+SB7qQKMlWzajY6k+jGSawCjoVz3PBaURxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SLOKC2p+P7wyPyZ07WXvycKyTPHkh6IjpdU/lxHh0FBot1rNj19Zgyqcjuc2Mvj0qV
         lUPD1fbIYgBx3jLV4R4zYmr0Cg0Fg6pZQB2KbH9LScW6dEseoPEcEMRC1cSfDd7eMwch
         qdMYbKiAhWDQvw91zbCUPPf1oWA0qHwELEIKw=
Received: by 10.86.97.20 with SMTP id u20mr6662160fgb.15.1222204287763;
        Tue, 23 Sep 2008 14:11:27 -0700 (PDT)
Received: from localhost (ppp85-140-170-49.pppoe.mtu-net.ru [85.140.170.49])
        by mx.google.com with ESMTPS id d4sm9796076fga.5.2008.09.23.14.11.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 14:11:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809232241.42649.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96596>

On Tue, Sep 23, 2008 at 10:41:42PM +0200, Johannes Sixt wrote:
> 
> You copied the function from compat/mingw.c. There it has the meaning "Fill in 
> struct stat using Win32 API" and nothing else. Here it has the meaning "Fill 
> in struct stat using Win32 API if you can, and using cygstat() in certain 
> exceptional cases". If you stayed with the original meaning, it would be 
> slightly easier to factor out common code.

do_stat() always fills in the structure, but it can do that fast using
Win32 API or fallback on cygstat() in exceptional cases. So, I don't
think I change its meaning much, its implementation certainly differs.

> > > You do duplicate a lot of code here. Any chances to factor out the
> > > common parts?
> >
> > I don't see much common code here. Initialization of 5 variables where
> > four of them are just constants? Perhaps, the biggest common part here
> > is conversion of dwFileAttributes to st_mode, but it is still 5 lines of
> > trivial code.
> 
> Sigh. I gave a pointer how to unify the two functions (although I missed the 
> fact that the member variables are named differently). I'd appreciate if you 
> did not make it more difficult than necessary to factor out common code.

Because the stat structure is different and handling exceptional
situation is different, I don't think we can have a single do_stat
function for Cygwin and MinGW. Yet, perhaps, it is possible to
move some code in common functions even if it is just a few lines.

The first candidate is win_attr_to_st_mode(), which converts
dwFileAttributes returned by GetFileAttributesExA to st_mode.
Another possible function is that obtains and converts Win32 error
code to errno value. These function can be placed into some common
header (for example, win32.h), which will included by both
implementations. Does it make sense?


Dmitry
