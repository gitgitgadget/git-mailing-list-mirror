From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/5] Remove unnecessary 'fetch' argument from transport_get API
Date: Sun, 16 Sep 2007 04:11:29 -0400
Message-ID: <20070916081129.GE3099@spearce.org>
References: <20070915072314.GE20346@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 10:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWpEJ-0001eg-VG
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 10:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbXIPILo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 04:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbXIPILn
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 04:11:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46399 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbXIPILl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 04:11:41 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWpE1-0000gY-Ei; Sun, 16 Sep 2007 04:11:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DCD8520FBAE; Sun, 16 Sep 2007 04:11:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070915072314.GE20346@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> We don't actually need to know at the time of transport_get if the
> caller wants to fetch, push, or do both on the returned object.
> It is easier to just delay the initialization of the HTTP walker
> until we know we will need it by providing a CURL specific fetch
> function in the curl_transport that makes sure the walker instance
> is initialized before use.

Daniel privately emailed me his rationale for why this fetch argument
was here in the first place and I mostly agree with him, but will
be working up a more clear API replacement in the near future.
The "1/0","fetch/push" thing is not the clearest way that we could
define the API.

Right now this patch is required to go along with my 1/5 bug fix,
as without this patch we get the sequence:

	http_init()
	http_init()
	... use http ...
	http_cleanup()
	... try to use http again and barf ...

This 5/5 makes the sequence be in proper order by delaying creation
of the HTTP walker object (and thus one of the http_init() calls)
to after the first http_cleanup(), so we get the nice neat order of:

	http_init()
	... use http ...
	http_cleanup()
	http_init()
	... use http just fine ...
	http_cleanup()

I'll be honest here; I did not test 1/5 or 5/5 on their own.
I only tested the combined result of them, and that creates a
working HTTP fetch.  But I'm pretty sure that one of these patches
alone will still cause SIGSEGV/SIGBUS errors during HTTP fetch due
to either the bad cleanup (1/5 fixes) or the bad init ordering I'm
talking about above (5/5 fixes).

Reinstating a replacement for the fetch parameter that I removed
in this patch isn't critical for functionality, but will be
necessary to do performance optimization in the form of reusing
the connection between ref discovery and pack transfer in the
native protocol.  Right now I'm focusing on making builtin-fetch
stable and implementing prior behavior.  Once its solid enough to
graduate to `next` we can start doing some of the optimization work.
 
-- 
Shawn.
