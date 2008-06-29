From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 29 Jun 2008 12:08:38 -0700
Message-ID: <7vhcbcawjt.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0806291127140.21402@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 21:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD2Hl-0006eb-J1
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 21:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbYF2TIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 15:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbYF2TIu
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 15:08:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbYF2TIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 15:08:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 34FDAC6BF;
	Sun, 29 Jun 2008 15:08:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6D9E2C6BA; Sun, 29 Jun 2008 15:08:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CC4C563A-460E-11DD-9FA6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86819>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Maybe just say
>
>  * Do not install all git subcommands as 'git-xyzzy' files in the user 
>    path. This avoids unnecessary hardlinks (or copies on systems that do 
>    not support links), and enforces the 'git xyzzy' syntax.
>
>    Subcommands that aren't builtins now get installed in
>    /usr/libexec/git-core/ or somesuch.

Thanks.

> (I haven't looked at the series, but I _assume_ it also avoids installing 
> the builtin subcommands entirely when not necessary, ie "git-cat-file" 
> really _is_ gone, but it's not because the "cat-file" command itself is 
> gone).

It is actually a fairly long road ahead.

In 1.6.0, most of them will be moved to /usr/libexec/git-core/, so that
really old scripts end users may have can be more easily kept working by
simply saying:

	PATH=$(git --exec-path):$PATH

early, without doing "s/git-/git /g".

Current git clients run git-upload-pack and friends in "git-xyzzy" form
when accessing remote repositories directly over ssh, so in 1.6.0 we will
have to leave these server side programs in $(bindir) as well.

git-shell and gitosis is being updated to accept "git upload-pack" form as
well, and after older versions of these programs die out, we can update
the clients to ask for remote side programs without dash.

None of the server side programs is built-in, so we could start the
hardlink removal independent from this transition (iow, "Only subcommands
that aren't builtin will be installed in libexec, builtins are not on the
disk anywhere" could happen now), but I'd prefer to keep changes in each
steps small to minimize impacts to the end users' environments.
