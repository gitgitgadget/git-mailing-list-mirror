From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 24/44] fetch.c: use a single ref transaction for all
 ref updates
Date: Sat, 17 May 2014 17:17:29 +0200
Message-ID: <53777D89.2090501@alum.mit.edu>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com> <1400261852-31303-25-git-send-email-sahlberg@google.com> <53777AA1.1020107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 17:17:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlgMi-0006SX-Ve
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbaEQPRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:17:33 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60093 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757116AbaEQPRc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 11:17:32 -0400
X-AuditID: 12074414-f79f86d000000b9f-4c-53777d8b766b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 62.0D.02975.B8D77735; Sat, 17 May 2014 11:17:31 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3A76.dip0.t-ipconnect.de [93.219.58.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4HFHUJT029280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 11:17:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <53777AA1.1020107@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1O2uLQ82uDDD2KLrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ0xc+VjxoIHPBV/ts5gbWB8w9nFyMkhIWAi8XXJ
	cRYIW0ziwr31bCC2kMBlRomHi+q6GLmA7PNMEp/3HWbqYuTg4BXQlvj8xBakhkVAVaLz3QtW
	EJtNQFdiUU8zWImoQJDEn7OKIGFeAUGJkzOfgI0XEbCTWH9rITOILSwQJXHh1QQ2iPFzGCW6
	bk5kAklwCuhI7J9yiRVkjoSAuERPYxBImBko/K7vATOELS+x/e0c5gmMArOQrJiFpGwWkrIF
	jMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUICVGQH45GTcocYBTgYlXh4
	E+zLgoVYE8uKK3MPMUpyMCmJ8trGlgcL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHd7QaU401J
	rKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4L1XA9QoWJSanlqRlplTgpBm
	4uAEGc4lJVKcmpeSWpRYWpIRD4rS+GJgnIKkeID2FlaD7C0uSMwFikK0nmLU5Th151gbkxBL
	Xn5eqpQ4732QHQIgRRmleXArYOnoFaM40MfCvA9BqniAqQxu0iugJUxAS97sLQVZUpKIkJJq
	YGw3cv519IDIkbcKM9sWOH10iOI5n2rOHHH82k/rY4LTg+u/1HseO9l9i6HSrq3C7uUOvjdz
	K8/X2x3fzH+vf/up/y/nOCx41eDOGRjKfyFlveTf6ysLFhytUQj/fkqDZ3m8Z/ca 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249471>

On 05/17/2014 05:05 PM, Michael Haggerty wrote:
> On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
>> [...]
>> disk and thus we would not return STORE_REF_ERROR_DF_CONFLICT for this case.
>>
>> I think this new behaviour is more correct, since if there was a problem
>> we would not even try to commit the transaction but need to highlight this
>> change in how/what errors are reported.
>> This change in what error is returned only occurs if there are multiple
>> refs that fail to update and only some, but not all, of them fail due to
>> ENOTDIR.
> 
> Thanks for the detailed explanation.  The change in behavior seems
> reasonable to me.

Wait, now I'm having second thoughts.

Won't the old code display *all* of the errors that occur, each time
proceeding nevertheless?  Whereas the new code displays only the *first*
error that would occur and then aborts?

This could be very frustrating if three references have problems, but
the user only finds out about one problem each time she runs "git
fetch".  Instead of

    git fetch # oops, ref1, ref2, and ref3 failed
    fix, fix, fix
    git fetch # :-)

she'd have to do

    git fetch # oops, ref1 failed
    fix ref1
    git fetch # oops, ref2 failed
    fix ref2
    git fetch # oops, ref3 failed
    fix ref3
    git fetch # :-( git I hate you

What kind of failures are we talking about here?  Are we talking about
errors like non-ff updates that happen routinely, or rarer/more serious
errors that would be expected to happen singly?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
