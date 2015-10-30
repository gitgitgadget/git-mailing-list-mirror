From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Fri, 30 Oct 2015 15:04:02 -0400
Message-ID: <CAPig+cSw7+-vfsWtfP2y4eNijuWdauWe-HfgbOvUt1vYFUEjAg@mail.gmail.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEy9-000804-D3
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760158AbbJ3TEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:04:05 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:32894 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbbJ3TEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:04:04 -0400
Received: by vkgy127 with SMTP id y127so53709738vkg.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H1dTgD6xOpmK5PTcrapql0W+iehGfSq0Ui3zQVpw/A8=;
        b=ObxP32j5O39sAemEvr4vifeAOfw5nRcDw/kyHI+e3zAXL5ZUYzYKE14ZJ2lx0UDlec
         XYCy42nkt7sh8RYu1umhSm+ZHPROKoi8OmaUVYdnkj9lQjYMhd3/xNCsaMP2/Oj9Lyao
         uC11ifXsb8lO3qzmD9sso/dabcn6R1AL6Ev1gr1NbsJQ55HJMVrfLZezJoAAEGNqOiCy
         +SolcewxCwdFjTdNInAoGxsIJqWJiwGunWbvdGbZzgPopREfrNs8HAff2O3DWTRQOwj7
         +OjtbgIWF4qsu9z+AqUshzPIXiEOBngPcHLVK8bCEGaD0heQDg9SKE965ou/rCe2AGj8
         UvSA==
X-Received: by 10.31.56.15 with SMTP id f15mr6593752vka.84.1446231842666; Fri,
 30 Oct 2015 12:04:02 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Fri, 30 Oct 2015 12:04:02 -0700 (PDT)
In-Reply-To: <xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: eCcB0hCVUGnZho9lb_mI1XkjA1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280522>

On Fri, Oct 30, 2015 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Thu, Oct 29, 2015 at 9:23 PM, Edmundo Carmona Antoranz
>> <eantoranz@gmail.com> wrote:
>>> +       opts.verbose_update = !o->quiet && (option_progress > 0 ||
>>> +                                          (option_progress < 0 && isatty(2)));
>>
>> Does this logic also need to be applied to the other instance where
>> isatty() is consulted in merge_working_tree()?
>
> This makes me wonder if option_progress and o->quiet change once
> parse_options() finished doing its job.  If we know that these two
> will never change once parse_options() is done, then we can
> introduce a variable "show_progress", assign the value of that
> variable to opts.verbose_update in these places and then arrange
> that variable is set to the combination of quiet, option_progress
> and isatty(2) just once after parse_options().
>
> That is, something like this on top of Edmundo's patch.
>
> @@ -27,7 +27,7 @@ static const char * const checkout_usage[] = {
> -static int option_progress = -1;
> +static int show_progress = 1;
> @@ -430,8 +430,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
> -       opts.verbose_update = !o->quiet && (option_progress > 0 ||
> -                                          (option_progress < 0 && isatty(2)));
> +       opts.verbose_update = show_progress;
> @@ -515,7 +514,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
> -               topts.verbose_update = !opts->quiet && isatty(2);
> +               topts.verbose_update = show_progress;
> @@ -1143,6 +1142,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
> +       int option_progress = -1;
> @@ -1187,6 +1187,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options, checkout_usage,
>                              PARSE_OPT_KEEP_DASHDASH);
>
> +       show_progress = (!opts.quiet &&
> +                        (0 < option_progress || (option_progress < 0 && isatty(2))));

Yep, I was thinking that too. Also, Edmundo's explanatory comment
about how --quiet, --progress, and isatty() interact would move down
to this location (if it's deemed worth keeping).
