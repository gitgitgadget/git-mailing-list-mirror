From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] cmd_fetch_pack(): fix constness problem and memory
 leak
Date: Mon, 21 May 2012 10:13:48 +0200
Message-ID: <4FB9F93C.4010308@alum.mit.edu>
References: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu> <1335955259-15309-3-git-send-email-mhagger@alum.mit.edu> <7vk4069ug8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 10:14:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNkd-0006JI-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 10:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab2EUINy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 04:13:54 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:62829 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756213Ab2EUINu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 04:13:50 -0400
X-AuditID: 12074411-b7f596d000000932-37-4fb9f93dfddd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.B8.02354.D39F9BF4; Mon, 21 May 2012 04:13:49 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4L8DmTa007552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2012 04:13:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vk4069ug8.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqGv7c6e/weXZVhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xq2GS6wFT3gqJm1/z9TA2MPVxcjJISFgIrGy
	YyEbhC0mceHeeiCbi0NI4DKjxMzT39ghnONMEpPevGYHqeIV0JZ4caCTBcRmEVCVuN1/ixnE
	ZhPQlVjU08zUxcjBISoQJrH6gQZEuaDEyZlPwMpFBNQkJrYdYgEpYRYQl+j/BxYWFgiSOHq+
	gRli1XJGidVNe8FGcgqYSdxdNJENot5a4tvuIpAws4C8xPa3c5gnMArMQrJhFkLVLCRVCxiZ
	VzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKEhKjgDsYZJ+UOMQpwMCrx8DrN
	2OkvxJpYVlyZe4hRkoNJSZT39TegEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeuw+BcrwpiZVV
	qUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCd6cH0CNgkWp6akVaZk5JQhpJg5O
	kOFcUiLFqXkpqUWJpSUZ8aAojS8GxilIigdobxFIO29xQWIuUBSi9RSjLseMT4uuMQqx5OXn
	pUqJ8yqDFAmAFGWU5sGtgCWkV4ziQB8L81qAVPEAkxncpFdAS5iAlgS9AFtSkoiQkmpgdHFz
	XL3xT+9i2R6RidGJx38//PGn4X5terHbq81d64TLaroN891OR6Y5nNb9dcnG8q/a48/3Am8w
	JFcmZZ4KPbLpqTZz78Fjf70nJF2xPrW+LHxLPqvGh0ID/4JdhV2xV/Ksul5YPflx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198094>

On 05/21/2012 03:47 AM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
>
>> I understand that it is not crucial to free memory allocated in a
>> cmd_*() function but it is unclear to me whether it is *preferred* to
>> let the process clean up take care of things.
>
> Traditionally, the cmd_foo() functions roughly correspond to main() in
> other programs, so from that point of view, "it is not crucial to free" is
> an understatement. It is not even worth wasting people's time to (1)
> decide which way is *preferred* and to (2) churn the code only to match
> whichever way.

OK, thanks for the info.  I will remove the "freeing-memory" part of the 
patch.

> If you have a plan to split cmd_fetch_pack() and make other parts of the
> system call it, [...]

No, I have no plans for cmd_fetch_pack() besides cleaning up the 
constness errors that I found when randomly reading the code.

> It also seems that some cruft has snuck into this patch, e.g. like this
> part,
>
>> -	int i, ret, nr_heads;
>> +	int i, ret;
>
> that do not have anything to do with "fix constness" nor "memory leak".

This particular hunk is part of moving alloc_heads, nr_heads, and heads 
together to make it more obvious that they are part of an ALLOC_GROW 
triplet.  Previously alloc_heads was a block-local variable used only in 
the case of the --stdin option.

But I admit that the patch is harder than necessary to read because of 
the indentation changes etc, so I will break it up into more digestible 
quanta.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
