From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/5] Retry if fdopen() fails due to ENOMEM
Date: Tue, 10 Mar 2015 12:42:56 +0100
Message-ID: <54FED8C0.7060104@alum.mit.edu>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu> <xmqqy4nb2qwn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 12:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVIZD-0003zp-DX
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 12:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbbCJLnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 07:43:14 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45448 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751218AbbCJLnM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 07:43:12 -0400
X-AuditID: 12074414-f797f6d000004084-3f-54fed8c3fdfc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.79.16516.3C8DEF45; Tue, 10 Mar 2015 07:42:59 -0400 (EDT)
Received: from [192.168.69.130] (p4FC962B5.dip0.t-ipconnect.de [79.201.98.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2ABgvtF002159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 10 Mar 2015 07:42:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqy4nb2qwn.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1D1841+IwamZqhZdV7qZLBp6rzBb
	vL25hNGB2WPnrLvsHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ2x7u1r9oJHghWv2s8yNzB+
	5+1i5OCQEDCR2HFEo4uRE8gUk7hwbz1bFyMXh5DAZUaJhZt72SGc80wSj27tYwWp4hXQlujr
	38kOYrMIqEpM3XMCLM4moCuxqKeZCcQWFQiSeHnrLyNEvaDEyZlPWEBsEQE1iYlth1hAFjML
	2EpsfcIMEhYWsJM4fPYhWKuQQLHEzxcPwcZzClhLzO5rBGtlFtCT2HH9FyuELS/RvHU28wRG
	gVlINsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCGBK7KD
	8chJuUOMAhyMSjy8Kwz/hQixJpYVV+YeYpTkYFIS5W26AhTiS8pPqcxILM6ILyrNSS0+xCjB
	wawkwlt6FCjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBu+46UKNg
	UWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KE7ji4GRCpLiAdq7CqSdt7ggMRcoCtF6
	ilFRSpw3FSQhAJLIKM2DGwtLR68YxYG+FOblBCYnIR5gKoPrfgU0mAloMDvzH5DBJYkIKakG
	RmHhA3vVmsUiynr8tNdwr/Q6PnceL2PxvDaRZTZC3MsWHI7wnuv7M2Mqt9TZ3orJJ7b0v8mb
	9DZj2wav71J9H53rX048Wf775N6rHyev2b9S+ez3X2W+T10+TjTgXJq/yLzmexzf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265228>

On 03/05/2015 08:19 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> One likely reason for fdopen() to fail is the lack of memory for
>> allocating a FILE structure. When that happens, try freeing some
>> memory and calling fdopen() again in the hope that it will work the
>> second time.
> 
> In codepaths where we are likely under memory pressure, the above
> might help, but I have to wonder
> 
>     (1) if update-server-info and daemon fall into that category; and
> 
>     (2) if Git continues to work under such a memory pressure to
>         cause even fdopen() to fail.
> 
> In other words, I do not see a reason not to do this change, but I
> am not sure how much it would help us in practice.
> 
> We call fopen() from a lot more places than we call fdopen().  Do we
> want to do the same, or is there a good reason why this does not
> matter to callers of fopen(), and if so why doesn't the same reason
> apply to callers of fdopen()?

To be honest, I was hoping that Jonathan would jump in and respond to
this thread, as he is the one who suggested this change.

I agree that it seems rather unlikely that a call to fdopen() is the
straw that breaks the camel's back. But I've never looked very closely
at Git's facility for freeing up memory when an allocation fails and
don't really have a mental model for how it is used.

If memory is allocated profligately under the expectation that it can be
freed if necessary (i.e., if calls to try_to_free_routine() are
relatively routine and tend to free a lot of memory), then it seems
important that as many memory allocation paths as possible call it and
retry when there is an error. This would be the garbage-collection
model, in which a failure to call the garbage collector at the right
time unnecessarily turns a routine event into a fatal error.

On the other hand, if calling try_to_free_routine() is an act of
desperation and typically results in little or no memory being freed,
then calling it in this code path is probably not very useful.

You also make a good point that if this rigmarole makes sense for
fdopen(), then it probably also makes sense for fopen().

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
