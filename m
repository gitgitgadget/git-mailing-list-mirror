From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 5/5] reset: update cache-tree data when appropriate
Date: Wed, 7 Dec 2011 08:53:15 +0100
Message-ID: <201112070853.15364.trast@student.ethz.ch>
References: <cover.1323191497.git.trast@student.ethz.ch> <1385c10084ae41ae4543ef3ccaa1d6c8182b2204.1323191497.git.trast@student.ethz.ch> <7v62hte1k7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Carlos =?iso-8859-1?q?Mart=EDn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 08:53:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCJg-00025R-4x
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 08:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab1LGHxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 02:53:19 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:9538 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100Ab1LGHxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 02:53:19 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Dec
 2011 08:53:14 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Dec
 2011 08:53:16 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7v62hte1k7.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186438>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > @@ -84,6 +85,12 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
> >  		return error(_("Failed to find tree of %s."), sha1_to_hex(sha1));
> >  	if (unpack_trees(nr, desc, &opts))
> >  		return -1;
> > +
> > +	if (reset_type == MIXED || reset_type == HARD) {
> > +		tree = parse_tree_indirect(sha1);
> > +		prime_cache_tree(&active_cache_tree, tree);
> > +	}
> 
> The basic idea that MIXED or HARD should result in a cache-tree that match
> the tree we just read is sound, but how expensive is prime_cache_tree()? I
> think it reads the same tree once again. Admittedly, the data needed to
> reconstruct the tree is likely to be hot in core, but it may be necessary
> to measure before deciding if this is a good change.

Oh, I just didn't bother with timings because it's the same strategy
that read-tree follows, so I assumed if it was worth it back then, it
should again be a win.

For linux-2.6 as usual and best-of-10:

  git reset            before: 0:00.25real 0.12user 0.11system
	               after:  0:00.28real 0.14user 0.12system

  git reset --hard     before: 0:00.21real 0.13user 0.06system
                       after:  0:00.18real 0.10user 0.07system

So we spend ~30ms of extra user time, at a possible gain of 30% in
future git-commit invocations, as mentioned in the cover letter.  I
think that's worth it :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
