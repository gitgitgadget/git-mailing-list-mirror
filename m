From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] do not write null sha1s to on-disk index
Date: Sat, 29 Dec 2012 05:27:07 -0500
Message-ID: <20121229102707.GA26730@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 11:27:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Totde-0002eQ-VJ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 11:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab2L2K1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 05:27:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38737 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab2L2K1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 05:27:11 -0500
Received: (qmail 28479 invoked by uid 107); 29 Dec 2012 10:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 05:28:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 05:27:07 -0500
Content-Disposition: inline
In-Reply-To: <20121229100130.GA31497@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212303>

On Sat, Dec 29, 2012 at 02:03:46AM -0800, Jonathan Nieder wrote:

> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1800,6 +1800,8 @@ int write_index(struct index_state *istate, int newfd)
> >  			continue;
> >  		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
> >  			ce_smudge_racily_clean_entry(ce);
> > +		if (is_null_sha1(ce->sha1))
> > +			return error("cache entry has null sha1: %s", ce->name);
> >  		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
> >  			return -1;
> 
> Quick heads up: this is tripping for me in the "git am --abort"
> codepath:

Thanks. The intent was that this should never happen, and we are
protecting against bogus sha1s slipping into the index. So either we
have found a bug in "am --abort", or the assumption that it should never
happen was wrong. :)

>   $ cd ~/src/linux
>   $ git checkout v3.2.35
>   $ git am -3sc /tmp/alsa-usb-audio-fix-missing-autopm-for-midi-input.patch 
>   Applying: ALSA: usb-audio: Fix missing autopm for MIDI input
>   Using index info to reconstruct a base tree...
>   Falling back to patching base and 3-way merge...
>   error: Your local changes to the following files would be overwritten by merge:
> 	sound/usb/midi.c
>   Please, commit your changes or stash them before you can merge.
>   Aborting
>   Failed to merge in the changes.
>   Patch failed at 0001 ALSA: usb-audio: Fix missing autopm for MIDI input
>   When you have resolved this problem run "git am --resolved".
>   If you would prefer to skip this patch, instead run "git am --skip".
>   To restore the original branch and stop patching run "git am --abort".
>   $ git am --abort
>   error: cache entry has null sha1: sound/usb/midi.c
>   fatal: unable to write new index file
>   Unstaged changes after reset:
>   M       sound/usb/midi.c
>   $

I can't reproduce here. I can checkout v3.2.35, and I guess that the
patch you are applying comes from f5f1654, but I don't know your
local modification to sound/usb/midi.c. If I just make a fake
modification, I get this:

  $ git checkout v3.2.35
  $ echo fake >sound/usb/midi.c
  $ git format-patch --stdout -1 f5f1654 | git am -3 ~/patch
  [same errors as you]
  $ git am --abort
  Unstaged changes after reset:
  M       sound/usb/midi.c

So I wonder if there is something in the way your working tree is
modified. Can you give more details?

> Reproducible using v1.8.1-rc3 and master.  Bisects to 4337b585 (do not
> write null sha1s to on-disk index, 2012-07-28).  For comparison, older
> gits produced
> 
>   $ git am --abort
>   Unstaged changes after reset:
>   M       sound/usb/midi.c

What does your index look like afterwards? Does it have a null sha1 in
it (check "ls-files -s")?

-Peff
