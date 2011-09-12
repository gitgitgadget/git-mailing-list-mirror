From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/2] format-patch: produce non colorized patches when
 color.ui=always
Date: Mon, 12 Sep 2011 12:53:17 -0400
Message-ID: <20110912165317.GA8054@sigill.intra.peff.net>
References: <1315843016-10959-1-git-send-email-pangyanhan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	martin.von.zweigbergk@gmail.com, sdaoden@googlemail.com,
	ib@wupperonline.de
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 18:53:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R39l7-00022O-Bu
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 18:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab1ILQxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 12:53:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36982
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab1ILQxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 12:53:19 -0400
Received: (qmail 16089 invoked by uid 107); 12 Sep 2011 16:54:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 12:54:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 12:53:17 -0400
Content-Disposition: inline
In-Reply-To: <1315843016-10959-1-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181222>

On Mon, Sep 12, 2011 at 11:56:54PM +0800, Pang Yan Han wrote:

> commit c9bfb953 (want_color: automatically fallback to color.ui) introduced
> a regression which causes format-patch to produce colorized patches when
> color.ui is set to "always".
> 
> Since patches are ultimately intended for machine consumption, having color
> codes present in them is undesirable.

Thanks for looking at this. I meant to do so last week, but it looks
like my procrastination paid off. :)

> My understanding of the codebase is very limited. I've looked into builtin/log.c
> and the call chain which causes format-patch to produce colorized output is:
> 
> git_format_config
>   |_ git_log_config
>        |_ git_diff_ui_config
> 	        |_ git_color_config
> 			     |_ git_config_colorbool
> 
> which causes git_use_color_default to be set to 1 when color.ui is set to
> "always".
> 
> I believe that I can assume that the parsing done in git_diff_ui_config is
> related to the [<common diff options>] based on git format-patch manpage?

Yes. However, there is also git_diff_basic_config, which is used by the
diff plumbing tools. So my plan had been to provide a callpath like
this:

  git_format_config
   |_ git_log_basic_config
     |_ git_diff_basic_config
       |_git_default_config

However, git_diff_ui_config does some other things that affect patch
output, including:

  diff.renames
  diff.mnemonicprefix
  diff.noprefix
  diff.external
  diff.wordregex
  diff.ignoresubmodules

Which of these are OK for format-patch to respect, and which not? Even
though it is plumbing, I think people depend on it respecting
diff.renames. So probably switching to just using git_diff_basic_config
is not right.

Another option is to just clear ALLOW_COLOR from the diff_options before
producing any output. But that would disable something like:

  git format-patch --color ...

which, while it is crazy for somebody actually generating a patch to
send, may be useful for somebody who wants to review what format-patch
will produce. So that's not right either.

At this point in my thinking, I scratched my head a bit. Shouldn't
setting "diff.color = always" have the exact same problem? But it
doesn't. And indeed, we have code to handle that in f3aafa4 (Disable
color detection during format-patch, 2006-07-09). It intercepts
diff.color in git_format_config and doesn't pass it along.

I can't decide if that is a hack (because format-patch needs to know
about diff config variables) or elegant (because it can intercept and
ignore whichever variables it likes). But it probably makes sense to use
the same strategy for color.ui, so at least we don't have two different
hacks. :)

Can you tweak your 2/2 to use that approach?

> I understand that this is very hacky but well, I'm really looking for ways
> to contribute to Git and this seems like one.
> 
> Any advice on how this can be better solved is deeply appreciated.

Welcome to git development. :) Despite my comments above, thank you for
a well-written submission. We don't always get the patches perfect the
first time, but communicating the problem and the proposed solution well
helps reviewers move it in the right direction.

-Peff
