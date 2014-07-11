From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v8 1/2] add `config_set` API for caching config-like files
Date: Fri, 11 Jul 2014 22:01:41 +0530
Message-ID: <53C0116D.3010404@gmail.com>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>	<1405049655-4265-2-git-send-email-tanayabh@gmail.com> <vpqlhs02cz7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:31:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5djl-000750-7F
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 18:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbaGKQbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 12:31:49 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35738 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbaGKQbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 12:31:48 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so1741977pad.37
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qtmuhNIlTbedQff1MAsjwER12kqJpJ15b93Tutdqjm4=;
        b=ilYsGDbvly/7qK/p5hVo60MmdNMOvQagGZ4VzMQC3xasdvrSpJDs6Cfugcf8dovWiO
         MkLgRI3q1w3qVHXJUj0nk5TvfN1kPg4JWDbOrRTql8AJHEL2KaIEL3QJsvFMOk1yLKGi
         PAEXQohlLElW4moIHWxsrCWLgGlMLSHFi9CzOFCpKWQCPCJixrjbSqXas4bcZg9C4nXz
         UnAPHosYM6uvduOam9UWyl8RhCeEmE7N5izpfaMg7IBuiajUSyr5D2xKiEgThm77p14I
         cT50ZFVOMKIZyQza3cmkE0zzTVrUJqYX9hI8WKjU+fqLuae1pyGL0Jh9Si+x2EDkLuG6
         AfQg==
X-Received: by 10.70.35.143 with SMTP id h15mr25133002pdj.5.1405096307822;
        Fri, 11 Jul 2014 09:31:47 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.219.157])
        by mx.google.com with ESMTPSA id co3sm2742533pbb.89.2014.07.11.09.31.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 09:31:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqlhs02cz7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253289>



On 7/11/2014 7:51 PM, Matthieu Moy wrote:
> Hi,
> 
> I had a closer look at error management (once more, sorry: I should have
> done this earlier...), and it seems to me that:
> 
> * Not all errors are managed properly
> 
> * Most error cases are untested
> 
> Among the cases I can think of:
> 
> * Syntax error when parsing the file
> 
> * Non-existant file
> 
> * Unreadable file (chmod -r)
>

I had seen that there were checks for Syntax error or Non-existant files in
t1300-repo-config, for example,

# malformed configuration files
test_expect_success 'barf on syntax error' '
	cat >.git/config <<-\EOF &&
	# broken section line
	[section]
	key garbage
	EOF
	test_must_fail git config --get section.key >actual 2>error &&
	grep " line 3 " error
'

test_expect_success 'barf on incomplete section header' '
	cat >.git/config <<-\EOF &&
	# broken section line
	[section
	key = value
	EOF
	test_must_fail git config --get section.key >actual 2>error &&
	grep " line 2 " error
'

test_expect_success 'barf on incomplete string' '
	cat >.git/config <<-\EOF &&
	# broken section line
	[section]
	key = "value string
	EOF
	test_must_fail git config --get section.key >actual 2>error &&
	grep " line 3 " error
'
test_expect_success 'alternative GIT_CONFIG (non-existing file should fail)' '
	test_must_fail git config --file non-existing-config -l
'

They cover the same parsing code which I used for constructing the cache.
Still, more tests will not harm anyone, I will add more testcases accordingly
for the corner cases you raised. :)

> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> +`int git_configset_add_file(struct config_set *cs, const char *filename)`::
>> +
>> +	Parses the file and adds the variable-value pairs to the `config_set`,
>> +	dies if there is an error in parsing the file.
> 
> The return value is undocumented.
> 
> If I read correctly, the only codepath from this to a syntax error sets
> die_on_error, hence "dies if there is an error in parsing the file" is
> correct.
> 
> Still, there are errors like "unreadable file" or "no such file" that do
> not die (nor emit any error message, which is not very good for the
> user), and lead to returning -1 here.
> 
> I'm not sure this distinction is right (why die on syntax error and
> continue running on unreadable file?).
> 
> In any case, it should be documented and tested. I'll send a fixup patch
> with a few more example tests (probably insufficient).
>

I am not sure of this myself, I will have to look into it.

>> +static int git_config_check_init(void)
>> +{
>> +	int ret = 0;
>> +	if (the_config_set.hash_initialized)
>> +		return 0;
>> +	configset_init(&the_config_set);
>> +	ret = git_config(config_hash_callback, &the_config_set);
>> +	if (ret >= 0)
>> +		return 0;
>> +	else {
>> +		hashmap_free(&the_config_set.config_hash, 1);
>> +		the_config_set.hash_initialized = 0;
>> +		return -1;
>> +	}
>> +}
> 
> We have the same convention for errors here. But a more serious issue is
> that the return value of this function is ignored most of the time.
> 
> It seems git_config should never return a negative value, as it calls
> git_config_with_options -> git_config_early, which checks for file
> existance and permission before calling git_config_from_file. Indeed,
> Git's tests still pass after this:
> 
> --- a/config.c
> +++ b/config.c
> @@ -1225,7 +1225,10 @@ int git_config_with_options(config_fn_t fn, void *data,
>  
>  int git_config(config_fn_t fn, void *data)
>  {
> -       return git_config_with_options(fn, data, NULL, 1);
> +       int ret = git_config_with_options(fn, data, NULL, 1);
> +       if (ret < 0)
> +               die("Negative return value in git_config");
> +       return ret;
>  }
> 
> Still, we can imagine cases like race condition between access_or_die()
> and git_config_from_file() in
> 
> 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
> 		ret += git_config_from_file(fn, git_etc_gitconfig(),
> 					    data);
> 		found += 1;
> 	}
> 
> where the function would indeed return -1. In any case, either we
> consider that git_config should never return -1, and we should die in
> this case, or we consider that it may happen, and that the "else" branch
> of the if/else above is not dead code, and then we can't just ignore the
> return value.
> 
> I think we should just do something like this:
> 
> diff --git a/config.c b/config.c
> index 74adbbd..5c023e8 100644
> --- a/config.c
> +++ b/config.c
> @@ -1428,7 +1428,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
>                 return 1;
>  }
>  
> -static int git_config_check_init(void)
> +static void git_config_check_init(void)
>  {
>         int ret = 0;
>         if (the_config_set.hash_initialized)
> @@ -1437,11 +1437,8 @@ static int git_config_check_init(void)
>         ret = git_config(config_hash_callback, &the_config_set);
>         if (ret >= 0)
>                 return 0;
> -       else {
> -               hashmap_free(&the_config_set.config_hash, 1);
> -               the_config_set.hash_initialized = 0;
> -               return -1;
> -       }
> +       else
> +               die("Unknown error when parsing one of the configuration files.");
>  }
>  
> If not, a comment should explain what the "else" branch corresponds to,
> and why/when the return value can be safely ignored.
>

Yes, this is much better, I will make the necessary changes, thanks.
