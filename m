From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] strtoul_ui: reject negative values
Date: Thu, 17 Sep 2015 17:34:22 +0200
Message-ID: <vpqr3lxoy9t.fsf@anie.imag.fr>
References: <1442500646-15293-1-git-send-email-Matthieu.Moy@imag.fr>
	<55FAD981.5080808@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, git@vger.kernel.org, max@max630.net
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 17:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcbCp-0006uc-OP
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 17:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbbIQPee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 11:34:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55107 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbbIQPec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 11:34:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8HFYLSo020616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 17 Sep 2015 17:34:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HFYMvu027710;
	Thu, 17 Sep 2015 17:34:22 +0200
In-Reply-To: <55FAD981.5080808@xiplink.com> (Marc Branchaud's message of "Thu,
	17 Sep 2015 11:17:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 17 Sep 2015 17:34:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8HFYLSo020616
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443108862.97302@rJEgCSE4zoumenGd9p75HA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278122>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -814,6 +814,9 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>>  	char *p;
>>  
>>  	errno = 0;
>> +	/* negative values would be accepted by strtoul */
>> +	if (strchr(s, '-'))
>> +		return -1;
>
> I think this is broken, in that it doesn't match strtoul's normal behaviour,
> for strings like "1234-5678", no?

The goal here is just to read a positive integer value. Rejecting
"1234-5678" is indeed a good thing. We already rejected it before my
patch by checking for p (AKA endptr for strtoul), as you noted below.

> The test also doesn't work if the string has leading whitespace ("
> -5").

Why? It rejects any string that contain the character '-', regardless of
trailing spaces.

>>  	ul = strtoul(s, &p, base);
>>  	if (errno || *p || p == s || (unsigned int) ul != ul)
>>  		return -1;
>
> Hmm, but we check *p here, so IIUC it's an error if the string has any
> trailing non-digits.  Weird.

strtoul_ui is more defensive than strtoul, by design.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
