From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Fri, 21 Dec 2012 13:47:52 +0100
Message-ID: <50D45A78.3020104@drmicha.warpmail.net>
References: <20121211153903.7522d6b0@chalon.bertin.fr> <7vd2yg8ngk.fsf@alter.siamese.dyndns.org> <20121212094432.6e1e48c8@chalon.bertin.fr> <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch> <20121217114058.449cbc3c@chalon.bertin.fr> <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com> <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org> <20121218120058.0c558ba5@chalon.bertin.fr> <7vehinibpc.fsf@alter.siamese.dyndns.org> <87ip7yp4mf.fsf@pctrast.inf.ethz.ch> <7vvcbx956f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Yann Dirson <dirson@bertin.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 13:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm21M-0005qU-JH
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 13:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab2LUMrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 07:47:55 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35561 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750871Ab2LUMrx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 07:47:53 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 881B52093C;
	Fri, 21 Dec 2012 07:47:53 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 21 Dec 2012 07:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=hYIRJRYM7I95d0q8g5q9ck
	nn/Rg=; b=JMY0RE9Cm20cxZU+G7YZhGfH6DHh2wGHZU3Ql42xaddZcIeO3g7fJI
	VqNk6DIE4s0HQ8az57Dn0lr0nPYi9l1TreRhCXPdOQkvsyWOjsrZkHsjLlqMBRw0
	7AxgCBrpo4i/wsnUl3Cdg5CgH+GKY5JUnsNrufjsfKvrlFFhSbhtc=
X-Sasl-enc: 4Tf0f36HgjMlkfUfob0hRAvuOPXOvcz5m1h37r5nmTfb 1356094073
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 64F658E06E7;
	Fri, 21 Dec 2012 07:47:52 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vvcbx956f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211969>

While replace refs are much more general than grafts, it seems the two
main uses are:

- grafts (change the recorded parents for a commit)
- svn cleanup (convert tagging commits into tag objects)

The latter one being quite a special case already.

The script below has helped me move from grafts to replace objects.
While not being super clean, something like it may be fit for contrib.

I think we ought to help John Doe get along with parents, while we can
safely leave most more advanced operations to people who know how to
edit a raw object file. Putting that facility into "git-commit" seems to
be too encouraging, though - people would use replace when they should
use amend or rebase-i. I'd prefer a special git-replace mode (be it
"--graft" or "--graft-commit") which does just what my script does. We
could add things like "--commit-tag" later, a full blown
"object-factory" seems like overkill.

Michael

--->%---

#!/bin/sh

die () {
	echo "$@"
	rm -f "$commitfile"
 	exit 1
}

warn () {
	echo "$@"
}

test $# -gt 0 || die "Usage: $0 <commit> [<parent>]*"

for commit
do
	git rev-parse --verify -q "$commit" >/dev/null || die "Cannot parse
$commit."
	test x$(git cat-file -t $commit) == "xcommit" || die "$commit is no
commit."
done

commit="$1"
shift

commitfile=$(mktemp)

git cat-file commit "$commit" | while read a b
do
	if test "$a" != "parent"
	then
		echo $a $b
	fi
	if test "$a" == "tree"
	then
		for parent
		do
			echo "parent $(git rev-parse $parent)"
		done
	fi
done >$commitfile
hash=$(git hash-object -t commit -w "$commitfile") || die "Cannot create
commit object."
git replace "$commit" $hash
rm -f $commitfile
