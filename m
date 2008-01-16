From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 16:46:23 -0600
Message-ID: <478E893F.4070100@nrlssc.navy.mil>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.44.0801152006260.944-100000@demand>	<7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>	<alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>	<7vodblo6c9.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil> <7v7ii9o2ld.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFH3u-0002Nu-Ed
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYAPWsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYAPWsR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:48:17 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39931 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbYAPWsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 17:48:16 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GMkNo3029694;
	Wed, 16 Jan 2008 16:46:24 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 16:46:23 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7v7ii9o2ld.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 16 Jan 2008 22:46:23.0458 (UTC) FILETIME=[9E9BEC20:01C85891]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--15.038700-0-2-1
X-TM-AS-Category-Info: : 2:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3NS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDM3MzEtNzExNDMyLTExMzkyMi03?=
	=?us-ascii?B?MDIwMjAtNzAxMjM2LTcwNDAzNC03MDM3ODgtNzAwOTcxLTEwNjQy?=
	=?us-ascii?B?MC03MDA2OTMtNzA4MTc5LTcwNzc1MC0xMzc3MTctMTg4MDE5LTcw?=
	=?us-ascii?B?NjI5MC0zMDAwMTUtNzA0Mjg3LTcwMjE0My03MDQ3NDctNzAxOTE0?=
	=?us-ascii?B?LTcwMDYxOC0xMTMyMjgtMTA1NzAwLTEyMTU4OC03MDAzMjQtNzAw?=
	=?us-ascii?B?MTUxLTcwNDA0OS0xNDgwMzktMTQ4MDUxLTIwMDQz?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70758>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> My patch does this, though I understand it may take some time to review.
> 
> This is what I have right now, squashed your change into [2/2] 
> I sent earlier, along with a couple of further fixups.
> 

Mainly, I prefer to not modify the data structures when a failure occurs.

Generally when commit_lock_file fails, the caller die()'s and then
remove_lock_file will delete the temporary file. If the caller were to
not call die, I think it should call rollback_lock_file() similarly to
how unlock_ref() is called everywhere in refs.c.

So I think the semantics should be:

	lock_fd = hold_lock_file(&lock);
	<do_something>
	if (close_lock_file(&lock)) {
		rollback_lock_file(&lock);
		return error;
	}
	if (commit_lock_file(&lock)) {
		rollback_lock_file(&lock);
		return error;
	}


> diff --git a/lockfile.c b/lockfile.c
> index f45d3ed..fcf9285 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -13,7 +13,8 @@ static void remove_lock_file(void)
>  	while (lock_file_list) {
>  		if (lock_file_list->owner == me &&
>  		    lock_file_list->filename[0]) {
> -			close(lock_file_list->fd);
> +			if (lock_file_list->fd >= 0)
> +				close(lock_file_list->fd);
>  			unlink(lock_file_list->filename);
>  		}
>  		lock_file_list = lock_file_list->next;
> @@ -159,11 +160,23 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on
>  	return fd;
>  }
>  
> +int close_lock_file(struct lock_file *lk)
> +{
> +	int fd = lk->fd;
> +	lk->fd = -1;
> +	return close(fd);
> +}

minor nit on this that I mentioned in another email.

> +
>  int commit_lock_file(struct lock_file *lk)
>  {
>  	char result_file[PATH_MAX];
>  	int i;
> -	close(lk->fd);
> +
> +	if (lk->fd >= 0 && close_lock_file(lk)) {
> +		unlink(lk->filename);
> +		lk->filename[0] = 0;
> +		return -1;
> +	}


I would rather have the caller call rollback_lock_file, or
fall back to remove_lock_file rather than do this unlinking
and modifying lk->filename here in commit_lock_file.


>  	strcpy(result_file, lk->filename);
>  	i = strlen(result_file) - 5; /* .lock */
>  	result_file[i] = 0;
> @@ -185,9 +198,15 @@ void set_alternate_index_output(const char *name)
>  int commit_locked_index(struct lock_file *lk)
>  {
>  	if (alternate_index_output) {
> -		int result = rename(lk->filename, alternate_index_output);
> -		lk->filename[0] = 0;
> -		return result;
> +		const char *newname = alternate_index_output;
> +		alternate_index_output = NULL;
> +
> +		if (lk->fd >= 0 && close_lock_file(lk)) {
> +			unlink(lk->filename);
> +			lk->filename[0] = 0;
> +			return -1;
> +		}

ditto here.

> +		return rename(lk->filename, newname);


If rename succeeds, we'll try to do an unnecessary unlink atexit.


Having said those things, I will defer to your more experienced judgment.

-brandon
