From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling large files with GIT
Date: Wed, 15 Feb 2006 01:54:52 -0800
Message-ID: <7vd5hpj6ab.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	<87slqty2c8.fsf@mid.deneb.enyo.de>
	<46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
	<Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
	<Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>
	<43F113A5.2080506@f2s.com>
	<Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>
	<43F249F7.5060008@vilain.net>
	<Pine.LNX.4.64.0602141357300.3691@g5.osdl.org>
	<7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602141741210.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602141811050.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602141829080.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602141953081.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 10:55:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9JNB-0000L7-Kj
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 10:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWBOJyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 04:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWBOJyy
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 04:54:54 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37819 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751056AbWBOJyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 04:54:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215095342.XNZ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 04:53:42 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602141953081.3691@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 14 Feb 2006 19:58:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16229>

Linus Torvalds <torvalds@osdl.org> writes:

> As far as I can tell, the output from git-merge-tree with that fix to only 
> simplify subdirectories that match exactly in all of base/branch1/branch2 
> is precisely the output that git-merge-recursive actually wants.

The matches the recollection I had last time I mucked with the
code.  Currently it is set up to do one path at a time in both
index and working tree, so it would not be a trivial rewrite,
but merge-tree based approach would speed things up quite a
bit.

I was thinking about implementing mergers as a pipeline:

	git-merge-tree O A B |
        git-merge-renaming A |
        git-merge-aggressive A |
        git-merge-filemerge

git-merge-tree (yours) does not do trivial collapsing, and
produce raw-diff from A.  git-merge-renaming reads it, finds
copied/renamed entries (maybe reusing parts of diffcore), and
writes out the results in the same format as merge-tree output
(that's why I am giving A on the command line -- so it can also
read A if it wanted to. it may need to talk about what a path in
A was even when merge-tree did not say anything about that
path).  Then git-merge-aggressive (bad naming, I know, it only
corresponds to the flag of the same name in read-tree) will
collapse git-merge-one-file equivalent stage collapsing.  The
remainder is fed to file-level merger for postprocessing.
Everything except the last step would work on a data format that
merge-tree outputs.
