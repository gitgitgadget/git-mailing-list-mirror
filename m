From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 11:51:30 +0200
Message-ID: <vpq64eakpnh.fsf@ecrins.imag.fr>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<453A7D7E.8060105@utoronto.ca>
	<20061022074513.GF29927@artax.karlin.mff.cuni.cz>
	<200610221105.26421.jnareb@gmail.com>
	<845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
	<87zmbozau2.wl%cworth@cworth.org>
	<20061022185350.GW75501@over-yonder.net>
	<Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	<20061023222131.GB17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 11:52:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcIxq-0007If-Cd
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 11:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWJXJwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 05:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWJXJwv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 05:52:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:48815 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1030267AbWJXJwu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 05:52:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9O9pV2h025579
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Oct 2006 11:51:31 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GcIwU-00022J-Ra; Tue, 24 Oct 2006 11:51:30 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GcIwU-0004dR-OD; Tue, 24 Oct 2006 11:51:30 +0200
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061023222131.GB17019@over-yonder.net> (Matthew D. Fuller's message of "Mon\, 23 Oct 2006 17\:21\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Tue, 24 Oct 2006 11:51:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29958>

"Matthew D. Fuller" <fullermd@over-yonder.net> writes:

>> For example, how long does it take to do an arbitrary "undo" (ie
>> forcing a branch to an earlier state) [...]
>
> I don't understand the thrust of this, either.  As I understand the
> operation you're talking about, it doesn't have anything to do with a
> branch; you'd just be whipping the working tree around to different
> versions.  That should be O(diff) on any modern VCS.

There are two things to do:

* Mark the tree as corresponding to a different revision in the past.
  This is roughly "echo 'revision@id-123' > .bzr/checkout/last-revision"
  in bzr. Obviously, writting the file is O(1), but computing the
  revision identifier if you say "bzr switch -r 42" (I'm not sure
  switch accepts this BTW), you have to load the revision history.
  Indeed, bzr would load it anyway to make sure that the revision you
  switch to is in the revision history.

  In bzr, you have .bzr/branch/revision-history for each branch, which
  is a newline-separated list of revision-identifiers. In the case of
  bzr.dev, for example, this file is 112KB as of now. This is
  O(history), with "history" being the length of the path from HEAD to
  the initial commit, following the leftmost ancestor (i.e. number of
  revisions in a centralized workflow, and less than this otherwise).
  That said, the constant factor is very small. For example, on
  bzr.dev, I did "grep -n some-rev-id" (which does revid-to-revno), it
  takes 0.004 seconds (Vs 0.003 seconds to grep in /dev/null
  instead ;-) ), so you'd need many orders of magnitude before this
  becomes a limitation.

  Linus's point AIUI is that this will _never_ be a limitation of git.

* Then, do the "merge" to make your tree up to date. You can hardly do
  faster than git and its unpacked format, but this is at the cost of
  disk space. But as you say, in almost any modern VCS, that's
  O(diff). In a space-efficient format, that's just the tradeoff you
  make between full copies of a file and delta-compression.

-- 
Matthieu
