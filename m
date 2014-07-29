From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 3/6] rewrite git_config() to use the config-set API
Date: Tue, 29 Jul 2014 23:19:33 +0530
Message-ID: <53D7DEAD.9060104@gmail.com>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>	<1406633302-23144-4-git-send-email-tanayabh@gmail.com>	<vpqlhrc8hif.fsf@anie.imag.fr> <53D7A280.6080201@gmail.com> <vpq4my045yu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:49:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBX5-000603-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbaG2Rtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:49:47 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:62461 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbaG2Rtq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:49:46 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so8474pdj.8
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JMscW/kleuKyX9fVI4CS6FU41YworQ52ro1sc/NAey8=;
        b=Y8KCS1nHQAyM/NOYM21bmA6Xt2+NQGdnlJgJajpIMGQ82jLnw/2iilPjDTEKA4EZfT
         yD06tqHDY10Ts2nIiSR+g580XUSCs6eNJ6fIYJb9cVYhM8BVb1rY8lUVn8CEH4bsVyV3
         PTixccyBLhjZfbBSglOJWRjNaQLKf1rDrj2u/yGSLT/dmt04xlW2dfJvL5pDY72Eo6Dh
         eUajGeY5eVXJ0gr1OuOtaVx3un6LjdaFO4xH3sgmweDoQULVWqZxSZfJYhfwybhnv1Qu
         2WiHEAZdbwOkp+Sic5Ee2hH67x6MXzC4nLcAHdYPLdxm6DAhbEE7VJnYkYMQsbkAPmJZ
         qvqw==
X-Received: by 10.69.2.99 with SMTP id bn3mr3676457pbd.34.1406656186417;
        Tue, 29 Jul 2014 10:49:46 -0700 (PDT)
Received: from [127.0.0.1] ([223.188.154.69])
        by mx.google.com with ESMTPSA id g7sm29840941pdk.87.2014.07.29.10.49.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 10:49:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq4my045yu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254450>



On 7/29/2014 7:33 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> On 7/29/2014 6:10 PM, Matthieu Moy wrote:
>>> So, I think it's time to make it official that git_config() does not
>>> return an error code, and make it return void. I would do that in a
>>> patch before the git_config() -> git_config_raw() rewrite.
>>>
>>> My preference would be to get the return value from
>>> git_config_with_options and die() if it's negative, but I can also live
>>
>> Doesn't git_config_with_options() only return positive values, we checked it
>> pretty intensively last time.
> 
> In normal cases, yes.
> 
> But the value comes from lines like
> 
> 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
> 		ret += git_config_from_file(fn, git_etc_gitconfig(),
> 					    data);
> 		found += 1;
> 	}
> 
> and git_config_from_file returns either 0 or -1.
> 
> So, either we consider that git_config_from_file always returns 0, and
> the "ret +=" part is dead code that should be removed as it only
> confuses the reader, or we consider cases where git_config_from_file
> returns -1, and we should do something with ret.
> 
> As we already discussed, "return -1" is possible in case of race
> condition between access_or_die() and git_config_from_file(). Very, very
> unlikely in practice, but may happen in theory.

This time I checked the entire blame history of the functions. You are right,
the return values are remnants of an earlier time.

The git_config() return value had no significance whatsoever for the majority
of the project existence.

git_config_with_options() return value is only checked for "git config --list"
, that also is redundant since doing something like this,

diff --git a/config.c b/config.c
index 058505c..63f1d30 100644
--- a/config.c
+++ b/config.c
@@ -1169,7 +1169,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)

        free(xdg_config);
        free(user_config);
-       return ret == 0 ? found : ret;
+       return found;
 }

still passes all the tests.

Also I tried every trick in the book, to make it return a negative value, but I failed.
So the only case left for a negative return value is what you said, race condition. I checked
about it and you are right, quoting from the "Linux programming interface",

"The time gap between a call to access() and a subsequent operation on a file means
that there is no guarantee that the information returned by access() will still be true
at the time of the later operation (no matter how brief the interval). This situation
could lead to security holes in some application designs."

"time-ofcheck, time-of-use race condition"


 That's why I suggest to
