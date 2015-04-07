From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Wed, 08 Apr 2015 00:43:09 +0200
Organization: D03
Message-ID: <87k2xn8sqq.fsf@rasmusvillemoes.dk>
References: <20150405010611.GA15901@peff.net>
	<20150405011110.GC30127@peff.net> <20150405045614.GA12053@peff.net>
	<87zj6kjbgu.fsf@rasmusvillemoes.dk> <20150407190413.GB2553@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 00:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfcDH-0005v3-AX
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 00:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbbDGWnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 18:43:16 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33375 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbDGWnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 18:43:13 -0400
Received: by lbbzk7 with SMTP id zk7so53938264lbb.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 15:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=gFcJiSXEuDC7pi65QI/bRwOP7faqo1lX8r92RR1l3C8=;
        b=KMpatJl9tH6C+5qIsYXhB2IdcmHNdaTCiWEIHKDZ2sCtX8nzkuh6HbqevDBxL9avA5
         hXKv/C+DkITsqmaF/ZQLzD7snAxepopZrEPjS1kbNHmaFTHqFUPCHTCZ8TPTNi9dHTwh
         McipZ1gstgabWZzARwW/DzBLh3OPyJycErc64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=gFcJiSXEuDC7pi65QI/bRwOP7faqo1lX8r92RR1l3C8=;
        b=IHRhro4zZNhIOGQ0vFoKoXnrtUuC8ohmnlrcrVOvuGY+qEoP0qbBUO97+6/TRdP2Xu
         dU+jjk7pveylG+ZRE2ruOWxzKyQuFHYM1IrCLppLPtwhC352/Im0o3Ul1fhgevgnyNzW
         H4smCjrPJ9a3XEKL1dxiG9oQ+oyHObCUHFGzMMXOIEcdlyh4i8vaxTXXzUdaGZc0bace
         jrkg3be7z1vluuIniWOHyOn3HNK7xwZ7YHOhUC2mWqxg6iO7v3lurE3ZRP90o05Cm9b6
         7s8II2IuTNasld0mOkgA7oI1jm7OZKzusMiPVeSKSWz/MI057Rpfj09mF0kAwJYD4VXD
         h6+Q==
X-Gm-Message-State: ALoCoQna1xsoxDkkMgnIZ+J1wBTKt5DMDkn1O+9sjwMYtm78SgBnm0lNXG0YGX+phjGVwWuRk/e7
X-Received: by 10.112.56.42 with SMTP id x10mr20566597lbp.123.1428446591879;
        Tue, 07 Apr 2015 15:43:11 -0700 (PDT)
Received: from morgan.rasmusvillemoes.dk (ip-21-165.bnaa.dk. [84.238.21.165])
        by mx.google.com with ESMTPSA id e1sm2070209lbc.7.2015.04.07.15.43.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Apr 2015 15:43:11 -0700 (PDT)
X-Hashcash: 1:20:150407:git@vger.kernel.org::porrE3J1dOqORMZ6:0000000000000000000000000000000000000000001FhY
X-Hashcash: 1:20:150407:peff@peff.net::KtsoDR0GzMODY9K8:00002fCp
In-Reply-To: <20150407190413.GB2553@peff.net> (Jeff King's message of "Tue, 7
	Apr 2015 15:04:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266944>

On Tue, Apr 07 2015, Jeff King <peff@peff.net> wrote:

> On Tue, Apr 07, 2015 at 03:48:33PM +0200, Rasmus Villemoes wrote:
>
>> Implementation-wise, I think strbuf_getwholeline could be implemented
>> mostly as a simple wrapper for getdelim. If I'm reading the current code
>> and the posix spec for getdelim correctly, something like this should do
>> it (though obviously not meant to be included as-is):
>
> I think it's close to what we want. strbuf_grow calls xrealloc, which
> will call try_to_free_routine() and possibly die() for us. So we would
> probably want to check errno on failure and respond similarly if we get
> ENOMEM.

Hm, I'm afraid it's not that simple. It seems that data may be lost from
the stream if getdelim encounters ENOMEM: Looking at the glibc
implementation (libio/iogetdelim.c), if reallocating the user buffer
fails, -1 is returned (presumably with errno==ENOMEM set by realloc), and
there's no way of knowing how many bytes were already copied to the
buffer (cur_len).

For regular files, I suppose one could do a ftell/fseek dance. For
other cases, I don't see a reliable way to retry upon ENOMEM.

Related thread on the posix mailing list:
http://thread.gmane.org/gmane.comp.standards.posix.austin.general/10091

> I wonder if it is even worth doing the getc_unlocked dance at all. It
> would potentially speed up the fallback code, but my hope that would be
> that most systems would simply use the getdelim() version.

Well, it's not really an intrusive patch, and 42% speedup is rather
significant. And, of course, the above ENOMEM issue may mean that
getdelim isn't usable after all.

Rasmus
