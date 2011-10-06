From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper functions
 everywhere
Date: Thu, 06 Oct 2011 08:17:54 +0200
Message-ID: <4E8D4812.9090102@viscovery.net>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>	<1316051979-19671-1-git-send-email-drafnel@gmail.com>	<1316051979-19671-3-git-send-email-drafnel@gmail.com>	<4E71A0C7.8080602@viscovery.net>	<CA+sFfMdVntk+U13UeMO=k1SCKJGhPfTpC9_i9kFOkbUJXrF-qg@mail.gmail.com>	<CA+sFfMf73K3yv_5K633DKOsVufMV6rTjd+SSunq4sBikt4jCsg@mail.gmail.com> <CA+sFfMdHpvdMU==a2sUR9sZZCcgqPfGF7+dy6yi8RVoMZ+uZVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "peff@peff.net" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>,
	"bharrosh@panasas.com" <bharrosh@panasas.com>,
	"trast@student.ethz.ch" <trast@student.ethz.ch>,
	"zapped@mail.ru" <zapped@mail.ru>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 08:18:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBhHX-0007QD-3T
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 08:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935725Ab1JFGSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 02:18:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35770 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933935Ab1JFGSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 02:18:03 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RBhHG-0007qk-ML; Thu, 06 Oct 2011 08:17:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 56D021660F;
	Thu,  6 Oct 2011 08:17:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <CA+sFfMdHpvdMU==a2sUR9sZZCcgqPfGF7+dy6yi8RVoMZ+uZVA@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182928>

Am 10/6/2011 4:00, schrieb Brandon Casey:
> [resend without html bits added by "gmail offline"]
> On Wed, Oct 5, 2011 at 7:53 PM, Brandon Casey <drafnel@gmail.com> wrote:
>> On Thursday, September 15, 2011, Brandon Casey wrote:
>>>
>>> On Thu, Sep 15, 2011 at 1:52 AM, Johannes Sixt <j.sixt@viscovery.net>
>>>> There is a danger that the high-level die() routine (which is used by
>>>> the
>>>> x-wrappers) uses one of the low-level compat/ routines. IOW, in the case
>>>> of errors, recursion might occur. Therefore, I would prefer that the
>>>> compat/ routines do their own error reporting (preferably via return
>>>> values and errno).
>>>
>>> Thanks.  Will do.
>>
>> Hi Johannes,
>> I have taken a closer look at the possibility of recursion with respect to
>> die() and the functions in compat/.  It appears the risk is only related to
>> vsnprintf/snprintf at the moment.  So as long as we avoid calling xmalloc et
>> al from within snprintf.c, I think we should be safe from recursion.
>> I'm inclined to keep the additions to mingw.c and win32/syslog.c since they
>> both already use the x-wrappers or strbuf, even though they could easily be
>> worked around.  The other file that was touched is compat/qsort, which
>> returns void and doesn't have a good alternative error handling path.  So,
>> I'm inclined to keep that one too.

I'm fine with keeping the change to mingw.c (getaddrinfo related) and
qsort: both are unlikely to be called from die().

But syslog() *is* called from die() in git-daemon, and it would be better
to back out the other offenders instead of adding to them.

-- Hannes
