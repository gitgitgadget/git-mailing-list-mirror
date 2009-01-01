From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 1 Jan 2009 17:38:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 17:39:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIQZg-0006wn-IC
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 17:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbZAAQhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 11:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbZAAQhr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 11:37:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:51813 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755827AbZAAQhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 11:37:46 -0500
Received: (qmail invoked by alias); 01 Jan 2009 16:37:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 01 Jan 2009 17:37:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zUfJJrfHznd09bvq4EoImce88znEf0WRoEjqoD3
	3vZ0onrreDcY2b
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081104152351.GA21842@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104298>


Nothing fancy, really, just a straight-forward implementation of the
heavily under-documented and under-analyzed paience diff algorithm.

One thing is a bit ugly: the libxdiff interface does not allow to
calculate diffs of ranges of lines.  So instead of reusing an initialized
environment (with line hashes and all), the simple structure of mmfile_t
is exploited to fake an mmfile_t of a file _part_, reusing the file's
buffer.

And this mmfile_t pair gets a new environment, recalculating hashes and 
all.

Davide, I think it would be easier to refactor xdl_do_diff() to take line
ranges, and use that interface both in xpatience.c and in xmerge.c.  
(Although I do not know if you took xmerge.c at all; you seemed a bit 
reluctant about it back when I sent it to you.)

For those interested in studying the code, I suggest starting with the 
short comment at the beginning of xpatience.c and then working yourself up 
from the end (i.e. xdl_do_patience_diff()).

It might be a good idea to think about using this code in our merging code
once it is well reviewed and tested, as it might help a substantial number
of otherwise non-trivial merge conflicts.

Oh, and the bash completions are so trivial I did not even bother to test
them.

Happy new year.

Johannes Schindelin (3):
  Implement the patience diff algorithm
  Introduce the diff option '--patience'
  bash completions: Add the --patience option

 Documentation/diff-options.txt         |    3 +
 Makefile                               |    2 +-
 contrib/completion/git-completion.bash |    2 +
 diff.c                                 |    2 +
 t/t4033-diff-patience.sh               |  168 ++++++++++++++
 xdiff/xdiff.h                          |    1 +
 xdiff/xdiffi.c                         |    3 +
 xdiff/xdiffi.h                         |    2 +
 xdiff/xpatience.c                      |  374 ++++++++++++++++++++++++++++++++
 9 files changed, 556 insertions(+), 1 deletions(-)
 create mode 100755 t/t4033-diff-patience.sh
 create mode 100644 xdiff/xpatience.c
