From: Jeff King <peff@peff.net>
Subject: Re: gc does not clean up after itself when not enough disk space
Date: Wed, 27 Feb 2013 00:07:35 -0500
Message-ID: <20130227050735.GA10976@sigill.intra.peff.net>
References: <512CD689.4050705@gmail.com>
 <512CD703.4080302@gmail.com>
 <7v1uc3njnf.fsf@alter.siamese.dyndns.org>
 <512D1B8C.9070506@web.de>
 <CAMK1S_hxZZzi911s2QRpc67sNf_U7Ceo1fPT_hg1gO500pO=6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"jones.noamle" <lenoam@gmail.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 06:08:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAZFO-0007B9-8n
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 06:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749Ab3B0FHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 00:07:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33636 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab3B0FHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 00:07:40 -0500
Received: (qmail 13504 invoked by uid 107); 27 Feb 2013 05:09:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Feb 2013 00:09:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Feb 2013 00:07:35 -0500
Content-Disposition: inline
In-Reply-To: <CAMK1S_hxZZzi911s2QRpc67sNf_U7Ceo1fPT_hg1gO500pO=6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217193>

On Wed, Feb 27, 2013 at 05:58:20AM +0530, Sitaram Chamarty wrote:

> > Ack. I just recently had to do
> >
> >    git gc || rm -f .git/objects/*/tmp_*
> >
> > as workaround in the nightly housekeeping script on our CI server.
> 
> it's not just 'git gc'; a failed push of a large repo (failed due to,
> say, network issues or whatever) also leave tmp_* lying around.  At
> least as far as I can tell...

Yes, we used to run into problems with failed pushes sometimes at
GitHub. A later `git gc` will clean up the tmp_* objects (via `git
prune`), but of course we will not run the prune if the repack fails.
Also note that a push will just keep receiving objects as long as the
client wishes to send them, spooling straight to disk, before any
enforcement hooks have a chance to run. So on stock git, you could in
theory just fill up the receiver's disk, and then git will leave the
file sitting around.

I have a patch to make index-pack just do a hard hangup after receiving
`receive.maximumBytes` bytes (with an appropriate message to stderr).
It's not an exact measure of the size of the push (since we need to
complete thin packs, and we may also explode smaller packs), but it at
least bounds the size that the sender can push. I'm happy to share the
patch if others are interested (it's only a few lines).

I've also considered a patch to have index-pack clean up tmp_pack_*
automatically on exit, default to off (i.e., the current behavior). A
busy site could turn it on globally, and then shut it off for a specific
repo when trying to debug a push problem. I find that the leftover
tmp_pack files are very seldom of interest for forensic debugging. I
haven't bothered to write that patch, though; we dropped our prune
expiration time well below the 2-week default, so the tmp files get
cleaned up pretty regularly now.

-Peff
