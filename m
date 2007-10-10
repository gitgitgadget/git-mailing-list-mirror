From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Problem with git-cvsimport
Date: Wed, 10 Oct 2007 04:34:34 +0200
Message-ID: <470C3A3A.2070809@alum.mit.edu>
References: <470B491F.9020306@jentro.com> <200710091447.50501.wielemak@science.uva.nl> <470B8049.1090308@samba.org> <47065A5D-D170-4D11-A802-85376F97F8D2@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Pasch <thomas.pasch@jentro.com>, git@vger.kernel.org,
        Jan Wielemaker <wielemak@science.uva.nl>,
        "Gerald (Jerry) Carter" <jerry@samba.org>,
        dev <dev@cvs2svn.tigris.org>
To: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>
X-From: dev-return-2100-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Wed Oct 10 04:34:57 2007
Return-path: <dev-return-2100-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IfRPU-0000Ox-CL
	for gcvscd-dev@gmane.org; Wed, 10 Oct 2007 04:34:56 +0200
Received: (qmail 12896 invoked by uid 5000); 10 Oct 2007 02:34:49 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 12883 invoked from network); 10 Oct 2007 02:34:49 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CADLXC0fAbSoIh2dsb2JhbACDJYskAgEICik
X-IronPort-AV: E=Sophos;i="4.21,251,1188802800"; 
   d="scan'208";a="86272564"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.13) Gecko/20070824 Thunderbird/1.5.0.13 Mnenhy/0.7.5.666
In-Reply-To: <47065A5D-D170-4D11-A802-85376F97F8D2@orakel.ntnu.no>
X-Enigmail-Version: 0.94.2.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60458>

Eyvind Bernhardsen wrote:
> On 9. okt.. 2007, at 15.21, Gerald (Jerry) Carter wrote:
>> I would actually plug using cvs2svn to convert directly to git.
>> See this thread for Michael's original announcement.
>>
>>   http://marc.info/?l=git&m=118592701426175&w=2
> 
> Seconded!  I've tried git-cvsimport, parsecvs, fromcvs, and cvs2svn on
> my employer's many large CVS modules, and cvs2svn is the only one that
> has never mangled an import.

I'm glad this worked.

> That said, it is a work in progress, so there are some caveats:
> 
> [...]
> 
> * Tags each get a branch with a single commit, with the actual tag
> pointing to that commit.  This makes it harder than necessary to figure
> out what the history looks like; gitk's default view won't show any
> tags, for example, since it only shows the master branch and not the
> single-commit tag branches.

I just fixed this in cvs2svn trunk r4213.  Now it reuses a single branch
called 'refs/heads/TAG.FIXUP' whenever it needs to make a tag fixup
branch, and it resets that branch when done.  (Resetting the tag fixup
branch changes it to 0000000000000000000000000000000000000000 but
doesn't really delete it; I don't know the ramifications of that but at
least it doesn't appear in gitk output any more.)

> * Branches all get a useless commit at their branch point.  All branches
> from the main branch appear to be merged from the vendor branch (ie, the
> useless commit has the vendor branch as an extra parent), which might
> make sense to someone who knows what the vendor branch is for, but makes
> no sense to me.  This combined with the previous point makes "gitk
> --all" look needlessly spaghetti-like if you have a slightly complicated
> CVS history.

I assume that the "useless commit" that you are referring to is the one
with log message "This commit was manufactured by cvs2svn to create
branch 'BRANCH'."  Is that correct?

I'm not a git expert, so I don't know whether these commits are in fact
useless.  But let me explain the reason I put them in and you can tell
me whether it is nonsense.

When you branch a file in CVS, CVS notes that the branch exists in the
file but doesn't record an author, log message, or timestamp.  The
contents of a file just after it is branched are exactly the same as the
contents on the parent branch.  Moreover, different files can be added
to a branch from different parent branches.

The intended purpose of the "useless commit" in the git output of
cvs2svn is to record the fact that a branch was created, to record
exactly which files exist on the branch at the time it was created, and
to record the source branches of the file on the branch.

I imagine that *if* a branch is created with a single parent branch, and
*if* each and every file from the parent branch is added to the new
branch, then it is possible that the "useless commit" could be omitted.
 But this decision would require information that cvs2svn doesn't
currently have at that stage of the conversion, and keeping the
necessary records would be quite expensive.

But in the general case, it doesn't seem to me that the commits are
really useless.  Am I wrong?  If so, please tell me what should be
changed in the git-fast-import data that is output when a branch is
created (e.g., for the main-cvsrepos in the cvs2svn test suite).

Regarding the superfluous vendorbranch parent: vendor branches are an
obscure CVS feature for tracking upstream sources.  The file contents on
the vendorbranch are typically exactly the same as that on trunk, and if
a branch is created while the vendorbranch is active, CVS doesn't record
whether the branch's parent was trunk or the vendorbranch.  Haven't yet
built the heuristics into cvs2svn to make this decision more
intelligently, so sometimes "vendorbranch" is listed as a branch parent
when it could be omitted.

> To sum up, cvs2svn gets the important stuff right, but has some sharp
> corners you need to watch so you don't put an eye out.

Thanks for the feedback!

Michael

[1] http://www.kernel.org/pub/software/scm/git/docs/git-fast-import.html
