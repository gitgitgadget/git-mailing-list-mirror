From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Ignore end-of-line style when computing similarity score for rename detection
Date: Thu, 28 Jun 2007 02:18:21 -0400
Message-ID: <20070628061821.GM32223@spearce.org>
References: <7vtzssog5i.fsf@assigned-by-dhcp.pobox.com> <20070628060416.GA13162@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 08:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3nKm-00018G-JW
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 08:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbXF1GS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 02:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755869AbXF1GS1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 02:18:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56881 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391AbXF1GS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 02:18:26 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I3nKg-0003Vb-HF; Thu, 28 Jun 2007 02:18:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CDB8220FBAE; Thu, 28 Jun 2007 02:18:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070628060416.GA13162@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51084>

Steven Grimm <koreth@midwinter.com> wrote:
> Junio rightly points out that it would be a mistake to discard \r
> characters from binary files when computing similarity scores. So now we
> only do it if the file contents test as non-binary.
> 
> The file attributes aren't available at this level of the code, but they
> could be propagated down from the higher levels if we don't trust
> buffer_is_binary() to make an adequately accurate decision.

Ick.  If we can get the attributes into diff_filespec this is
pretty easy, as you can do a crlf->lf conversion on both files if
both are considered to be text, but it doesn't look like it would
be very easy to get the attributes into the diff_filespec.

Actually even better if you can also run the in/out filter things.
I'm thinking of say an XML file that has had whitespace formatting
changes, but whose XSD and processors ignore unnecessary whitespace.
Be nice if the rename detection actually was able to canonicalize
both files before detecting the rename, assuming both files had a
canonicalizer input filter defined that does that...

Of course diff.c defines a nice diff_is_binary() at file scope that
does at least a "can we diff this" decision.  Might be good if that
could be reused for the rename detection.

OK, that's far more than I actually know about diffcore.  This is
one for Junio, Linus, you, and those who are less tired than I feel
right now...  ;-)

Personally I'd rather see us doing the right thing (use attributes
and fallback on guessing if no preference is stated either way)
over doing something half-a**ed (only guessing).

-- 
Shawn.
