From: Jeff King <peff@peff.net>
Subject: [BUG] git-diff-* --color oddness
Date: Fri, 4 Jan 2008 03:14:29 -0500
Message-ID: <20080104081429.GA30635@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:14:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAhhj-0003c1-4Z
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbYADIOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbYADIOd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:14:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1342 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbYADIOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:14:32 -0500
Received: (qmail 15721 invoked by uid 111); 4 Jan 2008 08:14:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 03:14:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 03:14:29 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69555>

I encountered some weirdness today with git-diff-{files,tree,index} and
--color.  They parse the --color command line option, but do _not_ call
git_config(git_diff_ui_config), so if the user has colors specified in
the config, they are not used.

Ordinarily, I would say "nobody should use --color with diff-files". But
we do, in git-add--interactive (see Wincent's 4af756f3). So we can
probably fix that with a "git_diff_minimal_ui_config" which does just
the colors, and use that from the plumbing diff scripts (or just move
the color stuff into git_default_config).

But it gets worse. Try this:

  # make a custom color
  git config color.diff.meta yellow
  # now show a plumbing diff
  git diff-tree --color -p 257f3020^ 257f3020

The first two lines of meta-info will be in the stock colors, but
everything after will be in the custom colors. So we are actually
reading the diff_ui options _during_ the diff. The culprit is
funcname_pattern, which calls read_config_if_needed.

It's my understanding that diff_ui_config is about porcelain diff
options, so it is a bit worrisome that in the middle of a plumbing diff
process, we load porcelain config. Fortunately, most of them aren't
looked at except in diff_setup, which has already run. Colors actually
affect globals which are used during the diff, and so are noticed.

So I think the best course is probably:
  1. before v1.5.4, we need to fix the color handling in "git-diff -i",
     either by declaring git-diff-files --color illegal and finding
     another way to do 4af756f3, or by moving the diff color
     functionality into the default config.

  2. Probably post-v1.5.4, some thought should be given to
     how the diff ui config is demand-loaded by
     diff.c:read_config_if_needed. I don't _think_ it is a problem for
     now except for the colors, because most parts just get used in
     diff_setup. But it seems a bit flaky.

-Peff
