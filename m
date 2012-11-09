From: Jeff King <peff@peff.net>
Subject: Re: bash completion of "addable" files for `git add`
Date: Fri, 9 Nov 2012 11:27:50 -0500
Message-ID: <20121109162750.GC19725@sigill.intra.peff.net>
References: <5E69B894-C392-4DD5-A4F1-723DA1A3D059@zitc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andreas Zeidler <az@zitc.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:28:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWrRB-0004rd-76
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 17:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab2KIQ1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 11:27:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40145 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab2KIQ1z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 11:27:55 -0500
Received: (qmail 8084 invoked by uid 107); 9 Nov 2012 16:28:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 11:28:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 11:27:50 -0500
Content-Disposition: inline
In-Reply-To: <5E69B894-C392-4DD5-A4F1-723DA1A3D059@zitc.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209227>

On Fri, Nov 09, 2012 at 02:22:27PM +0100, Andreas Zeidler wrote:

> so here's a patch adding bash completion on `git add` for modified,
> updated and untracked files.  i've also set up a pull request =E2=80=94=
 before
> i found `Documentation/SubmittingPatches`.  fwiw, it's at
> https://github.com/git/git/pull/29

Please put cover letter material like this after the "---" divider, or
include a "-- >8 --" scissors line before your commit. Either helps "gi=
t
am" realize which content should go into the commit message.

> From cbac6caee7e788569562cb7138eb698cc46a1b8f Mon Sep 17 00:00:00 200=
1
> From: Andreas Zeidler <az@zitc.de>
> Date: Fri, 9 Nov 2012 13:05:43 +0100

Please omit these lines, as they are redundant with your email header.

> Subject: [PATCH] add bash completion for "addable" files

This one is useful, but it would be even better if it were the subject
of your email. :)

> +__git_addable ()
> +{
> +	local dir=3D"$(__gitdir)"
> +	if [ -d "$dir" ]; then
> +		git --git-dir=3D"$dir" status --short --untracked=3Dall |\
> +			egrep '^.[UM?] ' | sed 's/^.. //'
> +		return
> +	fi
> +}

You would want to use the stable, scriptable "--porcelain" output, so
the completion is not broken by future changes to the "--short" format.
However, I do not think using "git status" is the best option. It
computes three things:

  1. The diff between HEAD and index.

  2. The diff between index and working tree.

  3. The list of untracked files.

But you only care about (2) and (3), so you are wasting time computing
(1).  I think the list you want could be generated with:

  git diff-files --name-only
  git ls-files --exclude-standard -o

and then you do not need to worry about grep or sed at all.

> @@ -810,6 +820,11 @@ _git_add ()
>  			--ignore-errors --intent-to-add
>  			"
>  		return
> +		;;
> +	*)
> +		__gitcomp "$(__git_addable)"
> +		return
> +		;;

I think you'd want to use __gitcomp_nl to handle filenames with spaces.

Speaking of which, the output of status (or of the commands I mentioned=
)
may have quoting applied to pathnames. I think that is not something we
handle very well right now in the completion, so it may not be worth
worrying about for this particular patch.

Other than those comments, I think the intent of your patch makes a lot
of sense.

-Peff
