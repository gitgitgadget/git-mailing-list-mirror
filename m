From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote: defer repacking packed-refs when deleting refs
Date: Tue, 20 May 2014 12:30:12 -0700
Message-ID: <xmqqtx8kxn7f.fsf@gitster.dls.corp.google.com>
References: <537B2FA4.7020001@opera.com> <537B30E7.5020505@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Tue May 20 21:30:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmpk6-0000yk-9k
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 21:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbaETTaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2014 15:30:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63465 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbaETTaU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 15:30:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7299018FC6;
	Tue, 20 May 2014 15:30:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xTbgGaMSGwE3
	fttSECAXWftzJpg=; b=syL1mAUmz0on5Fqtv7wf776i3V9ygAlywMlLoPF4d+hS
	FqGcviXyXhri0WQp1s2phT+YOkdo9zpbjSFCYBau/IDBOX10AmBr5PVvRM7NHfMU
	Xbs0h1IEeKgQp2eeASEf1Nj64cXMC/FllgtZY3MpfZozzQT58jgmuaKRoNdPKQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K74ldr
	N6FSEblw/mhKpmIdxDMtzGZAkI+IKfe9TO41CKmAp2RmEx4FU/Gk2rTqR+XS2gao
	MywFiGKCCLOS2Y2lVAQkikbSjUZGHECAHOpZGxIv7Kd3PilnAQCH63OID05H6uhl
	Odg9pQTpZIdB26BfSdPWO+7HVrcvskcYeGrkE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 677A918FC5;
	Tue, 20 May 2014 15:30:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 61E2118FBD;
	Tue, 20 May 2014 15:30:15 -0400 (EDT)
In-Reply-To: <537B30E7.5020505@opera.com> ("Jens =?utf-8?Q?Lindstr=C3=B6m?=
 =?utf-8?Q?=22's?= message of "Tue,
	20 May 2014 12:39:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B45F542-E055-11E3-B24E-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249735>

Jens Lindstr=C3=B6m <jl@opera.com> writes:

> When 'git remote rm' or 'git remote prune' were used in a repository
> with many refs, and needed to delete many refs, a lot of time was spe=
nt
> deleting those refs since for each deleted ref, repack_without_refs()
> was called to rewrite packed-refs without just that deleted ref.
>
> To avoid this, defer the repacking until after all refs have been
> deleted (by delete_ref()), and then call repack_without_refs() once t=
o
> repack without all the deleted refs.
>
> Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>
> ---
> This patch changes behavior when the operation is aborted in the
> middle, so that loose refs and ref logs might have been deleted, but
> not the corresponding entries in packed-refs, since packed-refs is no=
w
> only updated at the end.

Also this makes it a bit more dangerous for processes accessing the
repository while pruning is in progress by exposing stale refs that
may be pointing at objects that are no longer present in the object
store in the packed-refs file for a longer period ("git fsck" may
fail, for example).

As long as we accept that removing a remote or pruning one are kinds
of "maintenance" operations and nobody else should be peeking into
the repository during maintenance period, it may be alright, but
aborting the operation in the middle will essentially leave the
repository in a corrupted state---the "abort corrupts" is a downside
with or without this change and is not a new problem.

A bit safer way to organize might be to first create a list of the
refs to be removed in-core, update packed-refs without these refs to
be removed, and then finally remove the loose ones, but I haven't
thought things through.
