From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fetch-pack: avoid repeatedly re-scanning pack
 directory
Date: Sun, 27 Jan 2013 15:20:33 -0800
Message-ID: <20130127232033.GA8206@elie.Belkin>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <20130126224043.GB20849@sigill.intra.peff.net>
 <20130127102753.GB4228@elie.Belkin>
 <7vvcaiv14s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:21:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzbX6-0000HP-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab3A0XUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:20:44 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:40354 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab3A0XUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:20:42 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so951794dak.11
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RAvnywq4T3d00ZaDSZCe2/i1zqT5XehG3io4EioJVtA=;
        b=LS0YEiFmEBukgNDBY7c8LkijZyPIa09fkBv24l0MxKPuCnfWrll2I5Z/MUVyBN6/pb
         4kN5cRqi2qubWeP3SIsxaBcB4J/N4JozV97XczxXz8NqKbeBjGvL37LUTjDaio0UnsSP
         xu4C/D8HDODTU2vgTqJo55n+Mt4zTiRhVenjtBW8nhrsfDcS2vGD7KtYr/2wwUkkh6cA
         /Ybp18PwJKf57jCi0d4MMP+s74hQca389E3sv+Ce88xWCB4KzNQw+WHxhgDlJxpmqrTZ
         CGW3ESUmW5/W4rtHr/FDpMk9Dhil6fjBwk6fPORf2SESYZeEpbfca8AxCmDpgXCbD2v7
         kPag==
X-Received: by 10.68.242.134 with SMTP id wq6mr32659377pbc.146.1359328842302;
        Sun, 27 Jan 2013 15:20:42 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qn3sm5054789pbb.56.2013.01.27.15.20.39
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 15:20:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vvcaiv14s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214751>

Junio C Hamano wrote:

> It is not about a rough estimate nor common commits, though.  The
> "everything local" check in question is interested in only one
> thing: are we _clearly_ up to date without fetching anything from
> them?
[...]
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  * Why is 49bb805e ("Do not ask for objects known to be complete",
>>    2005-10-19) trying to do?  Are we hurting that in any way?
>
> An earlier fetch may have acquired all the necessary objects but may
> not have updated our refs for some reason (e.g. fast-forward check
> may have fired).  In such a case, we may already have a history that
> is good (i.e. not missing paths down to the common history) in our
> repository that is not connected to any of our refs, and we can
> update our refs (or write to FETCH_HEAD) without asking the remote
> end to do any common ancestor computation or object transfer.
>
> That was the primary thing the patch wanted to do.

Interesting.

After I fetch objects for branches a, b, and c which all have different
commit times in a fetch that fails due to the fast-forward check, I
have the following objects:

	a	commit date = 25 January 2013
	b	commit date = 26 January 2013
	c	commit date = 27 January 2013

When I try to fetch again (forcibly this time), git notices that the
objects are available locally and sets "cutoff" to 27 January 2013 as
a hint about the last time I fetched.

mark_recent_complete_commits() is called, and since these objects are
not reachable from any local refs, none are visited in the walk, and
49bb805e does not affect the outcome of the fetch positively or
negatively.

On the other hand, if I fetched a, b, and c to local branches and then
built on top of them, 49bb805e ensures that a second fetch of the same
refs will know right away not to request objects for c.  So it brings
some of the benefits of 2759cbc7 (git-fetch-pack: avoid unnecessary
zero packing, 2005-10-18) when the receiving side has either (A)
renamed refs or (B) built new history on top of them.

Correct?

It is only in case (B) that the cutoff matters.  If we miscalculate
the cutoff, that means either (i) cutoff == 0, and we would lose the
benefit of the walk that finds complete commits, or (ii) cutoff is a
little earlier, and the walk to find complete commits would take a
little longer.  Neither effects the result of the fetch, and neither
is likely to be a significant enough performance difference to offset
the benefit of Jeff's patch.

Thanks for explaining.
Jonathan
