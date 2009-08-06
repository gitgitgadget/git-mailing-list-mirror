From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] gitk: fix direction of symmetric difference in optimized mode
Date: Thu, 6 Aug 2009 09:19:26 +0200
Message-ID: <200908060919.27780.trast@student.ethz.ch>
References: <0fd5fc0f09779bb04c02b54d6ec8f43087a51bca.1249130587.git.trast@student.ethz.ch> <8a2113bfa2f1eaf6a13587cadfbaae81c8914947.1249506383.git.trast@student.ethz.ch> <19066.8802.98042.957009@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 09:19:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYxGQ-0006Vm-4r
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 09:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbZHFHTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 03:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbZHFHTm
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 03:19:42 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:19627 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbZHFHTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 03:19:41 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 6 Aug
 2009 09:19:39 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 6 Aug
 2009 09:19:39 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <19066.8802.98042.957009@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125048>

Paul Mackerras wrote:
> Thomas Rast writes:
> 
> > The confusing part of this, but also how I stumbled across the real
> > bug, was that I was playing with --show-all and that flipped the
> > direction *again*.  Turns out the option is not recognized by gitk and
> > lets it go back to unoptimized mode, where the bug does not exist.
> 
> What does --show-all do?  Maybe I need to add support for it to gitk.

Support for _displaying_ it was added to gitk in 1407ade, even before
the option was added to the revision walker.  Since it's a debugging
option, I doubt it's worth handling this in the optimized code path.

But anyway, it does not do what I hoped :-(

It shows commits that were walked, but found uninteresting, with a ^
in front.  See the long explanation in 3131b71; you can try

  gitk --show-all origin/next..origin/pu

for a nice example in git.git.

I was _actually_ looking for an option to make --cherry-pick
--left-right history connected again, as I was trying to make sense of
an SVN history basically by saying

  gitk --left-right --cherry-pick svn/2.2...svn/trunk

(Incidentally this SVN is publicly available at
https://secure.a-eskwadraat.nl/svn/domjudge, but I doubt it's worth
the cloning.)

The problem with this is that it disconnects history, so I was looking
for an option to either get back the commits omitted by --cherry-pick
(but of course flagged in some way that shows they're duplicated) or
fix the parent pointers so that history becomes connected again.  Some
of my guesses were --sparse, --full-history and --show-all, but none
achieve this.

[I *think* --sparse comes closest, but it's about TREESAME-type
uninteresting commits, not about --cherry-pick.  --full-history is
only about the merges that are TREESAME, so that's out.  --show-all
apparently is something entirely different.]

Sadly, it's really the underlying git-rev-list that is "broken" in the
sense that it does not fix the parent lists.  And git log --graph
handles it much worse than gitk.  I've added the authors of the
relevant features to Cc; maybe you can help?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
