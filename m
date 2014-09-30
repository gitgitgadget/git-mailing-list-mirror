From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Do not make trace.c/getnanotime an inlined function
Date: Tue, 30 Sep 2014 16:25:44 +0700
Message-ID: <CACsJy8Cnx=KQ02MT354Ly=o04=smbOhnrgCXLNa_tAtOPGmSdA@mail.gmail.com>
References: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>
 <CACsJy8ArOU7WF4fiy5vn8zq5y6Vm5JxgTf+Tiai_WOeMSj--Ug@mail.gmail.com> <xmqqa95iuxlf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ben Walton <bdwalton@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 11:26:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYthM-0000EC-2U
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 11:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbaI3J0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 05:26:16 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:49026 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbaI3J0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 05:26:15 -0400
Received: by mail-yk0-f179.google.com with SMTP id 142so5835783ykq.10
        for <git@vger.kernel.org>; Tue, 30 Sep 2014 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+06Q4+jHJYjSn7FyAcXh1v7s/6s0gI7qi+I4gOaLHXQ=;
        b=ROCgh1fYAWy9nNPxcRAM3VBcHCAI1wswnvVcUhSO5q5fFCocAq02ULOI/tyxocqMbK
         2DLs9kmETg8M5ST1JoJvDo0nblfZPGetRujKIx4FspnHBW/N538cV/ovjEfVXb4gSEnK
         l2mbDJWK1DFV5tcYAm1ILP0TYY33GNES9+tEeFHcGl/10RY7fRy3sfRlNKJPsiJnL+qP
         h5WoeDZhhRMgDpS+pb/2YH6DAkFaIAFAMVLoFQxxAiHjEVuhjJ/36WSatc3gwGOXTMcd
         c1PfeeDeMvPByW6WqidEROP7zZ1YxozYdL4u5H+aB2rI66riCHViG0JXsOKjjQQBylsB
         oclw==
X-Received: by 10.236.10.66 with SMTP id 42mr64274421yhu.68.1412069174794;
 Tue, 30 Sep 2014 02:26:14 -0700 (PDT)
Received: by 10.170.62.136 with HTTP; Tue, 30 Sep 2014 02:25:44 -0700 (PDT)
In-Reply-To: <xmqqa95iuxlf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257662>

On Tue, Sep 30, 2014 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sun, Sep 28, 2014 at 2:50 PM, Ben Walton <bdwalton@gmail.com> wrote:
>>> Oracle Studio compilers don't allow for static variables in functions
>>> that are defined to be inline. GNU C does permit this. Let's reference
>>> the C99 standard though, which doesn't allow for inline functions to
>>> contain modifiable static variables.
>>>
>>> Signed-off-by: Ben Walton <bdwalton@gmail.com>
>>> ---
>>>  trace.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/trace.c b/trace.c
>>> index b6f25a2..4778608 100644
>>> --- a/trace.c
>>> +++ b/trace.c
>>> @@ -385,7 +385,7 @@ static inline uint64_t gettimeofday_nanos(void)
>>>   * Returns nanoseconds since the epoch (01/01/1970), for performance tracing
>>>   * (i.e. favoring high precision over wall clock time accuracy).
>>>   */
>>> -inline uint64_t getnanotime(void)
>>> +uint64_t getnanotime(void)
>>>  {
>>>         static uint64_t offset;
>>
>> Would moving this offset outside getnanotime() work?
>
> I am not sure what the definition of "work" is.
>
> The function computes the difference between the returned value from
> gettimeofday(2) and a custom highres_nanos() just once and returns
> the value it got from gettimeofday the first time, and then for
> subsequent calls massages the returned value from highres_nanos() to
> be consistent with the value returned from gettimeofday using the
> offset it computed in the first call.
>
> If we have two copies of this function, two independent probes to
> these pair of underlying functions will be made to compute their
> offsets.

Hmm.. no. Even if the function is inlined in multiple places, inline
code still points to the same "offset" variable. So the
gettimeofday_nanos()/highres_nanos() pair should only be called once.
Tested with gcc.
-- 
Duy
