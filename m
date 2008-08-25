From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: always provide a fallback when hardlinks fail
Date: Mon, 25 Aug 2008 14:36:20 -0700
Message-ID: <7vej4cg4kr.fsf@gitster.siamese.dyndns.org>
References: <0EFF470D-341A-4619-910A-0F9C663D0B51@web.de>
 <7vljyv6gyo.fsf@gitster.siamese.dyndns.org>
 <D4374620-C6D8-4CB3-8A7D-C5449BB8E8D1@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjkj-0003vG-7Y
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbYHYVg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2008 17:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbYHYVg2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:36:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbYHYVg2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 17:36:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F1225535A;
	Mon, 25 Aug 2008 17:36:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 631DB55350; Mon, 25 Aug 2008 17:36:23 -0400 (EDT)
In-Reply-To: <D4374620-C6D8-4CB3-8A7D-C5449BB8E8D1@web.de> (Andreas
 =?utf-8?Q?F=C3=A4rber's?= message of "Mon, 25 Aug 2008 17:42:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DEF57936-72ED-11DD-BFD1-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93684>

Andreas F=C3=A4rber <andreas.faerber@web.de> writes:

> From: Andreas Faerber <andreas.faerber@web.de>
> Date: Mon, 25 Aug 2008 17:33:03 +0200
> Subject: [PATCH] Makefile: always provide a fallback when hardlinks f=
ail
>
> We make hardlinks from "git" to "git-<cmd>" built-ins and have been
> careful to avoid cross-device links when linking "git-<cmd>" to
> gitexecdir.
>
> However, we were not prepared to deal with a build directory that is
> incapable of making hard links within itself. This patch corrects it.
>
> Instead of temporarily linking "git" to gitexecdir, directly link "gi=
t-
> add", falling back to "cp". Try hardlinking that as "git-<cmd>", fall=
ing
> back to symlinks or "cp" on error.
>
> While at it, avoid 100+ error messages from hardlink failures when we
> are going to fall back to symlinks or "cp" by redirecting the standar=
d
> error to /dev/null.
>
> Signed-off-by: Andreas F=C3=A4rber <andreas.faerber@web.de>
> ---
>  Makefile |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 7a6cbb6..fb4863c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1110,7 +1110,10 @@ help.o: help.c common-cmds.h GIT-CFLAGS
>  		'-DGIT_INFO_PATH=3D"$(infodir_SQ)"' $<
>
>  $(BUILT_INS): git$X
> -	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
> +	$(QUIET_BUILT_IN)$(RM) $@ && \
> +	ln git$X $@ 2>/dev/null || \
> +	ln -s git$X $@ 2>/dev/null || \
> +	cp git$X $@

Ok.

>
>  common-cmds.h: ./generate-cmdlist.sh command-list.txt
>
> @@ -1371,16 +1374,13 @@ ifneq (,$X)
>  endif
>  	bindir=3D$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
>  	execdir=3D$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
> -	if test "z$$bindir" !=3D "z$$execdir"; \
> -	then \
> -		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
> -		cp "$$bindir/git$X" "$$execdir/git$X"; \
> -	fi && \
> -	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln
> "$$execdir/git
> $X" "$$execdir/$p" ;) } && \
> -	if test "z$$bindir" !=3D "z$$execdir"; \
> -	then \
> -		$(RM) "$$execdir/git$X"; \
> -	fi && \

(mental note while reviewing the change) Outside context before this pa=
rt
we have installed "git$X" to $$bindir, and removed leftover "git-foo"
without .exe on the platform where X=3D.exe.

> +	{ $(RM) "$$execdir/git-add$X" && \
> +		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
> +		cp git-add$X "$$execdir/git-add$X"; } && \

(mental note while reviewing the change) First, we install git-add$X to
$$execdir, either hardlink or copy.

> +	{ $(foreach p,$(patsubst git-add,,$(BUILT_INS)), $(RM)
> "$$execdir/
> $p" && \
> +		ln "$$execdir/git-add$X" "$$execdir/$p" 2>/dev/null || \
> +		ln -s "$$execdir/git-add$X" "$$execdir/$p" 2>/dev/null || \
> +		cp "$$execdir/git-add$X" "$$execdir/$p" || exit;) } && \

    Nits.

    * Line-wrapped;
    * $(patsubst) is probably $(filter-out);

(mental note while reviewing the change) Then we install the rest by
linking, symlinking or copying git-add$X.

We might want to do the "symlinking" to $$bindir/git$X instead, but oth=
er
than that (and above two minor nits), this looks pretty good.

Thanks, will try and apply.
