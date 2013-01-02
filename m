From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Tue, 1 Jan 2013 19:33:44 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130102003344.GA9651@thyrsus.com>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 01:34:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqCIC-0000id-8O
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 01:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab3ABAea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 19:34:30 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59838
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab3ABAe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 19:34:29 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id A916044151; Tue,  1 Jan 2013 19:33:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212478>

Junio C Hamano <gitster@pobox.com>:
> So..., is this a flag-day patch?
> 
> After this is merged, users who have been interoperating with CVS
> repositories with the older cvsps have to install the updated cvsps
> before using a new version of Git that ships with it?

Yes, they must install an updated cvsps. But this is hardly a loss, as
the old version was perilously broken.

There was an error or typo in the branch-analysis code, dating from
2006 and possibly earlier, that meant that branch root points would
almost always be attributed to parent patchsets one patchset earlier
than they should have been.  Shocked me when I found it - how was this
missed for six years?

Because of the way the analysis is done, this fundamental bug would
also cause secondary damage like file changes near the root point
getting attributed to the wrong branch.  In fact, this is how I
first spotted the problem; my test suite exhibited this symptom.

And mind you this is on top of ancestry-branch tracking not working -
two separate bugs that could interact in ways I'd really rather not
think about.  The bottom line is that every import of a branchy CVS
repo with a pre-3.x version of cvsps is probably wrong.

The old git-cvsimport code was doing its part to screw things up, too.
At least three of the bugs on its manual page are problems I couldn't
reproduce using a bare cvsps instance, even the old broken version.

>                                                    As long as
> they update both cvsps and cvsimport, they can continue using the
> existing repository to get updates from the same upstream CVS
> repository without losing hisory continuity?

Yes, but in that case I would strongly advise re-importing the entire
CVS history, as the portion analyzed with 2.2b1 and earlier versions
of cvsps will almost certainly have been somewhat garbled if it
contains any branches.

> I would have preferred an addition of "git cvsimport-new" (or rename
> of the existing one to "git cvsimport-old"), with additional tests
> that compare the results of these two implemenations on simple CVS
> history that cvsimport-old did *not* screw up, to ensure that (1)
> people with existing set-up can choose to keep using the old one,
> perhaps by tweaking their process to use cvsimport-old, and (2) the
> updated one will give these people the identical conversion results,
> as long as the history they have been interacting with do not have
> the corner cases that trigger bugs in older cvsps.
> 
> Or am I being too conservative?

I think you are being too conservative.  This patch is *not* a mere
feature upgrade. The branch-analysis bug I found three days ago is not
a minor problem, it is a big ugly showstopper for any case beside the
simplest linear histories.  Only linear histories will not break.

'People with existing set-ups' should absolutely *not* 'keep using the
old one'; we should yank that choice away from them and get the old
cvsimport/cvsps pair out of use *as fast as possible*, because it
silently mangles branchy imports.

Accordingly, giving people the idea that it's OK to use old and new
versions in parallel would be an extremely bad idea.  I would go so
far as to call it irresponsible.

Here is what I have done to ease the transition:

If you try to use old git-cvsimport with new cvsps, new cvsps will detect
this and ship a message to stderr telling you to upgrade

If you try to use new git-cvsimport with old cvsps, old cvsps will complain
of an invalid argument and git-cvsimport will quit.

As for testing...cvsps now has several dozen self-tests on five
different CVS repositories, including improved versions of the
t960[123] tests.  I will keep developing these as I work on bringing
parsecvs up to snuff.

I don't think there is a lot of point in git-cvsimport having its own
tests any more.  If you read it I think you'll see why; it's a much
thinner wrapper around the conversion engine(s) than it used to be. In
particular, it no longer does its own protocol transactions to the
CVS server.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
