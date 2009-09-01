From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: stash --dwim safety
Date: Tue, 01 Sep 2009 08:27:20 +0200
Message-ID: <vpqocpv2n93.fsf@bauges.imag.fr>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
	<7v3a77dx5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 08:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiMsk-0000Y9-G4
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 08:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbZIAGaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 02:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbZIAGaI
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 02:30:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:47487 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbZIAGaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 02:30:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n816RLKS018711
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Sep 2009 08:27:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MiMps-0002JO-R2; Tue, 01 Sep 2009 08:27:20 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MiMps-0001SY-Oy; Tue, 01 Sep 2009 08:27:20 +0200
In-Reply-To: <7v3a77dx5b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 31 Aug 2009 22\:58\:08 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 01 Sep 2009 08:27:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127524>

Junio C Hamano <gitster@pobox.com> writes:

> It turns out that the rework was simple enough, so I did it myself.  Among
> his 3 patch series, an equivalent to the first one ("save -keep" can be
> written as "save -k" for brevity) were already in, and the second one
> (default to "save" if we see any option before command word) was unsafe
> without the third one (reject unknown option to "save"), so it ended up as
> a single patch that is a combination of the latter two patches.

Thanks, lack of time on my side to work on this, sorry.

I was actually thinking of being a little more paranoid to prevent
accidental "stash save": we could refuse to create a named stash when
the "save" command is not given. The case I hadn't thought of was "git
stash -q apply", which has 99% chances of being a typo for "git stash
apply -q", and which would mean "create a stash named apply, quietly".

> +# The default command is "save"
> +case "$1" in
> +-*)
> +	set "save" "$@"
> +	;;
> +esac

So, that could become something like

default_to_save=t
for arg in "$@"; do
	case "$arg" in
	-*)
		;;
	*)
		default_to_save=
	esac
done

if [ "$default_to_save" = t ]; then
	set "save" "$@"
fi

(untested)

-- 
Matthieu
