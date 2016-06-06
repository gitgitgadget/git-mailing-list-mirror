From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted remotes.
Date: Mon, 06 Jun 2016 17:18:32 +0200
Message-ID: <vpq37oqjqgn.fsf@anie.imag.fr>
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, larsxschneider@gmail.com,
	rsbecker@nexbridge.com, aaron@schrab.com, peff@peff.net
To: Antoine Queru <Antoine.Queru@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 17:19:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9wIv-0003Iy-C1
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 17:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbcFFPS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 11:18:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44813 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbcFFPSz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 11:18:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u56FIVPI017521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 17:18:31 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56FIW9T002054;
	Mon, 6 Jun 2016 17:18:32 +0200
In-Reply-To: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org> (Antoine
	Queru's message of "Sat, 4 Jun 2016 16:51:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 06 Jun 2016 17:18:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56FIVPI017521
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465831113.79351@0x7k7T5g8b9FZQAgar5TAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296520>

Antoine Queru <Antoine.Queru@grenoble-inp.org> writes:

> Currently, a user wanting to prevent accidental pushes to the wrong
> remote has to create a pre-push hook.  The feature

It's not clear what "The feature" refers to. Given the context, I read
it as "pre-push hook", but I think this is not what you meant.

> User, password and port are not treated. Should it be ?

Please elaborate on "not treated". What happens if github.com is
blacklisted by the user pushes to http://me@github.com ?

>  Documentation/config.txt            |  17 ++++++
>  Documentation/urls-remotes.txt      |  55 ++++++++++++++++++
>  builtin/push.c                      | 110 ++++++++++++++++++++++++++++++++++--
>  t/t5544-push-whitelist-blacklist.sh |  51 +++++++++++++++++
>  4 files changed, 228 insertions(+), 5 deletions(-)
>  create mode 100755 t/t5544-push-whitelist-blacklist.sh
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 53f00db..7fe88f5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2517,6 +2517,23 @@ remote.pushDefault::
>  	`branch.<name>.remote` for all branches, and is overridden by
>  	`branch.<name>.pushRemote` for specific branches.
>  
> +remote.pushBlacklist::
> +	The list of remotes the user is forbidden to push to.
> +	See linkgit:git-push[1]

This is only true when remote.pushDefaultPolicy is "allow". It makes
sense to say it explicitly here, if only to have a pointer to
pushDefaultPolicy.

	The list of remotes the user is forbidden to push to when
	`remote.pushDefaultPolicy` is 'allow'

?

This doesn't document the "longest prefix wins", so the complete
sentence could be

	The list of remotes the user is forbidden to push to when
	`remote.pushDefaultPolicy` is 'allow', or the list of exceptions
	to `remote.pushWhitelist` when it is 'deny'.

Or perhaps it's just overkill.

> +remote.pushWhitelist::
> +	The list of remotes the user is allowed to push to.
> +	See linkgit:git-push[1]

Likewise.

> +remote.pushDenyMessage::
> +	The message printed when pushing to a forbidden remote.
> +	Defaults to "Pushing to this remote has been forbidden".

Perhaps add something like "Please check your Git configuration files
for details" to give a hint to the user about what's going on? (and give
a chance to read the comment next to the configuration hopefully)

>  remote.<name>.url::
>  	The URL of a remote repository.  See linkgit:git-fetch[1] or
>  	linkgit:git-push[1].
> diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
> index bd184cd..705914d 100644
> --- a/Documentation/urls-remotes.txt
> +++ b/Documentation/urls-remotes.txt
> @@ -89,6 +89,61 @@ git push uses:
>  	HEAD:refs/heads/<head>
>  ------------
>  
> +Denying pushes to the wrong remotes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2 '~' missing above.

> +The simplest way to forbid pushes to a remote is to add its url in the
> +config file under the 'remote.pushBlacklist' variable.  A more
> +restrictive way is to change 'remote.pushDefaultPolicy' to 'deny',
> +thus denying pushes to every remote not whitelisted. You can then add
> +the right remotes under 'remote.pushWhitelist'.

A few meters from you are people working on guidelines for formatting of
configuration variables. I guess they read this patch already but
they're too angry to tell you ;-).

> +You can also configure more advanced acceptation/denial

A native may confirm/infirm, but it seems "acceptation" is essentially
the word french people use to mean "acceptance".

