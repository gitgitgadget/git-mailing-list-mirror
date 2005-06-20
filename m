From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Tue, 21 Jun 2005 00:37:52 +1000
Message-ID: <2cfc40320506200737113caa9f@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
	 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
	 <2cfc403205061903155a6090db@mail.gmail.com>
	 <2cfc40320506190741409f3a5@mail.gmail.com>
	 <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
	 <2cfc4032050619125537dee354@mail.gmail.com>
	 <Pine.LNX.4.58.0506192002240.2268@ppc970.osdl.org>
	 <2cfc403205061920272ee47166@mail.gmail.com>
	 <2cfc40320506192030290187af@mail.gmail.com>
	 <2cfc403205062003292db2b457@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 16:32:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkNK2-0000EC-QJ
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 16:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFTOiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 10:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVFTOiG
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 10:38:06 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:63373 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261245AbVFTOhx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 10:37:53 -0400
Received: by rproxy.gmail.com with SMTP id i8so726984rne
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 07:37:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dsSpVGwpDpWu97yIOPmhk5JjH+acsZEgRjXLXT6HfnXKj3m/xSXVRUGntxEkU6vL09ntZZ0SMRSLJ9oewbMfDGO3JwF563kRatdRg/AYSUjpRJpUlWTWuRyeCoyTnOYWMCfs29CJpDXs4+2YTCvNx5U0NQBj9jK/JVFLfyR8rAk=
Received: by 10.39.3.25 with SMTP id f25mr2203556rni;
        Mon, 20 Jun 2005 07:37:52 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Mon, 20 Jun 2005 07:37:52 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <2cfc403205062003292db2b457@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> I am exploring another variation of the idea which is even simpler.
> Experimentally it seems quite similar to your average case
> performance, but doesn't yet approach your low std deviations.
> However, I think I know why that is, so I will, after a few games of
> pool and a similar number of beers, have another crack at it.
> 

Ok, just for information, I have a linear bisection algorithm which
results in a bug-blatt algorithm with the following characteristics on
the Linux 2.6 kernel:

AVERAGE	13.64589235
MEDIAN	13
MAX	28
MIN	9
STDEV	2.171923221

These results were derived by running the algorithm over the full 2118
commits of the
current Linux 2.6 source.

I'll document what this algorithm is and what its flaws are.

The algorithm is as follows:

Consider the graph as a closed network of pipes with N reservoirs of 1
unit of volume. Rotate this graph so the head is at the top. Now, pour
N units of liquid into the top of the network of pipes. The liquid
percolates through the network of pipes and ends up in the reservoirs.
The selected bisection point is the node that saw as close to N/2
units of liquid as any other node.

Now, why isn't this as good (in terms of average and stdev) as Linus'
algorithm? The flaw with this algorithm is that some liquid from peer
nodes reaches the lower half of the network before the liquid that
went through the selected node. As a result, the selected node is
elevated "above" the ideal bisection point, by a factor that I believe
would be sufficient to explain the higher average and also the greater
standard deviation.

Still, my algorithm is very simple and very linear, so it's very good a start.

As it happens, I believe I have (re-?)discovered a precise way to
discover the bisection points in O(n). I am in the midst of
implementing that now.

jon.
