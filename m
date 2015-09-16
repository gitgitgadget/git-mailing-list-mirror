From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] strtoul_ui: actually report error in case of negative input
Date: Wed, 16 Sep 2015 08:08:43 +0200
Message-ID: <vpq1tdy99qs.fsf@anie.imag.fr>
References: <1442181636-27821-1-git-send-email-max@max630.net>
	<vpqr3m1seap.fsf@anie.imag.fr> <20150914202647.GA7806@wheezy.local>
	<vpq4miwfa78.fsf@anie.imag.fr> <20150916042037.GB7806@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 08:09:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc5tt-0001va-4V
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 08:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbbIPGI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 02:08:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44144 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbbIPGIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 02:08:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8G68hnJ031236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 16 Sep 2015 08:08:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8G68hxX026595;
	Wed, 16 Sep 2015 08:08:43 +0200
In-Reply-To: <20150916042037.GB7806@wheezy.local> (Max Kirillov's message of
	"Wed, 16 Sep 2015 07:20:38 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 16 Sep 2015 08:08:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8G68hnJ031236
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442988526.1177@dkN0eWO6L2KDqQ3sMOfzoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278003>

Max Kirillov <max@max630.net> writes:

> On Tue, Sep 15, 2015 at 08:50:03AM +0200, Matthieu Moy wrote:
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -814,6 +814,9 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>>         char *p;
>>  
>>         errno = 0;
>> +       /* negative values would be accepted by strtoul */
>> +       if (strchr(s, '-'))
>> +               return -1;
>>         ul = strtoul(s, &p, base);
>>         if (errno || *p || p == s || (unsigned int) ul != ul)
>>                 return -1;
>> 
>> What do you think?
>
> Explicit rejection of '-' is of course useful addition.
>
> I still find "(unsigned int) ul != ul" bad. As far as I
> understand it makes no sense for i386.

Nothing would make sense here for i386: there's no case where you want
to reject anything on this architecture. Well, you may have expected
strtoul to reject big numbers, but it did not and it's too late.

> And even for 64-bit it's too obscure. In form of "(ul & 0xffffffffL)
> == 0" it would be more clear.

I disagree. "(unsigned int) ul != ul" reads immediately as "if casting
ul to unsigned int changes its value", regardless of sizeof(int). This
is exactly what the check is doing.

> Or just make explicit comparison with intended limit, like I did.

What you really want is to compare with UINT_MAX which would not make
sense on 32 bits architectures.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
