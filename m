From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] do not write null sha1s to on-disk index
Date: Sat, 29 Dec 2012 06:05:41 -0500
Message-ID: <20121229110541.GA1408@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 12:06:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TouEu-0007k5-7U
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 12:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab2L2LFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 06:05:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38777 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab2L2LFp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 06:05:45 -0500
Received: (qmail 28860 invoked by uid 107); 29 Dec 2012 11:06:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 06:06:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 06:05:41 -0500
Content-Disposition: inline
In-Reply-To: <20121229103430.GG18903@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212308>

On Sat, Dec 29, 2012 at 02:34:30AM -0800, Jonathan Nieder wrote:

> >>   $ git am --abort
> >>   Unstaged changes after reset:
> >>   M       sound/usb/midi.c
> >
> > What does your index look like afterwards? Does it have a null sha1 in
> > it (check "ls-files -s")?
> 
> $ git diff-index --abbrev HEAD
> :100644 100644 eeefbce3873c... 000000000000... M	sound/usb/midi.c
> $ git ls-files --abbrev -s sound/usb/midi.c
> 100644 eeefbce3873c 0	sound/usb/midi.c

Hmm. It looks like "am --abort" overwrites the index again after the
read-tree which complains.  If I downgrade the error in write_index to a
warning, like this:

diff --git a/read-cache.c b/read-cache.c
index fda78bc..70a6d86 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1797,7 +1797,7 @@ int write_index(struct index_state *istate, int newfd)
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
 		if (is_null_sha1(ce->sha1))
-			return error("cache entry has null sha1: %s", ce->name);
+			warning("cache entry has null sha1: %s", ce->name);
 		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
 			return -1;
 	}

and then just run this:

  [clear state from last run]
  $ rm -rf .git/rebase-apply
  $ git reset --hard

  [apply the patch; we get a conflict]
  $ git am -3sc queue-3.2/alsa-usb-audio-fix-missing-autopm-for-midi-input.patch

  [now run just the read-tree from "am --abort"]
  $ git.compile read-tree --reset -u HEAD ORIG_HEAD
  warning: cache entry has null sha1: sound/usb/midi.c

  [and now check our index]
  $ git ls-files -s sound/usb/midi.c
  100644 0000000000000000000000000000000000000000 0 sound/usb/midi.c

  [yes, this index is bogus]
  $ git write-tree
  error: invalid object 100644 0000000000000000000000000000000000000000 for 'sound/usb/midi.c'
  fatal: git-write-tree: error building trees

So I think this check may actually be finding a real bug. I have seen
these null sha1s in the wild, but I was never able to track down the
actual cause. Maybe this will give us a clue. Now we just need to work
backwards and figure out who is putting it in the in-memory index and
why.

I'll try to work on it tomorrow, but please don't let that stop you if
you want to keep digging in the meantime.

-Peff
