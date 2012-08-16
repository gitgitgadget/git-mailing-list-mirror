From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Thu, 16 Aug 2012 14:00:53 +0200
Message-ID: <87k3wzujuy.fsf@thomas.inf.ethz.ch>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
	<877gt16ewe.fsf@thomas.inf.ethz.ch>
	<7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
	<87sjbpa5m8.fsf@thomas.inf.ethz.ch>
	<7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
	<CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
	<7vipcj2w9f.fsf@alter.siamese.dyndns.org>
	<7vehn72vyl.fsf@alter.siamese.dyndns.org>
	<87pq6rw77l.fsf@thomas.inf.ethz.ch> <502CC4E7.5060508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 16 14:01:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1yl6-0003C5-HN
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 14:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab2HPMA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 08:00:59 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:50901 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574Ab2HPMA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 08:00:57 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 Aug
 2012 14:00:52 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 Aug
 2012 14:00:54 +0200
In-Reply-To: <502CC4E7.5060508@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 16 Aug 2012 12:01:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 08/16/2012 10:51 AM, Thomas Rast wrote:
>> I suppose the real problem is that the "true" ordering
>> is completely obvious as the one ordering that does not require
>> preprocessing, but ugly to specify in words.  Perhaps we can bikeshed a
>> little?  How about
>>
>>    By default, commits are shown in an order that coincides with
>>    `--date-order` on well-behaved history, but is faster to compute.
>
> Maybe the problem is not the description of the options, but the
> options themselves.  Why does the behavior default to some mysterious
> order that we don't even want to document?  Only for the sake of
> computational efficiency.  This is the tail wagging the dog.
>
> Why not turn the behavior on its head:
>
> * Change the default behavior to be something well-defined, easy to
> document, and convenient for humans, such as "topological order with
> ties broken by timestamp" or "approximate timestamp order, but
> respecting dependencies".
>
> * Add a new option, --arbitrary-order, that explicitly chooses
> efficiency instead of a defined order.

I think that would be a rather bad decision, largely because (taking my
git.git as an example):

  $ time git log | head -1
  commit e5e6172f9060c958e3f0d679cd7049d4007eed2c

  real    0m0.033s
  user    0m0.026s
  sys     0m0.007s

  $ time git log --date-order | head -1
  commit e5e6172f9060c958e3f0d679cd7049d4007eed2c

  real    0m0.429s
  user    0m0.359s
  sys     0m0.031s

That is, even in medium-sized projects like git.git, any -order option
incurs a significant preprocessing time until git-log can show the first
commit.  It scales linearly with the number of commits in the range, and
in a linux.git lying around here is already around 3.9s for the same
command.

So if --date-order or --topo-order were the default, you'd have a
significant delay even if you just use 'git log' to quickly see the last
few commits.  At least to me, the optimization makes perfect sense.

The right fix would be to dig up Peff's work on generation number
caching, and modify the algorithm to take generation numbers into
account.  Then the default order would magically become the same as
--date-order at no speed loss, *and* we'd get a huge speed boost to 'git
log --graph' startup times.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
