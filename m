From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/9] ref-filter: add support for %(path) atom
Date: Sun, 04 Oct 2015 19:51:50 +0200
Message-ID: <vpqfv1q5xop.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-4-git-send-email-Karthik.188@gmail.com>
	<vpqwpv49so7.fsf@grenoble-inp.fr>
	<CAOLa=ZSdM34_J+gb_=K4-9fgNsMfseAYxUYGm_ncWZstcW+SYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 19:52:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZinSR-0002Ge-E6
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 19:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbbJDRv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 13:51:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46234 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbJDRv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 13:51:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t94Hpl3i017925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 4 Oct 2015 19:51:47 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t94HpoC1017260;
	Sun, 4 Oct 2015 19:51:50 +0200
In-Reply-To: <CAOLa=ZSdM34_J+gb_=K4-9fgNsMfseAYxUYGm_ncWZstcW+SYw@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 4 Oct 2015 22:37:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 04 Oct 2015 19:51:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t94Hpl3i017925
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444585911.11813@VNVBmQAaFUFagIIslOYdBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279007>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Sat, Oct 3, 2015 at 3:32 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> This adds %(path) and %(path:short) atoms. The %(path) atom will print
>>> the path of the given ref, while %(path:short) will only print the
>>> subdirectory of the given ref.
>>
>> What does "path" mean in this context? How is it different from
>> %(refname)?
>>
>> I found the answer below, but I could not guess from the doc and commit
>> message. Actually, I'm not sure %(path) is the right name. If you want
>> the "file/directory" analogy, then %(dirname) would be better.
>>
>
> Noted will change.

Note: I don't completely like %(dirname) either. I'm convinced it's
better than %(path), but there may be a better option.

>>> +             } else if (match_atom_name(name, "path", &valp)) {
>>> +                     const char *sp, *ep;
>>> +
>>> +                     if (ref->kind & FILTER_REFS_DETACHED_HEAD)
>>> +                             continue;
>>> +
>>> +                     sp = strchr(ref->refname, '/');
>>> +                     ep = strchr(++sp, '/');
>>
>> This assumes you have two / in the fullrefname. It is normally the case,
>> but one can also create eg. refs/foo references. AFAIK, in this case sp
>> will be NULL, and you're then calling strchr(++NULL) which may segfault.
>
> Not really,

Oops, indeed, for refs/foo, sp points to / and ep is NULL. It would
segfault for any ref without a /. Currently, the only such ref is HEAD
and it is dealt with by the 'if' above, but that still sounds a bit
fragile to me. Ifever we allow listing refs like FETCH_HEAD, I'm not
sure we'll remember that and test %(path) on it.

Adding something like

if (!sp)
	continue;

after the first strchr would make me feel safer.

> but you made me think of another possible issue.
>
> Assume refs/foo "sp = strchr(ref->refname, '/');" would set sp to point at
> '/' and ++sp will now point at 'f'.
>
> The problem now is refs/foo is supposed to print just "refs" whereas it'll
> print "refs/foo". and %(dirname:short) is supposed to print "" whereas it'll
> print "foo". Will look into this :)

I think it's worse than that because ep will be NULL, and then you call

	v->s = xstrndup(sp, ep - sp);

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
