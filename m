From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/6] rewrite git_config() to use the config-set API
Date: Tue, 29 Jul 2014 16:03:53 +0200
Message-ID: <vpq4my045yu.fsf@anie.imag.fr>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
	<1406633302-23144-4-git-send-email-tanayabh@gmail.com>
	<vpqlhrc8hif.fsf@anie.imag.fr> <53D7A280.6080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 16:04:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC80s-0002AZ-U0
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 16:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbaG2OES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 10:04:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52553 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaG2OER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 10:04:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6TE3qBG007451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2014 16:03:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6TE3rbF030199;
	Tue, 29 Jul 2014 16:03:53 +0200
In-Reply-To: <53D7A280.6080201@gmail.com> (Tanay Abhra's message of "Tue, 29
	Jul 2014 19:02:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Jul 2014 16:03:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6TE3qBG007451
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407247433.2053@Beqa3wFmSnEZKZxDgmarMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254443>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/29/2014 6:10 PM, Matthieu Moy wrote:
>> So, I think it's time to make it official that git_config() does not
>> return an error code, and make it return void. I would do that in a
>> patch before the git_config() -> git_config_raw() rewrite.
>> 
>> My preference would be to get the return value from
>> git_config_with_options and die() if it's negative, but I can also live
>
> Doesn't git_config_with_options() only return positive values, we checked it
> pretty intensively last time.

In normal cases, yes.

But the value comes from lines like

	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
		ret += git_config_from_file(fn, git_etc_gitconfig(),
					    data);
		found += 1;
	}

and git_config_from_file returns either 0 or -1.

So, either we consider that git_config_from_file always returns 0, and
the "ret +=" part is dead code that should be removed as it only
confuses the reader, or we consider cases where git_config_from_file
returns -1, and we should do something with ret.

As we already discussed, "return -1" is possible in case of race
condition between access_or_die() and git_config_from_file(). Very, very
unlikely in practice, but may happen in theory. That's why I suggest to
die() in these cases: the user will never see it in practice, but it
guarantees that we won't try to proceed if such case happen.

My point is not to improve the behavior, but to improve the code, by
documenting properly where the error code is lost in the path from
git_parse_source() to the caller of git_config().

We wouldn't have such discussion if the code was clear. I spent quite
some time trying to understand why an error code could be returned by
e.g. git_config_early(), and I'd like future readers to avoid wasting
such time.

> Where can the die() statement be inserted? Again, I am confused.

I mean, changing the corresponding hunk to this:

--- a/config.c
+++ b/config.c
@@ -1223,9 +1223,21 @@ int git_config_with_options(config_fn_t fn, void *data,
        return ret;
 }
 
-int git_config(config_fn_t fn, void *data)
+void git_config(config_fn_t fn, void *data)
 {
-       return git_config_with_options(fn, data, NULL, 1);
+       if (git_config_with_options(fn, data, NULL, 1) < 0)
+               /*
+                * git_config_with_options() normally returns only
+                * positive values, as most errors are fatal, and
+                * non-fatal potential errors are guarded by "if"
+                * statements that are entered only when no error is
+                * possible.
+                *
+                * If we ever encounter a non-fatal error, it means
+                * something went really wrong and we should stop
+                * immediately.
+                */
+               die("Unknown error occured while reading the user's configuration");
 }
 
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)

>> with a solution where the return value from git_config_with_options() is
>> ignored. It's the same discussion we already had about the call to
>> git_config() in git_config_check_init() actually, but I now think a
>> die() statement should be within git_config(), not after, so that every
>> callers benefit from it.
>
> The above patch works like that, doesn't it?

Except, it ignores the return code silently.

If you chose not to use a die() here, then ignoring the return value
must be justified, or readers of the code will just assume a programming
error, and will be tempted to repair the code by not ignoring the return
value. If so, there is no point in counting errors in git_config_early()
anymore, and a cleanup patch should be applied, something like:

--- a/config.c
+++ b/config.c
@@ -1147,30 +1147,30 @@ int git_config_system(void)
 
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
-       int ret = 0, found = 0;
+       int found = 0;
        char *xdg_config = NULL;
        char *user_config = NULL;
 
        home_config_paths(&user_config, &xdg_config, "config");
 
        if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
-               ret += git_config_from_file(fn, git_etc_gitconfig(),
+               git_config_from_file(fn, git_etc_gitconfig(),
                                            data);
                found += 1;
        }
 
        if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
-               ret += git_config_from_file(fn, xdg_config, data);
+               git_config_from_file(fn, xdg_config, data);
                found += 1;
        }
 
        if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK)) {
-               ret += git_config_from_file(fn, user_config, data);
+               git_config_from_file(fn, user_config, data);
                found += 1;
        }
 
        if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
-               ret += git_config_from_file(fn, repo_config, data);
+               git_config_from_file(fn, repo_config, data);
                found += 1;
        }
 
@@ -1187,7 +1187,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
        free(xdg_config);
        free(user_config);
-       return ret == 0 ? found : ret;
+       return found;
 }
 
 int git_config_with_options(config_fn_t fn, void *data,

(untested)

My preference goes for the defensive one, using a proper die() statement
(or even an assert()).

>> In any case, doing this in a separate patch means the commit message
>> (and possibly a comment next to the git_config() call) should explain
>> the situation clearly and justify the choice.
>>
>
> The choice being not to return a error code for git_config()?
> I am pretty much confused by now.

The choice of which of the two patches above you'll prefer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
