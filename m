From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/3] Server side automatic tag following
Date: Mon, 3 Mar 2008 21:35:51 -0500
Message-ID: <20080304023550.GL8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 03:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWN17-0006bF-CZ
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 03:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbYCDCf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 21:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbYCDCfz
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 21:35:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38546 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbYCDCfz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 21:35:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWN0H-00069e-NO; Mon, 03 Mar 2008 21:35:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 79F1D20FBAE; Mon,  3 Mar 2008 21:35:51 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76013>

As promised earlier, this series adds automatic tag following on
the server side, allowing git-fetch to grab tags over a single
connection rather than opening a secondary one for the tags we
cannot get via my 'sp/fetch-optim' branch.

  1)  git-pack-objects: Automatically pack annotated tags if object was packed
  2)  Teach fetch-pack/upload-pack about --auto-follow-tags
  3)  Teach git-fetch to exploit server side automatic tag following

 Documentation/git-fetch-pack.txt   |    8 +++-
 Documentation/git-pack-objects.txt |    5 ++
 builtin-fetch-pack.c               |    9 +++-
 builtin-fetch.c                    |    3 +
 builtin-pack-objects.c             |   24 +++++++++-
 fetch-pack.h                       |    3 +-
 t/t5305-autofollow-tag.sh          |   84 ++++++++++++++++++++++++++++++++++++
 t/t5503-tagfollow.sh               |   26 +++++++++++
 transport.c                        |    5 ++
 transport.h                        |    3 +
 upload-pack.c                      |   10 +++-
 11 files changed, 172 insertions(+), 8 deletions(-)


We may still want to support multiple request/pack pairs on a single
connection, but I think that's more work than this is and may not
offer a worthwhile pay-off.  Usually the client knows what branches
it wants when it connects, and if it wants tag data.  That's all
we need to know on the server to generate an optimal packfile, and
said packfile is the only thing the client needs to update itself.

The multiple request/pack pairs is actually better implemented for
users like X.org where you want to update many repositories over
a single SSH connection.  For that we need git-fetch to multiplex
over multiple repositories, not just git-upload-pack.

-- 
Shawn.
