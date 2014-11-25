From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] remote: add --fetch and --both options to set-url
Date: Tue, 25 Nov 2014 17:09:04 -0500
Message-ID: <CAPig+cS1rFpFO4YsNEi2Fjzfj+qH7Oat+PR+0GUo32=MFTNRiA@mail.gmail.com>
References: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Tue Nov 25 23:09:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtOIL-0006FN-0B
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 23:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbaKYWJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 17:09:08 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:60173 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaKYWJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 17:09:05 -0500
Received: by mail-yh0-f49.google.com with SMTP id f10so741070yha.22
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 14:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s9p57c2MO0Mx/9YLRyJJo5Mj5OlHSovTmGaTxTQ5+Dc=;
        b=hqhXb+uU77mHWb1eD/NmFcOqapXaJDJUfO+KYOva1ImdVouC7RZ3qC09brBhfOYc4Y
         7eL4wJoWiRliHELDco3bhCjUzRcmZOuyOlJuw3eTgEVghskcmUv5yvxVV4tyH0Na9K/C
         mSx3jwIUIapV2haW3bXy5wE2s6sApH1POLdV/7HTYbZSe7n3U2XcVqLTVVM6C1cYvsg1
         0cEmkyaX7c8zzKTUpfIr8KnuwwhHQxzHQYrpp81VWwKcusIPJ/k+vVExB1LTwVhJLgQG
         8PLfLcCPDPa6DbSOp1iJ3d/yQKbSOKarpB9SSSPYknTqCxTJanw0By5NUBInnH2guZ0v
         UsfA==
X-Received: by 10.236.8.100 with SMTP id 64mr26917493yhq.112.1416953344926;
 Tue, 25 Nov 2014 14:09:04 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 25 Nov 2014 14:09:04 -0800 (PST)
In-Reply-To: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl>
X-Google-Sender-Auth: xxR3Ps9w9TJ8JIwrX996eqNNBMI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260243>

On Tue, Nov 25, 2014 at 6:48 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> git remote set-url knew about the '--push' option to update just the
> pushurl, but it does not have a similar option for "update fetch URL and
> leave whatever was in place for the push URL".
>
> This patch adds support for a '--fetch' option which implements that use
> case in a backwards compatible way: if no --both, --push or --fetch
> options are given, then the push URL is modified too if it was not set
> before. This is the case since the push URL is implicitly based on the
> fetch URL.
>
> A '--both' option is added to make the command independent of previous
> pushurl settings. For the --add and --delete set operations, it will
> always set the push and/ or the fetch URLs. For the primary mode of
> operation (without --add or --delete), it will drop pushurl as the
> implicit push URL is the (fetch) URL.

I've read (though perhaps not fully digested) the other email thread
which led up to this version of the patch, as well as the
documentation update in this patch, but I still don't understand the
need for the --both option. Intuitively, I would expect that
specifying --fetch and --push on the command line would have the same
effect as the proposed --both option. Thus, why is a separate (and
exclusive) --both option needed? Is it to reduce typing? What am I
missing?

More below.

> The documentation has also been updated and a missing '--push' option
> is added to the 'git remote -h' command.
>
> Tests are also added to verify the documented behavior.
>
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---
>
>  v2: fixed test case
>  v3: added --both option, changed --fetch --push behavior, added more tests for
>      --add/--delete cases, refactored to reduce duplication (not special-casing
>      add_mode without oldurl, just skip initially setting oldurl).
>
> Translators note: the help text gained more translatable strings and some
> strings got additional options.
> ---
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index cb103c8..bdd0305 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -134,7 +134,16 @@ Changes URL remote points to. Sets first URL remote points to matching
>  regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
>  <oldurl> doesn't match any URL, error occurs and nothing is changed.
>  +
> -With '--push', push URLs are manipulated instead of fetch URLs.
> +With '--both', both the fetch and push URLs are manipulated.
> ++
> +With '--fetch', only fetch URLs are manipulated.
> ++
> +With '--push', only push URLs are manipulated.
> ++
> +If none of the '--both', '--fetch' or --push' options are given, then
> +'--both' applies only if no push URL was set before. Otherwise '--fetch'
> +is assumed for historical reasons. This default may change in the
> +future to '--both' to avoid surprises depending on the configuration.

This explanation is somewhat tortuous. Assuming that the --both option
is superfluous, perhaps this could be explained more clearly along
these lines:

--- 8< ---
`--fetch` changes fetch URLs, and --push changes push URLs. Specified
together, both fetch and push URLs are changed.

For historical reasons, if neither --fetch nor --push is specified,
then the fetch URL is changed, as well as the push URL if not already
set.
--- 8< ---

>  +
>  With '--add', instead of changing some URL, new URL is added.
>  +
