From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Problem with git-cvsimport
Date: Wed, 31 Oct 2007 05:42:09 +0100
Message-ID: <472807A1.8030804@alum.mit.edu>
References: <470B491F.9020306@jentro.com>	 <200710091447.50501.wielemak@science.uva.nl>	 <470B8049.1090308@samba.org>	 <47065A5D-D170-4D11-A802-85376F97F8D2@orakel.ntnu.no>	 <470C3A3A.2070809@alum.mit.edu>	 <F1176033-1C6E-43F3-9F47-3BDD5EC88A14@orakel.ntnu.no> <170fa0d20710301306o6b3798f9k72615eb811d871f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
        Thomas Pasch <thomas.pasch@jentro.com>, git@vger.kernel.org,
        Jan Wielemaker <wielemak@science.uva.nl>,
        "Gerald (Jerry) Carter" <jerry@samba.org>,
        dev <dev@cvs2svn.tigris.org>
To: Mike Snitzer <snitzer@gmail.com>
X-From: dev-return-2110-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Wed Oct 31 05:42:24 2007
Return-path: <dev-return-2110-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1In5PM-0004qE-An
	for gcvscd-dev@gmane.org; Wed, 31 Oct 2007 05:42:24 +0100
Received: (qmail 5018 invoked by uid 5000); 31 Oct 2007 04:42:13 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 5008 invoked from network); 31 Oct 2007 04:42:13 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAH6kJ0fAbSoIh2dsb2JhbACOZQIBCAop
X-IronPort-AV: E=Sophos;i="4.21,349,1188802800"; 
   d="scan'208";a="88428741"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.13pre) Gecko/20071023 Thunderbird/1.5.0.14pre Mnenhy/0.7.5.666
In-Reply-To: <170fa0d20710301306o6b3798f9k72615eb811d871f2@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62790>

Mike Snitzer wrote:
> On 10/10/07, Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no> wrote:
> ...
>> Thanks for making cvs2svn the best CVS-to-git conversion tool :)  Now
>> if it would only support incremental importing...
> 
> I second this question: is there any chance incremental importing will
> be implemented in cvs2svn?

Unfortunately, no, there is not much chance that I will implement this.
 I wouldn't be interested in a works-most-of-the-time solution, and a
reliable solution would take weeks to implement.

If somebody else wants to implement this feature, I would be happy to
help him get started, answer questions, discuss the design, etc.  Or if
somebody wants to sponsor the work, I might be able to justify working
on it myself.  But otherwise, I'm afraid it is unlikely to happen.

> I've not used cvs2svn much and when I did it was for svn not git; but
> given that git-cvsimport is known to mess up your git repo (as Eyvind
> pointed out earlier) there doesn't appear to be any reliable tools to
> allow for incrementally importing from cvs to git.

That's because it is quite a tricky problem, especially since CVS allows
history to be changed retroactively; for example,

- shift a tag to a different file revision

- add an existing tag to a new file or remove it from an old file

- delete ("obsolete") old revisions

- change files from vendor branches to main line of development

- even nastier server-side repository manipulations like deleting an RCS
file, renaming a file, etc.

These things really happen in the topsy-turvy CVS world; indeed, they
are a part of many organizations' standard workflow.

cvs2svn uses repository-wide information in the heuristics that it uses
to determine changesets, choose branch parents, fix clock skew, etc.
Therefore the naive approach of running a full conversion a second time
and just skipping over the revisions that were handled during the first
conversion would not even begin to work.  (I believe that this is the
approach of cvsps, which uses mostly local information to determine
changesets.)

I think the correct approach would involve recording the "frontier" of
the CVS repository, then at the next incremental conversion:

1. compare the current CVS repository to the recorded information

2. emit "fixup" changesets to reflect any CVS changes that happened
behind the previous "frontier".

3. emit changesets to reflect CVS changes beyond the frontier.

It is step 2 that is IMO the trickiest because it is so open-ended, and
modern SCMs don't allow all of the corresponding operations in any
straightforward way.  Presumably one would have to prohibit some of the
nastier CVS tricks and abort the incremental conversion if any are detected.

Furthermore, for many use-cases of incremental conversion the conversion
would have to run quickly.  Therefore, the incremental conversion code
should be written with a strong emphasis on achieving good performance.

Michael
