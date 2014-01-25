From: David Kastrup <dak@gnu.org>
Subject: How to substructure rewrites?
Date: Sat, 25 Jan 2014 13:44:59 +0100
Organization: Organization?!?
Message-ID: <877g9ocjsk.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 13:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W72cL-0001yG-2o
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 13:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbaAYMpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 07:45:14 -0500
Received: from plane.gmane.org ([80.91.229.3]:33030 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbaAYMpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 07:45:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W72bn-0001ia-9T
	for git@vger.kernel.org; Sat, 25 Jan 2014 13:45:11 +0100
Received: from x2f416b0.dyn.telefonica.de ([2.244.22.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Jan 2014 13:45:11 +0100
Received: from dak by x2f416b0.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Jan 2014 13:45:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f416b0.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:YlG4lUhluItUm/1zW5QKSZBMJWo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241066>

--=-=-=
Content-Type: text/plain


Hi,

I'm currently rewriting the internals of git-blame.  For the somewhat
academic example


--=-=-=
Content-Type: text/x-sh
Content-Disposition: inline; filename=blametest.sh

#/bin/sh

cd /tmp
rm -rf testit
mkdir testit
cd testit
git init
for inc in 8 4 3 7 2 9 5 6 1
do
    seq 252000 -$inc 0 > testfile
    git add testfile
    git commit -m "Run with increment $inc"
done
time git blame testfile >/dev/null

--=-=-=
Content-Type: text/plain


the performance of git-blame increases by 4000%.  It turns out that in
"real-world" bad cases, particularly after aggressively repacking
repositories, the gains are quite more modest.  I've seen a factor of 2
with source code and a factor of 3 with a large word list.  The bulk of
the remaining time is spent in system time (which has basically not
changed by my work), so it is likely that the repository gets read over
and over, calling for some better caching strategies.

So the question is how to restructure the work.  I want to put out a
"teaser" soonish but I think that there is little point in
substructuring the commits I have so far.  They start with a few
janitorial patches already in pu, but after that there is

commit 7c610731e9452f3e8c175ab7e7542eafed1c5b93
Author: David Kastrup <dak@gnu.org>
Date:   Sat Jan 25 13:19:17 2014 +0100

    wip

commit dca4c8c447b94e1a3f8f45874d5415665d503189
Author: David Kastrup <dak@gnu.org>
Date:   Wed Jan 22 01:16:06 2014 +0100

    wip

commit f64b41c472442ae9971321fe8f62c3885ba4d8b7
Author: David Kastrup <dak@gnu.org>
Date:   Sun Jan 19 02:16:21 2014 +0100

    blame.c: Let output determine MORE_THAN_ONE_PATH more efficiently

commit 607b094537d6fe4a75cf9a297470966bda934c73
Author: David Kastrup <dak@gnu.org>
Date:   Mon Jan 13 18:06:06 2014 +0100

    wip

commit 1cd4e172533fb55793d02147c9596c59f7b05343
Author: David Kastrup <dak@gnu.org>
Date:   Sun Jan 19 01:30:02 2014 +0100

    Reorganize blame data structures

commit 5ab2add67d5fcf3837623a7bc028bcaec1006cc4
Author: David Kastrup <dak@gnu.org>
Date:   Sun Jan 19 01:29:28 2014 +0100

    Add blame_sort function for sorting a blame list

commit d3745752968617979878962ead957a6b5f829f0b
Author: David Kastrup <dak@gnu.org>
Date:   Sun Jan 19 01:28:22 2014 +0100

    Add merge_blame function for merging two sorted blame lists.


As it can easily be guessed, the "add xxx function" commits are
basically adding not-yet-used code (and so will not disrupt
compilation), but everything starting with "Reorganize blame data
structures" up until the final commit will not work or compile since the
code does not match the data structures.

So there is little point in substructing all that, right?  Even
something seemingly isolated like

commit f64b41c472442ae9971321fe8f62c3885ba4d8b7
Author: David Kastrup <dak@gnu.org>
Date:   Sun Jan 19 02:16:21 2014 +0100

    blame.c: Let output determine MORE_THAN_ONE_PATH more efficiently

is not really useful as a separate commit since while it does implement
a particular task, this is done starting with non-working code relying
on no-longer existent data structures.

I'm seriously considering squashing all that in a single commit.  It
seems like it would be utterly pointless to introduce artificially
working in-between states that simulate a partial "migration" to new
data structures that never happened.  Where the algorithmic setup
happened, I rewrite from scratch, and it's pretty absurd to match and
marry efficient and inefficient half-algorithms.

Which brings us to point two: the "teaser" part.  The current stuff has
#if 0/#endif around the old implementation of the expensive -M and -C
options.  They are currently not operative due to the mismatch to data
structures.  Obviously, that makes the change unsuitable for putting
into master or anywhere close.

I'd still want to solicit feedback: when not using those options (which
will likely cause me another week of headaches), the code is working
well and delivering identical information.  So should I just squash the
stuff and leave just the commits that made it into pu separate (so that
people may git-am whether or not they already have those commits)?

In general, the rule is likely "any commit should not create a
non-working state" right?

-- 
David Kastrup

--=-=-=--
