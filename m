From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for
 .gitattributes
Date: Sat, 13 Oct 2012 21:29:59 -0700
Message-ID: <7v4nlx3cc8.fsf@alter.siamese.dyndns.org>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-3-git-send-email-pclouds@gmail.com>
 <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org>
 <50765CDC.8020509@viscovery.net> <7vpq4p80sn.fsf@alter.siamese.dyndns.org>
 <5077C7AC.9010301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 06:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNFz7-0006mb-6k
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 06:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872Ab2JNEaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 00:30:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab2JNEaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 00:30:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22E299E39;
	Sun, 14 Oct 2012 00:30:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=60opodG8WFtP0USPjL4kdEKrjG8=; b=en+lnm
	uNOIZv+fSG9tH/nMnZGz49NJHs4GXNjc1NyQ9HqcioDK2Z2gFh5/SOd0QkmOLbr0
	a/cOBNkhAye95cSDfz6KkalzCUZ3jLV3iJx+81eAJHZEYslWyVtvyi1QBH6kSDC7
	YVEQ6qIRhkyQ9VQYHlrnALvZjUAA+cR9713aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7Oau6wM/qSOWNEjZ4HyWN0YX6Va4XbF
	nYt8A4a7Aki9VZy1OPS5i/hqoLWoFgFdArUQ9QRqjtmbqdPVnWzAtdszz5TiHeym
	DtyQXIJaeNzNgYZJhUaHxf2O6u0CLYbkEv22HGaSU85m4AZYkZZJiM8SKKpYUSbL
	Qhx7NqPzfd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F4FA9E38;
	Sun, 14 Oct 2012 00:30:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 310709E37; Sun, 14 Oct 2012
 00:30:03 -0400 (EDT)
In-Reply-To: <5077C7AC.9010301@viscovery.net> (Johannes Sixt's message of
 "Fri, 12 Oct 2012 09:33:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2AA1058-15B7-11E2-96FF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207607>

Johannes Sixt <j.sixt@viscovery.net> writes:

> It might be worth it. We already have a similar special case in
> write_or_die.c:maybe_flush_or_die() for Windows, although it is not about
> a colon in a path name.
>
> Perhaps like this.

Hrm, the "we already have" one b2f5e26 (Windows: Work around an
oddity when a pipe with no reader is written to., 2007-08-17) was
what you added while I was looking the other way ;-) as a part of
Windows specific pull.

That change, and this patch, seem to cover the cases to be ignored
with a bit too wide a net to my taste.  On other systems, and even
on Windows if the path does not have any colon, EINVAL is something
we would want to notice and report, as a potential problem, no?

> --- 8< ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] attr: do not warn on path with colon on Windows
>
> In the same spirit as commit 8e950dab (attr: failure to open a
> .gitattributes file is OK with ENOTDIR), ignore EINVAL errors. On
> Windows, a path that contains a colon that is not the one after the
> drive letter is not allowed and is reported with errno set to
> EINVAL.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  attr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/attr.c b/attr.c
> index 8010429..ac945ad 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -354,7 +354,15 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
>  	int lineno = 0;
>  
>  	if (!fp) {
> -		if (errno != ENOENT && errno != ENOTDIR)
> +		/*
> +		 * If path does not exist, it is not worth mentioning,
> +		 * but I/O errors and permission errors are.
> +		 *
> +		 * On Windows, EINVAL is reported if path contains a colon
> +		 * that is not the driver letter separator. Such a path
> +		 * cannot exist in the file system and is also uninteresting.
> +		 */
> +		if (errno != ENOENT && errno != ENOTDIR && errno != EINVAL)
>  			warn_on_inaccessible(path);
>  		return NULL;
>  	}
