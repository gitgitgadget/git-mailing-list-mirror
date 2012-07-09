From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change configure to check if pthreads are usable without
 any extra flags
Date: Mon, 09 Jul 2012 07:50:01 -0700
Message-ID: <7vk3ydkmzq.fsf@alter.siamese.dyndns.org>
References: <1341529386-11589-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 16:50:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoFIZ-0001KW-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 16:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943Ab2GIOuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jul 2012 10:50:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342Ab2GIOuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2012 10:50:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 732A175EC;
	Mon,  9 Jul 2012 10:50:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q5SrDa9R78Ri
	47F/i/2LTOjjB60=; b=bKOObu1gOREV97kZQLRp2+9epp3kBxyBRerLQaTnjNtf
	LatwD50vkZIcsBM6B+4135bu1VAfpR0bwb3Of0P5TVggXQ3YSNOZdZXrC/zrD0E4
	A43RNWrtvpd2BZckUnQ2dTmqSMrwboMkclB/1LIJt0v7rC9rXJv50P1atLBFV/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=n+Xb1j
	Isnx1TRpPSDolKb9nCHU682Jpa44HpngmILfVANj0w8r/7jzpgfjUUijyfltBMTb
	hG+4fNMJvj29b5pG+tHj7SidL92OShINGvzGl/KxPuTCRxlZnjyN5f+YZu60qLsp
	DZsJAfbDbJzZ87RshWNk+vTpi1Nq9AgqnXhdk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68DC475EB;
	Mon,  9 Jul 2012 10:50:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF71875E7; Mon,  9 Jul 2012
 10:50:03 -0400 (EDT)
In-Reply-To: <1341529386-11589-1-git-send-email-max@quendi.de> (Max Horn's
 message of "Fri, 6 Jul 2012 01:03:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DF323E0-C9D5-11E1-9D20-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201206>

Max Horn <max@quendi.de> writes:

> The configure script checks whether certain flags / libraries are
> required to use pthreads. But so far it did not consider the possibil=
ity
> that no extra compiler flags are needed (as is the case on Mac OS X).=
 As
> a result, configure would always add "-mt" to the list of flags. This=
 in
> turn triggered a warning in clang about an unknown argument.
> To solve this, we now first check if pthreads work without extra flag=
s.
>
> Signed-off-by: Max Horn <max@quendi.de>
> ---
>  configure.ac | 2 +-
>  1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt=
(-)
>
> diff --git a/configure.ac b/configure.ac
> index 4e9012f..d767ef3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1002,7 +1002,7 @@ if test -n "$USER_NOPTHREAD"; then
>  # -D_REENTRANT' or some such.
>  elif test -z "$PTHREAD_CFLAGS"; then
>    threads_found=3Dno
> -  for opt in -mt -pthread -lpthread; do
> +  for opt in "" -mt -pthread -lpthread; do

Hmph.  Would it work to append the new empty string at the end of
the existing list, as opposed to prepending it?  I'd prefer a
solution that is order independent, or if the change is order
dependent, then a comment to warn others from changing it later.

>       old_CFLAGS=3D"$CFLAGS"
>       CFLAGS=3D"$opt $CFLAGS"
>       AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])

Perhaps "for linking with POSIX Threads" would make it clearer, as
CFLAGS (rather, PTHREAD_CFLAGS) has been checked earlier separately.
