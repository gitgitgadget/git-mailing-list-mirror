From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: A darcs that can pull from git
Date: Mon, 25 Apr 2005 00:32:18 +0200
Message-ID: <7ipswjbybx.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 00:27:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPpZi-0007CN-5e
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 00:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVDXWcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 18:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVDXWcd
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 18:32:33 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:29649 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S262468AbVDXWcY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 18:32:24 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3OMWLpX056861
          ; Mon, 25 Apr 2005 00:32:21 +0200 (CEST)
X-Ids: 165
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j3OMWIoc004770
          ; Mon, 25 Apr 2005 00:32:18 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DPpeE-0003Zq-LM; Mon, 25 Apr 2005 00:32:18 +0200
To: darcs-devel@darcs.net
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.165]); Mon, 25 Apr 2005 00:32:21 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 426C1E75.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've just finished putting together a hack for darcs to allow it to
pull from Git repositories.  You'll find the patch (Darcs patch, not
diff patch) on

  http://www.pps.jussieu.fr/~jch/software/files/darcs-git-20050424.darcs

You should get yourself a copy of darcs-unstable, then apply this
patch:

  $ darcs get http://www.abridgegame.org/repos/darcs-unstable darcs-git
  $ cd darcs-git
  $ darcs apply darcs-git-20050424.darcs
  $ make darcs

If you get merge conflicts, try using a version of the darcs-unstable
tree from 18.04.2005, which is what I started with.

A minor problem: there's something broken with the build procedure;
you'll probably need to manually do a ``make Context.hs'' followed
with ``make darcs'' when the build breaks.

After you build darcs-git, you should be able to do something like

  $ cd ..
  $ mkdir a
  $ cd a
  $ darcs initialize
  $ ../darcs-git/darcs pull /usr/local/src/git-pasky-0.4
  $ darcs changes

This version can *pull* from git, but it cannot push; in other words,
the only way to export your data from Darcs back to git is to use diff
and patch.

Please be aware that this is just a proof-of-concept prototype.  David
and the rest of the Central Committee haven't looked at this code yet;
it is quite likely that future versions of Darcs will generate
completely different patches from git repositories.  It is also likely
that THIS CODE WILL EAT YOUR DATA.

The major issue is that we generate no patch dependencies.  If you try
to cherry-pick from repositories generated with this version, you'd
better know what you're doing.

David, could you please have a look at the patches

  Sun Apr 24 16:50:02 CEST 2005  Juliusz Chroboczek <jch@pps.jussieu.fr>
    * First cut at remodularising repo access.

  Sun Apr 24 16:01:32 CEST 2005  Juliusz Chroboczek <jch@pps.jussieu.fr>
    * Change Repository to DarcsRepo.

and tell me whether this sort of restructuring is okay with you.

(David, I'm not claiming that this scheme is better than the ``tagging
like crazy'' scheme that you outlined; I'm only trying to prove that
my scheme is workable.)

Right now, I'm taking a Git commit and manually generating a Darcs
patch id from that, which is a bad idea.  A better way would be to get
Darcs to deal with arbitrarily shaped patch ids; a patch that
originates with git would get the git patch id, while a patch that
comes from Darcs would retain its patch id even when pushed to git.
David, you had some objections to that; any chance we could discuss
the issue?

This is slow.  There are a few obvious improvements to make to the
performance, but I'd rather first implement whatsnew, diff and apply,
and fix the problem with patch dependencies.  (Whatsnew is where git's
performance is actually likely to be better than Darcs, but it will
require some abstracting of ``Slurpy'' in order to make that
effective.)  Unfortunately, I don't expect to have hacking time before
next week-end.


Enjoy,

                                        Juliusz Chroboczek
