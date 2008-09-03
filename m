From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 03 Sep 2008 00:50:43 -0700
Message-ID: <7vprnld5ws.fsf@gitster.siamese.dyndns.org>
References: <20080903072011.GA14252@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 03 09:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kan9j-0003Ry-1p
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 09:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbYICHux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 03:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbYICHux
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 03:50:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYICHuw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2008 03:50:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 28616723B2;
	Wed,  3 Sep 2008 03:50:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 53ED4723B1; Wed,  3 Sep 2008 03:50:46 -0400 (EDT)
In-Reply-To: <20080903072011.GA14252@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Wed, 3 Sep 2008 09:20:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0754B540-798D-11DD-9EBA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94758>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> "git merge" produces a (IMHO) wrong result, when a commit from the
> branch that is to be merged in was cherry-picked into the current bra=
nch
> and later reverted on the original branch. Basically ignoring the
> revert.

There are a few issues around 3-way merge.

One thing is, what happened in between the common ancestor and the fina=
l
results on histories before you initiate the merges does not matter.  W=
hen
doing a 3-way merge, you look only at three endpoints: your final state=
,
their final state and the common ancestor between the two.

Your history looks like this:

            123a456
               3-----------?
              /           /
             /           /
            0-----1-----2
         123456       123456

During the development between 0..2, your undecision might have caused =
the
contents of the file fluctuate back and forth many number of times, but=
 in
the end result, you (the one who went 0..1..2) decided that for your
development, you do not have to change the contents of that path.  The
path might have been a xyzzy.h file, and you once added an extern decl =
of
a function because you thought a function in xyzzy.c might be needed by
another file frotz.c, but it turned out that the function can stay priv=
ate
and you removed that extern decl from xyzzy.h and ended up in the same
state.

But the other person who built the history 0..3 decided that having the
change is better than not having it.  Perhaps his code does use the
function from some other place and needs an extern.

You are merging the two histories, which means by definition you trust
your decision and the other guys decision with equal weight.  And here =
is
another thing.

When you compare the path in question at 0 and 2, you see they are
identical.  And you are interpreting that "I say they MUST STAY THE SAM=
E,
while they say they want to change it some way, that is a conflict".

But in 3-way merge context, you do not interpret the fact that somethin=
g
is identical between 0..2 as "they MUST STAY THE SAME".  Instead, you r=
ead
it as "My history does not care what happens to that path -- if the oth=
er
guy wants to change it, I'll happily take it."

    Note.  I am not claiming that the above interpretation will always
    match what you would expect.  I am just explaining how the underlyi=
ng
    concept of 3-way merge works in general.  If you think about it in =
a
    realistic context, such as the "extern in xyzzy.h you did not need =
to
    add but the other guy needed to have", you'll realize that more oft=
en
    than not, "I do not care and let the other guy decide" interpretati=
on
    results in a more useful result.

That essentially boils down to three rules:

 (0) If both of you did not change anything, the final result won't hav=
e
     any change (obvious);

 (1) If you decided you do not have a need to change a path, but the ot=
her
     one saw a need, you take the change;

 (2) If you and the other one both wanted to change a path but in a
     different way, you need to merge at the contents level.

And you are seeing rule (1) in action.
