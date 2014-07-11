From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 1/2] add `config_set` API for caching config-like files
Date: Fri, 11 Jul 2014 16:21:00 +0200
Message-ID: <vpqlhs02cz7.fsf@anie.imag.fr>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>
	<1405049655-4265-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:21:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5bi0-0008Av-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 16:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779AbaGKOVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 10:21:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46892 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbaGKOVe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 10:21:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6BEKwBt014136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jul 2014 16:20:59 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6BEL0k3024086;
	Fri, 11 Jul 2014 16:21:00 +0200
In-Reply-To: <1405049655-4265-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 10 Jul 2014 20:34:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Jul 2014 16:20:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6BEKwBt014136
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405693261.82626@usxCMsfxFs4UIRndGKcdkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253276>

Hi,

I had a closer look at error management (once more, sorry: I should have
done this earlier...), and it seems to me that:

* Not all errors are managed properly

* Most error cases are untested

Among the cases I can think of:

* Syntax error when parsing the file

* Non-existant file

* Unreadable file (chmod -r)

Tanay Abhra <tanayabh@gmail.com> writes:

> +`int git_configset_add_file(struct config_set *cs, const char *filename)`::
> +
> +	Parses the file and adds the variable-value pairs to the `config_set`,
> +	dies if there is an error in parsing the file.

The return value is undocumented.

If I read correctly, the only codepath from this to a syntax error sets
die_on_error, hence "dies if there is an error in parsing the file" is
correct.

Still, there are errors like "unreadable file" or "no such file" that do
not die (nor emit any error message, which is not very good for the
user), and lead to returning -1 here.

I'm not sure this distinction is right (why die on syntax error and
continue running on unreadable file?).

In any case, it should be documented and tested. I'll send a fixup patch
with a few more example tests (probably insufficient).

> +static int git_config_check_init(void)
> +{
> +	int ret = 0;
> +	if (the_config_set.hash_initialized)
> +		return 0;
> +	configset_init(&the_config_set);
> +	ret = git_config(config_hash_callback, &the_config_set);
> +	if (ret >= 0)
> +		return 0;
> +	else {
> +		hashmap_free(&the_config_set.config_hash, 1);
> +		the_config_set.hash_initialized = 0;
> +		return -1;
> +	}
> +}

We have the same convention for errors here. But a more serious issue is
that the return value of this function is ignored most of the time.

It seems git_config should never return a negative value, as it calls
git_config_with_options -> git_config_early, which checks for file
existance and permission before calling git_config_from_file. Indeed,
Git's tests still pass after this:

--- a/config.c
+++ b/config.c
@@ -1225,7 +1225,10 @@ int git_config_with_options(config_fn_t fn, void *data,
 
 int git_config(config_fn_t fn, void *data)
 {
-       return git_config_with_options(fn, data, NULL, 1);
+       int ret = git_config_with_options(fn, data, NULL, 1);
+       if (ret < 0)
+               die("Negative return value in git_config");
+       return ret;
 }

Still, we can imagine cases like race condition between access_or_die()
and git_config_from_file() in

	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
		ret += git_config_from_file(fn, git_etc_gitconfig(),
					    data);
		found += 1;
	}

where the function would indeed return -1. In any case, either we
consider that git_config should never return -1, and we should die in
this case, or we consider that it may happen, and that the "else" branch
of the if/else above is not dead code, and then we can't just ignore the
return value.

I think we should just do something like this:

diff --git a/config.c b/config.c
index 74adbbd..5c023e8 100644
--- a/config.c
+++ b/config.c
@@ -1428,7 +1428,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
                return 1;
 }
 
-static int git_config_check_init(void)
+static void git_config_check_init(void)
 {
        int ret = 0;
        if (the_config_set.hash_initialized)
@@ -1437,11 +1437,8 @@ static int git_config_check_init(void)
        ret = git_config(config_hash_callback, &the_config_set);
        if (ret >= 0)
                return 0;
-       else {
-               hashmap_free(&the_config_set.config_hash, 1);
-               the_config_set.hash_initialized = 0;
-               return -1;
-       }
+       else
+               die("Unknown error when parsing one of the configuration files.");
 }
 
If not, a comment should explain what the "else" branch corresponds to,
and why/when the return value can be safely ignored.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
