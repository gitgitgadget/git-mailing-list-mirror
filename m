From: Victor Leschuk <vleschuk@gmail.com>
Subject: Re: [PATCH 1/2] Introduce grep threads param
Date: Tue, 15 Dec 2015 23:21:28 +0300
Message-ID: <56707648.4050005@gmail.com>
References: <1450193500-22468-1-git-send-email-vleschuk@accesssoftek.com>
 <1450193500-22468-2-git-send-email-vleschuk@accesssoftek.com>
 <xmqq60zzfpdz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com, john@keeping.me.uk,
	peff@peff.net, pclouds@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 21:21:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8w6L-0003YH-OO
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 21:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbbLOUVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 15:21:33 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36405 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbbLOUVc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 15:21:32 -0500
Received: by mail-lb0-f181.google.com with SMTP id lt2so13231959lbb.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 12:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=R7KNtRE/qWyGlr+QcgLLs9+qUSVwgj/AF5NAspnlYKQ=;
        b=NTbI9tYztAH8bixRDmdAw3FljPVTkrbGu0LG3q+2f1fGAKQZDwXqGWi7OfuV4PU6t9
         umheu+jh8sUdPkRmWg+0t57/v6LwKm4PADGf6gQXyQ3uumpqTHjsf+9mgDeXwTjCHzoA
         H6q+MHhZbC5+zx2HMscGJ8w6vSr4cQoiEJgnP6k3Bnaez9N+EDC6im0uerwj2Rd5NtLa
         dlkP3h2X0tpeaamMcJ9fHZ6S/WdM75eQNzkA6n4n8ObWyNA+Ndm4GJR21M2RK1CoLM7w
         EtiaM0WW19SjvOjxU7PKSKPM+SVevoAmLyIC0zRKQKvheP9e/6KXF6F7S5jAX6aJhyFO
         KlHw==
X-Received: by 10.112.161.33 with SMTP id xp1mr16524614lbb.141.1450210890542;
        Tue, 15 Dec 2015 12:21:30 -0800 (PST)
Received: from [192.168.1.101] (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id pl2sm450477lbc.8.2015.12.15.12.21.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Dec 2015 12:21:29 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqq60zzfpdz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282498>

Hello Junio,

On 12/15/2015 11:06 PM, Junio C Hamano wrote:
> Victor Leschuk <vleschuk@gmail.com> writes:
>
>> Subject: Re: [PATCH 1/2] Introduce grep threads param
> I'll retitle this to something like
>
>      grep: add --threads=<num> option and grep.threads configuration
>
> while queuing (which I did for v7 earlier).
Ok, thanks.
>
>>   "git grep" can now be configured (or told from the command line)
>>   how many threads to use when searching in the working tree files.
>>
>> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
>> ---
>> ...
>> +grep.threads::
>> +	Number of grep worker threads.
> "Number of grep worker threads to use"?
Accepted, will change.
>
>> +	See `grep.threads` in linkgit:git-grep[1] for more information.
>> ...
>> +grep.threads::
>> +	Number of grep worker threads, use it to tune up performance on
>> +	your machines. Leave it unset (or set to 0) for default behavior,
>> +	which is using 8 threads for all systems.
>> +	Default behavior may change in future versions
>> +	to better suit hardware and circumstances.
> The last sentence is too noisy.  Perhaps drop it and phrase it like
> this instead?
>
>      grep.threads::
>              Number of grep worker threads to use.  If unset (or set to 0),
>              to 0), 8 threads are used by default (for now).
Agree.
>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 4229cae..e9aebab 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -24,11 +24,11 @@ static char const * const grep_usage[] = {
>>   	NULL
>>   };
>>   
>> -static int use_threads = 1;
>> +#define GREP_NUM_THREADS_DEFAULT 8
>> +static int num_threads = 0;
> Please do not initialize static to 0 (or NULL).
Ok.
>
>> @@ -267,6 +270,12 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
>>   	int st = grep_config(var, value, cb);
>>   	if (git_color_default_config(var, value, cb) < 0)
>>   		st = -1;
>> +
>> +	if (!strcmp(var, "grep.threads")) {
>> +		/* Sanity check of value will be perfomed later */
> Hmm, is that a good design?
>
> A user may hear "invalid number of threads specified (-4)" later,
> but if that came from "grep.threads", especially when the user did
> not say "--threads=-4" from the command line, would she know to
> check her configuration file?
>
> If she had "grep.threads=Yes" in her configuration, we would
> helpfully tell her that 'Yes' given to grep.threads is not a valid
> integer.  Shouldn't we do the same for '-4' given to grep.threads,
> too?
>
> 	if (!strcmp(var, "grep.threads")) {
> 		num_threads = git_config_int(var, value);
> 		if (num_threads < 0)
> 			die(_("invalid number of threads specified (%d) for %s"),
> 			    num_threads, var);
> 	}
>
> perhaps.
When I was doing this I looked at other code and saw that exact message 
"Invalid number of threads..." is used in other parts of git and is 
present in 'po' translations. Thus I decided to use exactly the same 
message in order not to create numerous almost similar localizations 
(which we should do if we use two different messages in different 
places). Do you think we need to create two more different messages (and 
translations, I can prepare Russian and French) and create two checks 
for cmd and config?
>
>> @@ -817,14 +827,23 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>   	}
>>   
>>   #ifndef NO_PTHREADS
>> -	if (list.nr || cached || online_cpus() == 1)
>> -		use_threads = 0;
>> +	if (list.nr || cached || online_cpus() == 1 || show_in_pager) {
>> +		/* Can not multi-thread object lookup */
>> +		num_threads = 0;
> Removing 'use_threads = 0' from an earlier part and moving the check
> to show_in_pager is a good idea, but it invalidates this comment.
> The earlier three (actually two and a half) are "cannot" cases,
> i.e. the object layer is not easily threaded without locking, and
> when you have a single core, you do not truly run multiple
> operations at the same time, but as [PATCH 2/2] does, threading in
> "grep" is not about CPU alone, so that is why I am demoting it to
> just a half ;-).  But show_in_pager is "we do not want to", I think.
>
> In any case, this comment and "User didn't specify" below are not
> telling the reader something very much useful.  You probably should
> remove them.
Ok, will remove comments.
>
>> +	}
>> +	else if (num_threads == 0) {
>> +		/* User didn't specify value, or just wants default behavior */
>> +		num_threads = GREP_NUM_THREADS_DEFAULT;
>> +	}
>> +	else if (num_threads < 0) {
>> +		die(_("invalid number of threads specified (%d)"), num_threads);
>> +	}
> Many unnecessary braces.
I put braces to make code look more unified. I had to put braces here:

+	else if (num_threads == 0) {
+		/* User didn't specify value, or just wants default behavior */


In order to be able to place long comment above the line. And code like:

if (a)
   do_smth();
else if (b) {
   do_smth1();
   do_smth2();
}
else
   do_smth3();

Looks rather ugly to me. Usually I put braces to all 'ifs' if any part 
of block requires them.
Actually I will remove comments as I said above, and thus remove all braces.
>
> I think [2/2] and also moving the code to disable threading when
> show-in-pager mode should be separate "preparatory clean-up" patches
> before this main patch.  I'll push out what I think this topic
> should be on 'pu' later today (with fixups suggested above squashed
> in); please check them and see what you think.
>
> Thanks.
Ok, I will prepare v8 as soon as we finish discussion on this one.

Thanks for the review.

--
Victor
