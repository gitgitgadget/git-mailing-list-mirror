From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/3] Implement the patience diff algorithm
Date: Wed, 7 Jan 2009 21:19:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901072110340.7496@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
 <20090107143926.GB831@artemis.corp> <alpine.DEB.1.00.0901071610290.7496@intel-tinevez-2-302> <alpine.DEB.1.00.0901071802190.7496@intel-tinevez-2-302> <alpine.DEB.1.10.0901071001360.16651@alien.or.mcafeemobile.com> <alpine.DEB.1.00.0901071924350.7496@intel-tinevez-2-302>
 <alpine.DEB.1.10.0901071159060.17115@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:20:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKetO-0003Xh-B8
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 21:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbZAGUTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 15:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbZAGUTS
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 15:19:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:48096 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752383AbZAGUTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 15:19:17 -0500
Received: (qmail invoked by alias); 07 Jan 2009 20:19:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 07 Jan 2009 21:19:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pmLo2ibQpuCyf61Ltzt3pbA5Dxw3uYCVJZkHDe0
	hhJEl6tseE8GSu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.10.0901071159060.17115@alien.or.mcafeemobile.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104828>

Hi,

On Wed, 7 Jan 2009, Davide Libenzi wrote:

> On Wed, 7 Jan 2009, Johannes Schindelin wrote:
> 
> > Could it be that you misread my patch, and assumed that I faked an 
> > xdfenv?
> > 
> > I did not, but instead faked two mmfiles, which is only as simple as I did 
> > it because in git.git, we only have contiguous mmfiles.  (I recall that 
> > libxdiff allows for ropes instead of arrays.)
> > 
> > The way I did it has one big shortcoming: I need to prepare an xdfenv for 
> > the subfiles even if I already prepared one for the complete files.  IOW 
> > the lines are rehashed all over again.
> 
> I told you I just glanced at the code :)
> In that way, if you guys decide to merge this new algo, you'll need to 
> split the prepare from the optimize, and feed it with an already prepared 
> env.

Right.

> Before going that way, have you ever tried to tweak xdl_cleanup_records 
> and xdl_clean_mmatch to reduce the level of optimization, and see the 
> results you get? It is possible that you won't need two different algos 
> inside git.

No, I hadn't thought that libxdiff already determines uniqueness before 
actually running xdl_do_diff().

I also have to admit that I am not as clever as other people, and had 
quite a hard time figuring out as much as I did (for example, that rchg[i] 
== 1 means that this line is to be added/deleted, and that i is in the 
range 0, ..., N - 1 rather than 1, ..., N).

So it is quite possible that something patience-like can be done earlier.

However, I do not see a way to implement the recursion necessary for the 
patience diff.  Remember:

	patience(line range):
		find unique lines
		if no unique lines found:
			resort to classical diff
			return
		extract the longest common sequence of unique common lines
		between those, recurse

When recursing, previously non-unique lines can turn unique, of course.  
And I do not see how that recursion could be done before 
xdl_clean_mmatch(), short of redoing the hashing and cleaning records up.

Of course, it might well be possible, but I am already out of my depth 
reading something like "rdis0" and "rpdis1", and being close to despair.

:')

Ciao,
Dscho

		
