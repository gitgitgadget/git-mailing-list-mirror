From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Tue, 22 Jul 2008 17:16:38 -0700
Message-ID: <7vk5fdiheh.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
 <4882454D.2080500@free.fr> <7vd4l9zgmp.fsf@gitster.siamese.dyndns.org>
 <4884917A.1060005@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:18:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLS3X-0006HB-Du
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYGWARL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYGWARK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:17:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbYGWARJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:17:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 84F2337571;
	Tue, 22 Jul 2008 20:17:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 466A737570; Tue, 22 Jul 2008 20:16:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0092E44-584C-11DD-B4EF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89577>

Olivier Marin <dkr+ml.git@free.fr> writes:

> The last thing that still annoy me is the --skip that refuse to skip in 3-way
> merge. Perhaps we can use the "git read-tree --reset -u" thing for skip too.

Hmm...

We traditionally left that as something the user deliberately should do to
signal --skip that the user knows he is dropping that change (by the way,
so did "git-rebase").  But with fb6e4e1 (Do git reset --hard HEAD when
using git rebase --skip, 2007-11-08), we run the reset upon rebase --skip,
so it probably is a good idea to match it here as well.

> diff --git a/git-am.sh b/git-am.sh
> index 60aaa4a..864c77e 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -202,8 +202,15 @@ then
>  	die "previous rebase directory $dotest still exists but mbox given."
>  	resume=yes
>  
> -	case "$abort" in
> -	t)
> +	case "$skip,$abort" in
> +	t,)
> +		git rerere clear
> +		git read-tree --reset -u HEAD HEAD
> +		orig_head=$(cat "$GIT_DIR/ORIG_HEAD")
> +		git reset HEAD
> +		git update-ref ORIG_HEAD $orig_head
> +		;;

Sorry, I do not quite understand what this reset after the read-tree dance
is trying to do; you have already reset the index to the tree in HEAD when
you cleared the change involved in the patch application with that
two-tree form of read-tree.