> +Pushes like this  will be accepted:
> +-------------------------------
> +git push repository.com/Special_Path/*
> +-------------------------------

The '*' is misleading to me. As-is, it's a shell metacaracter that would
be expanded locally by my shell. I guess you don't mean it like this,
but rather "type anything here". Since you're already giving a concrete
example, I'd make it completely concrete like

git push repository.com/Special_Path/subdirectory

> +While this one for example will be denied:
> +-------------------------------
> +git push repository.com/Other_Path/
> +-------------------------------
> +
> +Remember to use '--add' with 'git config' to add more than one
> +'remote.pushBlacklist'.

I'd write:

`remote.pushBlacklist` and `remote.pushWhitelist` are multi-valued
variables, hence you can more than one element using `git config --add`.


Now, a real question about the behavior: what happens when multiple
patterns match on the same side (white or black), like

pushBlacklist = example.com
pushBlacklist = example.com/a/b
pushWhitelist = example.com/a

?

I think this deserves a test.

> +Specific schemes can also be denied. For example :

No space before :.

> +-------------------------------
> +git config --add remote.pushBlacklist http://repo.com
> +-------------------------------

Avoid using real domain names (or domain names that could become real)
in examples. example.com is made precisely for this (rfc2606).

> +By doing so, only pushes to repo.com using 'http' will be denied,

`...` around `repo.com`.

> +static void check_length_prefix(const int whitelist,
> +				const int blacklist,

On the caller side, these are called *_size, and you dropped the _size
part here. I find it much less readable.

> +static void find_longest_prefix(const char *str, const char *pre, int *max)
> +{
> +	if (starts_with(str, pre)) {
> +		int tmp = strlen(pre);
> +		if (*max < tmp)
> +			*max = tmp;
> +	}
> +}

>From the name of the function, I'd have expected it to find the longest
common prefix of two strings or so, but it doesn't do that at all.
Please find a better name.

> +/*
> + *NEEDSWORK: Ugly because file://... is recognized as an url, and we
> + *may want to compare it to local path without this scheme. Forcing
> + *the user to put file:// before every local path would make the code
> + *easier and avoid confusion with a distant repo like 'github.com'
> + *which is not an url.
> + */

Not sure what you mean. In the text above, which instance refers to "the
path the user is pushing to" and which one is "the path that appears in
the whitelist/blacklist"?

I think you have to forbid relative local path here if you want to allow
strings like "github.com", which can both be a relative path and a
hostname.

If you do, then you can apply the rule

int is_local = 0;
if (is_absolute_path(curr_url))
	is_local = 1;
else if (skip_prefix(curr_url, "file://", &curr_url))
	is_local = 1

to know if the current item is local or not. OTOH, for target_str, the
URL scheme has to be there for remote accesses so there's no ambiguity.

