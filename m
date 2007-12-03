From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Use regex for :/ matching
Date: Mon, 03 Dec 2007 10:17:18 -0800
Message-ID: <7vbq97iqxd.fsf@gitster.siamese.dyndns.org>
References: <20071203043258.GA16658@coredump.intra.peff.net>
	<Pine.LNX.4.64.0712031052410.27959@racer.site>
	<20071203173022.GA19219@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFrU-0007Z6-3u
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbXLCSRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbXLCSRY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:17:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34509 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbXLCSRY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:17:24 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 25B242F9;
	Mon,  3 Dec 2007 13:17:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 88FD59C78E;
	Mon,  3 Dec 2007 13:17:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66939>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 03, 2007 at 10:55:15AM +0000, Johannes Schindelin wrote:
>
>> Except that I did not support ".." (does yours?), _and_ that my patch is 
>> not as nice as yours.
>
> No, I didn't. I'm not sure it is sane, since :/ can contain free-form
> text (and with a regex, .. is not that unlikely). And you can always do
> git-log --not :/foo :/bar
>
>> But then, my patch also works when save_commit_buffer == 0.  But I can 
>> refactor this into its own patch, since it really is a separate issue.
>
> Agreed.

What I found mildly irritating in the current syntax (and that is the
primary reason why I use it rarely) is that there is no way to tell it
to dig from a particular ref (e.g. "on master branch, find the latest
commit whose title matches this string").

For "git-log", you can do "git log master --grep=string -1" to emulate
this, and it extends to "git log maint..master --grep=string" to limit
the revision ranges and "find all not just latest" very naturally.

Also once we start to talk about supporting "ranges", I suspect the
semantics becomes fuzzier, because ":/" is defined as an extended SHA-1
expression that resolves to a single commit.  ":/A..:/B" is probably
unneeded as you can always say "^:/B :/A", but making ":/A" (we need an
extended syntax to differentiate from the singleton case we currently
have) to mean "all the commits that match this pattern" is something
people might be interested to see.  Unfortunately, that does not define
a revision range operator but a operator that gives back set of commits
that are not consecutive, primarily good for giving to nothing but "git
show", and again "git log --grep" would emulate it just as well.

So in short:

 * I do not think extending it to mean a set of commits (with some
   definition of how the set is computed) is a good idea.  It can stay
   "name one commit that matches this string" without losing usefulness,
   and I think it should;

 * The definition of the "match" can be tweaked and introducing regexp
   might be a good way;

 * The definition of the "match" may become more useful if we can limit
   which refs to dig from.
