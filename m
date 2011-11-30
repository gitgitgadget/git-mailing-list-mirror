From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 20:01:45 -0800
Message-ID: <1322625705.1728.299.camel@yos>
References: <1322546563.1719.22.camel@yos>
	 <CAJo=hJtFT55Ucyij9esr3Hd9yJ6XCxatK7vjPOLMKow57HqBoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	peff@peff.net, torvalds@linux-foundation.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 30 05:02:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVbMu-0006Yr-6Q
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 05:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab1K3EBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 23:01:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41616 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab1K3EBy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 23:01:54 -0500
Received: by iage36 with SMTP id e36so110250iag.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 20:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=QB8FOR/Hjlbs/GHjkwNkf0Jahehh6L7PqG7zslGzjmQ=;
        b=V+keLr7X4PSQx9Opk4KilFlluaVIaPe/Qk7nqpyWzkNMeJXAb5Lv68k/513KYE6XC2
         +fkIZ0/ap3G02wUheKA+jGTFDFRJtqfQ+GF+H/zcVOu2o7Zv7CdTee+ZOt17i2OwNi6m
         dp7fnc+DX60YCRnu8zxIofqVgGNoSN/bV7MWE=
Received: by 10.50.140.1 with SMTP id rc1mr299968igb.25.1322625713437;
        Tue, 29 Nov 2011 20:01:53 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id dm1sm1426135igb.6.2011.11.29.20.01.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 20:01:51 -0800 (PST)
In-Reply-To: <CAJo=hJtFT55Ucyij9esr3Hd9yJ6XCxatK7vjPOLMKow57HqBoQ@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186099>

Note: for some reason my email is not showing up on the mailing list.
I'm trying a different email address - previously my 'From' field
contained a subaddress "+git" but gmail won't put that in the 'Sender'
field, so possibly the email is being filtered for that reason.

On Tue, 2011-11-29 at 09:08 -0800, Shawn Pearce wrote:

> I don't think you understand how these thin packs are processed.

I think the confusion was due to me being a bit too terse.  The
documentation clearly states that thin packs allow deltas to be
sent when the delta is based on an object that the server and client
both have in common, given the commits each already has.  If there is
one server and one client, there isn't an issue.  The case I meant is
the one in which a user does a fetch from one server, gets a forged
blob, and then fetches from another server with the original blob, and
with additional commits along the same branch. If a server bases the
delta off of the original blob, and the client applies the delta to the
forged blob, the client will most likely end up with a blob with a
different SHA-1 hash than the one expected.  Since an object in a tree
is then missing (no object with the expected SHA-1 hash), the repository
is corrupted.

The "first to arrive wins" policy isn't sufficient in one specific case:
multiple remote repositories where new commits are added asynchronously,
with the repositories out of sync possibly for days at a time (e.g.,
over a 3-day weekend).  In this case, the first to arrive at one
repository may not be the first to arrive at another, so what happens at
a particular client in the presence of hash collisions is dependent on
the sequence of remotes from which updates were fetched.  The risk
occurs in the window where the repositories are out of sync.

Regarding the kernel.org problem that you used as a separate example,
while it was fortunately possible to rebuild things (and git provided
significant advantages), earlier detection of the problem might have
reduced the time for which kernel.org was down.  Early detection of
errors in general is a good practice if it can be done at a reasonable
cost.

> Trust. Review. Verify.

While good advice in principle, you should keep in mind that there are
a lot of people out there working at various companies who are not as
capable as you are.  Some of them are overworked and make mistakes
because they've been working 16 hour days for weeks trying to meet a
deadline. Given that, extra checks to catch problems early
are probably a good idea if they don't impact performance significantly.
