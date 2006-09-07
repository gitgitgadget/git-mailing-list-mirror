From: Shawn Pearce <spearce@spearce.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 7 Sep 2006 01:34:24 -0400
Message-ID: <20060907053424.GB31580@spearce.org>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com> <44FF5C27.2040300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 08:08:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLD3J-00018C-8W
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWIGGHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWIGGHa
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:07:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:16335 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751939AbWIGGH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 02:07:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GLD2t-0001TH-6f; Thu, 07 Sep 2006 02:07:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7CF8620FB33; Thu,  7 Sep 2006 01:34:25 -0400 (EDT)
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <44FF5C27.2040300@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26597>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> Just looking at the structures in non-BLOBS, I see a lot of potential
> for the use of a set dictionaries when deflating TREEs and another set
> of dictionaries when deflating COMMITs and TAGs. The low hanging fruit
> is to create dictionaries of the most referenced IDs across all TREE or
> COMMIT/TAG objects.

The most referenced IDs should be getting reused through deltas.
That is IDs which are highly referenced are probably referenced
in the same tree over many versions of that tree.  Since the data
isn't changing it should be getting copied by a delta copy command
rather than appearing as a literal.

The Mozilla pack appears to have the bulk of its storage taken up
by blobs (both bases and deltas).  I suspect this is because the
bases compress to approx. 50% of their original size but share a
lot of common tokens.  Those common tokens are being repeated in
every private zlib dictionary.  The same thing happens in a delta,
except here we are probably copying a lot from the base so the
average size is greatly reduced but we are still repeating tokens
in the zlib dictionary for anything that is a literal in the delta
(as it didn't appear in the base).

A large dictionary containing all tokens for the project should
greatly reduce the size of each blob, base and delta alike.  It also
lends itself to creating an efficient full text index.

-- 
Shawn.
