From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] do not write null sha1s to on-disk index
Date: Sat, 29 Dec 2012 02:03:46 -0800
Message-ID: <20121229100130.GA31497@elie.Belkin>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 11:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TotN6-0001IS-Hy
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 11:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab2L2KD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 05:03:58 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:60691 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2L2KD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 05:03:57 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so5115146dak.6
        for <git@vger.kernel.org>; Sat, 29 Dec 2012 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1HPMZpYWQcESF+x2ZQqjQCr3aSE125ySBsivCnYNn6Y=;
        b=TwfToo6LnTZ1QpRwuE6+Y0mnmE4rWVNXrH/fuhXc6WjGYpA8gjBOXIdv86UgorpH1H
         D2ZirNbGKyLpE1iEf/NlHqwZ1ffkzuHGnUfEXTjILTsizQgHmUqTMlSXdKDFuAvA/zi1
         SOttjmM17lOMPfK6GQPoYBmqbwKtsdYDlZIEAO9CGQaw4kyWa2lwaMBWgl+q6LuWgrYw
         GoVKGy0OENjoVbtUMUMLSugodPCVNoqMtm60paPMHpqJByjFZQt/nbQVrUi5OC856ZoN
         tEGBtGQ3J/szxLSTKwSYBzeDQmS6ytmK03Ejvf6tP7Kd3OrEr8qV7rvxfLuNEm4ATPNT
         Mv+Q==
X-Received: by 10.66.76.8 with SMTP id g8mr105854532paw.40.1356775435734;
        Sat, 29 Dec 2012 02:03:55 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id u1sm21959887pav.16.2012.12.29.02.03.53
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Dec 2012 02:03:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120728150524.GB25269@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212302>

Hi Peff,

Jeff King wrote:

> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1800,6 +1800,8 @@ int write_index(struct index_state *istate, int newfd)
>  			continue;
>  		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
>  			ce_smudge_racily_clean_entry(ce);
> +		if (is_null_sha1(ce->sha1))
> +			return error("cache entry has null sha1: %s", ce->name);
>  		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
>  			return -1;

Quick heads up: this is tripping for me in the "git am --abort"
codepath:

  $ cd ~/src/linux
  $ git checkout v3.2.35
  $ git am -3sc /tmp/alsa-usb-audio-fix-missing-autopm-for-midi-input.patch 
  Applying: ALSA: usb-audio: Fix missing autopm for MIDI input
  Using index info to reconstruct a base tree...
  Falling back to patching base and 3-way merge...
  error: Your local changes to the following files would be overwritten by merge:
	sound/usb/midi.c
  Please, commit your changes or stash them before you can merge.
  Aborting
  Failed to merge in the changes.
  Patch failed at 0001 ALSA: usb-audio: Fix missing autopm for MIDI input
  When you have resolved this problem run "git am --resolved".
  If you would prefer to skip this patch, instead run "git am --skip".
  To restore the original branch and stop patching run "git am --abort".
  $ git am --abort
  error: cache entry has null sha1: sound/usb/midi.c
  fatal: unable to write new index file
  Unstaged changes after reset:
  M       sound/usb/midi.c
  $

Reproducible using v1.8.1-rc3 and master.  Bisects to 4337b585 (do not
write null sha1s to on-disk index, 2012-07-28).  For comparison, older
gits produced

  $ git am --abort
  Unstaged changes after reset:
  M       sound/usb/midi.c

which is also not great but at least didn't involve any obviously
invalid behavior.  Known problem?

Thanks,
Jonathan
