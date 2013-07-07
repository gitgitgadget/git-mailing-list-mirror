From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] lockfile: fix buffer overflow in path handling
Date: Sun, 07 Jul 2013 12:25:41 +0200
Message-ID: <51D94225.1010803@alum.mit.edu>
References: <1373140132-12351-1-git-send-email-mhagger@alum.mit.edu> <20130707041236.GB30898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 12:26:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvmAP-0006mo-JM
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 12:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab3GGKZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 06:25:47 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49399 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751703Ab3GGKZq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jul 2013 06:25:46 -0400
X-AuditID: 1207440c-b7f016d000005997-9d-51d94229c5ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C8.C5.22935.92249D15; Sun,  7 Jul 2013 06:25:45 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD4B55.dip0.t-ipconnect.de [79.221.75.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r67APgu6018829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 7 Jul 2013 06:25:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130707041236.GB30898@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqKvpdDPQoPOVlkXXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7oxD9y8wFvwVrdizup25gXGT
	YBcjB4eEgInE4dOOXYycQKaYxIV769m6GLk4hAQuM0q0rpvADOGcZZJouvWBGaSKV0Bbom3+
	VyYQm0VAVeLf62lgcTYBXYlFPc1MIENFBcIkrvxWhSgXlDg58wkLiC0iICvx/fBGRhCbWcBa
	YsXrw2BjhAWcJTa9+A1WIyRQLPH7L4TNCVSztvcRO8hIZgF1ifXzhCBa5SW2v53DPIFRYBaS
	DbMQqmYhqVrAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81pXQTIyRoeXYwflsn
	c4hRgINRiYc3oPVGoBBrYllxZe4hRkkOJiVRXh/Hm4FCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHhzuYByvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJXhWQoYJFqemp
	FWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgGI0vBkYpSIoHaO8nB5C9xQWJuUBRiNZTjLoc
	B35sec8oxJKXn5cqJc7rBLJDAKQoozQPbgUsRb1iFAf6WJjXDaSKB5je4Ca9AlrCBLSk6/41
	kCUliQgpqQZGmz+lE/xy9vQt9Nxemz+95Jugs92WGsbmnrZbsbUi21KXB18OYDpwcb9VsoGB
	rhUbw8mknRbJ8l2P/RO4LUyfrZqf8dlddVHMnhtffrvETdR1kX9yKCt5SZmP3rn8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229767>

On 07/07/2013 06:12 AM, Jeff King wrote:
> On Sat, Jul 06, 2013 at 09:48:52PM +0200, Michael Haggerty wrote:
> 
>> When and if resolve_symlink() is called, then that function is
>> correctly told to treat the buffer as (PATH_MAX - 5) characters long.
>> This part is correct.  However:
>>
>> * If LOCK_NODEREF was specified, then resolve_symlink() is never
>>   called.
>>
>> * If resolve_symlink() is called but the path is not a symlink, then
>>   the length check is never applied.
>>
>> So it is possible for a path with length (PATH_MAX - 5 <= len <
>> PATH_MAX) to make it through the checks.  When ".lock" is strcat()ted
>> to such a path, the lock_file::filename buffer is overflowed.
> 
> Thanks for posting this. I independently discovered this about a month
> ago while working on an unrelated series, and then let it languish
> unseen and forgotten at the base of that almost-done series.
> 
> So definitely a problem, and my patch looked almost identical to
> yours. The only difference is:
> 
>>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>>  {
>> -	if (strlen(path) >= sizeof(lk->filename))
>> -		return -1;
>> -	strcpy(lk->filename, path);
>>  	/*
>>  	 * subtract 5 from size to make sure there's room for adding
>>  	 * ".lock" for the lock file name
>>  	 */
>> +	if (strlen(path) >= sizeof(lk->filename)-5)
>> +		return -1;
>> +	strcpy(lk->filename, path);
>>  	if (!(flags & LOCK_NODEREF))
>>  		resolve_symlink(lk->filename, sizeof(lk->filename)-5);
> 
> It might be worth consolidating the magic "-5" into a constant near the
> comment, like this:
> 
> diff --git a/lockfile.c b/lockfile.c
> index c6fb77b..2aeb2bb 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -124,15 +124,16 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  
>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>  {
> -	if (strlen(path) >= sizeof(lk->filename))
> -		return -1;
> -	strcpy(lk->filename, path);
>  	/*
>  	 * subtract 5 from size to make sure there's room for adding
>  	 * ".lock" for the lock file name
>  	 */
> +	static const size_t max_path_len = sizeof(lk->filename) - 5;
> +	if (strlen(path) >= max_path_len)
> +		return -1;
> +	strcpy(lk->filename, path);
>  	if (!(flags & LOCK_NODEREF))
> -		resolve_symlink(lk->filename, sizeof(lk->filename)-5);
> +		resolve_symlink(lk->filename, max_path_len);
>  	strcat(lk->filename, ".lock");
>  	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
>  	if (0 <= lk->fd) {
> 
> But either way, the fix looks good to me.

Yes, the constant is an improvement and Peff's version is also fine with me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
