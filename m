From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-grep threads-num param
Date: Thu, 22 Oct 2015 13:40:34 -0700
Message-ID: <xmqqbnbqr60t.fsf@gitster.mtv.corp.google.com>
References: <1445520236-10753-1-git-send-email-vleschuk@accesssoftek.com>
	<20151022142302.GL19802@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Victor Leschuk <vleschuk@accesssoftek.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 22:41:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpMgH-000691-JX
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 22:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965508AbbJVUki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 16:40:38 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932560AbbJVUkh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 16:40:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5976C2550A;
	Thu, 22 Oct 2015 16:40:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dzw92HSx9/F4IRLXZ0NNoC1lA20=; b=tbtuhb
	rukX0Yxf+5a7GMNHLGCl+tPVkE89GHJiD1N7UX9w9OpQqnnhWuwKXBhz8bJdsfWo
	omj1oy+HbkTYg8/3Q+uZbQqignuq/pYRmDPmAiZmS1IyF+/RRgiKPmPmh0m91Y/b
	3pJLRbJPrz+8fWF/6gGlrX8BDsAnmsh0q16uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TOyg9kU9abB+xWIwuX9YRWaFWVUSLPDi
	N9XOE8JHXwE8EXWBHvj8qo4zfFTQa6XAm/HtvTI+kM0Hm9m0bglKXoUQeYhxfgkH
	SHPzmVPJnxMaZpnIhUuD2VLYhNlYm/djKdv8NwEuxeI2S79OsPtYhyBT4WIVrKqk
	P4Y/bRJV47M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51D7825509;
	Thu, 22 Oct 2015 16:40:36 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CAF18254FB;
	Thu, 22 Oct 2015 16:40:35 -0400 (EDT)
In-Reply-To: <20151022142302.GL19802@serenity.lan> (John Keeping's message of
	"Thu, 22 Oct 2015 15:23:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 25A6EEB0-78FD-11E5-AB60-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280076>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Oct 22, 2015 at 04:23:56PM +0300, Victor Leschuk wrote:
>> Hello all, I suggest we make number of git-grep worker threads a configuration
>> parameter. I have run several tests on systems with different number of CPU cores.
>> It appeared that the hard-coded number 8 lowers performance on both of my systems:
>> on my 4-core and 8-core systems the thread number of 4 worked about 20% faster than
>> default 8. So I think it is better to allow users tune this parameter.
>
> For git-pack-objects we call the command-line parameter "--threads" and
> the config variable "pack.threads".  Is there a reason not to use the
> same name here (i.e. "--threads" and "grep.threads")?

Good suggestion.

>> +-t <num>::
>> +--threads-num <num>::
>> +	Set number of worker threads to <num>. Default is 8.

It is not like you would want to specify different degree of
parallelism for every invocation of "grep".  The command line option
for this feature is expected to be used extremely infrequently, only
to defeat a configuration variable that is misconfigured to a wrong
value.  Squatting on a short-and-sweet single-letter option name is
unwarranted for an option like this.

>> -	for (i = 0; i < ARRAY_SIZE(threads); i++) {
>> +	threads = xmalloc(sizeof(pthread_t) * opt->num_threads);

xcalloc(nmemb, size)?

>> @@ -702,6 +704,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  			N_("show <n> context lines before matches")),
>>  		OPT_INTEGER('A', "after-context", &opt.post_context,
>>  			N_("show <n> context lines after matches")),
>> +#ifndef NO_PTHREADS
>> +		OPT_INTEGER('t', "threads-num", &opt.num_threads,
>> +			N_("use <n> worker threads")),
>> +#endif /* !NO_PTHREADS */
>>  		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
>>  			context_callback),
>>  		OPT_BOOL('p', "show-function", &opt.funcname,
>> @@ -910,7 +916,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  	}
>>  
>>  	if (use_threads)
>> -		hit |= wait_all();
>> +		hit |= wait_all(&opt);

I do not think anybody checked if opt.num_threads is a sensible
number after parse_options() returned at this point.  There is a
code outside the context before this hunk that decides if it makes
sense to use threads and turns use_threads to zero, which should
be the right place to do the missing sanity check, I thinnk.

>> diff --git a/grep.c b/grep.c
>> index 7b2b96a..17e6a7c 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -40,6 +40,9 @@ void init_grep_defaults(void)
>>  	color_set(opt->color_selected, "");
>>  	color_set(opt->color_sep, GIT_COLOR_CYAN);
>>  	opt->color = -1;
>> +#ifndef NO_PTHREADS
>> +	opt->num_threads = GREP_NUM_THREADS_DEFAULT;
>> +#endif /* !NO_PTHREADS */
>>  }

These #ifndef/#endif's are unnecessary distraction.  Just set them
unconditionally, even in NO_PTHREADS build (and of course include
the field even in NO_PTHREADS build in grep.h).
