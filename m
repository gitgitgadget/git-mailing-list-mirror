From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: Reduce heads before trying to merge them
Date: Tue, 17 Apr 2012 11:52:37 -0700
Message-ID: <7vzkaambre.fsf@alter.siamese.dyndns.org>
References: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
 <1334687118-5386-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKDWG-0006xi-38
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab2DQSwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 14:52:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272Ab2DQSwk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 14:52:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF83764AC;
	Tue, 17 Apr 2012 14:52:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wHhIiiMcz5G3
	MlT07TZDAsnjPi4=; b=dnkMdhqCMAcSsvpVI1esPOHMdQ4CVkP2Hi6ybAh4pE3q
	1GK4nt+9w38eW9FxeXc2tZXG/PLnqUyeK0W0wQo16JN0fd2T/1vJ1mmrGM+itVyD
	rts+jymrHNKD6yQdNoi4FAs3wpCQCR13AnXsYhnDLykf5lBATVMW6JQoUHkPvOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OdqA7N
	x73GCqfYU33B7hgaxFj+eVNf/E+Ttwqhv8I9ry81dFr0a/GL+Iqpipmm91160NVW
	/HzPKda0d3w2ijiOXtYoT2hOQuqwBmqoUcV0uqSwUpo1a3kF8iadqX/XRyyI+DbO
	Xm8QXqDjczn9u1wEDYT47WeMF3fw26pa7GpoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7BCE64AB;
	Tue, 17 Apr 2012 14:52:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E71764AA; Tue, 17 Apr 2012
 14:52:39 -0400 (EDT)
In-Reply-To: <1334687118-5386-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Tue, 17 Apr 2012
 20:25:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8152A1EC-88BE-11E1-8314-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195794>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 08e01e8..2d5930f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1346,6 +1346,9 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>  			allow_trivial =3D 0;
>  	}
> =20
> +	if (remoteheads->next)
> +		remoteheads =3D reduce_heads(remoteheads);
> +

If your current HEAD is an ancestor of one of the commit on that list, =
the
above does not omit it from the parent list of the resulting merge comm=
it,
but if you performed the same merge while on one of the commit being
merged, your current HEAD will be excluded with reduce_heads(), which
would mean that you will end up recording a different history even thou=
gh
a merge is supposed to be symmetrical.

In other words, isn't any solution that calls reduce_heads() only on
remoteheads fundamentally wrong and merely papering over the problem?
