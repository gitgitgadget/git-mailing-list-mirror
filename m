From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: XDL_FAST_HASH can be very slow
Date: Mon, 22 Dec 2014 11:48:31 +0100
Message-ID: <87r3vsrmdc.fsf@thomasrast.ch>
References: <20141222041944.GA441@peff.net>
	<CAJrMUs_fM8+=2j1e5hYiaRjQq1QF87X6qOLN847q-B7Nu-wniw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Patrick Reynolds <piki@github.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 11:58:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y30gu-00085N-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 11:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbaLVK6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 05:58:15 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:36139 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbaLVK6P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 05:58:15 -0500
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Dec 2014 05:58:14 EST
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id C91454D6009;
	Mon, 22 Dec 2014 11:48:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mi4m1Gtg-jnw; Mon, 22 Dec 2014 11:48:30 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id CB3BD4D6001;
	Mon, 22 Dec 2014 11:48:29 +0100 (CET)
In-Reply-To: <CAJrMUs_fM8+=2j1e5hYiaRjQq1QF87X6qOLN847q-B7Nu-wniw@mail.gmail.com>
	(Patrick Reynolds's message of "Mon, 22 Dec 2014 03:08:12 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261642>

Patrick Reynolds <piki@github.com> writes:

> The original xdl_hash_record is essentially DJB hash, which does a
> multiplication, load, and xor for each byte of the input.  Commit
> 6942efc introduces an "XDL_FAST_HASH" version of the same function
> that is clearly inspired by the DJB hash, but it does only one
> multiplication, load, and xor for each 8 bytes of input -- i.e., fewer
> loads, but also a lot less bit mixing.  Less mixing means far more
> collisions, leading to the performance problems with evil-icons.  It's
> not clear to me if the XDL_FAST_HASH version intended to match the
> output of the DJB hash function, but it doesn't at all.

Note that XDL_FAST_HASH is just a ripoff of the hashing scheme that
Linus socially engineered on G+ around that time.  I didn't do any of
the hash genealogy that you did here, and it now shows.  The orginal
patches are linked from 6942efc (xdiff: load full words in the inner loop of
xdl_hash_record, 2012-04-06):

  https://lkml.org/lkml/2012/3/2/452
  https://lkml.org/lkml/2012/3/5/6

The code still exists:

  https://github.com/torvalds/linux/blob/master/fs/namei.c#L1678

> I have implemented two simpler possibilities, both of which fix the
> problems diffing the evil-icons repository:

I think it would be best to separate three goals here:

1. hash function throughput
2. quality of the hash values
3. avoiding collision attacks

XDL_FAST_HASH was strictly an attempt to improve throughput, and fairly
successful at that (6942efc (xdiff: load full words in the inner loop of
xdl_hash_record, 2012-04-06) quotes an 8% improvement on 'git log -p').

You are now addressing quality.

I have no idea how you ran into this, but if you are reworking things
already, I think it would be good to also randomize whatever hash you
put in so as to give some measure of protection against collision
attacks.

> 1. An XDL_FAST_HASH implementation that matches the output of the DJB
> hash exactly.  Its performance is basically the same as DJB, because
> the only thing is does differently is load 8 bytes at a time instead
> of 1.  It does all the same ALU operations as DJB.

I don't think there's a point in having such a function, since it would
mean a lot of code for no throughput gain.  Let's just remove
XDL_FAST_HASH and the original hashing scheme in favor of a better hash
function.

-- 
Thomas Rast
tr@thomasrast.ch
