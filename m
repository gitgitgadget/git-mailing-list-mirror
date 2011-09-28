From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Annotated branch =?UTF-8?B?4omIIGFubm90YXRlZCB0YWc/?=
Date: Wed, 28 Sep 2011 06:23:23 +0200
Message-ID: <4E82A13B.2080509@alum.mit.edu>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <1316729362-7714-1-git-send-email-gitster@pobox.com> <4E7C49CF.60508@drmicha.warpmail.net> <20110923201824.GA27999@sigill.intra.peff.net> <4E7DEC4A.3050900@drmicha.warpmail.net> <20110927215843.GE5176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 28 06:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8lgJ-00069P-A5
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 06:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308Ab1I1EXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 00:23:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:38914 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1I1EXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 00:23:34 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEB79A.dip.t-dialin.net [84.190.183.154])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8S4NNuA025745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 28 Sep 2011 06:23:24 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <20110927215843.GE5176@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182292>

On 09/27/2011 11:58 PM, Jeff King wrote:
> On Sat, Sep 24, 2011 at 04:42:18PM +0200, Michael J Gruber wrote:
>> I really think the only issue is remote refnames. As Junio points out,
>> they are local by nature. OTOH, you typically use a non-renaming refspec
>> which puts them under refs/remotes/foo/bar with "bar" being the same
>> name as the local one on the remote, foo something you have chosen. So,
>> teaching the code that the note for
> 
> If they are local by nature, is it worth putting them into a notes tree
> at all? That provides versioning and backup. But I wonder if it is worth
> the hassle, when one could just put them in the config.

I don't think that branch descriptions should be local-only.  They would
be a good way to share information with others about work in progress.

It seems to me that an annotated branch is very much like an (unsigned)
annotated tag, except that it is movable and disposable like a normal
branch.  What would be the ramifications of using an annotated-tag-like
object to record metainformation about a branch?  (Let's just call it an
"annotation object" for this discussion.)

* The branch would point not at a commit but at an annotation object
that points at a commit.

* Obviously, a new annotation object would have to be written every time
the branch is updated.

  * Presumably, by default, the old description would be copied from the
old annotation object to the new one; the committer would be set to
those of the user doing the update.

  * The old annotation object would become unreachable after every
branch update, though locally it would still be reachable via the
branch's reflog [1].

* Creating a new branch from an annotated branch should perhaps open an
editor to allow the user to set a new comment.  If the user deletes the
whole comment in the editor, then an unannotated branch is created
instead of an annotated branch.

* We would need rules for merging annotation objects:

  * There is no such thing as a fast-forward merge to an annotated
branch, because the merged-from branch, even if annotated, can never
have the merged-to annotation object in its history.  So proceed to the
following rules.

  * If both branches are unannotated, then the result should be an
unannotated branch (like today).

  * If both branches have the same comment, the comment should be
carried over to the result without prompting.

  * If the merge-to branch is annotated and the merge-from branch is
not, keep the merge-to branch's annotation.

  * If the merge-to branch is unannotated and the merge-from branch is
annotated, the result should be a conflict.  This cannot be resolved
automatically because there are two likely scenarios:

    * A remote branch is being merged into a remote-tracking branch.  In
this case somebody upstream probably added a comment to the branch, and
one would like to preserve this comment in a local annotated branch.

    * A feature branch is being merged back to mainline.  In such a case
one would *not* like to carry over the branch annotation (which
presumably describes the feature that was developed on the branch),
though it would often be convenient to integrate the merged-from branch
annotation into the log message of the merge commit.

    I'm not sure how to let the user distinguish between the two cases
above, but it probably involves $EDITOR.

  * If the merge-to branch and the merge-from branch have conflicting
annotations, there are two possibilities much like in the previous case.

* Annotated tag objects include the name of the tag that is being
annotated.  Annotated branch objects should *not* include this
information, because it does not carry across from one repo to another
when branches are renamed.  (Perhaps the presence/absence of the tag
name could be what distinguishes an (unmovable) annotated tag object
from a (movable) annotated branch object.)

It would even be possible to allow signatures in the annotated objects;
these could play the role of push certificates.  Whenever a signed
annotated branch is updated, the signature would go away (it would
probably be too cumbersome to prompt the user to generate it a new
signature for every branch update).  It should be easy to add a
signature to an existing annotated or unannotated branch (writing a new
annotation object, of course).

ISTM that the semantics would be very close to what is desired, and
would satisfy a few needs: a place to describe work-in-progress in a
sharable way, branch descriptions that can be used for constructing pull
requests and merge commit messages, and (optionally) a way to implement
signed pushes.  It would surely be a lot of work to implement, but being
based on annotated tags would mean that a lot of code, documentation,
and training would be common to the two concepts.

Michael

[1] If the retention of annotation history were considered a
requirement, the annotation object could record as a "parent" the object
name of the annotation object that it is succeeding.  But I don't think
that this is a good idea; it would make branches too heavyweight and
every branch update would be recorded permanently, both of which are
contrary to the git philosophy.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
