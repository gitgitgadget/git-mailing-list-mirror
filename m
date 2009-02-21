From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Sat, 21 Feb 2009 07:32:09 +0100
Message-ID: <499F9FE9.6050006@alum.mit.edu>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu> <20090220062543.GA27837@coredump.intra.peff.net> <499E8432.9010806@alum.mit.edu> <499F201E.2050106@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Sat Feb 21 07:40:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LalWs-0008GO-Cb
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 07:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZBUGcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 01:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbZBUGcX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 01:32:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:55936 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZBUGcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 01:32:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1L6WBT5000529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 21 Feb 2009 07:32:12 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <499F201E.2050106@datacom.ind.br>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110929>

Samuel Lucas Vaz de Mello wrote:
> Michael Haggerty wrote:
>> BTW, I don't want to trash "git cvsimport".  I'm not brave enough even
>> to try to implement incremental conversions in cvs2git.  So the fact
> 
> If I run cvs2git several times against a live cvs repo (using the
> same configuration), wouldn't it perform an incremental import?
> Is there anything that would make it produce different commits for
> the history?
> 
> I've just made a simple test here performing 2 imports (the 2nd with a
> dozen of new commits not in the 1st) and it seemed to work fine.
> 
> I know that it will take the same time/memory as the first import,
> but is there something that can break the repository or produce wrong
> data?

Cool, I'd never thought of that.  It's certainly not by design, but as
you've discovered, the interaction of cvs2git and git *almost* combine
to give you an incremental import.

Alas, it is only "almost".  There are many things that can happen in a
CVS repository that would cause the overlapping part of the history to
disagree between runs of cvs2svn.  The nastiest are things that a VCS
shouldn't really even allow, but are common in CVS, like

- Retroactively adding a file to a branch or tag.  (This is a
much-beloved feature of CVS.)  Since CVS doesn't record the timestamp
when a symbol is added to a file, cvs2git tries (subject to the
constraints of other timestamps) to group all such changes into a single
changeset.  So the creation of the symbol would look different in runs N
vs N+1 of cvs2git--containing different files and likely with a
different timestamp.

- Renaming a file "with history" by renaming or copying the associated
*,v file in the repository.  This retroactively changes the entire
history of that file and thus of all changesets that involved changes to
that file.

- Changing the "text vs binary" or keyword expansion mode of a file.
These properties apply to all revisions of a file, and therefore also
have a retroactive effect.

But even aside from these retroactive changes, the output of cvs2git is
not deterministic in any practical sense (though I've tried to make it
deterministic given *identical* input).  The problem is that there are
so many ambiguities in a CVS history (because CVS doesn't record enough
information) that cvs2git has to use heuristics to decide what
individual file events should be grouped together as commits.  The
trickiest part is that the graph of naively inferred changesets can have
cycles in it, and cvs2git uses several heuristics to decide how to split
up changesets so as to remove the cycles.  (See our design notes [1] for
all the hairy details.)  The CVS commits made between runs N and N+1
could easily change some of the heuristics' decisions, giving different
results even for the overlapping part of the history.

To add robust support for incremental commits to cvs2git would require
run N+1 to know about the decisions made in run N, to avoid
contradicting them.

I wonder what would happen if one would treat the results of cvs2git
conversions N and N+1 as two separate repositories and merge them using
git.  In many cases the merge would probably be trivial, and most
conflicts (except retroactive file renaming!) would probably tend to be
in the recent past and therefore resolvable manually.  At least the
repository shouldn't silently become corrupted, which can happen with
other incremental conversion tools.

The final problem is that cvs2git conversions of large CVS repositories
are quite time-consuming, so using it for incremental conversions of
large repositories would be painful.  No doubt it could be speeded up
considerably, especially if conversion N+1 was privy to the results of
conversion N.

These are all challenging problems and I would welcome volunteers and be
happy to get them started.

Michael

[1] http://cvs2svn.tigris.org/svn/cvs2svn/trunk/doc/design-notes.txt
