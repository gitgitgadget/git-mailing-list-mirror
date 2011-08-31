From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff/xprepare: initialise xdlclassifier_t cf in
 xdl_prepare_env()
Date: Wed, 31 Aug 2011 10:02:30 -0700
Message-ID: <7vei01zf89.fsf@alter.siamese.dyndns.org>
References: <1314766126-5060-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 19:02:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyoBT-0001Ut-PF
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 19:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157Ab1HaRCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 13:02:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932133Ab1HaRCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 13:02:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3690E4CF8;
	Wed, 31 Aug 2011 13:02:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cj5xtlh6cS9bXt5f3JUGCPJI1/0=; b=t48Dj7
	nEwRuJdQ7Ddm7GceH9tdjvK/rzYTEbBTp6fQ84tR7IQqCLdth+UE/UJuhGPmjdMl
	cnnZLUtuBD1ntSuqtpYtPyt2wYmcb7YN/zyueTrQkbAtrT1alubm1B8uw3ysIQ70
	3stx1Iu6tv4vgWx4giXN8/GotjQMJKEkNuysY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v6sdjnheh9v0NbaJjtfeDTCt6qisS1zw
	Txj1+GcdLJEJDn3PViWeMoEPOgeD4X5sCYwm3dESDiclxCUPA+qI2fJXTlJqquE7
	d7a9RVrT+CZ4FoHjOQ0pUeJcHVI6Mb1xxwupLwx0DlFo4BD71uzkL3D/ZEEImlZF
	Iv01gI5HkPU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D5D94CF7;
	Wed, 31 Aug 2011 13:02:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA5C84CF6; Wed, 31 Aug 2011
 13:02:31 -0400 (EDT)
In-Reply-To: <1314766126-5060-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Wed, 31 Aug 2011 12:48:46 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03F0B728-D3F3-11E0-8A8E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180493>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Ensure that the xdl_free_classifier() call on xdlclassifier_t cf is safe
> even if xdl_init_classifier() isn't called. This may occur in the case
> where diff is run with --histogram and a call to, say, xdl_prepare_ctx()
> fails.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

Thanks. Did you find this by code inspection?

>  xdiff/xprepare.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 620fc9a..4323596 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -239,6 +239,9 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>  	long enl1, enl2, sample;
>  	xdlclassifier_t cf;
>  
> +	cf.rchash = NULL;
> +	cf.ncha.head = NULL;

Would it be more appropriate to use memcpy(&cf, 0, sizeof(cf)) instead, so
that we wouldn't have to worry about a similar breakage when a new field
is added to "struct xdlclassifier" later?
