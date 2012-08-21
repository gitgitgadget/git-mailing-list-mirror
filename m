From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Mon, 20 Aug 2012 20:54:09 -0700
Message-ID: <7vipccgase.fsf@alter.siamese.dyndns.org>
References: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Conley Owens <cco3@android.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 05:54:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3fXx-00034w-1d
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 05:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab2HUDyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 23:54:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab2HUDyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 23:54:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0718588CD;
	Mon, 20 Aug 2012 23:54:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8sDF4IAGpaJ4ORlkq7rCQOmTVy0=; b=pHi9Mr
	OwAI15+I7XVmKJdgg27d8ec9j8xmJu5unFJm6AIHXFJZKSYXi8kCe+4Ok13jQvkY
	iFKDgFo4xS0VlxYxQJKxggxcVnvdxMWezCoPbjT/vPbEBF4vivKjERioPNBuq3wu
	JOu8ctb78wzVQ4OY9Fjo/ff1Nhy64AOBVr87Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L5L0tW7OTE0+nleI8OFHp6SGFQwXCXix
	bricAKgUdcYV3OUARqRp8llc5ibHNAnAekuN5l25q0cwNMApy5UpmlKsnZwzNfpz
	FAwGFuABEkr2zdj2dsJgtTfKfg/mlLKR1WMrUz8gnDXuj2xPq3axE00CYSr7GC34
	vuWsZbcQV5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E73D688CC;
	Mon, 20 Aug 2012 23:54:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5972388CB; Mon, 20 Aug 2012
 23:54:11 -0400 (EDT)
In-Reply-To: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com> (Conley
 Owens's message of "Mon, 20 Aug 2012 18:28:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDC3827E-EB43-11E1-BEE9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203925>

Conley Owens <cco3@android.com> writes:

> From f64ba3c908b33a2ea5a5ad1f0e5800af76b82ce9 Mon Sep 17 00:00:00 2001
> From: Conley Owens <cco3@android.com>
> Date: Mon, 20 Aug 2012 18:23:40 -0700
> Subject: [PATCH] Fallback on getpwuid if envar HOME is unset
>
> Signed-off-by: Conley Owens <cco3@android.com>
> ---

We can see you are doing what you claim on the title (modulo "envar"
typo) to be doing, but it is unclear why this patch wants to exist
in the first place.

If the user for whatever reason "unset HOME", why is it a good idea
to read from a place that is found by getpwuid()?  What problem does
it want to fix?  Why does a user want this updated behaviour?

>  path.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/path.c b/path.c
> index 66acd24..60affab 100644
> --- a/path.c
> +++ b/path.c
> @@ -144,6 +144,11 @@ void home_config_paths(char **global, char **xdg,
> char *file)
>         char *to_free = NULL;
>
>         if (!home) {
> +         struct passwd *pw = xgetpwuid_self();
> +         home = pw->pw_dir;

One level of indent is a HT, not two spaces.

> +       }
> +
> +       if (!home) {
>                 if (global)
>                         *global = NULL;
>         } else {
