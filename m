From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: Add diff.orderfile configuration variable
Date: Mon, 21 Oct 2013 11:40:40 -0700
Message-ID: <20131021184040.GX9464@google.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Waldenborg <anders.waldenborg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 21 20:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYKPK-0000ic-MA
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 20:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab3JUSkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 14:40:46 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60293 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3JUSko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 14:40:44 -0400
Received: by mail-pb0-f42.google.com with SMTP id jt11so1480055pbb.29
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dr5nkIXToTN1u9xTlthTvDcSmla8Ro58hXf6LYKBpwg=;
        b=QZR4wPPdmPQ1LAFL8Y/fEuB9hORBozT1VJ44RCI0rNdH0J3Nnn+ZVJTnflSzALv336
         BJzb0K2V1n7kThRUgOQWOzqqHxi1XaIkHncyZ+J3SVchSwP3K7LRvAjtroDV+0rGEAmf
         pqECwy1PdSztAkRK7qUXWMIEGeyctf1yWtw+Q1RRxQbcruMBGmeLjlXrb9pnkuJpuTHN
         Y1MSscrvvZWHR2WgKtOi3tuJTNKsTgNPq+h0p0bJYCSTJJotQlYou302XY+g0MNRFoIJ
         8fAtsXS19lIWiAa7hjLSBeaZlxWZxJPlUq473/69ZPhcDpO5MH7LcLAHaYhzAFkFM717
         wvjA==
X-Received: by 10.66.11.202 with SMTP id s10mr19655057pab.86.1382380843446;
        Mon, 21 Oct 2013 11:40:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id o1sm22448332pbe.37.2013.10.21.11.40.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Oct 2013 11:40:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236439>

Hi,

Anders Waldenborg wrote:

> diff.orderfile acts as a default for the -O command line option.
>
> Signed-off-by: Anders Waldenborg <anders@0x63.nu>

Thanks.

[...]
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -98,6 +98,10 @@ diff.mnemonicprefix::
>  diff.noprefix::
>   If set, 'git diff' does not show any source or destination prefix.

It looks like your mailer is corrupting tabs and converting them into
spaces.  See the "Discussion" section of git-format-patch(1) for hints
on checking a patch by mailing it to yourself and applying with
git-am(1).

> +diff.orderfile::
> + Path to file to use for ordering the files in the diff, each line
> + is a shell glob pattern; equivalent to the 'git diff' option '-O'.

Nits:

 * "Path to" could be left out, since a path is the only way to specify a
   file :)
 * Comma splice.
 * What happens if both [diff] orderfile and the -O option are used?

How about something like the following?

	diff.orderfile::
		File indicating how to order files within a diff, using
		one shell glob pattern per line.
		Can be overridden by the '-O' option to linkgit:git-diff[1].

Should the git-diff(1) manpage get a note about this setting as
well (perhaps in a new CONFIGURATION section)?

[...]
> --- a/diff.c
> +++ b/diff.c
> @@ -30,6 +30,7 @@ static int diff_use_color_default = -1;
>  static int diff_context_default = 3;
>  static const char *diff_word_regex_cfg;
>  static const char *external_diff_cmd_cfg;
> +static const char *diff_order_file_cfg;
>  int diff_auto_refresh_index = 1;
>  static int diff_mnemonic_prefix;
>  static int diff_no_prefix;
> @@ -201,6 +202,8 @@ int git_diff_ui_config(const char *var, const char
> *value, void *cb)
>   return git_config_string(&external_diff_cmd_cfg, var, value);
>   if (!strcmp(var, "diff.wordregex"))
>   return git_config_string(&diff_word_regex_cfg, var, value);
> + if (!strcmp(var, "diff.orderfile"))
> + return git_config_string(&diff_order_file_cfg, var, value);
> 
>   if (!strcmp(var, "diff.ignoresubmodules"))
>   handle_ignore_submodules_arg(&default_diff_options, value);
> @@ -3207,6 +3210,8 @@ void diff_setup(struct diff_options *options)
>   options->detect_rename = diff_detect_rename_default;
>   options->xdl_opts |= diff_algorithm;
> 
> + options->orderfile = diff_order_file_cfg;
> +

Should Documentation/technical/api-diff.txt be tweaked to mention that
the options set by diff_setup() depend on configuration now?

If a caller wants to parse diff config and also wants to make a diff
without using the config (the example I'm imagining is an alternative
implemention fo "git log -p --cherry-pick"), can they do that?  It's
tempting to move handling of configuration into a separate function.
(Perhaps it's not worth worrying about that until someone needs the
flexibility, though.)
> --- /dev/null
> +++ b/t/t4056-diff-order.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +
> +test_description='diff order'
> +
> +. ./test-lib.sh
> +
> +_test_create_files () {

Why the leading underscore?

[...]
> +test_expect_success "setup" '_test_create_files 1 && _test_create_files 2'

Usual style is to put each command on its own line:

	test_expect_success 'setup' '
		_test_create_files 1 &&
		_test_create_files 2
	'

> +
> +test_expect_success "no order (=tree object order)" '
> + git diff HEAD^..HEAD | grep ^diff >actual_diff_headers &&

This loses the exit code from "git diff", which loses a chance to
notice if "git diff" starts to segfault now and then.  How about:

	git diff HEAD^..HEAD >patch &&
	grep ^diff patch >actual_diff_headers
	test_cmp expect_diff_headers_non actual_diff_headers

> + test_debug actual_diff_headers

test_debug runs its argument as a command, which is not what I think
you want here. :)  Probably you wanted to write the diff header out
when testing with "--verbose" so if it fails it is clear how it
failed?

> + test_cmp expect_diff_headers_none actual_diff_headers'

Luckily test_cmp already takes care of that, by printing a diff.

Hope that helps,
Jonathan
