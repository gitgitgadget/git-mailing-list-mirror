From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu, 15 Dec 2011 15:29:01 -0600
Message-ID: <20111215212901.GC16160@elie.hsd1.il.comcast.net>
References: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
 <1323967528-10537-1-git-send-email-artagnon@gmail.com>
 <1323967528-10537-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbIrd-0008NM-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759495Ab1LOV3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:29:11 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52757 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab1LOV3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:29:09 -0500
Received: by wgbdr13 with SMTP id dr13so4740961wgb.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=d0DwSZz56axGKigk3W+cdmUbJebW/vBh69gPUx96HEw=;
        b=FsMHwVY6OeW/Qk+IwjvYpKaVLHt3uA6Wzqbbx7geSOl5mwuPDpUjWwMEdUJcgI8lyS
         Nd0YDPBV5vP4ecnnjzPGD9z1Jvv3PBFg/Tp0CPsO0m0aqjimTYIQRCpblikN2KX++fEr
         7IKxr4qqcsfeL0875ZuCwRw0bsjQjSmJIdmFI=
Received: by 10.227.208.133 with SMTP id gc5mr3869279wbb.25.1323984548260;
        Thu, 15 Dec 2011 13:29:08 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d17sm11341546wbh.19.2011.12.15.13.29.05
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 13:29:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323967528-10537-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187237>

Ramkumar Ramachandra wrote:

> The git-bundle builtin currently parses command-line options by hand;
> this is fragile, and reports cryptic errors on failure.  Use the
> parse-options library to do the parsing instead.

I don't understand how this is fragile.  I haven't actually run into
error messages from "git bundle" I found to be cryptic, but if they
are, they surely can be improved locally.  Could you give an example
or something?

> Encouraged-by: Jonathan Nieder <jrnieder@gmail.com>

No, not encouraged.

But parseoptification does have some nice benefits, so let's see how
the patch looks...

[...]
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/bundle.c  |   91 +++++++++++++++++++++++++++++++----------------------
>  t/t5704-bundle.sh |    2 +-
>  2 files changed, 54 insertions(+), 39 deletions(-)
> 
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 92a8a60..13ed770 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
[...]
> @@ -9,57 +10,71 @@
[...]
>  int cmd_bundle(int argc, const char **argv, const char *prefix)
>  {
> -	struct bundle_header header;
> -	const char *cmd, *bundle_file;
> +	int prefix_length;
>  	int bundle_fd = -1;
> -	char buffer[PATH_MAX];
> -	if (argc < 3)
> -		usage(builtin_bundle_usage);
> +	const char *subcommand, *bundle_file;
> +	struct bundle_header header;
> +	struct option options[] = { OPT_END() };
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			builtin_bundle_usage, PARSE_OPT_STOP_AT_NON_OPTION);

No, just no.  Using parse-options with an empty option table is
complete overkill for handling the "-h" option.  Without a lot more
justification, this doesn't make it seem more sane or readable at all.

Stopping here.  I wouldn't mind seeing "git bundle" being
parseoptified, but not if the result looks like this.

I _do_ think that a systematic option-parsing library that handles
subcommands would be something possible and probably useful for git.
Its input might include a table with subcommand names, an option table
for each, and a function to call when that subcommand is used:

	struct parseopt_subcommand subcmds[] = {
		{ "list", no_options, notes_list },
		{ "add", add_options, notes_add },
		{ "copy", copy_options, notes_copy },
		{ "append", append_options, notes_append },
		{ "edit", no_options, notes_edit },
		{ "show", no_options, notes_show },
		...
	};

Then "git notes -h" might be able to automatically generate a table of
synopses, and "gite notes --help-all" might print help for all
subcommands.  Something like that.

Hope that helps,
Jonathan
