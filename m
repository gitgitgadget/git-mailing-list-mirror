From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision.c: Clarify error message for missing objects
Date: Mon, 14 Mar 2011 10:40:55 -0700
Message-ID: <7vsjupeh20.fsf@alter.siamese.dyndns.org>
References: <7vzkp1y0jr.fsf@alter.siamese.dyndns.org>
 <4D7E303A.5090605@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 18:41:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzBlY-0003ux-61
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 18:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab1CNRlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 13:41:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab1CNRlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 13:41:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7DDF8323F;
	Mon, 14 Mar 2011 13:42:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CJOia6FW3HF6amPxSH5XvnGPEOw=; b=JElevD
	shxMMey+bwj87xjbIpdnUtHx+5at4kMWPomxdiF3OjFjA1Es/EVUOdcQee3wmKwy
	9rNg7mrTs43Bz8cjhOWjjQyHUI33QDCq0eV8P7qp4JAddtBQwcVg/k9wNjY1X88Q
	uBR1zTEpcJ4gTu5+/pMghttgLXYZ4lntTJMoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xP4k+LPTwrl4Ek5ta9G0ga2n0MVgFeyK
	Y1sM/SoL5V6i9wxsTzD01HcWG37X2K9WUOotB85r9v/j+1wovl3BGX+Vjc1zX9zC
	PL+amdlXbgU7woKLx79ILDy3Z/yZLLikcbVbmy/M/BCnsT5808ehfneIgSa46DU7
	tT/BwgwnKJQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D623323B;
	Mon, 14 Mar 2011 13:42:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 32473323A; Mon, 14 Mar 2011
 13:42:26 -0400 (EDT)
In-Reply-To: <4D7E303A.5090605@elegosoft.com> (Jakob Pfender's message of
 "Mon, 14 Mar 2011 16:11:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FE821EE-4E62-11E0-9373-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169002>

Jakob Pfender <jpfender@elegosoft.com> writes:

> This patch introduces a check to see whether an object exists (with the
> appropriate error message if it doesn't) and removes the unnecessary and
> misleading original error message if parse_object() fails.

How does this interact with object replacement?

I suspect the real issue is in read_sha1_file_repl() that says:

    /*
     * This function dies on corrupt objects; the callers who want to
     * deal with them should arrange to call read_object() and give error
     * messages themselves.
     */

without giving sufficient support for the callers that wish to use
read_object() themselves to implement the object replacement logic.


> Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
> ---
>  revision.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 86d2470..085aac2 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -173,9 +173,9 @@ static struct object *get_reference(struct
> rev_info *revs, const char *name, con
>  {
>      struct object *object;
>
> +    if (sha1_object_info(sha1, NULL) < 0)
> +        die("Not a valid object name %s", name);
>      object = parse_object(sha1);
> -    if (!object)
> -        die("bad object %s", name);
>      object->flags |= flags;
>      return object;
>  }
