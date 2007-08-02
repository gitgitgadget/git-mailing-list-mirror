From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 03 Aug 2007 01:19:34 +0200
Message-ID: <46B26686.3010002@alum.mit.edu>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <alpine.LFD.0.999.0708021340450.8184@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
        users@cvs2svn.tigris.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: users-return-1610-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Fri Aug 03 01:19:46 2007
Return-path: <users-return-1610-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IGjxG-0005eF-IB
	for gcvscu-users@gmane.org; Fri, 03 Aug 2007 01:19:42 +0200
Received: (qmail 24930 invoked by uid 5000); 2 Aug 2007 23:19:40 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 24918 invoked from network); 2 Aug 2007 23:19:40 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAEIDskbAbSoIemdsb2JhbACOEgEBCQo
X-IronPort-AV: i="4.19,215,1183359600"; 
   d="scan'208"; a="63480206:sNHT66338790"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <alpine.LFD.0.999.0708021340450.8184@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54640>

Linus Torvalds wrote:
> On Thu, 2 Aug 2007, Steffen Prohaska wrote:
>> Right now, I'd prefer the import by parsecvs because of the
>> simpler history. However, I don't know if I loose history
>> information by doing so. I'd start by a run of cvs2svn to validate
>> the overall structure of the CVS repository.
> 
> Well, once imported, you could just go through the branches and tags, and 
> just delete the ones you consider uninteresting, and then do a "git gc".
> 
> You'd want to re-pack after a fast-import anyway (regardless of the source 
> of the fast-import input), so maybe cvs2svn ends up giving you a bit 
> unnecessary info, but it should be easy enough to get rid of 
> after-the-fact.

The real goal is to get cvs2svn to include the useful information and
exclude the rest. :-)

I definitely want to address the problem of the helper branches used to
create tags.  This problem has has two aspects:

1. The helper branches should be deleted after the tag has been defined.
 I simply couldn't figure out how to do this using git-fast-import, and
git-fast-import complained when I tried to use a branch called
"TAG_FIXUP" without the "refs/head/" prefix.

2. The helper branch is not needed at all if an existing revision has
exactly the same contents as needed on the tag.  This requires cvs2svn
to keep a record of which files exist in the complete file tree on every
branch at every revision (which it can already do, though it is
expensive), and also to give it the smarts to choose the optimal tag
point (which it already does, except that it currently doesn't penalize
sources that require files to be deleted before making the tag).


If the problem is lots of seemingly-unnecessary merges involving a
vendor branch, then it is time for me or some other volunteer to add the
optimization of allowing branches to be grafted from the vendor branch
to trunk.  I know of the problem and have a good idea how to implement
it; it is just a matter of finding the time to get it done.


If the problem is unlabeled branches that can't be excluded (because
other branches or tags depend on them), then the real problem is that it
is not known which unlabeled branches in individual files correspond to
the same project-wide conceptual branch.  I have considered two
possibilities to improve this situation:

1. Allow unlabeled -- indeed any -- branches to be discarded even if
other branches or tags depend on them.  This could be done by
incorporating the content of the source revision (i.e., the revision on
the unlabeled branch that is going to be discarded) into the zeroth
revision of the daughter branch, then grafting the daughter onto the
branch from which the unlabeled branch sprouted.

2. Rename the unlabeled branches by figuring out which unlabeled branch
in fileA corresponds to which unlabeled branch in fileB, fileC, etc.
This would involve a tricky bit of matching file-wise dependency trees
onto one another to unify unlabeled branch labels, keeping in mind that:

  - The trees have other differences as well.
  - The unlabeled branch does not necessarily occur in every file.
  - There may be multiple unlabeled branches per file.

Michael
