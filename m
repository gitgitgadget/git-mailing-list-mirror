From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dose git-fetch need --reference option like git-clone?
Date: Sun, 11 Nov 2007 00:36:20 -0800
Message-ID: <7vsl3dgovv.fsf@gitster.siamese.dyndns.org>
References: <46dff0320711110009y713c7d38q7b1457c92daecef6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Yin Ping" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8J7-00057u-K2
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbXKKIg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbXKKIg0
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:36:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44890 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXKKIgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:36:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7D8972F2;
	Sun, 11 Nov 2007 03:36:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0800693791;
	Sun, 11 Nov 2007 03:36:43 -0500 (EST)
In-Reply-To: <46dff0320711110009y713c7d38q7b1457c92daecef6@mail.gmail.com>
	(Yin Ping's message of "Sun, 11 Nov 2007 16:09:55 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64429>

"Yin Ping" <pkufranky@gmail.com> writes:

> If I already have a cloned remoteA on local machine (say
> /path/to/remoteACloned), I want to do following to reduce the net
> traffic as git-clone:
> git fetch --reference /path/to/remoteACloned remotedA
>
> Is this reasonable? Or is there already a resolution for this case?

Resolution, meaning "No, that's not a good thing and we refuse
to support such an option"?

No, there is no such thing.

I think what you are talking about is a reasonable thing to
want.  It would have been easier to hack in back when git-fetch
was a script, but now you would need to work a bit harder in the
C code.  On the other hand, however, I suspect the resulting
code would be cleaner without having to actually create and
delete temporary refs in refs/reference-tmp/ namespace but fake
them only in-core, with a proper transport API enhancements.

But if you only want a quick-and-dirty workaround, you can
manually do refs/reference-tmp and objects/info/alternates dance
that is done by git-clone before running a git-fetch from such
"nearby" remote.

I strongly suspect that an approach not to use temporary refs on
the filesystem would be needed for robustness if we were to do
this for real inside git-fetch as a real solution, so that we
would not leave them behind when interrupted.  This is not such
a big deal for git-clone which knows it always starts from a
void and cleaning up the mess is not a big issue, but matters
for the use of git-fetch under discussion, which _will_ work
inside an already initialized repository.
