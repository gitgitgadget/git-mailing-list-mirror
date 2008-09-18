From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Thu, 18 Sep 2008 09:24:50 +0200
Message-ID: <20080918072450.GB12550@diana.vm.bytemark.co.uk>
References: <20080912215613.10270.20599.stgit@localhost.localdomain> <20080914085118.GC30664@diana.vm.bytemark.co.uk> <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com> <20080915075740.GB14452@diana.vm.bytemark.co.uk> <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com> <20080916074024.GA2454@diana.vm.bytemark.co.uk> <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com> <20080916193647.GA12513@diana.vm.bytemark.co.uk> <b0943d9e0809170909j4fce34acr8f0b844d0cb5281d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 09:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDYR-0006aa-FA
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 09:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbYIRHCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 03:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbYIRHCr
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 03:02:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1775 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYIRHCq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 03:02:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KgDsg-0003NG-00; Thu, 18 Sep 2008 08:24:50 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809170909j4fce34acr8f0b844d0cb5281d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96174>

On 2008-09-17 17:09:46 +0100, Catalin Marinas wrote:

> I'm still confused by this and I don't think your new flag would
> help. The meaning of stop_before_conflict is that it won't push the
> conflicting patch but actually leave the stack with several patches
> pushed or popped.
>
> What I want for sink (and float afterwards) is by default to cancel
> the whole transaction if there is a conflict and revert the stack to
> it's original state prior to the "stg sink" command.

Ah, OK. Then I think you want something like this:

  try:
      trans.reorder_patches(applied, unapplied, hidden, iw)
  except transaction.TransactionHalted:
      if not options.conflict:
          trans.abort(iw)
          raise common.CmdException(
              'Operation rolled back -- would result in conflicts')
  return trans.run(iw)

But with a better error message ...

StackTransaction.abort() doesn't have much in the way of
documentation, unfortunately, but what it does is to check out the
tree we started with. (Nothing else is necessary, since we never touch
any refs and stuff until the end of StackTransaction.run(). And the
only case where we touch the tree is when we need to fall back to
merge-recursive.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
