From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] git-am: emit usage when called w/o arguments and
 w/o patch on stdin
Date: Wed, 28 Jan 2009 10:52:51 -0800
Message-ID: <7v3af3s1oc.fsf@gitster.siamese.dyndns.org>
References: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sverre@rabbelier.nl
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 19:54:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSFYR-00012M-Bc
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbZA1SxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbZA1SxA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:53:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZA1Sw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:52:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6813D942E0;
	Wed, 28 Jan 2009 13:52:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 02479942DC; Wed,
 28 Jan 2009 13:52:52 -0500 (EST)
In-Reply-To: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed, 28 Jan 2009 10:03:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0C32EBC-ED6C-11DD-957C-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107564>

Jay Soffian <jaysoffian@gmail.com> writes:

> When git am is called w/o arguments, w/o a patch on stdin and the user hits
> ctrl-c, it leaves behind a partially populated $dotest directory. After this
> commit, it emits usage when called w/o arguments and w/o a patch on stdin.
>
> Noticed by Sverre Rabbelier
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> Change from v2: make Junio happy by no longer removing $dotest if git-am is
> interupted while mailsplit is running.

Sorry, I think I was misleading.  I did not mean that "Also" change was a
bad thing to do.  It just did not logically belong to this "is it coming
from the tty?" issue.

While you are looking at "am", I have a complaint about a very rough and
dangerous edge around a relatively new "usability" feature.

A scenario goes like this.

 (1) You have a patch, try to apply it to one existing topic branch

	$ git checkout myTopic
	$ git am some-patch

 (2) You see it does not apply, you realize that the patch is more suited
     for another branch.

	$ git checkout anotherTopic
        $ git am

 (3) It still does not apply, you examine the patch, and find flaws in its
     logic and decide not to apply it at all anywhere.

	$ git am --abort

After this, the tip of anotherTopic is updated to where the tip of myTopic
was!

Being able to remove the state directory $GIT_DIR/rebase-apply from the
command line is very useful when you want to get a clean slate to run
another git-am session, and often it is handy to abort the application of
the whole series when you do so (the latter is done by resetting the
original branch back to the original commit).  But being able to switch
branches after starting application of patches from one mailbox is also
useful in practice, so at least the latter should not be done blindly when
the user asks for --abort.  We definitely need some safety here.

Perhaps....

 (1) If --abort is asked for and you are on a branch different from where
     you started your "git am" session from, error out without doing
     anything.

 (2) Add --clean that does what the current --abort does, except for the
     rewinding of the HEAD.

The second one may be useful regardless of the "rough and dangerous edge"
issue above.  The early parts of the series may be useful and you may want
to keep the result from their application, while discarding the remainder
of the series.

Hmm?
