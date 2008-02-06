From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write failures
Date: Wed, 6 Feb 2008 20:02:34 +0000
Message-ID: <e1dab3980802061202i39c42432k4dd9f95560a7ea62@mail.gmail.com>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
	 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
	 <e1dab3980802061110p2c1dad1ep8a46eeda93839bb9@mail.gmail.com>
	 <alpine.LFD.1.00.0802061420510.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Steven Tweed" <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqUC-0008Ne-Kb
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYBFUCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbYBFUCj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:02:39 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:24785 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbYBFUCi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:02:38 -0500
Received: by ti-out-0910.google.com with SMTP id 28so321070tif.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 12:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VMUtjeNc+mtuJb2RKOe/HwweRLNHnqS3nKHTOLG/itw=;
        b=K8uZz+aTjoQc9fhUaW6j9/h1TjcLrA1gY1jGEDnhM8SOj9WbUdrFRpfkHQJytuJT7SwdEhpevmTQOQepRxpqpkClAv6RNTXGv5mwqOS6kxsosqGY5X8dC8yoINfzs0f/6JsncscfBcUWAIb8RZqicTC/q/9LnqqYCIi47AmdFPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pavRhas3w9+Oauj5VOcrNUMvQL5EOIPlWKOZ9PeKB/iO2TBLY2tpH/tag+uWs/Wqssbp806d+uiYaZwGOnW8HnbKyVbTpXA6dOExXYcpfV0KNhnNYhVEmzNxjZTEfW/vJkcsF3Md+uyVQ11AP2JtkGR/yXEVBrweuaQhgu3bUfE=
Received: by 10.150.177.20 with SMTP id z20mr4375494ybe.137.1202328154775;
        Wed, 06 Feb 2008 12:02:34 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Wed, 6 Feb 2008 12:02:34 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802061420510.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72838>

On Feb 6, 2008 7:31 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 6 Feb 2008, David Tweed wrote:
>
> > I guess the -n ought to be honoured. However, unless I'm missing
> > something, the case of expiring objects is different. The primary
> > reason is that objects can get orphaned by "semantic" decisions
> > (delete this branch, rewind, etc) so they contain valid content that
> > you might want to later rescue (using low-level command like git cat
> > if necessary).
>
> You can also get loose unconnected objects when fetching and the number
> of objects is lower than the transfer.unpackLimit value.

I didn't know that, but the key point is that these are still
well-formed objects, so rescuing data from them makes sense. In
contrast, I'm concerned with packs which are ill-formed from a
write-error, which I don't believe git will even read. (I've just
tried truncating a finished pack file and none of the git commands
I've tried will read any objects in it. So you'll have to do low-level
hacking to get data out of a write-error pack. WARNING: be aware of
how to do a non-hardlinked clone before trying this.)

> > In contrast, the only way to get a temporary pack when
> > the repository is quiescent is resulting from a _write error_ and thus
> > is a corrupt entity which it would take a great deal of work to
> > extract any valid data from.
>
> Or when a fetch is in progress, just like the case above, but with the
> number of objects greater than transfer.unpackLimit.

Being "in progress" contradicts the presumption of "being quiescent".

> This is uncommon to have a prune occurring at the same time as a fetch,
> but the --expire argument is there if for example you do a prune from a
> cron job but still want to be safe by giving a grace period to garbage
> files which might not be so after all.

Ah, I hadn't realised this was an intended usage of --expire. Since as
you note there's no way to tell an abandoned tmp pack from one that's
in the process of being written, following expire is probably
necessary for safety. I'll look at adding support for that.

Many thanks for the advice,

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
