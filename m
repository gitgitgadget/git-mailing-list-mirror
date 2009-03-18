From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Define a version of lstat(2) specially for copy
 operation
Date: Wed, 18 Mar 2009 00:41:41 -0700
Message-ID: <7vmybjl1l6.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com>
 <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net>
 <20090317202818.GA13458@blimp.localdomain>
 <7v63i7ridk.fsf@gitster.siamese.dyndns.org>
 <20090317213820.GC13458@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjqQu-0000cQ-8l
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 08:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZCRHl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 03:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbZCRHlz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 03:41:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZCRHlz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 03:41:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 423A0754C;
	Wed, 18 Mar 2009 03:41:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4599F754B; Wed,
 18 Mar 2009 03:41:43 -0400 (EDT)
In-Reply-To: <20090317213820.GC13458@blimp.localdomain> (Alex Riesen's
 message of "Tue, 17 Mar 2009 22:38:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F1A9164-1390-11DE-85F9-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113594>

Alex Riesen <raa.lkml@gmail.com> writes:

> So that Cygwin port can continue work around its supporting
> library and get access to its faked file attributes.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ...
> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index ee3911f..f3f781b 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -66,7 +66,7 @@ static void copy_templates_1(char *path, int baselen,
>  		else
>  			exists = 1;
>  
> -		if (lstat(template, &st_template))
> +		if (lstat_for_copy(template, &st_template))
>  			die("cannot stat template %s", template);
>  
>  		if (S_ISDIR(st_template.st_mode)) {

Yuck; that's a bit too ugly for generic code.  Will there be other places
that this needs to be used?  If so, we'd probably need to encourage its
use where appropriate, which is even uglier but we cannot avoid it...

Also when the underlying system does not know the executable bit, how
would this help?  I thought that earlier you said the part that checks if
it wants to execute hooks with access(X_OK) will fail, so...
