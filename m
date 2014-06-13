From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Thu, 12 Jun 2014 21:18:33 -0400
Organization: Twitter
Message-ID: <1402622313.5629.45.camel@stross>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>
		<xmqqfvjdenk5.fsf@gitster.dls.corp.google.com>
	 <xmqqvbs9d6qn.fsf@gitster.dls.corp.google.com>
	 <53969FDF.3050506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 03:18:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvG8f-0003WY-Df
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 03:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbaFMBSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 21:18:37 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:49728 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaFMBSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 21:18:37 -0400
Received: by mail-qc0-f173.google.com with SMTP id l6so3247989qcy.32
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 18:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=fAW17Vp+UEGBTM+BYd3M+uWKEYCN7WI32LwKU93mh6g=;
        b=aWAyFWDlb8B3D6cfzZBj7uQRiSGk4VDKegXtJKAlYyLBH5P89vfu/1ysUm36kdHCFH
         riNOoAiAl4PI+6CywcHv3rUHQfKC+PpF5kiwxnB0B6Gyi8Tr1MJHfAQ2xKx9xAD6m1Y7
         Ny8QIrRN8/VJj95TWRB/hZr5fNvprgciSCk/PzgSvLHaWqS+Y08r56+AnfvFl4p+aZSZ
         c5c+BWnF642GhiGGqeNgzNxoLCNSHt3glkjQIARkpcsNX4H3eQBqjWjdSCboDsJ2XQ3v
         3HNXJGMPdxlZyhlYMAMLZOLM4nCB+lGevv5jB+rHuyYZLyFQay0hcAsG7vau4TVdkqzW
         HobQ==
X-Gm-Message-State: ALoCoQnmvkshG55wH74xAb3rhMhCeepPNqE8F5DpKCMH4sInHK6Gw/XWGvJQPe2kfyJg0VKy3MVx
X-Received: by 10.224.55.130 with SMTP id u2mr66325211qag.67.1402622316224;
        Thu, 12 Jun 2014 18:18:36 -0700 (PDT)
Received: from [172.18.24.43] ([8.25.196.26])
        by mx.google.com with ESMTPSA id 8sm4108381qak.16.2014.06.12.18.18.34
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 12 Jun 2014 18:18:35 -0700 (PDT)
In-Reply-To: <53969FDF.3050506@viscovery.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251510>

On Tue, 2014-06-10 at 08:04 +0200, Johannes Sixt wrote:
> Am 6/10/2014 1:05, schrieb Junio C Hamano:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> >> David Turner <dturner@twopensource.com> writes:
> >>
> >>> Since Junio has picked up the first patch from previous versions of
> >>> this series, I'm just going to send the second (SSE) one.  I decided
> >>> not to s/NO_SSE42/!HAVE_SSE42/ because it looks like git mostly uses
> >>> the former convention (for instance, that's what GIT_PARSE_WITH
> >>> generates).
> >>
> >> Yeah but NO_FROTZ is used only when FROTZ is something everybody is
> >> expected to have (e.g. it's in posix, people ought to have it, but
> >> we do support those who don't), isn't it?  For a very arch specific
> >> stuff like sse42, I'd feel better to make it purely opt-in by
> >> forcing people to explicitly say HAVE_SSE42 to enable it.
> > 
> > Just FYI: I am getting
> > 
> > compat/cpuid.h:8:12: error: 'processor_supports_sse42' defined but
> > not used [-Werror=unused-function]
> > cc1: all warnings being treated as errors
> > 
> > while building 'pu'; I'll have to rebuild 'pu' without this patch
> > before I can push the day's result out.
> 
> And I get this when I compile on Windows with msysgit:
> 
>     CC abspath.o
> In file included from git-compat-util.h:694,
>                  from cache.h:4,
>                  from abspath.c:1:
> compat/cpuid.h: In function 'processor_supports_sse42':
> compat/cpuid.h:11: warning: implicit declaration of function '__cpuid'
> abspath.c: At top level:
> compat/cpuid.h:8: warning: 'processor_supports_sse42' defined but not used
> abspath.c: In function 'processor_supports_sse42':
> compat/cpuid.h:11: warning: 'eax' is used uninitialized in this function
> compat/cpuid.h:11: warning: 'ebx' is used uninitialized in this function
> compat/cpuid.h:11: warning: 'ecx' is used uninitialized in this function
> compat/cpuid.h:11: warning: 'edx' is used uninitialized in this function
> 
> Perhaps our gcc is too old?

It is too old for my patch because it doesn't support ifunc (and I
suspect that no version of GCC for Windows supports ifunc).  But that
does not seem to be what is going on in your error message.  Instead,
when we #include <cpuid.h>, we get compat/cpuid.h rather than the
system's cpuid.h.  When I rename compat/cpuid.h to something else (and
adjust the code accordingly), and add a check for gcc 4.5+ and for
Windows before using ifunc, then everything works.

So tomorrow, I'm going to send a new patch (which also fixes the
warnings Junio reported) which I've tested on Windows, GNU/Linux, and
Mac OS X. 

I'm testing on a Windows 8 VM from modern.ie with msysgit's
"netinstaller" -- is that a reasonable test environment?
