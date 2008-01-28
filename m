From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 02:27:23 -0800
Message-ID: <7vy7aatfck.fsf@gitster.siamese.dyndns.org>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com>
	<7vhcgyuwsx.fsf@gitster.siamese.dyndns.org>
	<4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com>
	<vpqfxwi5ljf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"git mailing list" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJRDl-0000IL-AV
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 11:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYA1K1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 05:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbYA1K1g
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 05:27:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbYA1K1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 05:27:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B8213FF;
	Mon, 28 Jan 2008 05:27:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A654A13FE;
	Mon, 28 Jan 2008 05:27:29 -0500 (EST)
In-Reply-To: <vpqfxwi5ljf.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	28 Jan 2008 10:47:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71872>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>
>> Yes it helps but I still wonder whether thereis a "simpler" way to achive that.
>> Is it possible to split a patch selecting the hunk in git gui or any
>> other graphical
>> tool?
>
> You can apply the patch without commiting it, and them make several
> partial commits, by right-click "stage hunk for commit" in git-gui.

Yes, and you can do the same with "git add -i".  These tools are
not quite nice, as they encourage a wrong workflow of committing
what you haven't had as a whole in the work tree.  By
definition, you are making untested commits between your base
commit (that presumably was tested well) and your final commit
(that would also be tested well).

Ideally, once you have a perfect state (i.e. the shape of the
tree recorded by the last commit in your "split" series), you
should be able to make a commit, and walk backwards, removing
the fanciest "finishing touches" changes from the work tree
files, test it, and record it as a new commit between where you
are and one commit before it.  A possible workflow could be:

	$ work work work, now it is perfect.
	$ git commit -a -m 'Now it is perfect'
        $ edit away the fanciest bits
        $ test test, the basics still work.
        $ git commit --splice -a -m 'Almost there'

And the last "git commit --splice" would record the tree object
as a commit, whose parent is the parent of the current HEAD, and
record the tree of the current HEAD as a (rewritten) commit that
is a child of that commit.

Graphically, you would start from (X is "the perfect commit"):

	---o-------X

then "--splice" would create a new commit "W" and record the
same tree as X as a new commit X' that is a child of W:

             .--W---X'
            /
	---o-------X

There is no such tool yet, though.

The splitting you can do with "rebase -i" instead walks
forwards.  That also lets you test before you make commits in
each step.
