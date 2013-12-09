From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] rev-parse and "--"
Date: Mon, 9 Dec 2013 12:56:21 -0800
Message-ID: <20131209205621.GW29959@google.com>
References: <20131206211222.GB20482@sigill.intra.peff.net>
 <20131206211509.GB20536@sigill.intra.peff.net>
 <20131206220520.GA30652@sigill.intra.peff.net>
 <xmqqmwk9zvyy.fsf@gitster.dls.corp.google.com>
 <20131209191224.GR29959@google.com>
 <xmqqob4pycmv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7sV-0000wM-EW
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008Ab3LIU42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:56:28 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:34130 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab3LIU41 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:56:27 -0500
Received: by mail-yh0-f48.google.com with SMTP id f73so3179561yha.35
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZEpVIe4/ObCbZ2WUNEYq/5ITyRNYUL2WOdoyJDBBI20=;
        b=sfvWR4rjf2O8STxMYWkAIijPBOeyVq9UfcfGKgxX12qGji07MV6sJ41heBzXlsQQot
         cOBFpFufEb4khPG3jxaPJw67rHY1iW6hNsyLdM+7IBK/3pFaQeMK0fFcKhxXsvpEUwCg
         WzQl0wTGToFgHjvHNf0xoorJOXwurncr5QOBQgQkVVnD3U2Au3UQ6ouGC8dzMMtigAww
         L21iFV5dQ6ogF9xlWk4gDFy0EhZJugPgH9SKHKJRs5m1UYxjhbFOuewKL+jh3cZUoAdo
         1mX8B6JAh6x30RMTeYT/mqbrXN42RLhcbyXHYm6E3Sdh/kknDaQ7OAna/Yg2IjAlKI/j
         Z+BQ==
X-Received: by 10.236.50.194 with SMTP id z42mr17320620yhb.18.1386622584545;
        Mon, 09 Dec 2013 12:56:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id n48sm18605189yho.24.2013.12.09.12.56.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 12:56:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqob4pycmv.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239096>

Junio C Hamano wrote:

> I do not share the "with --verify is better hence no problem"
> reasoning.  My "not so much worth worrying about" comes solely from
> a hunch that nobody has "HEAD~3..HEAD" in their working directory,

That's what makes it a problem.  This change makes it very easy to
make a general-purpose script that breaks in an edge case that the
script's author is not likely to run into.  Then as soon as someone
adds a file with such a name to the test data in their repo, their
favorite general-purpose repo munger just breaks.

If we wanted to forbid git from tracking files named HEAD~3..HEAD
altogether, that would be a different story.

> and if somebody has one, then they must be using "--verify" (or a
> clarifying "--"), because their "git log" and whatever they use "git
> rev-parse HEAD~3..HEAD" for would behave very differently otherwise.

Isn't protecting against this kind of thing the reason we ask authors
of general-purpose scripts to use "simple, do what I say and not what
I mean" plumbing commands?

Another relevant detail is that using rev-parse with "--" is more
painful than without, since it includes the "--" in its output.
Without this change, it seems much more likely to me that someone
would do

	git rev-parse <commits> |
	while read commit
	do
		...
	done

than

	git rev-parse <commits> -- |
	while read commit
	do
		if test "$commit" = "--"
		then
			continue
		fi

		...
	done

> So it is not merely "--verify is better"---in a situation where the
> backward incompatibility matters, I doubt the existing behaves
> sensibly in the first place.

What in the former of the above two loops is broken?

> But if we cook it for a while, I suspect that we will find more and
> more breakages of expectations in the existing scripts in and out of
> the tree;

Alas, probably no, because nobody has "HEAD~3..HEAD" in their working
directory.  That's exactly the problem --- it creates an edge case
that nobody is likely to test until the once-in-a-few-years moment
when they need it.

Jonathan
