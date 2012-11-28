From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure.ac: fix pthreads detection on Mac OS X
Date: Tue, 27 Nov 2012 22:38:12 -0800
Message-ID: <7vlidmi65n.fsf@alter.siamese.dyndns.org>
References: <1354058931-88873-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 07:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdbHz-0001qB-TT
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 07:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab2K1GiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 01:38:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab2K1GiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 01:38:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB46267FF;
	Wed, 28 Nov 2012 01:38:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SW7laSP3Bpb2HMEq4gBWDloYH7c=; b=vDmSSO
	PEQUgUXJjGQpOFZVkrpkiVzyH7bla3v3JyXM098nvrsmaNcPH5xrhae36fMuT0zm
	ZG4z/dxkTPDDdmJCiC/5A2uW84svQd/GlR7mHPWstx2ITfKjl/fUYxv0q8t26D7v
	F5Y7PviFYJtCFsM/Jr8Tg35N9fMLviMEEaizk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KkbWe/QaPWNgjlJEDsLDT2bTgHv4UzYY
	wJnOkA67PmGA9QScTv8p10NZXFgekZslIf10ce0A0YrWE/6vnt2+fKTJavvXeDtk
	0bFqDx4/+X82MpHe+untWV79GZbRjYmtle0HrnmMZuty9RW9WPmDOS0vsnFyc8Zg
	XCt9u0IWUD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7BD367FE;
	Wed, 28 Nov 2012 01:38:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 395B367FC; Wed, 28 Nov 2012
 01:38:14 -0500 (EST)
In-Reply-To: <1354058931-88873-1-git-send-email-max@quendi.de> (Max Horn's
 message of "Wed, 28 Nov 2012 00:28:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F775796-3926-11E2-9C39-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210706>

Max Horn <max@quendi.de> writes:

> The configure script checks whether certain flags are required to use
> pthreads. But it did not consider that *none* might be needed (as is the
> case on Mac OS X). This lead to configure adding "-mt" to the list of
> flags (which does nothing on OS X except producing a warning). This in
> turn triggered a compiler warning on every single file.
>
> To solve this, we now first check if pthreads work without extra flags.
> This means the check is now order dependant, hence a comment is added
> explaining this, and the reasons for it.
>
> Note that it might be possible to write an order independent test, but
> it does not seem worth the extra effort required for implementing and
> testing such a solution, when this simple solution exists and works.
>
> Signed-off-by: Max Horn <max@quendi.de>
> ---
>
> This is actually a revised version from my patch
>  "Change configure to check if pthreads are usable without any extra flags"
> from July. I simply had forgotten all about it :-(.

Will queue, but we would need wider testing to avoid "compiles well
without an option but fails to link" issues similar to cea13a8
(Improve test for pthreads flag, 2011-03-28) on other people's
platforms (I know you tested on Mac OS X and over there it compiles
and links well---I am worried about others).

Thanks.

> Chers,
> Max
>
>  configure.ac | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index ad215cc..41ac9a5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1021,7 +1021,17 @@ if test -n "$USER_NOPTHREAD"; then
>  # -D_REENTRANT' or some such.
>  elif test -z "$PTHREAD_CFLAGS"; then
>    threads_found=no
> -  for opt in -mt -pthread -lpthread; do
> +  # Attempt to compile and link some code using pthreads to determine
> +  # required linker flags. The order is somewhat important here: We
> +  # first try it without any extra flags, to catch systems where
> +  # pthreads are part of the C library, then go on testing various other
> +  # flags. We do so to avoid false positives. For example, on Mac OS X
> +  # pthreads are part of the C library; moreover, the compiler allows us
> +  # to add "-mt" to the CFLAGS (although it will do nothing except
> +  # trigger a warning about an unused flag). Hence if we checked for
> +  # "-mt" before "" we would end up picking it. But unfortunately this
> +  # would then trigger compiler warnings on every single file we compile.
> +  for opt in "" -mt -pthread -lpthread; do
>       old_CFLAGS="$CFLAGS"
>       CFLAGS="$opt $CFLAGS"
>       AC_MSG_CHECKING([for POSIX Threads with '$opt'])
