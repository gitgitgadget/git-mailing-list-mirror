From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] avoid bogus "recursion detected in die handler"
 message
Date: Tue, 16 Apr 2013 21:37:08 -0400
Message-ID: <20130417013708.GA27786@sigill.intra.peff.net>
References: <20130415230802.GA11267@sigill.intra.peff.net>
 <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
 <20130416004228.GA14995@sigill.intra.peff.net>
 <CA+sFfMdzTNjH10FKxhvJy+7hZg+0=1Wrqy9k8KaPoJg1DuDpmg@mail.gmail.com>
 <20130416025024.GA20932@sigill.intra.peff.net>
 <516CFB56.1090805@viscovery.net>
 <20130416130154.GA17976@sigill.intra.peff.net>
 <516D5CA4.7000500@viscovery.net>
 <20130416194418.GA7187@sigill.intra.peff.net>
 <20130417004941.GJ29773@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 03:37:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USHJG-0007Qp-GY
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 03:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936003Ab3DQBhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 21:37:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48679 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932461Ab3DQBhL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 21:37:11 -0400
Received: (qmail 26655 invoked by uid 107); 17 Apr 2013 01:39:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Apr 2013 21:39:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2013 21:37:08 -0400
Content-Disposition: inline
In-Reply-To: <20130417004941.GJ29773@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221495>

On Tue, Apr 16, 2013 at 05:49:41PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >   [1/2]: usage: allow pluggable die-recursion checks
> >   [2/2]: run-command: use thread-aware die_is_recursing routine
> 
> Lovely.  This doesn't solve the analagous problem for grep,
> index-pack, pack-objects, preload-index, or bidirectional_transfer_loop,
> but it doesn't make them worse and even should make them easier to fix
> later, so
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The problem does exist in those other programs, but is much less
likely to be triggered. There it would be a race between two threads
calling die() at the same time, because as soon as one finishes, it
takes down the whole program. What made this one so easy to trigger was
the installation of die_async.

So it's probably not that big a deal to leave the race in those other
places for the time being. Any refactoring of the "dying" flag should
accompany an overall strategy for managing the clean death of
sub-threads (which would entail a custom die routine, at which point the
recursion-check should just fall out naturally from whatever approach
they choose).

Thanks for reviewing.

-Peff
