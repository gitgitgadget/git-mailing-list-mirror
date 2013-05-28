From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 28 May 2013 11:18:12 +0200
Message-ID: <20130528091812.GG25742@login.drsnuggles.stderr.nl>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin>
 <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
 <7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 28 11:18:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhG2x-0007cf-Q2
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 11:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933726Ab3E1JSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 05:18:20 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:33889 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933615Ab3E1JSS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 05:18:18 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UhG2m-0002ND-Qb; Tue, 28 May 2013 11:18:13 +0200
Received: (nullmailer pid 9124 invoked by uid 1000);
	Tue, 28 May 2013 09:18:12 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225623>

Hi Junio,

I'm interested in getting a fetch tip commit only feature into git, I'll
probably look into creating a patch for this.

> >>> Sounds buggy.  Would anything break if we were to make --depth=1 mean
> >>> "1 deep, including the tip commit"?
> >>
> >> As long as we do not change the meaning of the "shallow" count going
> >> over the wire (i.e. the number we receive from the user will be
> >> fudged, so that user's "depth 1" that used to mean "the tip and one
> >> behind it" is expressed as "depth 2" at the end-user level, and we
> >> send over the wire the number that corresponded to the old "depth
> >> 1"), I do not think anything will break, and then --depth=0 may
> >> magically start meaning "only the tip; its immediate parents will
> >> not be transferred and recorded as the shallow boundary in the
> >> receiving repository".
> >
> > I'd rather we reserve 0 for unlimited fetch, something we haven't done
> > so far [1]. And because "unlimited clone" with --depth does not make
> > sense, --depth=0 should be rejected by git-clone.
> 
> I actually was thinking about changing --depth=1 to mean "the tip,
> with zero commits behind it" (and that was consistent with my
> description of "fudging"), but ended up saying "--depth=0" by
> mistake.  I too think "--depth=0" or "--depth<0" does not make
> sense, so we are in agreement.

Did you consider how to implement this? Looking at the code, it seems
the "deepen" parameter in the wire protocol now means:
 - 0: Do not change anything about the shallowness (i.e., fetch
   everything from the shallow root to the tip).
 - > 0: Create new shallow commits at depth commits below the tip (so
   depth == 1 means tip and one below).
 - INFINITE_DEPTH (0x7fffffff): Remove all shallowness and fetch
   complete history.

Given this, I'm not sure how one can express "fetch the tip and nothing
below that", since depth == 0 already has a different meaning.

Of course, one could using depth == 1 in this case to receive two
commits and then drop one, but this would seem a bit pointless to me
(especially if the commit below the tip is very different from the tip
leading to a lot of useless data transfer).

Or did I misunderstand something here?

Gr.

Matthijs
