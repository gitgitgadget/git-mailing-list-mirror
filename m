From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make sure quickfetch is not fooled with a previous, incomplete fetch.
Date: Tue, 17 Apr 2007 02:58:53 -0400
Message-ID: <20070417065853.GR2229@spearce.org>
References: <11767920013264-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 08:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdheY-0006gI-1Q
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 08:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbXDQG67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 02:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbXDQG67
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 02:58:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38105 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbXDQG66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 02:58:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HdheQ-0004Wr-RH; Tue, 17 Apr 2007 02:58:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B697620FBAE; Tue, 17 Apr 2007 02:58:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11767920013264-git-send-email-junkio@cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44736>

Junio C Hamano <junkio@cox.net> wrote:
> in the kernel repository, with three different implementations
> of the "check-blob".
> 
>  - Checking with has_sha1_file() has negligible (unmeasurable)
>    performance penalty, which is what this patch has.
> 
>  - Checking with sha1_object_info() makes it somewhat slower,
>    perhaps by 5%.
> 
>  - Checking with read_sha1_file() to cause a fully re-validation
>    is prohibitively expensive (about 4 times as much runtime).
> 
> I am tempted to make the version with has_sha1_file() the
> default, getting rid of this new --check-blob option.

Misses in has_sha1_file suck, as we rescan for packfiles after
failing to find it in the current known packfiles and running a
failed stat().  Per object.

Though if --objects aborts with an error on the first failure, that's
perfectly reasonable performance, and actually quite sane behavior.
So I'm all for having --objects always imply has_sha1_file().

If the object exists enough to satisfy has_sha1_file() I think its
sane enough to assume its safe for a fast-fetch path.  If we didn't
have fast-fetch implemented and we fetched <100 objects we'd use
unpack-objects, which would only call has_sha1_file() anyway, and
find that possibly corrupted object in the source repository...,
oh, and that cannot happen as the source repository had to have a
good copy of the damn object to send it to us in the first place.
So has_sha1_file() is sufficient.

In my opinion, I think the --check-blob option of rev-list should
imply doing the sha1_object_info() type test at least, if not doing
a full-up SHA-1 validation of the blob content.  Which yea, that's
basically most of an fsck...


So I'm in favor of making --objects imply has_sha1_file(), aborting
on the first false return from that, and either make --check-blob
do the stricter checking work, or don't define it at this time.

-- 
Shawn.
