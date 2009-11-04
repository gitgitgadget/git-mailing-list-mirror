From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Wed, 4 Nov 2009 22:16:50 +0100
Message-ID: <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:16:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nDt-0000F0-RF
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbZKDVQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 16:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbZKDVQq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:16:46 -0500
Received: from gv-out-0910.google.com ([216.239.58.184]:11782 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbZKDVQq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 16:16:46 -0500
Received: by gv-out-0910.google.com with SMTP id r4so1017926gve.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J1+IJxn01SM/CVI73ekKlmlTgWtFj4nY98Nsc6nV+qE=;
        b=gTsAJSaYab9kyAmdjYudyY0/Nq9ZPJel+Otyqy7bYK6R3S3huutvU+Z+ymOUynhHZr
         Fp0ttBGT1iopZvbIRqcZPbptYQiMQGNTP4WRJJtFIYN9bdusnC2tO9g3YWzz31ffMKQd
         fdqrJRYtSuDEGGLB/vlPCvBS+0zyfM4rWnjFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eMFamP1oodJ2HAOmsvuazUkFu4O2aZVXKytFJgXaLreI9PhPIICOE2YTqkRoQY80bx
         SozXncDU6P9TpuqrM5ycpUGszDc/ALWwuafFshX6yjmh8ObO3NfMZexU/ijYErwNdubH
         9VSKeFeOWVwktt1FhA5uNEGaV6bJu/FRql3R0=
Received: by 10.239.163.205 with SMTP id q13mr220138hbd.132.1257369410122; 
	Wed, 04 Nov 2009 13:16:50 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132147>

2009/11/4 Nicolas Pitre <nico@fluxnic.net>:
> On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:
>
>> + =A0 =A0 NO_STATIC_PTHREADS_INIT =3D YesPlease
>
> Let's not go that route please. =A0If Windows can't get away without
> runtime initializations then let's use them on all platforms. =A0Ther=
e is
> no gain in exploding the code path combinations here wrt testing
> coverage.
>

I don't like that approach either, but I was frighten of Junio being
anal about static inits ;).

Let's make it clear: has anyone have any objections that I add
explicit initialization of mutexes and condition variables for POSIX
also?

>> +static THREAD_RET_TYPE threaded_find_deltas(void *arg)
>
> Why can't you just cast the function pointer in your pthread_create
> wrapper instead? =A0No one cares about the returned value anyway.

Because of calling convention - I'd have to cast cdecl function as
stdcall function, which would change the function call clean up (in
cdecl caller is responsible for unwinding stack, stdcall callee; the
effect - double stack unwinding).

>> @@ -2327,6 +2354,8 @@ int cmd_pack_objects(int argc, const char **ar=
gv, const char *prefix)
>> =A0#ifdef THREADED_DELTA_SEARCH
>> =A0 =A0 =A0 if (!delta_search_threads) =A0 =A0 =A0/* --threads=3D0 m=
eans autodetect */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 delta_search_threads =3D online_cpus();
>> +
>> + =A0 =A0 init_threaded_delta_search();
>
> What about doing this at the beginning of ll_find_deltas() instead?
> And similarly for cleanup_threaded_delta_search(): call it right befo=
re
> leaving ll_find_deltas(). =A0This way thread issues would remain more
> localized. =A0In fact I'd move the whole thing above in ll_find_delta=
s()
> as well (separately from this patch though).

Sounds sensible, but I'd wait for the NO_STATIC_PTHREADS_INIT verdict.

--
Andrzej
