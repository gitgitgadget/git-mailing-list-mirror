From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 09:17:55 +0100
Message-ID: <16cee31f0911040017x70c7dfeev6696c3ea8f7ffe56@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>
	 <alpine.DEB.1.00.0911040031210.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 09:18:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5b47-0003EA-5M
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 09:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbZKDIRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 03:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbZKDIRw
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 03:17:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:8449 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbZKDIRv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 03:17:51 -0500
Received: by fg-out-1718.google.com with SMTP id 16so139196fgg.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 00:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BHNqi5/JyrCzoDgqiAFrN6DK44G0buslnMLpuITogyY=;
        b=vpQ1C/Py9baZvRoOajRJ4pY2MdVGuQxLwmOqTlGNVDaXzmfxhPtgeQ7IeKU1jsAbuF
         YgOrKj9W3AJsvZ5er0ou3tl4dXDMOWZ097bHn+PZW4fY3pT/+XfWfas9xDuT/EoJ9hfi
         jHVaa+XfUfEZ7WTtIdx1c2LziFDWasYjOQz4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VEERMUlyljM7IXS5VcMPMXtsBRuAkvhKwx725wFjqvhKhReDUrZwrQT8JPoxpNAQcG
         zID+6KrS36g9pdJmuDfsDanUMwgqFURFymRpPATauLNcqwtxDu56gey9La5Eo8KU9mGL
         n/dkgUxMxZeTjcV9YVpdckxubVOsFEE8VzTRc=
Received: by 10.239.190.227 with SMTP id y35mr117205hbh.212.1257322675802; 
	Wed, 04 Nov 2009 00:17:55 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911040031210.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132061>

2009/11/4 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Could you please add the reasoning from the cover letter to this comm=
it
> message? =A0And add a sign-off?

Sure, will do so for next submission of that patch.

> It is unlikely that an #ifdef "contamination" of this extent will go
> through easily, but I have a suggestion that may make your patch both
> easier to read and more likely to be accepted into git.git: Try to wr=
ap
> the win32 calls into pthread-compatible function signatures. =A0Then =
you can
> add a compat/win32/pthread.h and not even touch core files of git.git=
 at
> all.

=46irst of all I didn't want to use wrappers because (if not inlined)
they introduce one additional call, that can be avoided with #defines
(as you can see even pthread_init can be done with macro). Second
reason is that I didn't want to create wrapping structures that would
need to be initialized / allocated / tracked. That patch translates
pthread calls to purely Win32 calls without anything in between.

Here are my reasoning for some of these #ifdefs and what can be done
and what can't (without using wrappers):

1. Thread routine has very different signature:
void *__cdecl func(void *); /* pthreads */
uint32_t __stdcall func(void *); /* Windows API */
=46irst I thought it might be a problem to do (especially return value,
which is different size for 64-bit architectures), but since Git
doesn't use return value, it can be done.

2. Initialization of CRITICAL_SECTION and SEMAPHORE (used by condition
variables implementation). These need explicit initialization on
Windows and can't be done statically with PTHREAD_MUTEX_INITIALIZER
and PTHREAD_COND_INITIALIZER. There's no easy way around that (read:
it needs wrappers).

> Oh, and you definitely do not want to copy-paste err_win_to_posix(). =
=A0You
> definitely want to reuse the existing instance.

Yeah, that was lazy, mea culpa.

I'll resubmit the patch with some fixes shortly,
Andrew
