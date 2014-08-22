From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v3 2/3] Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
Date: Fri, 22 Aug 2014 15:46:11 +0200
Message-ID: <0342479D-7C9F-42E6-9B79-745AEDE57EB5@zib.de>
References: <1408637110-15669-1-git-send-email-prohaska@zib.de> <1408637110-15669-3-git-send-email-prohaska@zib.de> <xmqq1ts9qy24.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 15:46:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKpAy-00087B-DY
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 15:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbaHVNqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 09:46:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:57540 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106AbaHVNqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 09:46:39 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7MDkJc0024123;
	Fri, 22 Aug 2014 15:46:19 +0200 (CEST)
Received: from [192.168.1.200] (ip5f5bd082.dynamic.kabel-deutschland.de [95.91.208.130] (may be forged))
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7MDkHph023896
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 22 Aug 2014 15:46:18 +0200 (CEST)
In-Reply-To: <xmqq1ts9qy24.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53F749AB.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53F749AB.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53F749AB.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255670>


On Aug 22, 2014, at 12:26 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
>> Similar to testing expectations about malloc with GIT_ALLOC_LIMIT (see
>> commit d41489), it can be useful to test expectations about mmap.
>> 
>> This introduces a new environment variable GIT_MMAP_LIMIT to limit the
>> largest allowed mmap length (in KB).  xmmap() is modified to check the
>> limit.  Together with GIT_ALLOC_LIMIT tests can now easily confirm
>> expectations about memory consumption.
>> 
>> GIT_ALLOC_LIMIT will be used in the next commit to test that data will
> 
> I smell the need for s/ALLOC/MMAP/ here, but perhaps you did mean
> ALLOC (I won't know until I check 3/3 ;-)

You are right.


>> diff --git a/sha1_file.c b/sha1_file.c
>> index 00c07f2..88d64c0 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -663,10 +663,25 @@ void release_pack_memory(size_t need)
>> 		; /* nothing */
>> }
>> 
>> +static void mmap_limit_check(size_t length)
>> +{
>> +	static int limit = -1;
> 
> Perhaps you want ssize_t here?  I see mmap() as a tool to handle a
> lot more data than a single malloc() typically would ;-) so previous
> mistakes by other people would not be a good excuse.

Maybe; and ...


>> +	if (limit == -1) {
>> +		const char *env = getenv("GIT_MMAP_LIMIT");
>> +		limit = env ? atoi(env) * 1024 : 0;

... this should then be changed to atol(env), and ... 


>> +	}
>> +	if (limit && length > limit)
>> +		die("attempting to mmap %"PRIuMAX" over limit %d",
>> +		    (intmax_t)length, limit);

... here PRIuMAX and (uintmax_t); (uintmax_t) also for length.

I'll fix it and also GIT_ALLOC_LIMIT.

	Steffen


>> +}
>> +
>> void *xmmap(void *start, size_t length,
>> 	int prot, int flags, int fd, off_t offset)
>> {
>> -	void *ret = mmap(start, length, prot, flags, fd, offset);
>> +	void *ret;
>> +
>> +	mmap_limit_check(length);
>> +	ret = mmap(start, length, prot, flags, fd, offset);
>> 	if (ret == MAP_FAILED) {
>> 		if (!length)
>> 			return NULL;
