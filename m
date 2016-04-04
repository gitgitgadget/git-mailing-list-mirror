From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 13/16] ref-filter: allow porcelain to translate messages in the output
Date: Mon, 04 Apr 2016 10:05:30 +0200
Message-ID: <vpqa8l9ztmd.fsf@anie.imag.fr>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
	<1459330800-12525-14-git-send-email-Karthik.188@gmail.com>
	<xmqqa8lfsk5e.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQjxmVHuXc0fZioe9OLi9vjNwgHQq-8vf1opWxbuedM9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 10:05:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amzW6-00079p-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 10:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbcDDIFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 04:05:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45147 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbcDDIFi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 04:05:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3485Tlq013825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 4 Apr 2016 10:05:29 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3485UVA019382;
	Mon, 4 Apr 2016 10:05:30 +0200
In-Reply-To: <CAOLa=ZQjxmVHuXc0fZioe9OLi9vjNwgHQq-8vf1opWxbuedM9Q@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 2 Apr 2016 00:30:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 04 Apr 2016 10:05:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3485Tlq013825
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460361931.2993@sM0+WVatosKoHScffcvfjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290682>

Karthik Nayak <karthik.188@gmail.com> writes:

> cc'ing Matthieu since this patch was initially written by him.
>
> On Thu, Mar 31, 2016 at 3:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> +static struct ref_msg {
>>> +     const char *gone;
>>> +     const char *ahead;
>>> +     const char *behind;
>>> +     const char *ahead_behind;
>>> +} msgs = {
>>> +     "gone",
>>> +     "ahead %d",
>>> +     "behind %d",
>>> +     "ahead %d, behind %d"
>>> +};
>>> +
>>> +void setup_ref_filter_porcelain_msg(void)
>>> +{
>>> +     msgs.gone = _("gone");
>>> +     msgs.ahead = _("ahead %d");
>>> +     msgs.behind = _("behind %d");
>>> +     msgs.ahead_behind = _("ahead %d, behind %d");
>>> +}
>>
>> I do not think this patch is wrong, but I wonder if it would be
>> sufficient to have a single bit in file-scope static variable and
>> flip it in setup_ref_filter_porcelain_msg().  I.e.
>>
>>         static int use_porcelain_msg; /* false by default */
>>
>>         void setup_ref_filter_porcelain_msg(void)
>>         {
>>                 use_porcelain_msg = 1;
>>         }
>>
>>         static const char *P_(const char *msg)
>>         {
>>                 return use_porcelain_msg ? _(msg) : msg;
>>         }
>>
>> and then mark the message up perhaps like so:
>>
>>         -       *s = xstrdup("gone");
>>         +       *s = xstrdup(P_("gone"));
>>
>> which may make things much simpler.

... but less evolutive. The non-translatable strings also need to be
cast in stone, while the translatable ones may be subject to future
improvements/tweaks. If they are already duplicated in the code, then
updating one won't change the other, but factoring them means that the
porcelain message can't easily be changed without modifying the plumbing
one.

I'm not sure how important it is in this case, but it was in the case of
setup_unpack_trees_porcelain which I took inspiration from when we
discussed this (actually, in setup_unpack_trees_porcelain, there's isn't
any translation even in porcelain).

Note that this can be worked around later by adding another function like

        static const char *get_message(const char *porcelain, const char *plumbing)
        {
                return use_porcelain_msg ? porcelain : plumbing;
        }

to be called with get_message(_("this ref was gone"), "gone") or so.

>> We'd need to update Makefile to recognize X_() as another keyword;

(I guess you meant P_, not X_)

>> I'd think something like this should do:
>>
>>          XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
>>         -        --keyword=_ --keyword=N_ --keyword="Q_:1,2"
>>         +        --keyword=_ --keyword=N_ --keyword=P_ --keyword="Q_:1,2"

I'm a bit reluctant to modifying the Makefile for something not really
build-related.

> I'm not totally knowledgeable  about how porcelain works, although
> Matthieu did give me a
> brief explanation. I guess it'd better to hear his thoughts on this.

In summary: both would work. No strong opinion from me, but I slightly
prefer the version in the patch (i.e. the one I suggested IIRC) to
Junio's version.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
