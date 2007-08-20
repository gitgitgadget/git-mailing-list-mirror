From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On writing builtin-reset.c, a question about git-reset.sh
Date: Sun, 19 Aug 2007 17:24:52 -0700
Message-ID: <7vir7b9hnv.fsf@gitster.siamese.dyndns.org>
References: <46C8D604.4090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 02:25:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMv4w-0002DU-DS
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 02:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbXHTAZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 20:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbXHTAZG
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 20:25:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbXHTAZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 20:25:05 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4925D1248F2;
	Sun, 19 Aug 2007 20:25:21 -0400 (EDT)
In-Reply-To: <46C8D604.4090203@gmail.com> (Carlos Rica's message of "Mon, 20
	Aug 2007 01:45:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56159>

Carlos Rica <jasampler@gmail.com> writes:

> Hi, I'm writing builtin-reset.c and
> I'm really stuck with a little code in
> git-reset.sh:
>
> if orig=$(git rev-parse --verify HEAD 2>/dev/null)
> then
> 	echo "$orig" >"$GIT_DIR/ORIG_HEAD"
> else
> 	rm -f "$GIT_DIR/ORIG_HEAD"
> fi
>
> My question is about when this condition
> could fail (and then the rm executed),...

When orig does not exist.  That is, when HEAD is a symref that
point at an unborn branch (e.g. between "git init" and your
first "git commit").  After "git reset" of any kind, we would
want to make sure that GIT_DIR/ORIG_HEAD points at the commit
you were previously at, and if orig is not there we do not want
anything in that file.

Another possibility would be if somebody wants to add an
unrelated branch to the repository [*1*].  This is against
recommended practice, but you could make your HEAD point at an
unborn branch using plumbing commands, or even by hand:

	$ echo 'ref: refs/heads/unrelated' >.git/HEAD

Your next commit will make a root commit that is pointed by
'refs/heads/unrelated' ref, but before that happens, we would
not want to have GIT_DIR/ORIG_HEAD if you did git-reset.

Now, you might wonder if "git reset" makes any sense from such a
state, and actually it does ;-)

	$ git init
        $ git remote add -f friend ../neighbour.git/
        $ git reset --hard friend/master

[Footnote]

*1* People often seem to want to do something like the html, man, and
todo branches in my public repository that do not share any history
with the primary development branches.  Perhaps they think it is cool
to do so, but it is not.  These independent branches originate from
different repositories, and are published in the same repository only
for easier distribution.  There is no reason for you (nor me) to
create such unrelated branches in a single originating repository.

A recommended procedure to publish independent branches in a single
repository is to push into one from separate, independent
repositories.  Starting an independent history in an existing
repository, like the main body of this message shows you how, is not
recommended.
