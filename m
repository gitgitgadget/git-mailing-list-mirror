From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 5/3] revert most of the http_options() change
Date: Tue, 30 Jul 2013 12:41:37 -0700
Message-ID: <3C93D9D6-8FC3-4D94-AE6E-37150202314A@gmail.com>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org> <1375138150-19520-1-git-send-email-gitster@pobox.com> <7v7gg8ztvk.fsf_-_@alter.siamese.dyndns.org> <7v1u6gztf1.fsf_-_@alter.siamese.dyndns.org> <CC3A0EB0-79FE-40C2-B1AC-E3B9683A3ED6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:41:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Fnl-0002pN-I0
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455Ab3G3Tlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:41:42 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:34273 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab3G3Tll (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:41:41 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so6366810pbc.25
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=Z9MECUf4Nvet0h3WRxnZTPhYzpxIjWGgB8Xl6NkmoGw=;
        b=VMiHiDG3xAxo5IhoG2zl/VaUh/toclcFL/WtaZtrTqnllF0JXifPRyH9NY49OzNxs/
         23ML5Z2oCWRvwanFfnPCrEt2tArkaODVI2A7Tzk0XYuw+vXTNSFCZKFyMqvsP7boMhav
         3kwZ8GUZkt6J0ooOqSa3hwy9Ibvd5pM0FQN9rqoxx0kzbkTguiJX6ypXgb+9pqMwlLuY
         sQJ6A2J8c/Yb2e8JlPzs12D4y1YzsOotFJQgOmG3Htx3fne2RWGUpUd/meeNF6ZI8i2u
         nFm1UjXU3UnvZxvNrHw3chcktNeZQyMPP2gJv3IpkrXrhF+rKEhPKRqXtF4gCl7rh00m
         mktQ==
X-Received: by 10.66.216.129 with SMTP id oq1mr34087102pac.75.1375213300298;
        Tue, 30 Jul 2013 12:41:40 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id a5sm14149454pbw.4.2013.07.30.12.41.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 12:41:39 -0700 (PDT)
In-Reply-To: <CC3A0EB0-79FE-40C2-B1AC-E3B9683A3ED6@gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231381>


On Jul 30, 2013, at 12:14, Kyle J. McKay wrote:

> On Jul 29, 2013, at 19:13, Junio C Hamano wrote:
>
>> With the previous preparation step, the earlier 1bb00006 (config:
>> add support for http.<url>.* settings, 2013-07-21) that introduced
>> many repeated changes:
>>
>>       -if (!strcmp("http.key", var)) {
>>       +if (!strcmp("key", key)) {
>>       +       if (match_is_shorter(..., OPT_KEY_NAME))
>>       +               return 0;
>>               ... original processing for KEY_NAME ...
>>        }
>>
>> can be reverted.
>>
>> This allows us to also get rid of the "repeating yourself to the
>> death" enum http_option_type, and new code (like db/http-savecookies
>> patch) that wants to add a new configuration to the http.* subsystem
>> does not have to conflict with http.<urlpattern>.variable series at
>> all.
>>
>> This is more-or-less how I want the endgame to look like. Not even
>> compile tested, but it is getting late so I'll show it to the list
>> in case people may want to play with it and polish it while I am
>> away for the night ;-).
>>
>> If people can agree that this is going in the right direction,
>> perhaps we should rebuild Kyle's series without detouring of adding
>> and then yanking what 1bb00006 (config: add support for http.<url>.*
>> settings, 2013-07-21) did in the next cycle.
>>
>> http.c               | 181 ++++++++ 
>> +------------------------------------------
>> test-url-normalize.c |   9 ++-
>> 2 files changed, 39 insertions(+), 151 deletions(-)
>>
>> diff --git a/http.c b/http.c
>> index a91a00b..c7f513b 100644
>> --- a/http.c
>> +++ b/http.c
> [...]
>> @@ -469,15 +342,23 @@ void http_init(struct remote *remote, const  
>> char *url, int proactive_auth)
>> {
>> 	char *low_speed_limit;
>> 	char *low_speed_time;
>> -	struct url_info info;
>> +	char *normalized_url;
>> +	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
>> +
>> +	config.fn = http_options;
>> +	config.cascade_fn = git_default_config;
>> +	config.item_alloc = NULL;
>> +	config.item_clear = NULL;
>> +	config.cb = NULL;
>
> Missing this:
> +	config.section = "http";
>
>
> [...]
>> diff --git a/test-url-normalize.c b/test-url-normalize.c
>> index 0b809eb..fab94e5 100644
>> --- a/test-url-normalize.c
>> +++ b/test-url-normalize.c
>> @@ -15,8 +15,15 @@ static int run_http_options(const char *file,
>> {
>> 	struct strbuf opt_lc;
>> 	size_t i, len;
>> +	struct urlmatch_config config = { STRING_LIST_INIT_DUP };

Also needs this:

+	memcpy(&config.url, info, sizeof(struct url_info));

>> -	if (git_config_with_options(http_options, (void *)info, file, 0))
>> +	config.fn = http_options;
>> +	config.cascade_fn = git_default_config;
>> +	config.item_alloc = NULL;
>> +	config.item_clear = NULL;
>> +	config.cb = NULL;
>
>
> Missing this:
> +	config.section = "http";
>
> Without these it segfaults running the tests.
>
> However, now the tests that actually check the results using config  
> files are failing:
>
>> # failed 1 among 11 test(s)
>
> I'm looking at it now to see if I can fix the problem.

And now all the t5200-url-normalize tests pass again.

FYI, I couldn't get the patches to apply against next or pu without  
some minor tweaks that were just conflict resolutions having to do  
with git_config_with_options changing its signature.
