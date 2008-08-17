From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: [PATCH 6/6] Always provide a fallback when hardlinks fail
Date: Sun, 17 Aug 2008 14:14:42 +0200
Message-ID: <06F58415-2F22-44BE-8F19-70460DDF7F35@web.de>
References: <0EFF470D-341A-4619-910A-0F9C663D0B51@web.de> <7vljyv6gyo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUhB8-0003RR-6W
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbYHQMPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 08:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbYHQMPH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:15:07 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:43804 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbYHQMPF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 08:15:05 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id B52FEE6E564C;
	Sun, 17 Aug 2008 14:15:04 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUhA0-0000iI-00; Sun, 17 Aug 2008 14:15:04 +0200
In-Reply-To: <7vljyv6gyo.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1/XPHul1KpEgvzmXXfMidwzx+6WsSk9zUqLBr5R
	aWUp/dl/SRPeLRvXeCSetNI3rZhgLNY8+5uxAIzcdQAuAeQSLn
	yFb+s0ExLHnxAtMgjD6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92601>


Am 17.08.2008 um 13:03 schrieb Junio C Hamano:

> Andreas F=E4rber <andreas.faerber@web.de> writes:
>
>> BFS does not support hardlinks, so suppress the resulting error
>> messages.
>
> Hmm, this is not specific to BFS.  I would have preferred if you =20
> brought
> up much earlier.

Right, it isn't. Do you mean earlier in time, or would you like me to =20
reorder it in my v2 series?

> diff --git a/Makefile b/Makefile
> index 53ab4b5..53112bb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1098,7 +1098,10 @@ help.o: help.c common-cmds.h GIT-CFLAGS
> 		'-DGIT_INFO_PATH=3D"$(infodir_SQ)"' $<
>
> $(BUILT_INS): git$X
> -	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
> +	$(QUIET_BUILT_IN)$(RM) $@ && \
> +	ln git$X $@ 2>/dev/null || \
> +	ln -s git$X $@ 2>/dev/null || \
> +	cp git$X $@
>
> common-cmds.h: ./generate-cmdlist.sh command-list.txt
>
> @@ -1365,10 +1368,12 @@ endif
> 	execdir=3D$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
> 	if test "z$$bindir" !=3D "z$$execdir"; \
> 	then \
> -		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
> -		cp "$$bindir/git$X" "$$execdir/git$X"; \
> +		$(RM) "$$execdir/git$X" && \
> +		ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
> +		ln -s "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
> +		cp "$$bindir/git$X" "$$execdir/git$X" || exit; \
> 	fi && \
> -	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/=20
> git$X" "$$execdir/$p" ;) } && \
> +	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/=20
> git$X" "$$execdir/$p" 2>/dev/null || cp "$$execdir/git$X" "$$execdir/=
=20
> $p" || exit;) } && \
> 	if test "z$$bindir" !=3D "z$$execdir"; \
> 	then \
> 		$(RM) "$$execdir/git$X"; \

Looks fine, I'll test it together with the other changes.

Andreas
