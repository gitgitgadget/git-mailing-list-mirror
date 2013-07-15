From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Sun, 14 Jul 2013 23:37:44 -0700
Message-ID: <EFAADB2C-5774-4076-99CE-887AFB2B5CCA@gmail.com>
References: <7v38rjlif4.fsf@alter.siamese.dyndns.org> <20130712190531.GD8482@google.com> <7vtxjzk13q.fsf@alter.siamese.dyndns.org> <CAHREChiOE8oMWQYFY_7yzf1tz-4E2_L5W9--k33vwATFSrR==A@mail.gmail.com> <7vzjtoea0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Mark Lodato <lodatom@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 08:37:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UycPw-0003lK-4b
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab3GOGhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:37:48 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:56222 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973Ab3GOGhs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:37:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so10787100pac.40
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mauler;
        bh=OKevHEPqqJY8My5yMGkCGlIDIBU1K0TwOcv+LfzzJAM=;
        b=bq88KsaOH93mktCLmnsfTmhFHXJgHz/kwZ6b2o5fKsey1k3eamV6m3ZzL06WR7roIn
         LuAoKHKwdaUyq9O3/EcW+JhYJSWa8rZmufxkKKvuRFew6rlzPU4+hYR3tIOWH9JvgBHD
         9TLc4tC/N80k6yfCW4tqpSjnrqlNxOQuHJN0BAXL/MMF90naHzIM/BiVxcR75WvlqEfd
         GuuBCemA289Osqopw4vMIUIiGCCMJaPbd8v2LbxU3ule1RXHbAqXYVCGj5W5WA647c7Z
         Lpxek9gP2xM4ZY922vDBsX6QDZvANvsR911v97vnli2RS6UlQ1mH3VkSY0XSS0ewgveq
         zA9A==
X-Received: by 10.68.164.69 with SMTP id yo5mr52111390pbb.96.1373870267390;
        Sun, 14 Jul 2013 23:37:47 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yj2sm59077875pbb.40.2013.07.14.23.37.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:37:46 -0700 (PDT)
In-Reply-To: <7vzjtoea0a.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230424>

On Jul 14, 2013, at 21:13, Junio C Hamano wrote:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> On Fri, Jul 12, 2013 at 3:52 PM, Junio C Hamano <gitster@pobox.com>  
>> wrote:
>>>
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>
>>>> FWIW the GIT_SSL_CERT_PASSWORD_PROTECTED envvar has a similar "can
>>>> only enable" behavior, but since it's documented, that's not as big
>>>> of a problem.  Do you remember why it was written that way?
>>>
>>> Not me ;-).
>>
>> Because that's how GIT_NO_VERIFY, GIT_CURL_FTP_NO_EPSV, and
>
> s/GIT_NO_VERIFY/GIT_SSL_NO_VERIFY/, I think.
>
>> GIT_CURL_VERBOSE (and perhaps others) work.  That said, I agree that
>> parsing the variable's value as a boolean would make much more sense.
>> Perhaps this is how all of those variables should work?
>
> I think you are probably right.

That works fine for GIT_SSL_CERT_PASSWORD_PROTECTED and  
GIT_CURL_VERBOSE, but it's a little bit awkward for GIT_SSL_NO_VERIFY  
and GIT_CURL_FTP_NO_EPSV since they have "_NO_" in their names.

If the user wants to override a "http.sslVerify=false" then  
"GIT_SSL_NO_VERIFY=false" is needed rather than "GIT_SSL_VERIFY=true".

We could:

1) Introduce GIT_SSL_VERIFY and GIT_CURL_FTP_EPSV and say if they are  
set the "_NO_" version is ignored.

2) Go ahead with "GIT_SSL_NO_VERIFY=false" to force http.sslVerify  
back to true (and similarly for EPSV).

3) Just leave GIT_SSL_NO_VERIFY and GIT_CURL_FTP_NO_EPSV alone.

4) Do something else, ideas?

Comments?