> die() in these cases: the user will never see it in practice, but it
> guarantees that we won't try to proceed if such case happen.
> 
> My point is not to improve the behavior, but to improve the code, by
> documenting properly where the error code is lost in the path from
> git_parse_source() to the caller of git_config().
> 
> We wouldn't have such discussion if the code was clear. I spent quite
> some time trying to understand why an error code could be returned by
> e.g. git_config_early(), and I'd like future readers to avoid wasting
> such time.
> 
>> Where can the die() statement be inserted? Again, I am confused.
> 
> I mean, changing the corresponding hunk to this:
> 
> --- a/config.c
> +++ b/config.c
> @@ -1223,9 +1223,21 @@ int git_config_with_options(config_fn_t fn, void *data,
>         return ret;
>  }
>  
> -int git_config(config_fn_t fn, void *data)
> +void git_config(config_fn_t fn, void *data)
>  {
> -       return git_config_with_options(fn, data, NULL, 1);
> +       if (git_config_with_options(fn, data, NULL, 1) < 0)
> +               /*
> +                * git_config_with_options() normally returns only
> +                * positive values, as most errors are fatal, and
> +                * non-fatal potential errors are guarded by "if"
> +                * statements that are entered only when no error is
> +                * possible.
> +                *
> +                * If we ever encounter a non-fatal error, it means
> +                * something went really wrong and we should stop
> +                * immediately.
> +                */
> +               die("Unknown error occured while reading the user's configuration");
>  }
>

Sounds reasonable, will apply in the next series.
Somewhat validation for git_config_with_options() return value is given in 1f2baa78c6,
quoted below for review.

"config: treat non-existent config files as empty

The git_config() function signals error by returning -1 in
two instances:

  1. An actual error occurs in opening a config file (parse
     errors cause an immediate die).

  2. Of the three possible config files, none was found.

However, this second case is often not an error at all; it
simply means that the user has no configuration (they are
outside a repo, and they have no ~/.gitconfig file). This
can lead to confusing errors, such as when the bash
completion calls "git config --list" outside of a repo. If
the user has a ~/.gitconfig, the command completes
succesfully; if they do not, it complains to stderr.

This patch allows callers of git_config to distinguish
between the two cases. Error is signaled by -1, and
otherwise the return value is the number of files parsed.
This means that the traditional "git_config(...) < 0" check
for error should work, but callers who want to know whether
we parsed any files or not can still do so."


>  static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
> 
>>> with a solution where the return value from git_config_with_options() is
>>> ignored. It's the same discussion we already had about the call to
>>> git_config() in git_config_check_init() actually, but I now think a
>>> die() statement should be within git_config(), not after, so that every
>>> callers benefit from it.
>>
>> The above patch works like that, doesn't it?
> 
> Except, it ignores the return code silently.
> 
> If you chose not to use a die() here, then ignoring the return value
> must be justified, or readers of the code will just assume a programming
> error, and will be tempted to repair the code by not ignoring the return
> value. If so, there is no point in counting errors in git_config_early()
> anymore, and a cleanup patch should be applied, something like:
> 
> --- a/config.c
> +++ b/config.c
> @@ -1147,30 +1147,30 @@ int git_config_system(void)
>  
>  int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  {
> -       int ret = 0, found = 0;
> +       int found = 0;
>         char *xdg_config = NULL;
>         char *user_config = NULL;
>  
>         home_config_paths(&user_config, &xdg_config, "config");
>  
>         if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
> -               ret += git_config_from_file(fn, git_etc_gitconfig(),
> +               git_config_from_file(fn, git_etc_gitconfig(),
>                                             data);
>                 found += 1;
>         }
>  
>         if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
> -               ret += git_config_from_file(fn, xdg_config, data);
> +               git_config_from_file(fn, xdg_config, data);
>                 found += 1;
>         }
>  
>         if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK)) {
> -               ret += git_config_from_file(fn, user_config, data);
> +               git_config_from_file(fn, user_config, data);
>                 found += 1;
>         }
>  
>         if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
> -               ret += git_config_from_file(fn, repo_config, data);
> +               git_config_from_file(fn, repo_config, data);
>                 found += 1;
>         }
>  
> @@ -1187,7 +1187,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  
>         free(xdg_config);
>         free(user_config);
> -       return ret == 0 ? found : ret;
> +       return found;
>  }
>  
>  int git_config_with_options(config_fn_t fn, void *data,
> 
> (untested)
> 
> My preference goes for the defensive one, using a proper die() statement
> (or even an assert()).
> 

Yes, mine too goes with the defensive one. Thanks.
