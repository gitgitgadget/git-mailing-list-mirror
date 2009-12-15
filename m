From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/7] reset: do not accept a mixed reset in a .git dir
Date: Tue, 15 Dec 2009 12:20:02 -0800
Message-ID: <7vocm0yop9.fsf@alter.siamese.dyndns.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
 <20091212043259.3930.98779.chriscool@tuxfamily.org>
 <7vtyvvn9wx.fsf@alter.siamese.dyndns.org>
 <200912152041.36194.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 15 21:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKdst-000492-UH
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 21:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933159AbZLOUUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 15:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933119AbZLOUUf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 15:20:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932748AbZLOUUe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 15:20:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 601D985157;
	Tue, 15 Dec 2009 15:20:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=09iRagxuhPgmo8wE4DSzcamtKNY=; b=Glnn05
	XRJIzIYpClyaJOuvltw7iOeFHge/wrEc/L/K6+wtnpcGu2XNd0nmc1q6xDQgYA3f
	tUOEZ3TQIgxAj1YK69aDVrdsl9uXQMKbCTF3h+9eY/qu/dlHEnjUV3O41yvj6xMO
	jHQXSn7sdhAFeOUGaap1YrrxV/sevXDGWOgFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fEyr+h9f/+ggu1gaQNh8T9z4kO2sB5za
	b8i/lFJ7LYUbLFSkOdvfZEt74BFarRjHzKigatehtEIM7m7Lz9B7U08AeRe0u4SW
	JagDZoeiYc0cqmNnv2rD0k78bqsJmhEOUy2E9JII9B77nOUS4T3UARvMmxDt7cm5
	Iivli91zxtc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C173E85150;
	Tue, 15 Dec 2009 15:20:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BA008514A; Tue, 15 Dec
 2009 15:20:03 -0500 (EST)
In-Reply-To: <200912152041.36194.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue\, 15 Dec 2009 20\:41\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4240FE8E-E9B7-11DE-9063-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135298>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/builtin-reset.c b/builtin-reset.c
> index 11d1c6e..ac3505b 100644
> --- a/builtin-reset.c
> +++ b/builtin-reset.c
> @@ -286,11 +286,15 @@ int cmd_reset(int argc, const char **argv, const char 
> *pre
>         if (reset_type == NONE)
>                 reset_type = MIXED; /* by default */
>
> -       if ((reset_type == HARD || reset_type == MERGE)
> -           && !is_inside_work_tree())
> +       if (reset_type != SOFT && reset_type != MIXED
> +            && !is_inside_work_tree())
>                 die("%s reset requires a work tree",
>                     reset_type_names[reset_type]);
>
> +       if (reset_type == MIXED && is_bare_repository())
> +               die("%s reset is not allowed in a bare repository",
> +                   reset_type_names[reset_type]);

This patch text itself makes sense, I think, except the first part.
