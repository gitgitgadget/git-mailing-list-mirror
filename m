From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] allow recovery from command name typos
Date: Thu, 26 Jul 2012 13:26:30 -0400
Message-ID: <20120726172630.GD13942@sigill.intra.peff.net>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
 <1343232982-10540-4-git-send-email-rctay89@gmail.com>
 <1343232982-10540-5-git-send-email-rctay89@gmail.com>
 <7vtxwvbu5s.fsf@alter.siamese.dyndns.org>
 <CALUzUxp91zubHEkWMC1z2xp7kJCRYrtznQS_=pVSZoNkZMihig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:26:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuRpe-0005pV-UK
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab2GZR0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:26:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37398 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422Ab2GZR0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:26:32 -0400
Received: (qmail 10571 invoked by uid 107); 26 Jul 2012 17:26:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 13:26:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 13:26:30 -0400
Content-Disposition: inline
In-Reply-To: <CALUzUxp91zubHEkWMC1z2xp7kJCRYrtznQS_=pVSZoNkZMihig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202281>

On Fri, Jul 27, 2012 at 01:08:34AM +0800, Tay Ray Chuan wrote:

> > Perhaps we should audit "isatty()" calls and replace them with a
> > helper function that does this kind of thing consistently in a more
> > robust way (my recent favorite is Linus's somewhat anal logic used
> > in builtin/merge.c::default_edit_option()).
> 
> Any specific callers to isatty() you have in mind? A quick grep shows
> that a significant portion of the "offenders" are isatty(2) calls to
> determine whether to display progress, I think those are ok.

Yeah, those are probably fine. Grep reveals that besides isatty(2) and
the merge default_edit_option check, we have:

  - isatty(1) for checking auto-output munging, including auto-colors,
    auto-columns, and the pager. These are all fine, as they are not
    about interactivity, but specifically about whether stdout is a tty.

  - isatty(0) in commit.c to print a message when reading "-F -" from
    stdin. OK.

  - isatty(0) in pack-redundant to avoid reading stdin when it is a
    terminal (a questionable choice, perhaps, but not really something
    that would want a full interactivity check).

  - isatty(0) check in cmd_revert to set opts.edit automatically. This
    one should match merge's behavior.

  - isatty(0) in shortlog; this is a compatibility hack as shortlog
    traditionally accepted log output on stdin, but can now be used
    stand-alone. OK.

So I think the only one that could be improved is the one in cmd_revert.

> The credential helper has some prompting functionality that is close
> to what I intend to do here, but I think it can make some assumptions
> about stdin/stdout that we can't, as you have pointed out. So that
> leaves merge-edit and this patch as the beneficiaries of a
> builtin/merge.c::default_edit_option() refactor. That's just off the
> top of my head.

The credential code uses git_terminal_prompt, which actually opens
/dev/tty directly. So it is probably sane to use for your new prompt,
but it does not (and should not) rely on isatty.

> Perhaps the helper function could be named "git_can_prompt()" and
> placed in prompt.c?

Please don't. The isatty() checks have nothing to do with whether
git_prompt can run. The only thing such a git_can_prompt function should
do is see if we can open /dev/tty.

The isatty check in merge.c is more about "are we interactive, so that
it is sane to run $EDITOR".

-Peff
