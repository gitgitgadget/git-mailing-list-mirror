From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Thu, 30 May 2013 10:23:22 +0200
Message-ID: <20130530082322.GW25742@login.drsnuggles.stderr.nl>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin>
 <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
 <7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
 <20130528091812.GG25742@login.drsnuggles.stderr.nl>
 <7va9nf2fyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 10:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhy96-0002w7-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 10:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967860Ab3E3IXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 04:23:35 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:48755 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967723Ab3E3IXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 04:23:32 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1Uhy8o-0002W6-Ou; Thu, 30 May 2013 10:23:23 +0200
Received: (nullmailer pid 9675 invoked by uid 1000);
	Thu, 30 May 2013 08:23:22 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7va9nf2fyp.fsf@alter.siamese.dyndns.org>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225944>

Hi Junio,

On Tue, May 28, 2013 at 10:04:46AM -0700, Junio C Hamano wrote:
> Matthijs Kooijman <matthijs@stdin.nl> writes:
> 
> > Did you consider how to implement this? Looking at the code, it seems
> > the "deepen" parameter in the wire protocol now means:
> >  - 0: Do not change anything about the shallowness (i.e., fetch
> >    everything from the shallow root to the tip).
> >  - > 0: Create new shallow commits at depth commits below the tip (so
> >    depth == 1 means tip and one below).
> >  - INFINITE_DEPTH (0x7fffffff): Remove all shallowness and fetch
> >    complete history.
> >
> > Given this, I'm not sure how one can express "fetch the tip and nothing
> > below that", since depth == 0 already has a different meaning.
> 
> Doing it "correctly" (in the shorter term) would involve:

Given below suggestion, I take it you don't like what Jonathan proposed
(changing the meaning of the deepen parameter in the protocol so that
the server effectively decides how to interpret --depth)?

>  - adding a capability on the sending side "fixed-off-by-one-depth"
>    to the protocol, and teaching the sending side to advertise the
>    capability;
>    
>  - teaching the sending side to see if the new behaviour to fix
>    off-by-one is asked by the requestor, and stop at the correct
>    number of commits, not oversending one more.  Otherwise retain
>    the old behaviour.
We can implement these two in current git already, since they only
add to the protocol, not break it in an incompatible manner, right?

>  - teaching the requestor that got --depth=N from the end user to
>    pay attention to the new capability in such a way that:
> 
>    - when talking to an old sender (i.e. without the off-by-one
>      fix), send N-1 for N greater than 1.  Punt on N==1;
> 
>    - when talking to a fixed sender, ask to enable the capability,
>      and send N as is (including N==1).
And these should wait for git2, since they change the meaning of the
--depth parameter? Or is this change ok for current git as well?

What do you mean by "punt" exactly? Show an error to the user, saying
only depth >= 2 is supported?

> In the longer term, I think we should introduce a better deepening
> mechanism.  Cf.
Even when there will be a better deepening mechanism, the above is still
useful (passing --depth=1 serves to get just a single commit without
history, which is a distinct usecase from deepening the history of an
existing shallow repository). In other words, I think the "improved
deepening" and "fixed depth" should be complementary features.

Gr.

Matthijs
