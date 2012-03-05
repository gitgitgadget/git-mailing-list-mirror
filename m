From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Mon, 05 Mar 2012 20:34:50 +0100
Message-ID: <4F55155A.3050309@web.de>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com> <7v7gyz7pei.fsf@alter.siamese.dyndns.org> <CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com> <7vobsb67dn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4dgU-0008N9-HG
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 20:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474Ab2CETe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 14:34:58 -0500
Received: from fmmailgate06.web.de ([217.72.192.247]:48628 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab2CETe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 14:34:57 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate06.web.de (Postfix) with ESMTP id 80229DCE848
	for <git@vger.kernel.org>; Mon,  5 Mar 2012 20:34:55 +0100 (CET)
Received: from [192.168.178.48] ([91.3.190.153]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M6UmJ-1SKVnh17md-00yJbh; Mon, 05 Mar 2012 20:34:54
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vobsb67dn.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:uYatTLq255Cp27cyzX2/1Fhnn7Duy9Pu6xnw4RB57kp
 x6WZqpsJI7xw7Xq+XvVWxvxhZevde1IpQeeMccidmZ+LdoIF9r
 7Vham2R33a+qaQ8UrS/iWwD9LH0z1OJO0iRPNhdZEFBoy8f8b5
 U8WhTduBWyHe4jqQ9ZXab8z2gvwYlpbOuLkKgMI4BnFhLYq8Q4
 26IXPh/W39bDq2pLpXy3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192265>

Am 05.03.2012 04:42, schrieb Junio C Hamano:
> Jiang Xin <worldhello.net@gmail.com> writes:
> 
>> Orignal source code:
>>
>> 244   case WT_STATUS_CHANGED:
>> 245     if (d->new_submodule_commits || d->dirty_submodule) {
>> 246       strbuf_addstr(&extra, " (");
>> 247       if (d->new_submodule_commits)
>> 248         strbuf_addf(&extra, _("new commits, "));
>> 249       if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
>> 250         strbuf_addf(&extra, _("modified content, "));
>> 251       if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
>> 252         strbuf_addf(&extra, _("untracked content, "));
>> 253       strbuf_setlen(&extra, extra.len - 2);
>> 254       strbuf_addch(&extra, ')');
>> 255     }
>>
>> The bad thing is strbuf_setlen() at line 253. We can not asume the translation
>> of ", " must be 2 characters.
> 
> It sounds like you are merely working around a poor style in the original,
> which should have been structured more like this in the first place, no?
> 
>         /* a helper function elsewhere, possibly inlined */
>         static void add_iwsep_as_needed(struct strbuf *buf, int origlen)
>         {
>                 if (buf->len != origlen)
>                         strbuf_addstr(buf, _(","));
>         }
> 
>         ...
>         int origlen;
> 
>         strbuf_addstr(&extra, " ("))
>         origlen = extra.len;
>         if (a)
>                 strbuf_addstr(&extra, _("msg a"));
>         if (b) {
>                 add_iwsep_as_needed(&extra, origlen);
>                 strbuf_addstr(&extra, _("msg b"));
>         }
>         if (c) {
>                 add_iwsep_as_needed(&extra, origlen);
>                 strbuf_addstr(&extra, _("msg c"));
>         }
>         strbuf_addstr(&extra, ")");
> 
> Cc'ing Jens whose 9297f77 (git status: Show detailed dirty status of
> submodules in long format, 2010-03-08) introduced the "two-byte backstep".

I have no objections at all against changing the code that way to make it
possible to translate it in a sane way. This code predates the i18n effort
by a few months, so it didn't take this kind of problem into account.
