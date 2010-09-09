From: Jeff King <peff@peff.net>
Subject: Re: [Alt. PATCH] format-patch: do not use diff UI config
Date: Thu, 9 Sep 2010 15:43:23 -0400
Message-ID: <20100909194323.GA1146@sigill.intra.peff.net>
References: <1284019625-14096-1-git-send-email-ods15@ods15.dyndns.org>
 <2a6b8c51903fd6a22606b8f592b1a2e11ea68741.1284020917.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Oded Shimon <ods15@ods15.dyndns.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:43:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otn1h-0002fM-3Z
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab0IITnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:43:13 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59880 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718Ab0IITnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:43:11 -0400
Received: (qmail 21280 invoked by uid 111); 9 Sep 2010 19:43:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Sep 2010 19:43:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Sep 2010 15:43:23 -0400
Content-Disposition: inline
In-Reply-To: <2a6b8c51903fd6a22606b8f592b1a2e11ea68741.1284020917.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155896>

On Thu, Sep 09, 2010 at 10:36:54AM +0200, Thomas Rast wrote:

> format-patch read and used the diff UI config, such as diff.renames,
> diff.noprefix and diff.mnemnoicprefix.  These have a history of
> breaking rebase and patch application in general; cf. 840b3ca (rebase:
> protect against diff.renames configuration, 2008-11-10).
> 
> Instead of continually putting more options inside git-rebase to avoid
> these issues, this patch takes the stance that output from
> format-patch is intended primarily for git-am and only as a side
> effect also for human consumption.  Hence, ignore the diff UI config
> entirely when coming from format-patch.
> 
> Note that all existing calls to git_log_config except for the one in
> git_format_config use a NULL callback.

This was my first thought upon reading Oded's patch, too. We would want
to cut out anything that will cause format-patch to create a patch that
could not be applied. So from your list:

> This is a bolder approach that just outright ignores the backwards
> compatibility complaints Junio had in 840b3ca.  Among the variables
> parsed in git_diff_ui_config, namely
> 
>   color.diff (and its legacy alias diff.color)
>   diff.renames
>   diff.autorefreshindex
>   diff.mnemonicprefix
>   diff.noprefix
>   diff.external
>   diff.wordregex
>   diff.ignoresubmodules
> 
> arguably only diff.renames (and perhaps diff.ignoresubmodules, I don't
> use them) should affect format-patch.  Everything else undermines the
> guarantee (by having a consistent format) that format-patch|am works.

I would agree that diff.renames should probably be the only thing we
want to allow (because it is not about making a broken diff, but because
the receiver may or may not support it, and we already know that
git-rebase will handle it).

diff.external is debatable. If your external diff is producing real,
applicable diffs, then it is fine to use it. I have to wonder why you
would use an external diff, then. I guess because it's faster, or maybe
has an algorithm that produces equivalent but easier-to-read results
(e.g., patience before we had --patience)?

> So now I'm not so sure about diff.renames.  Perhaps it needs to be
> retained, but that requires a special case since we cannot move it to
> git_diff_basic_config() (which affects diff-* plumbing too).

I think it is reasonable to just move an explicit "diff.renames" check
into format_patch, and then set the diff_options appropriately. It
requires special case code because it _is_ a special case.

-Peff
