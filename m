From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: reject if another gc is running, unless --force is given
Date: Thu, 08 Aug 2013 11:12:53 -0700
Message-ID: <7vk3jw9hlm.fsf@alter.siamese.dyndns.org>
References: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
	<1375959938-6395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 20:13:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Uhx-0002Zt-07
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 20:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051Ab3HHSM6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Aug 2013 14:12:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757978Ab3HHSM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 14:12:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51312377F4;
	Thu,  8 Aug 2013 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1LhAI4MnqcYt
	tZrgeRfs4EbL/IM=; b=V1SNaM/iuV4GOeDgX6CZDCP4lvpEL/vIW0nCcQpGDjOy
	gNvVKOynfZSvlmmihWKvS/9LkBzuW1H2uCR0xZLq6agQ3IKjUXwy2F9OKnV5Hf56
	oAUrwWmCT/R3raXrwkmjUpEjKY8dnYZE0pa0Fl4PhnI9wVMJBVPy3qqwaazlRFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rBvm2Y
	zJ9PGOl/i8Mz2L6A3fcnt4CYrYZ4gickjcgUUnMnOjWhGoUCI4edtOREnfWrZsh9
	mmU8LNgW9rz0/15KtqrkmCnkrWeHokzthgB7kpdoKCP5ZsDQJ0fD2BEtec74zSz4
	T1rc8YLzxyErxXUiHPH9EYyvmnk+EDLqtgCA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46BEE377F3;
	Thu,  8 Aug 2013 18:12:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73389377F1;
	Thu,  8 Aug 2013 18:12:55 +0000 (UTC)
In-Reply-To: <1375959938-6395-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 8 Aug
 2013 18:05:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25EEE94E-0056-11E3-94C1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231915>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6be6c8d..99682f0 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -167,11 +167,69 @@ static int need_to_gc(void)
> + ...
> +	fd =3D hold_lock_file_for_update(&lock, git_path("gc.pid"),
> +				       LOCK_DIE_ON_ERROR);
> +	if (!force) {
> +		fp =3D fopen(git_path("gc.pid"), "r");
> +		memset(locking_host, 0, sizeof(locking_host));
> +		should_exit =3D
> +			fp !=3D NULL &&
> +			!fstat(fileno(fp), &st) &&
> +			/*
> +			 * 12 hour limit is very generous as gc should
> +			 * never take that long. On the other hand we
> +			 * don't really need a strict limit here,
> +			 * running gc --auto one day late is not a big
> +			 * problem. --force can be used in manual gc
> +			 * after the user verifies that no gc is
> +			 * running.
> +			 */
> +			time(NULL) - st.st_mtime <=3D 12 * 3600 &&
> +			fscanf(fp, "%"PRIuMAX" %127c", &pid, locking_host) =3D=3D 2 &&
> +			!strcmp(locking_host, my_host) &&
> +			!kill(pid, 0);

If there is a lockfile we can read, and if we can positively
determine that the process named in the lockfile is still running,
then we definitely do not want to do another "gc".  That part is
good.

If the lock is very stale, 12-hour test will kick in, and we do not
read who locked it, nor check if the locker is still alive.  By
doing so, we avoid misidentifying a new process that is unrelated to
the locker who died and left the lockfile behind, which is a good
thing.  The logic to ignore such lockfile as "unknown" applies
equally to a remote locker on a lockfile that is old.  So the logic
for an old lockfile is good, too.

When we see a recent lockfile created by a "gc" running elsewhere,
we do not set "should_exit".  Is that a good thing?  I am wondering
if the last two lines should be:

-	!strcmp(locking_host, my_host) &&
-	!kill(pid, 0);
+	(strcmp(locking_host, my_host) || !kill(pid, 0));

instead.

Thanks, looking good.
