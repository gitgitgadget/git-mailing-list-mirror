From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Wed, 18 Mar 2015 18:52:30 +0100
Message-ID: <vpqwq2eyyzl.fsf@anie.imag.fr>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 18:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYI95-0002Td-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 18:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbbCRRwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 13:52:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54924 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201AbbCRRwh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 13:52:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2IHqSYq003709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Mar 2015 18:52:28 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2IHqUIm018144;
	Wed, 18 Mar 2015 18:52:30 +0100
In-Reply-To: <1426600662-32276-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Tue, 17 Mar 2015 21:57:42 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Mar 2015 18:52:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2IHqSYq003709
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427305950.25553@Fuf8kdbDRh1xWMixO5oOZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265743>

Hi,

First of all, thanks a lot for working on this. I'm rather impressed to
see a working proof of concept so soon! And impressed by the quality for
a "first draft".

A few minor remaks below after a very quick look.

Paul Tan <pyokagan@gmail.com> writes:

> Ideally, I think the solution is to
> improve the test suite and make it as comprehensive as possible, but
> writing a comprehensive test suite may be too time consuming.

time-consuming, but also very beneficial since the code would end up
being better tested. For sure, a rewrite is a good way to break stuff,
but anything untested can also be broken by mistake rather easily at any
time.

I'd suggest doing a bit of manual mutation testing: take your C code,
comment-out a few lines of code, see if the tests still pass, and if
they do, add a failing test that passes again once you uncomment the
code.

> diff --git a/Makefile b/Makefile
> index 44f1dd1..50a6a16 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -470,7 +470,6 @@ SCRIPT_SH += git-merge-octopus.sh
>  SCRIPT_SH += git-merge-one-file.sh
>  SCRIPT_SH += git-merge-resolve.sh
>  SCRIPT_SH += git-mergetool.sh
> -SCRIPT_SH += git-pull.sh

When converting a script into a builtin, we usually move the old script
to contrib/examples/.

> +static const char * const builtin_pull_usage[] = {
> +	N_("git pull [-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>..."),

I know we have many instances of very long lines for usage string, but
it would be better IMHO to wrap it both in the code and in the output of
"git pull -h".

> +/* NOTE: git-pull.sh only supports --log and --no-log, as opposed to what
> + * man git-pull says. */

We usually write multi-line comments

/*
 * like
 * this
 */

> +/* Global vars since they are used often */

Being use often does not count as an excuse for being global IMHO.
Having global variables means you share the same instance in several
functions, and you have to be careful with things like

void g()
{
	glob = bar;
}

void f()
{
	glob = foo;
	g();
	bar = glob;
}

As a reader, I'd rather not have to be careful about this to keep my
neurons free for other things.

> +static char *head_name;

Actually, this one is used only in one function, so "often" is not even
true ;-).

> +static struct option builtin_pull_options[] = {

You may also declare this as local in cmd_pull().

> +/**
> + * Returns remote for branch

Here and elsewhere: use imperative (return, not return_s_). The comment
asks the function to return a value.

> +	strbuf_addf(&key, "branch.%s.remote", branch);
> +	git_config_get_value(key.buf, &remote);
> +	strbuf_release(&key);

This config API is beautiful :-).

(Before last year's GSoC, you'd have needed ~10 lines of code to do the
same thing)

> +		return error("Ambiguous refname: '%s'", ref);

Here and elsewhere: don't forget to mark strings for translation.

> +/**
> + * Appends FETCH_HEAD's merge heads into arr. Returns number of merge heads,
> + * or -1 on error.
> + */
> +static int sha1_array_append_fetch_merge_heads(struct sha1_array *arr)
> +{
> +	int num_heads = 0;
> +	char *filename = git_path("FETCH_HEAD");
> +	FILE *fp = fopen(filename, "r");

I guess this is one instance where we could avoid writting (fetch) and
then parsing (here) if we had a better internal API.

But that can come after, of course.

> +}
> +
> +
> +static void argv_array_push_merge_args(struct argv_array *arr,

Bikeshed: you sometimes have two blank lines between functions,
sometimes one. Not sure it's intended.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
