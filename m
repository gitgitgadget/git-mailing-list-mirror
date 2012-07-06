From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] branch: add -u as a shortcut for --set-upstream
Date: Fri, 6 Jul 2012 10:32:39 -0500
Message-ID: <20120706153239.GA29362@burratino>
References: <1341475035-14310-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:33:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnAWn-0002I4-63
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 17:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757749Ab2GFPct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jul 2012 11:32:49 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65457 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757630Ab2GFPcs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2012 11:32:48 -0400
Received: by yenl2 with SMTP id l2so8703816yen.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3ZPLDrqKqjoyy+hyQ0YCO4wOdKVD9Vt8prMHH310oQs=;
        b=DS48qzMhSJfWh7IQVHVJkAk+NNCWYnEGt7qVlRn0eoB+eo7lWhx2biA2XMQxEvxueo
         um1BzYFqDyM32P1pm4Wwt+LWZ/CszzKsWU1E6av/WPVwG1vuNAtccDQf1auDlETSqOp2
         p4bkIhHmulUxJ5qRKkP28zGEWBYBO9MXtnmZtYbE0satGz2VNrXD9xzQTTEqe3czbltw
         xmoTPqk9q4RoCCvHWP+gumCG9S1Ie53FigQHVShRMH9+syW/3FRGp+A8gpvuzfHXwnGe
         YY3ak8LUj+vPZj7NnVYGKQHUsx9x99PyUEmQOgvtoMHEpYzrx4f0Ug1a3t8aIyegZXcy
         dcIQ==
Received: by 10.50.135.74 with SMTP id pq10mr2769385igb.48.1341588767357;
        Fri, 06 Jul 2012 08:32:47 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id k6sm5552080igw.14.2012.07.06.08.32.46
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 08:32:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1341475035-14310-1-git-send-email-cmn@elego.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201115>

Hi Carlos,

Carlos Mart=C3=ADn Nieto wrote:

> Add this shortcut just like git-push has it.
[...]
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -724,7 +724,7 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>  		OPT__QUIET(&quiet, "suppress informational messages"),
>  		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-=
pull(1))",
>  			BRANCH_TRACK_EXPLICIT),
> -		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
> +		OPT_SET_INT('u', "set-upstream",  &track, "change upstream info",
>  			BRANCH_TRACK_OVERRIDE),

I think this is a bad idea.  The --set-upstream option is confusing:

	$ git branch --set-upstream=3Dfoo
	error: option 'set-upstream' takes no value
	$ ???

-u to set the corresponding upstream branch at the same time as
creating a branch, analagous to "git push -u" might seem intuitive:

	# create foo branch, setting its upstream at the same time
	git branch -u foo origin/foo

But that is what --track does and is not what --set-upstream is for.

Unlike --track, I don't think --set-upstream is a common enough
operation to deserve a one-letter synonym.

Instead, I'd suggest the following changes:

 1) Add support for

	# change upstream info
	git branch --set-upstream=3Dorigin/foo foo

    for existing branches only.

 2) Introduce an --unset-upstream option which removes the
    "corresponding upstream branch" configuration for an existing
    branch.

 3) Warn on

	# acts just like --track
	git branch --set-upstream foo origin/foo

    for branches that do not exist yet.  Plan to make this a hard
    error in the future.

 4) Warn on

	# sets upstream for "foo" to the current branch
	git branch --set-upstream foo

    and plan to make it a hard error in the future.

 5) Warn on

	git branch --set-upstream origin/foo foo

  which is almost certainly a typo for

	git branch --set-upstream=3Dorigin/foo foo

 6) Perhaps, make -u a synonym for -t for consistency with "git push".

What do you think?
Jonathan
