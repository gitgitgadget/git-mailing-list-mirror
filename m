From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for check_refname_component
Date: Wed, 4 Jun 2014 18:21:30 +0700
Message-ID: <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>
 <1401853091-15535-2-git-send-email-dturner@twitter.com> <538ED2F1.9030003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twitter.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 13:22:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws9Gj-0007xW-3u
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 13:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbaFDLWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 07:22:03 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:54798 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbaFDLWC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2014 07:22:02 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so15094517qga.6
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qKi31ceJcuIZyKipeHLp92fC8dd6BHgapGyKdZVT42c=;
        b=iaBx/G+x40dbnOlNCp9fz4WAbe74J1wjtnxX0Y9B1tW+KCo4czRgJBGTdnCEmkUw7e
         pRZsDjbW8TI7HO+5EBd2A1iQGuD961fSXBNUvRYSCWBJ4SA6L/8MJACCQIDoURvgMwxl
         wyHAK+7CubtDWPP7IymG00u133HBu0Soc6iLsG84C0BaoRNVRmtHOks6sEU2XyRVBilb
         h+VsCiv1dyVHZ/tqsO+gEGfmk32eDAwIgahDkyAc0CWzapApZfqEVbUn8pylRxU6q8Iz
         onqDdmSrK6x342dl4vUxLnAxRzUnx4oBWupeNRVIIwQ/O8oSBkoNernJrLlUGG3N7vr1
         5WSg==
X-Received: by 10.140.20.68 with SMTP id 62mr62465551qgi.30.1401880920740;
 Wed, 04 Jun 2014 04:22:00 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 4 Jun 2014 04:21:30 -0700 (PDT)
In-Reply-To: <538ED2F1.9030003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250721>

On Wed, Jun 4, 2014 at 3:04 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
>
> On 2014-06-04 05.38, David Turner wrote:
> []
>> []
>> diff --git a/Makefile b/Makefile
>> index a53f3a8..dd2127a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1326,6 +1326,11 @@ else
>>               COMPAT_OBJS +=3D compat/win32mmap.o
>>       endif
>>  endif
>> +ifdef NO_SSE42
>> +     BASIC_CFLAGS +=3D -DNO_SSE42
>> +else
>> +     BASIC_CFLAGS +=3D -msse4.2
>> +endif
> This does work for some people, but break for others, like the system=
s in my test-lab.
> On 2 different systems the gcc has support for -msse4.2, but the proc=
essor has not,
> and t5511 fails with "Illegal instruction".
> How can that be?
> The maintainer of a Linux distro wants to ship gcc with all possible =
features,
> an the end-user can compile the code with all the features his very p=
rocessor has.

I think glibc code uses cpuid instruction to decide whether to use
optimized version. May be we can do the same? If we go that route and
have a way to detect sse support from compiler, then we can drop
NO_SSE42, enable all and pick one at runtime.
--=20
Duy
