From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH MISC 1/1] Make gcc warning about empty if body go away.
Date: Thu, 08 Nov 2007 09:41:55 +0100
Message-ID: <4732CBD3.503@op5.se>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>	<1194430832-6224-2-git-send-email-madcoder@debian.org> <7vode57awg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2xr-0005vy-Nt
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbXKHImA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbXKHImA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:42:00 -0500
Received: from mail.op5.se ([193.201.96.20]:36450 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXKHIl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:41:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CDA531F08708;
	Thu,  8 Nov 2007 09:41:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5MbThtSJsf2; Thu,  8 Nov 2007 09:41:46 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id A1F1E1F08707;
	Thu,  8 Nov 2007 09:41:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vode57awg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63967>

Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
> 
>> diff --git a/builtin-diff.c b/builtin-diff.c
>> index f77352b..80392a8 100644
>> --- a/builtin-diff.c
>> +++ b/builtin-diff.c
>> @@ -204,7 +204,7 @@ static void refresh_index_quietly(void)
>>  		if (write_cache(fd, active_cache, active_nr) ||
>>  		    close(fd) ||
>>  		    commit_locked_index(lock_file))
>> -			; /*
>> +			(void)0; /*
>>  			   * silently ignore it -- we haven't mucked
>>  			   * with the real index.
>>  			   */
> 
> Wouldn't this be much easier to read, by the way?
> 
> The point is that if we touched the active_cache, we try to
> write it out and make it the index file for later users to use
> by calling "commit", but we do not really care about the failure
> from this sequence because it is done purely as an optimization.
> 
> The original code called three functions primarily for their
> side effects, which is admittedly a bad style.
> 
>  builtin-diff.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin-diff.c b/builtin-diff.c
> index f77352b..906c924 100644
> --- a/builtin-diff.c
> +++ b/builtin-diff.c
> @@ -200,15 +200,9 @@ static void refresh_index_quietly(void)
>  	discard_cache();
>  	read_cache();
>  	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
> -	if (active_cache_changed) {
> -		if (write_cache(fd, active_cache, active_nr) ||
> -		    close(fd) ||
> -		    commit_locked_index(lock_file))
> -			; /*
> -			   * silently ignore it -- we haven't mucked
> -			   * with the real index.
> -			   */
> -	}
> +	if (active_cache_changed &&
> +	    !write_cache(fd, active_cache, active_nr) && !close(fd))
> +		commit_locked_index(lock_file);
>  	rollback_lock_file(lock_file);
>  }
>  

Ack, obviously, as it no longer requires a comment to explain it, although
I'd prefer an empty line after commit_locked_index(lock_file); so as to not
confuse the rollback_lock_file() statement as being part of the conditional
path.

First I thought the rollback_lock_file() was the *only* statement to the
condition, and everyone who uses 4 for tabsize) will have double trouble
since commit_locked_index(lock_file) aligns with the second line of the
condition.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
