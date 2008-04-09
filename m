From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation	and	broken
 branch imports
Date: Wed, 09 Apr 2008 03:53:20 +0200
Message-ID: <47FC2190.3070303@alum.mit.edu>
References: <1207100091.10532.64.camel@gandalf.cobite.com>	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>	 <1207230582.17329.39.camel@gandalf.cobite.com>	 <47F5FA79.8010604@alum.mit.edu> <1207590845.17329.98.camel@gandalf.cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: David Mansfield <david@cobite.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 03:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjPVt-0004a8-4s
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYDIBx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbYDIBx3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:53:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59391 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYDIBx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:53:28 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m391rNEL015786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Apr 2008 03:53:24 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080227 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <1207590845.17329.98.camel@gandalf.cobite.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79066>

David Mansfield wrote:
> The design goal of cvsps was always simply to show who did what and in
> what chronological order.  However, just with that, it's impossible to
> use for the purpose it is currently being used for.

Good point.

I re-read the cvsps manpage and found the information about "FUNKY" and
"INVALID" tags.  I'd forgotten that cvsps does the right thing in some
cases by warning the user about tags that are beyond its abilities to
describe.  (But there are other problems that cvsps doesn't warn about;
see below.)

Then I looked in the git-cvsimport code to see how it deals with FUNKY
and INVALID tags.  It does the *wrong* thing by explicitly ignoring
these warnings (!).  IMHO git-cvsimport should notice the **FUNKY** and
**INVALID** annotations and at least output a warning to the user that
the associated tags may not have been converted correctly.

But cvsps makes some other symbol-related mistakes, presumably in the
name of simplification.  These problems make it impossible for
git-cvsimport to generate accurate branches and tags, even if it were to
use fixup branches internally.  Moreover, many of these are silent
failures; there is no way that git-cvsimport could even determine that
the cvsps output is inadequate.  For example, if I understand correctly:

- cvsps pretends that a tag or branch is applied to a single snapshot of
the repository on a single branch, even though in reality:

  - some files might have been left out of the tag/branch (cvsps doesn't
give any indication if this was the case).  If this tag/branch is
checked out, the files that were not tagged are erroneously included.

  - the revisions not being tagged might not have all existed
contemporaneously (cvsps indicates these cases by marking the tags
**FUNKY** or **INVALID**).

  - a tag can be applied to different files on different branches; e.g.,
a tag can contain file1:1.3 (from trunk) and file2:1.2.2.1 (from some
other branch).  cvsps seems to pick one branch as source without
indicating a problem.  The inevitable result in cvsps is that the tag
includes the wrong contents for some files with no way to detect the error.

- If there is no commit on a branch, cvsps ignores the branch entirely.
 (Maybe this is fixed by your recent patch?)

- If there are multiple tags applied to the same set of file revisions
(for example, a daily tag and a release tag), cvsps silently ignores all
but one of them.  This causes unavoidable data loss in git-cvsimport.

There are lots of more complicated scenarios that I haven't tested
against cvsps...

Granted, cvsps was not written to be usable for converters.  But
regardless of whether the output is being read by a human or by another
program, its output can be wrong, and there is often no way to tell from
the output that it had a problem.  Maybe cvsps could emit warning
annotations in more of the situations that it punts on, and
git-cvsimport could pass these warnings along to the end user?
Otherwise people will believe that git-cvsimport is converting their
repository accurately when in fact it often silently produces incorrect
output.

> The place where the fixup branch logic needs to be is in git-cvsimport,
> not in cvsps.  Better yet, get rid of git-cvsimport and replace it with
> cvs2git if it works better.  

cvs2git hopefully gives a more accurate conversion of a CVS repository
-- it handles all of the cases described above, plus many more [1] --
but it is much slower and can't work incrementally.  So there is
definitely still demand for something like git-cvsimport.

Michael

[1] http://cvs2svn.tigris.org/features.html
