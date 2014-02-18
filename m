From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] revert.c: Allow to specify -x via git-config
Date: Tue, 18 Feb 2014 09:49:13 -0800
Message-ID: <20140218174913.GB7855@google.com>
References: <20140218065620.GA3448@bogon.m.sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 18:49:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFonK-00046R-Ql
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 18:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbaBRRtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 12:49:18 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:41235 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbaBRRtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 12:49:17 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so17123240pbb.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=81gWtZ51I8iSanV1VE6hoDK9OAySxJLGy91uunyV6V4=;
        b=k2ud5dQWxQjvlakYXBZoxfzmIIxgvreIwk/d+BL9gmO9a4sbhJHz3fbNtX5vNOc152
         VyjbWojCwGppZGw2EMmjfW2HWIQsU54lNVCqwKt0Bx2rl+2gdRz6TFeqxC9kZtdKhkzH
         l9IeRBYw8pSAqF9jhC5kEfvLtnIwebDJp1w5svfCzcEGBni4A4pUs+weiVyhgaii7j5Y
         DRgT4httjhLNeXNN1OQA/dAEcpZr+zWsi3T5WxE56gVOVB4Hy68dfhfxDvPYCX9ISoqL
         RnUCXEbdqP+BKnciJQ4IzF2Qv98D1SE4NnHuiz9RJe4ky4xR1VQeiqP9WIlP0JL5PiOo
         JR1Q==
X-Received: by 10.66.164.70 with SMTP id yo6mr34860828pab.85.1392745757278;
        Tue, 18 Feb 2014 09:49:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id q7sm57969307pbc.20.2014.02.18.09.49.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 09:49:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140218065620.GA3448@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242332>

Hi,

Guido G=FCnther wrote:

> Without this when maintaining stable branches it's easy to forget to =
use
> -x to track where a patch was cherry-picked from.
[...]
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -215,6 +215,14 @@ the working tree.
>  spending extra time to avoid mistakes based on incorrectly matching
>  context lines.
> =20
> +CONFIGURATION
> +-------------
> +
> +See linkgit:git-config[1] for core variables.
> +
> +cherrypick.record-origin::
> +	Default for the `-x` option. Defaults to `false`.

I'm not convinced this is a good idea.  Even if I always want -x when
cherry-picking to stable, isn't this going to add the extra clutter
line when I cherry-pick on other branches?  It's especially worrying
because there would be no way to override the configuration with a
flag on the command line.  ("-r" which used to do that is now a
no-op.)

I would be more easily convinced by a '[branch "foo"]
recordcherrypickorigins' option that makes cherry-pick default to '-x'
when and only when on the "foo" branch.

Can you say more about the context?  Why is it important to record the
original commit id?  Is it a matter of keeping a reminder of the
commits' similarity (which cherry-pick without '-x' does ok by reusing
the same message) or are people reviewing the change downstream going
to be judging the change based on the recorded upstream commit id?
(Like linux's stable-<version> branches --- but those have other
requirements so I don't think this configuration would work as is
there.)

[...]
> +++ b/builtin/revert.c
> @@ -196,6 +196,15 @@ int cmd_revert(int argc, const char **argv, cons=
t char *prefix)
[...]
> +	if (!strcmp(var, "cherrypick.record-origin"))
> +		opts->record_origin =3D git_config_bool (var, value);

More nitpicky: git uses camelCase, not dash-delimited, for multiword
configuration items.  The config parsing machinery normalizes to
lowercase, so this would then be "cherrypick.recordorigin".

Hope that helps,
Jonathan