> +static int longest_prefix_size(const char* target_str,
> +				const struct string_list *list)
> +{
> +	struct string_list_item *curr_item;
> +	struct url_info target_url;
> +	int max_size = 0;
> +	if (!list)
> +		return 0;
> +
> +	skip_prefix(target_str, "file://", &target_str);
> +	url_normalize(target_str, &target_url);
> +
> +	for_each_string_list_item(curr_item, list) {

curr_item just says it's the current item, but not of what. Perhaps
curr_prefix or curr_pattern (not 100% convinced myself actually).

> +		struct url_info curr_url;
> +		const char *curr_str = curr_item->string;
> +		skip_prefix(curr_str, "file://", &curr_str);
> +		url_normalize(curr_str, &curr_url);
> +		if (target_url.url &&
> +		    curr_url.url &&
> +		    target_url.scheme_len == curr_url.scheme_len &&
> +		    !strncmp(target_url.url,curr_url.url,curr_url.scheme_len))

This comparison is quite obscure if you don't have the whole picture in
mind. It really deserves a comment (explanation and/or example).

> +			find_longest_prefix(target_url.url + target_url.host_off,
> +					    curr_url.url + curr_url.host_off,
> +					    &max_size);
> +		else if (target_url.url && !curr_url.url)
> +			find_longest_prefix(target_url.url + target_url.host_off,
> +					    curr_str,
> +					    &max_size);
> +
> +		else if(!target_url.url && !curr_url.url)

Space after if.

> +			find_longest_prefix(target_str, curr_str, &max_size);

When no condition match, there's no "else" so you're doing nothing. This
also deserves a comment like

/* else, either:
 * - !target_url.url && curr_url.url: ...
 * - target_url.url && curr_url.url but both use different schemes: ...
 */

Actually, I'd even write actual if/else branches for these cases, with
an empty statement like

if (target_url.url && curr_url.url)
	if (target_url.scheme_len == curr_url.scheme_len &&
            !strncmp(target_url.url,curr_url.url,curr_url.scheme_len))
        	find_longest_prefix(...)
        else
        	; /* explanation of why you do nothing here */
...
else
	; /* likewise */


>  static int do_push(const char *repo, int flags)
>  {
>  	int i, errs;
> @@ -404,15 +501,18 @@ static int do_push(const char *repo, int flags)
>  	url_nr = push_url_of_remote(remote, &url);
>  	if (url_nr) {
>  		for (i = 0; i < url_nr; i++) {
> -			struct transport *transport =
> -				transport_get(remote, url[i]);
> +			struct transport *transport;
> +			if (!(flags & TRANSPORT_PUSH_NO_HOOK))
> +				block_unauthorized_url(url[i]);
> +			transport = transport_get(remote, url[i]);
>  			if (push_with_options(transport, flags))
>  				errs++;
>  		}
>  	} else {
> -		struct transport *transport =
> -			transport_get(remote, NULL);
> -
> +		struct transport *transport;
> +		if (!(flags & TRANSPORT_PUSH_NO_HOOK))
> +			block_unauthorized_url(remote->url[0]);
> +		transport = transport_get(remote, NULL);
>  		if (push_with_options(transport, flags))
>  			errs++;
>  	}

I think it's time to introduce a helper function doing either the body
of the "for" loop or the "else" branch: you're starting to get too much
code duplication IMHO.

> --- /dev/null
> +++ b/t/t5544-push-whitelist-blacklist.sh
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +
> +test_description='blacklist for push'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	git init --bare blacklist/ &&
> +	git init --bare whitelist/ &&
> +	git init --bare blacklist/allow &&
> +	test_commit commit &&
> +	echo "fatal: Pushing to this remote using this protocol is forbidden" > forbidden
> +'
> +
> +test_expect_success 'basic case' '
> +	git config --add remote.pushBlacklist http://blacklist.com &&
> +	test_must_fail git push http://blacklist.com HEAD 2> result &&
> +	test_cmp result forbidden
> +'
> +
> +test_expect_success 'no scheme and no path' '
> +	git config remote.pushBlacklist blacklist.com &&
> +	test_must_fail git push http://blacklist.com/foo HEAD 2> result &&
> +	test_cmp result forbidden
> +'
> +
> +test_expect_success 'local path' '
> +	git config remote.pushBlacklist blacklist &&
> +	test_must_fail git push blacklist HEAD 2> result &&
> +	test_cmp result forbidden
> +'
> +
> +test_expect_success 'local path with file://' '
> +	git config remote.pushBlacklist file://blacklist &&
> +	test_must_fail git push blacklist HEAD 2> result &&
> +	test_cmp result forbidden
> +'
> +test_expect_success 'only one scheme allowed' '
> +	git config remote.pushDefaultPolicy deny &&
> +	git config remote.pushWhitelist http://blacklist.com &&
> +	test_must_fail git push https://blacklist.com HEAD 2> result &&
> +	test_cmp result forbidden
> +'
> +
> +test_expect_success 'denied repo in allowed repo' '
> +	git config remote.pushBlacklist blacklist &&
> +	git config --add remote.pushWhitelist blacklist/allow &&

This is not self-contained as it relies on the configuration set by the
previous test. Actually, I think you don't want the --add here.

I think

git push -c remote.pushBlacklist=blacklist \
         -c remote.pushWhitelist=http://blacklist.com \
         -c remote.pushWhitelist=blacklist/allow \
	blacklist/allow HEAD

would be even clearer: there's a bit more syntactical disturbance (-c,
\), but the whole relevant config is under the reviwer's eyes at the
right time.

> +	git push blacklist/allow HEAD

This is the only positive case, and many others are missing. For example
"push to https://example.com" is allowed even when "http://example.com"
is blacklisted.

It's harder to test without doing an actual remote push, but I think you
can still manage using fake URL scheme like foo://example.com and check
that git-remote-foo is actually called.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
