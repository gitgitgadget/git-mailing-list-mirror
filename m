From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 08:54:00 +0100
Message-ID: <4c8ef71002152354s3be9503aja28e5426a735ca07@mail.gmail.com>
References: <20100215225001.GA944@book.hvoigt.net>
	 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
	 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
	 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 08:54:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhIG8-0007iN-LS
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 08:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700Ab0BPHyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 02:54:06 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:55357 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686Ab0BPHyE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2010 02:54:04 -0500
Received: by fxm7 with SMTP id 7so6770748fxm.28
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 23:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CM4/nQcTjK5opQl0F1Gb+CGDElp+ghj0MTz2amgPdnE=;
        b=av+M4JbgxX0W9GP01+0HfKd0RW6XHM9MrE52saDw4pV2BBklnXNuav51QIf9ojIgb/
         8YO/LK+tnAVo6CpOgj3s8yiayRx10ugCT/mrZiVU3wxRTW0//ViXu+UreY99KoNdzJjs
         HXmZ55ioQRBKaWfCA/iBLAhjoQOM1eZ0l/op4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SaHq8Ge2I6QJ/p3rWSEOVJCJhEkuhEKYFKCDS2zv+Fr04Qx/6mlh16WMAfI5Iezvwj
         L2hMMOIqA7lIF4BAtFnXLNRskTOwg1lQ+t7X776gUP/TEufdCD6atzjPblc62YOhl6+B
         Wp4se6R9i0mf6hl5R2JL6BjBnWYpTRvDRVFpo=
Received: by 10.239.137.140 with SMTP id l12mr736350hbl.18.1266306840424; Mon, 
	15 Feb 2010 23:54:00 -0800 (PST)
In-Reply-To: <7vljetlx8r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140084>

On Tue, Feb 16, 2010 at 03:39, Junio C Hamano <gitster@pobox.com> wrote=
:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Is this the answer to my question?
>
> IOW, please try this patch. =A0I am planning to queue it to 'maint' a=
s part
> of 1.7.0.1 if this is the right solution (which I obviously think it =
is).
>
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Mon, 15 Feb 2010 18:34:28 -0800
> Subject: [PATCH] Fix use of mutex in threaded grep
>
> The program can decide at runtime not to use threading even if the
> support is compiled in. =A0In such a case, mutexes are not necessary
> and left uninitialized. =A0But the code incorrectly tried to take and
> release the read_sha1_mutex unconditionally.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =A0builtin-grep.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-grep.c b/builtin-grep.c
> index 26d4deb..5c1545e 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -81,8 +81,8 @@ static pthread_mutex_t read_sha1_mutex;
>
> =A0#define grep_lock() pthread_mutex_lock(&grep_mutex)
> =A0#define grep_unlock() pthread_mutex_unlock(&grep_mutex)
> -#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
> -#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
> +#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&r=
ead_sha1_mutex); } while (0)
> +#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unloc=
k(&read_sha1_mutex); } while (0)
>
> =A0/* Signalled when a new work_item is added to todo. */
> =A0static pthread_cond_t cond_add;

This is the correct fix. Thanks.

Acked-by: Fredrik Kuivinen <frekui@gmail.com>

- Fredrik
