From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About -X<option>
Date: Sun, 06 Jul 2008 12:25:23 -0700
Message-ID: <7vd4lqerx8.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness>
 <20080705133245.GH4729@genesis.frugalware.org>
 <AB745D70-D23A-4742-A5B3-DC1B6CAD9C30@ai.rug.nl>
 <7v63rktekf.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807060342550.3557@eeepc-johanness>
 <7vmykvpq2n.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0807061315310.32725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <frimmirf@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 21:26:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFZsU-0006OA-HG
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 21:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784AbYGFTZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 15:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756837AbYGFTZc
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 15:25:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775AbYGFTZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 15:25:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 756121B198;
	Sun,  6 Jul 2008 15:25:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 959C41B195; Sun,  6 Jul 2008 15:25:25 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0807061315310.32725@wbgn129.biozentrum.uni-wuerzburg.de>
 (Johannes Schindelin's message of "Sun, 6 Jul 2008 13:28:00 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4BC76940-4B91-11DD-9196-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87545>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> By allowing users to put a script in their PATH (possibly resorting to "." 
> just for that script), named "git-merge-<mybackend>", the following 
> becomes possible:
>
> 	$ echo 'git merge-recursive --theirs "$@"' > ~/bin/git-merge-X
> 	$ chmod a+x ~/bin/git-merge-X
> 	$ git merge -s X
>
> This would be even more flexible than the "-X" option, and it would 
> properly keep "--theirs" out of our officially supported features.

The above "custom backend" is fine, and would be useful for _other_ things
(That's why I invented "-s" option to "git-merge" to begin with).  The sad
part is that it does not have much to do with a solution about -X<option>
issue.

Imagine you want to enhance the recursive strategy so that the user can
tweak the similarity threashold used in the rename detection.  You would
want to pass the equilvalent of -M<similarity> to the strategy backend
through "git merge".  You could use millions of such custom merge backend
to do so:

	$ echo 'git merge-recursive -M2 "$@"' >~/bin/git-merge-M2
	$ echo 'git merge-recursive -M4 "$@"' >~/bin/git-merge-M4
	$ echo 'git merge-recursive -M6 "$@"' >~/bin/git-merge-M6
	$ ... millions of these ...
        $ git merge -s M09

but that's not a solution.  You are kuldging around the issue by punting
and by not solving it (iow "I did not have forsight to allow passing
options through git-merge, and as consequence, the users are forced to
have canned set of options in their backend").  You have the same issue
with "-Xsubtree=git-gui/", for example.

Being able to pick strategy backend is wonderful, and being able to define
new ones is also wonderful.  But that is unrelated to what we are
discussing here.  Don't confuse the issue.

I am not married to -X<option> notation. Perhaps we can borrow the way
"gcc" does this, when allowing linker and assmebler options to be passed
from the command line to the backend with -Wa,<option> and -Wl,<option>.

The issue being addressed with these notation is exactly the same as what
we are discussing, and we can follow the same model.  The intermediary
(gcc and git-merge) does not have to fully understand what the option they
are passing to the backend (assembler and merge-* strategy).
