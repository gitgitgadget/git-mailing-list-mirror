From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git commit generation numbers
Date: Thu, 21 Jul 2011 08:03:09 -0400
Message-ID: <1311249789.9745.30.camel@drew-northup.unet.maine.edu>
References: <20110720221632.14223.qmail@science.horizon.com>
	 <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, nico@fluxnic.net,
	anthonyvdgent@gmail.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Jul 21 14:05:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjs0r-0008TK-Rm
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 14:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab1GUMFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 08:05:52 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:41247 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab1GUMFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 08:05:51 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p6LC3DpA028907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Jul 2011 08:03:18 -0400
In-Reply-To: <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p6LC3DpA028907
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1311854621.06698@irhC9UIGQ+IgY3B0IP+waA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, 2011-07-20 at 16:26 -0700, david@lang.hm wrote:
> On Wed, 20 Jul 2011, George Spelvin wrote:
> 
> >> The alternative of having to sometimes use the generation number,
> >> sometimes use the possibly broken commit date, makes for much more
> >> complicated code that has to be maintained forever.  Having a solution
> >> that starts working only after a certain point in history doesn't look
> >> eleguant to me at all.  It is not like having different pack formats
> >> where back and forth conversions can be made for the _entire_ history.
> >
> > It seemed like a pretty strong argument to me, too.
> 
> except that you then have different caches on different systems. If the 
> generation number is part of the repository then it's going to be the same 
> for everyone.

I keep hearing (reading) people stating this utterly unfounded argument.
The fact is that for any work not yet integrated back into a shared
repository it just isn't true--and even after upstream integration the
truth of such a statement may be limited.

I have not read yet one discussion about how generation numbers [baked
into a commit] deal with rebasing, for instance. Do we assign one more
than the revision prior to the base of the rebase operation or do we
start with the revision one after the highest of those original commits
included in the rebase? Depending on how that is done
_drastically_different_ numbers can come out of different repository
instances for the same _final_ DAG. This is one major reason why, as I
see it, local storage is good for generation numbers and putting them in
the commit is bad. 

I have no problem with putting an _advisory_ "revision number" in the
commit. It would not be expected to have a proper "1-to-1 and onto"
functional association with the _final_ DAG, but it could potentially
get us some nice benefits. We would still need to answer questions like
the one I ask above, but it would hurt less to change if we need to.

One other sane option that was mentioned at least once in passing was to
store the generation number in some Git "filesystem-level" object. This
could then be reconciled with each "git gc" or "git fsck" operation if
not more often. This is less ad-hoc and messy than a separate cache,
becomes amenable to the standard tool-set, and always gets updated (no
invalid cache). If an _advisory_ revision number is available in commits
that are sent along those could conceivably be used to help build up the
local git-fs generation numbers more quickly. (If a "git pull" is issued
to our repo, or we push to another, we don't send the generation numbers
locally stored--we expect the git-fs machinery to regenerate those on
the fly.)

I may not be one of the "resident rocket scientists," but that's how I
see it.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
