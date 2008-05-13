From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: How to (re-)create .git/logs/refs
Date: Tue, 13 May 2008 14:13:14 +0200
Message-ID: <200805131413.14753.hs4233@mail.mn-solutions.de>
References: <200805081256.11465.hs4233@mail.mn-solutions.de> <200805130842.06112.hs4233@mail.mn-solutions.de> <alpine.DEB.1.00.0805131244300.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 14:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvtRn-0005KL-C9
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 14:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbYEMMQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 08:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbYEMMQp
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 08:16:45 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:27444 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYEMMQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 08:16:44 -0400
Received: from lin01.mn-solutions.de (pD95FBA72.dip0.t-ipconnect.de [217.95.186.114])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 8E5085E4143;
	Tue, 13 May 2008 14:16:42 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id 3EC121E0038; Tue, 13 May 2008 14:13:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id 22B591E0004;
	Tue, 13 May 2008 14:13:44 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.DEB.1.00.0805131244300.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82024>

> Are you sure you understand what @{date} does?  It shows you
> the state _this_ repository was in at that date.

Who says so?  "man git-rev-parse" just says:

o  A ref followed by the suffix @ with a date specification
   enclosed in a brace pair (e.g. {yesterday}, {1 month 2 weeks 3
   days 1 hour 1 second ago} or {1979-02-26 18:30:00}) to specify
   the value of the ref at a prior point in time. This suffix may
   only be used immediately following a ref name and the ref
   must have an existing log ($GIT_DIR/logs/<ref>).


It just states "at a prior point in time", not "at a prior point 
in time in your git repository/checkout".


> It is a common misconception that you can reference anything
> by date in a distributed setup.  (Before you ask, I will just
> mention "clock skew" and "parallel branches" to give you an
> idea why this is a misconception.)

My idea was to use the first commit (from git-rev-log) where the 
date is below the specified date.

To give you some context: Bitbake (from www.openembedded.org) is 
a tool that can download software, patch it, configure it, 
compile it and create packages out of it. Nothing fancy, except 
that it can do this for a huge amount of embedded devices, 
usually using a cross-compiler for ARM, MIPS, whatever.

And it can download not just tar files, it can also use CVS, SVN, 
hg, git and so on.

In Openembedded, many patch recipes specify the version to use. 
If you deal with versioned stuff, e.g. 
filename-frob-3.14.tar.bz, this is fine. Sometimes the version 
is a SVN revision number. And sometimes it's a git, mercury or 
monotone hash. However, the latter beast are almost 
non-describing. So many bitbake recipes specify a SRCDATE, and 
you can immediately see if SRCDATE=20070501 that it uses an 
ancient version of the software, from 1st May 2007. You won't 
see that if it would specify 
GIT_REV=6e2df4fd066c450b0b3c8e0f1769d4163e2b52c4. Of course you 
can do

  GIT_REV=6e2df4fd066c450b0b3c8e0f1769d4163e2b52c4
  # This is from 2007 May 1st

but then you're redundant and chances are high that those two 
lines get out-of-sync.


So, when I have SRCDATE=20070501, I'd be happy if git would, for 
me, find out that this is 
6e2df4fd066c450b0b3c8e0f1769d4163e2b52c4, even when the commit 
6e2df4fd066c450b0b3c8e0f1769d4163e2b52c4 was not done on my 
local machine, but is a commit that I pulled from the outside.

Also, when I do "git checkout @{20070501}", I don't usually mind 
if, e.g. because of time-skew or multi-heads, I'm not at the 
17th commit in this area, but on the top-most for which this 
condition is true. I can use "git log" and "git reset" or 
whatever to dig my way to the state I want, but git would do the 
dull work for me.
