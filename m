From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/5] progress.c: replace signal() with sigaction()
Date: Wed, 28 May 2014 10:48:35 +0200
Message-ID: <CABPQNSbRZS6DuNOLpWKtx6150sz20GjQ6RaakiSdi7FEQW5X3Q@mail.gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
 <1401257655-6043-2-git-send-email-jmmahler@gmail.com> <5385994A.5040507@gmail.com>
 <87sinuiad2.fsf@fencepost.gnu.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 28 10:49:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpZY3-0001QP-8v
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 10:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbaE1ItR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 04:49:17 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47970 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbaE1ItP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 04:49:15 -0400
Received: by mail-ie0-f169.google.com with SMTP id at1so10123323iec.28
        for <git@vger.kernel.org>; Wed, 28 May 2014 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=zL11IGPmSoVwDqE2pbdTEdkHWGIiT3wqKMpVAHmvVsI=;
        b=po/I6JYHcVmDwyKLyXrhCgRKZ2w6eIRXITkI3Ok6bT6A0oyg8QD6tyIQnS7T5+J7su
         5+Ids6nstdcjKUfVwhDIkP6GNzo8vQkgceKvmtqKJ6Ut9TKXXA6GQnbBUuxRsDhPybQE
         w2OT9uy9g/+Yes42BPNETwKIzoe+6+AESBfzpzM8FYozskfYLVihCY8Xmrq9lE1eCZ0n
         9+mbsutlFe+j+z5XW+kq2n0/IHkx67eC6xQMGaHhLLiBCf89qhZnWhRaNwpqBcyAQuoY
         H3p8z+Q0k/n1aFICAJqmliumYrxG+8ezPJKWz+TEgIS1EYCF0puj9tEBu/uQ6z+GJYnc
         TMIQ==
X-Received: by 10.50.30.6 with SMTP id o6mr40992831igh.43.1401266955177; Wed,
 28 May 2014 01:49:15 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 28 May 2014 01:48:35 -0700 (PDT)
In-Reply-To: <87sinuiad2.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250274>

On Wed, May 28, 2014 at 10:19 AM, David Kastrup <dak@gnu.org> wrote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> On 28/05/14 18:14, Jeremiah Mahler wrote:
>>> From signal(2)
>>>
>>>   The behavior of signal() varies across UNIX versions, and has als=
o var=E2=80=90
>>>   ied historically across different versions of Linux.   Avoid  its=
  use:
>>>   use sigaction(2) instead.  See Portability below.
>>
>> Minor nit. The last sentence applies to the man page you're quoting =
and
>> doesn't really make sense when viewed in the context of this commit
>> message. Same applies to other patches in this series.
>>
>>>
>>> Replaced signal() with sigaction() in progress.c
>>>
>>> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
>>> ---
>>>  progress.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/progress.c b/progress.c
>>> index 261314e..24df263 100644
>>> --- a/progress.c
>>> +++ b/progress.c
>>> @@ -66,8 +66,12 @@ static void set_progress_signal(void)
>>>  static void clear_progress_signal(void)
>>>  {
>>>      struct itimerval v =3D {{0,},};
>>> +    struct sigaction sa;
>>> +
>>> +    memset(&sa, 0, sizeof(sa));
>>> +    sa.sa_handler =3D SIG_IGN;
>>
>> A C99 initialiser here would save the call to memset. Unfortunately
>> Documentation/CodingGuidelines is fairly clear on not using C99
>> initialisers, given the fact we're now at git 2.0 maybe it's time to
>> revisit this policy?
>
> If I look at the initialization of v in the context immediately above
> the new code, it would appear that somebody already revisited this
> policy.

Huh, the initialization of v doesn't use C99-features...?
