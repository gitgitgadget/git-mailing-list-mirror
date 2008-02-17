From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 17 Feb 2008 03:18:41 -0500
Message-ID: <20080217081841.GS24004@spearce.org>
References: <200802081828.43849.kendy@suse.cz> <m3y79nb8xk.fsf@localhost.localdomain> <alpine.LSU.1.00.0802142054080.30505@racer.site> <200802142300.01615.jnareb@gmail.com> <alpine.LSU.1.00.0802142334480.30505@racer.site> <20080214235129.GU27535@lavos.net> <alpine.LSU.1.00.0802150007480.30505@racer.site> <alpine.LFD.1.00.0802142032030.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Downing <bdowning@lavos.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 09:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQekR-0002w3-0Y
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 09:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768AbYBQITF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 03:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758255AbYBQITE
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 03:19:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53460 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbYBQITA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 03:19:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JQejR-0000RU-MK; Sun, 17 Feb 2008 03:18:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3FF4D20FBAE; Sun, 17 Feb 2008 03:18:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802142032030.2732@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74104>

Nicolas Pitre <nico@cam.org> wrote:
> 
> I should really come around to fixing packed_object_info_detail() for 
> the OBJ_OFS_DELTA case one day.

Please don't.

Obtaining the SHA-1 of your delta base would require unpacking your
delta base and then doing a SHA-1 hash of it.  Or alternatively
doing a search through the .idx for the object that starts at the
requested OFS.  Either way, its really expensive for a minor detail
of output in verify-pack.  Something that any script can produce
with a simple reverse lookup table.

Its also run after we just spent a hell of a lot of time and disk
IO trying to verify the packfile.  We slammed through the pack
once to do its overall SHA-1, and then god knows how many times as
we iterate the objects in pack order, not delta base order, thus
causing the delta base cache to become overwhelmed and constantly
fault out entries.  Pack verification is stupid and slow.  This
would make -v even worse.


But if you are going to do that, you may also want to fix the
"*store_size = 0 /* notyet */" that's like 5 lines above.  :)


BTW, why does this return const char* from typename(type) instead
of just returning the enum object_type and letting the caller do
typename() if they want it?  Most of our other code that returns
types returns the enum, not the string.  :-\

-- 
Shawn.
