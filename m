From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: FLEX_ARRAY=1 causes SIGSEGV on SPARC
Date: Mon, 17 Dec 2007 20:01:26 -0500
Message-ID: <20071218010126.GP14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 02:01:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4QqM-00005o-Ij
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 02:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbXLRBBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 20:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbXLRBBa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 20:01:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40461 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXLRBBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 20:01:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J4Qph-0000p3-KO
	for git@vger.kernel.org; Mon, 17 Dec 2007 20:01:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A1A8420FBAE; Mon, 17 Dec 2007 20:01:26 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68680>

So today I discovered latest master will cause a SIGSEGV on
Solaris/SPARC if FLEX_ARRAY is defined to the default value of 1.

The issue is the (old) compiler I'm using from Sun doesn't pass
the tests defined in 8e9739914972419baad820e76b44d9720ed885c2 (aka
"git-compat-util.h: auto-adjust to compiler support of FLEX_ARRAY
a bit better") so we fallback to #define FLEX_ARRAY 1.

Then git-pack-objects finds something unaligned and segfaults.
It always segfaults.  During the deltification phase.  Probably it
was working on deltifying loose objects; the set I fed it was about
100 most recent objects so they were probably all loose.

I'll try to track it down tomorrow.  But the immediate workaround was
to just add '-DFLEX_ARRAY=/* empty */' to my CFLAGS and recompile
the world.  This compiler accepts the empty FLEX_ARRAY macro but
I'm not sure what feature test(s) would be necessary to make Git
able to automatically set that, seeing as how the tests defined in
8e97 are perfectly reasonable and didn't pass.

Yea, yea, shame on me for not testing Git since Nov 20th on this
system... I should have caught the failure sooner.  I'm buried in
non-Git work these days, but will try to come up with a reasonable
detection patch.  Maybe someone will beat me to it.  :-)

-- 
Shawn.
