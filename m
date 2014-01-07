From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 10/17] lock_ref_sha1_basic(): on SCLD_VANISHED, retry
Date: Tue, 07 Jan 2014 11:25:38 +0100
Message-ID: <52CBD622.3010805@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu> <1389015935-21936-11-git-send-email-mhagger@alum.mit.edu> <xmqq4n5hj8ry.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 11:25:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Tr8-0005vw-UK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 11:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbaAGKZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 05:25:47 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62728 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751005AbaAGKZn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 05:25:43 -0500
X-AuditID: 12074414-b7fb46d000002a4d-ca-52cbd6269512
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.E1.10829.626DBC25; Tue,  7 Jan 2014 05:25:42 -0500 (EST)
Received: from [192.168.69.148] (p57A25E76.dip0.t-ipconnect.de [87.162.94.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s07APdkY012817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jan 2014 05:25:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <xmqq4n5hj8ry.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqKt27XSQQeteHYuuK91MFg29V5gt
	3t5cwmixe9oCNgcWj52z7rJ7XLyk7PF44glWj8+b5AJYorhtkhJLyoIz0/P07RK4M+YsOcFe
	8EqioveJQwPjQ+EuRk4OCQETib/HZzND2GISF+6tZ+ti5OIQErjMKPHnzD4o5xyTxJx3E8Cq
	eAW0JS4c/s4CYrMIqEq8+vILLM4moCuxqKeZCcQWFQiSeHToITtEvaDEyZlPwOpFBNQkJrYd
	ArI5OJgFCiVuvCkCCQsL+Egs6F0GtWsto0TryunsIDWcAtYSd+96gZgSAuISPY1BIOXMAjoS
	7/oeMEPY8hLb385hnsAoOAvJsllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdC
	LzezRC81pXQTIyTERXYwHjkpd4hRgINRiYd3wu5TQUKsiWXFlbmHGCU5mJREeXsvng4S4kvK
	T6nMSCzOiC8qzUktPsQowcGsJMJ7ZyNQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6Yklqdmpq
	QWoRTFaGg0NJgjf1ClCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCh644uB8QuS
	4gHaawnSzltckJgLFIVoPcWoyzHvy4dvjEIsefl5qVLivM0gRQIgRRmleXArYAntFaM40MfC
	vC0gVTzAZAg36RXQEiagJaFxp0CWlCQipKQaGJeZnb+qtlqpUevfmjNm+XkNnFmSU2fvv+Pt
	qzlxaY+tse5UNbbQrfJfvBLOVr4paUgr3t9dO81j0zWJmfHr1ae+nO0WpWmp75Qi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240103>

On 01/06/2014 06:54 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If safe_create_leading_directories() fails because a file along the
>> path unexpectedly vanished, try again (up to 3 times).
>>
>> This can occur if another process is deleting directories at the same
>> time as we are trying to make them.  For example, "git pack-refs
>> --all" tries to delete the loose refs and any empty directories that
>> are left behind.  If a pack-refs process is running, then it might
>> delete a directory that we need to put a new loose reference in.
>>
>> If safe_create_leading_directories() thinks this might have happened,
>> then take its advice and try again (maximum three attempts).
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 3926136..6eb8a02 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2039,6 +2039,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>  	int type, lflags;
>>  	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
>>  	int missing = 0;
>> +	int attempts = 3;
>>  
>>  	lock = xcalloc(1, sizeof(struct ref_lock));
>>  	lock->lock_fd = -1;
>> @@ -2093,7 +2094,15 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>  	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
>>  		lock->force_write = 1;
>>  
>> -	if (safe_create_leading_directories(ref_file)) {
>> + retry:
>> +	switch (safe_create_leading_directories(ref_file)) {
>> +	case SCLD_OK:
>> +		break; /* success */
>> +	case SCLD_VANISHED:
>> +		if (--attempts > 0)
>> +			goto retry;
>> +		/* fall through */
> 
> Hmph.
> 
> Having no backoff/sleep at all might be OK here as long as the other
> side that removes does not retry (and I do not think the other side
> would, even though I haven't read through the series to the end yet
> ;-)).

remove_dir_recurse() only tries deleting directories once (I haven't
changed that).  And from a broader perspective, it would be pretty silly
for any tidy-up-directories function to try deleting things more than
once.  So I don't think it is a problem.  But even in the worst case,
this function only tries three times before giving up, so it shouldn't
be a disaster.

> This may be just a style thing, but I find that the variable name
> "attempts" that starts out as 3 quite misleading, as its value is
> not "the number of attempts made" but "the remaining number of
> attempts allowed."  Starting it from 0 and then
> 
> 	if (attempts++ < MAX_ATTEMPTS)
> 		goto retry;
> 
> would be one way to clarify it.  Renaming it to remaining_attempts
> would be another.

I just renamed the variable to attempts_remaining.  (I thought I was
following your suggestion, but now I see that I put the words in the
opposite order; oh well, I think it's fine either way.)

Thanks for your review!  I will wait a day or so for any additional
comments, and then send a v3.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
