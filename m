From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 10:04:23 -0700
Message-ID: <7vli44td9k.fsf@alter.siamese.dyndns.org>
References: <520BAF9F.70105@googlemail.com>
	<1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, apelisse@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 19:04:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9eUp-0000G6-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 19:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759782Ab3HNRE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 13:04:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758765Ab3HNRE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 13:04:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53DE33680F;
	Wed, 14 Aug 2013 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H8oJVD19SgxW0bgPmut6o+599/A=; b=jx3i1t
	E9T1sj7Jw7AnuPC8zB41eLa+C2tFgxKngJ9J/JzDO68inG8qCM+IIaHiCczx4cOx
	yRFxx/MkTXNCu+Q81ZVjqYJ1BH4Qi98jvp16G/wQESQyWQ4qAJ/LIMwj9pplyBGf
	0VykrpIhro4CzUjzYN+8/U8uL3/EE+NRIDsyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cSyT6XvNxCJVpY/qqY/igDiooPxMuntw
	BPTgHJ9dcaRQ1CGHVCB5U5YC/vcV52TpPB0obDhTCc06jqbDtB7ST8rLqdD0bA8r
	A/C4Z2uD3cyAaJNLmnDjkrHNqYCxHBVG9vB3WhYRJWRUrmch61xCGhLxcgayaJ0M
	SJte4p48Vt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42DC63680E;
	Wed, 14 Aug 2013 17:04:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AB393680C;
	Wed, 14 Aug 2013 17:04:25 +0000 (UTC)
In-Reply-To: <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Wed, 14 Aug 2013 18:27:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92ADD17E-0503-11E3-8CED-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232297>

Stefan Beller <stefanbeller@googlemail.com> writes:

> diff --git a/builtin/repack.c b/builtin/repack.c
> new file mode 100644
> index 0000000..d39c34e
> --- /dev/null
> +++ b/builtin/repack.c
> @@ -0,0 +1,410 @@
> +/*
> + * The shell version was written by Linus Torvalds (2005) and many others.
> + * This is a translation into C by Stefan Beller (2013)
> + */
> +
> +#include "builtin.h"
> +#include "cache.h"
> +#include "dir.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +#include "sigchain.h"
> +#include "strbuf.h"
> +#include "string-list.h"
> +
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <dirent.h>

If you need these system-includes here, it means that our own
platform-portability layer "git-compat-util.h" is broken.  On
various systems, often some system header files are missing, need a
few feature macros to be defined before including, and/or need to be
included in certain order, etc., and "git-compat-util.h" is meant to
hide all such details from the programmers.

I do not think the above four needs to be included in *.c, as long
as you include either builtin.h or cache.h, both of which includes
the compat-util header.
