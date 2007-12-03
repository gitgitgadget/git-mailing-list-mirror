From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which
	commit was created
Date: Mon, 3 Dec 2007 02:53:57 -0500
Message-ID: <20071203075357.GB3614@sigill.intra.peff.net>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site> <Pine.LNX.4.64.0711111736440.4362@racer.site> <20071201222106.GA27102@coredump.intra.peff.net> <7vzlwsmdvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 08:54:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz68C-00017z-8L
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 08:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbXLCHyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 02:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbXLCHyA
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 02:54:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1682 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbXLCHx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 02:53:59 -0500
Received: (qmail 27210 invoked by uid 111); 3 Dec 2007 07:53:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 03 Dec 2007 02:53:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 02:53:57 -0500
Content-Disposition: inline
In-Reply-To: <7vzlwsmdvb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66884>

On Sun, Dec 02, 2007 at 11:33:28PM -0800, Junio C Hamano wrote:

> After reverting this, recording a merge commit seems to have lost the
> newline.  Can be easily reproduced with:
> 
> 	$ git merge --no-commit some-branch
>   $ git commit -a -m 'foo'

See, I knew reverting would flush it out. ;)

Unfortunately, the fix isn't terribly obvious. log_tree_commit produces
output either from log_tree_diff, which appends a newline, or from
show_log, which doesn't, and returns the same value in either case.

I tried adding a '%n' to the format specifier (which is "%h: %s"),
but that has inconsistent results, since another newline is always
placed between the diffstat and the log, anyway. The design of
--pretty=format is a bit inflexible here, since you are stuck with the
"$log\n$diff" format. But changing it would impact users, and is likely
to require a lot of surgery in the log machinery.

So short of munging log_tree_commit to add the newline, I'm not sure how
to fix it, and I'm a little wary of messing with that function.

-Peff
