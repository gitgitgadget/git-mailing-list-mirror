From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/3] grep multithreading and scaling
Date: Mon, 5 Dec 2011 21:16:47 +0100
Message-ID: <201112052116.48106.trast@student.ethz.ch>
References: <201111291507.04754.trast@student.ethz.ch> <20111202173400.GC23447@sigill.intra.peff.net> <201112051038.16423.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 21:17:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXeyC-0000Bm-SP
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 21:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415Ab1LEUQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 15:16:54 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:58015 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079Ab1LEUQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 15:16:54 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Dec
 2011 21:16:49 +0100
Received: from thomas.inf.ethz.ch (129.132.211.12) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Dec
 2011 21:16:48 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <201112051038.16423.trast@student.ethz.ch>
X-Originating-IP: [129.132.211.12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186289>

Thomas Rast wrote:
> 
> I just found out that on Linux, there's mincore() that can tell us
> (racily, but who cares) whether a given file mapping is in memory.
[...]
> So that looks fairly promising, and the order would then be:
> 
> - if stat-clean, and we have mincore(), and it tells us we can do it
>   cheaply: grab file from tree
> 
> - if it's a loose object: decompress it
> 
> - if stat-clean: grab file from tree
> 
> - access packs as usual

Just a small note, I tried two things:

* the simpler option of grabbing a loose object if it exists and is
  mincore() turns out to massively slow down 'git log HEAD', probably
  because only very few of these objects are loose in the first place

* doing this only under grep's use_threads, and dropping the lock
  around unpack_sha1_file() [i.e., zlib decompression] still results
  in a git-grep that is slower than without this, though not much

So no improvement here.  Will have to look into the worktree trick
though.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
