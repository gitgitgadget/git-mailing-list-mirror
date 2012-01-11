From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff-index: pass pathspec down to unpack-trees
 machinery
Date: Wed, 11 Jan 2012 12:40:24 -0800
Message-ID: <7vvcoi55xj.fsf@alter.siamese.dyndns.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-4-git-send-email-gitster@pobox.com>
 <20120111063104.GA3153@burratino>
 <CACsJy8D7EnOebAxBYF8ua7htu-81nKY=ghUMgg=JOe4Fc1uigQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:40:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl4yH-0003nE-LD
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 21:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758062Ab2AKUk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 15:40:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab2AKUk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 15:40:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EA927C8B;
	Wed, 11 Jan 2012 15:40:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YpgGFnA3QdTh+Z2sRwmZs1Kpt+U=; b=Kn7Wdt
	8bfVAZrPrlXzmVHRXk77UNy5PGoJkKHRiFZWJT4qDJ+hXp2qoQGqgRHpfAw23oUP
	mw9a79psdQtQym5cWhHqduypN2jp8KoNCeI2imj6i8Ik/+VO5hMIk/BsPYomZLTm
	MfKJ9Sh+2FltK+yuISx6faSOOdndp5ajfWfV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vBEtrf1RpNML+2yH9LvZ7kZGwtwUfRnX
	qCJ289rMHuL551ZjM18/tjAG+kqfNIm5bTRRy/B50Di+zjujkpgP/h5idrGE4kb4
	8V03Kj/0Qxq3XsGH6P6Ey1tqPuMgOliiw1oDZz1Efzo2ZwgkhVzKY9L3BqexYZGb
	JH7fNcoA/Ws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74B867C8A;
	Wed, 11 Jan 2012 15:40:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D02FA7C89; Wed, 11 Jan 2012
 15:40:25 -0500 (EST)
In-Reply-To: <CACsJy8D7EnOebAxBYF8ua7htu-81nKY=ghUMgg=JOe4Fc1uigQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 11 Jan 2012 19:33:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DA57C66-3C94-11E1-87CD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188394>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> This seems to fix this.
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 7c9ecf6..5cf58b6 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1042,6 +1042,7 @@ int unpack_trees(unsigned len, struct tree_desc
> *t, struct unpack_trees_options
>                 info.data = o;
>                 info.show_all_errors = o->show_all_errors;
>                 info.pathspec = o->pathspec;
> +               info.pathspec->recursive = 1;
>
>                 if (o->prefix) {
>                         /*
>
> Still scratching my head why this flag is zero by default, which would
> affect all other places.

Ahh, thanks for diagnosing.

> ... Or perhaps the right fix would be this
> instead
>
> diff --git a/tree-walk.c b/tree-walk.c
> index f82dba6..0345938 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -634,7 +634,7 @@ enum interesting tree_entry_interesting(const
> struct name_entry *entry,
>                                  * Match all directories. We'll try to
>                                  * match files later on.
>                                  */
> -                               if (ps->recursive && S_ISDIR(entry->mode))
> +                               if (S_ISDIR(entry->mode))
>                                         return entry_interesting;
>                         }
>
> @@ -662,7 +662,7 @@ match_wildcards:
>                  * Match all directories. We'll try to match files
>                  * later on.
>                  */
> -               if (ps->recursive && S_ISDIR(entry->mode))
> +               if (S_ISDIR(entry->mode))
>                         return entry_interesting;
>         }
>         return never_interesting; /* No matches */

Doesn't that break "git diff-tree A B" without the "-r" option?
