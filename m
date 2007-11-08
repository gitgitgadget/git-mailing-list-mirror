From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/3] git-fetch: test avoiding unnecessary copying from alternates
Date: Thu, 8 Nov 2007 03:34:40 -0500
Message-ID: <20071108083440.GK14735@spearce.org>
References: <20071108082213.GA17054@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:35:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2qq-00045h-E6
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbXKHIep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbXKHIep
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:34:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33546 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbXKHIeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:34:44 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iq2qW-00016m-P3; Thu, 08 Nov 2007 03:34:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E482820FBAE; Thu,  8 Nov 2007 03:34:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071108082213.GA17054@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63966>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> This test verifies my prior "avoid local fetching from alternate"
> patch is functional and doesn't regress in the future during any
> additional improvements made to git.
...
> +test_expect_success 'quickfetch should not copy from alternate' '
> +
> +	(
> +		mkdir quickclone &&
> +		cd quickclone &&
> +		git init-db &&
> +		(cd ../.git/objects && pwd) >.git/objects/info/alternates &&
> +		git remote add origin .. &&
> +		git fetch -k -k

Hmmph.  On second thought I think this is a little sketchy for
a test.  Versions without my quickfetch patch fail this test and
versions with it pass.  But it depends on the implementation of
`-k -k` to always call index-pack over unpack-objects.

I'm using -k -k here to ensure we keep the pack fetched as we're only
fetching 6 objects and they are already reachable in the quickclone
repository thanks to the alternate ODB.  If we use unpack-objects
during this fetch we will still pass this test because the objects
won't be unpacked if they are already reachable locally.

Of course this test is for a performance optimization.  For 6
tiny objects it really doesn't matter if we copy them or not, or
if we copy them over a pipe only to discard them because they are
already reachable.  It does however matter when you are talking
about nearly 300MB worth of objects.  :-\

-- 
Shawn.
