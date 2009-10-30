From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 16:26:28 -0400
Message-ID: <20091030202628.GA26513@coredump.intra.peff.net>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3y3Y-0006qI-3X
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 21:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbZJ3U0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756885AbZJ3U0c
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 16:26:32 -0400
Received: from peff.net ([208.65.91.99]:60923 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbZJ3U0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 16:26:32 -0400
Received: (qmail 3152 invoked by uid 107); 30 Oct 2009 20:30:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 16:30:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 16:26:28 -0400
Content-Disposition: inline
In-Reply-To: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131749>

On Fri, Oct 30, 2009 at 05:36:34PM -0200, Erick Mattos wrote:

> Anyway this update creates new options for choosing the source timestamp
> or a new one.  And set as default for -c option (editing one) to take a
> new timestamp and for -C option the source timestamp.  That is because
> we are normally using the source as template when we we are editing and
> as a correction when we are just copying it.
> 
> Those options are also useful for --amend option which is by default
> behaving the same.

Thanks, this is something I have been wanting. I have always thought
that --amend should give a new timestamp, so that while I'm fixing up
commits via "rebase -i" the commits end up in correct date order.

Your patch seems to always use the old timestamp for -C, the new one for
-c, and the old one for --amend. I would want it always for --amend.

I talked with Shawn about this at the GitTogether; his counter-argument
was that many people in maintainer roles will be amending or rebasing
just to do little things, like marking Signed-off-by, and that the date
should remain the same.

So my suspicion is that there are some people who almost always want
--new-timestamp, and some people who almost always want --old-timestamp,
depending on their usual workflow. In which case a config option
probably makes the most sense (but keeping the command-line to override
the config, of course).

> ---
>  Documentation/git-commit.txt |   10 ++++++++--
>  builtin-commit.c             |   15 ++++++++++++---
>  2 files changed, 20 insertions(+), 5 deletions(-)

Tests?

>  	Take an existing commit object, and reuse the log message
> -	and the authorship information (including the timestamp)
> -	when creating the commit.
> +	and the authorship information when creating the commit.
> +	By default, timestamp is taken from specified commit unless
> +	option --new-timestamp is included.

We should clarify that this is the _author_ timestamp. The committer
timestamp is always updated. Yes, it is talking about authorship
information in the previous sentence, but at least I had to read it
a few times to figure that out. Plus there are some minor English
tweaks needed, so maybe:

  and the authorship information when creating the commit.
  By default, the author timestamp is taken from the specified commit
  unless the option --new-timestamp is used.

>  -c <commit>::
>  --reedit-message=<commit>::
>  	Like '-C', but with '-c' the editor is invoked, so that
>  	the user can further edit the commit message.
> +	By default, timestamp is recalculated and not taken from
> +	specified commit unless option --old-timestamp is included.

Ditto:

  By default, the author timestamp is recalculated and not taken from
  the specified commit unless the option --old-timestamp is used.

> @@ -134,6 +138,8 @@ OPTIONS
>  	current tip -- if it was a merge, it will have the parents of
>  	the current tip as parents -- so the current top commit is
>  	discarded.
> +	By default, timestamp is taken from latest commit unless option
> +	--new-timestamp is included.

And:

  By default, the author timestamp is taken from the latest commit
  unless the option --new-timestamp is included.

> +	if (old_timestamp && new_timestamp)
> +		die("You can not use --old-timesamp and --new-timestamp together.");

Typo: s/samp/stamp/

But this mutual exclusivity implies to me that the option should
probably be "--timestamp=old|new".

-Peff
