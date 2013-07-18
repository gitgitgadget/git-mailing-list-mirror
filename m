From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Thu, 18 Jul 2013 15:30:09 +0100
Message-ID: <20130718143009.GC2337@serenity.lan>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
 <20130523102959.GP9448@inner.h.apk.li>
 <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 16:30:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzpDv-0004hv-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 16:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625Ab3GROaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 10:30:23 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:38147 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab3GROaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 10:30:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 373AD606519;
	Thu, 18 Jul 2013 15:30:21 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KF2an19U+s5; Thu, 18 Jul 2013 15:30:20 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id CC00E60651C;
	Thu, 18 Jul 2013 15:30:19 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id B6BDD161E359;
	Thu, 18 Jul 2013 15:30:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5aKCbWoCnje; Thu, 18 Jul 2013 15:30:19 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A775E161E34B;
	Thu, 18 Jul 2013 15:30:11 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230693>

On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
> diff --git a/git-pull.sh b/git-pull.sh
> index 638aabb..4a6a863 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -264,6 +274,30 @@ case "$merge_head" in
>  		die "$(gettext "Cannot rebase onto multiple branches")"
>  	fi
>  	;;
> +*)
> +	# integrating with a single other history
> +	merge_head=${merge_head% }
> +	if test -z "$rebase$no_ff$ff_only${squash#--no-squash}" &&
> +		test -n "$orig_head" &&
> +		! $(git merge-base --is-ancestor "$orig_head" "$merge_head")

I think this needs to be:

	! $(git merge-base --is-ancestor "$orig_head" "$merge_head" ||
	    git merge-base --is-ancestor "$merge_head" "$orig_head")

in order to avoid printing the message when "git pull" does not fetch
any new changes and the user has some new commits.
