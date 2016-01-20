From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule update: Initialize all group-selected submodules by default
Date: Wed, 20 Jan 2016 13:30:28 -0800
Message-ID: <xmqqr3hc3pmz.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:30:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM0Kq-0007Gy-3q
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 22:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbcATVad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 16:30:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbcATVab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 16:30:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7BAD3C1BE;
	Wed, 20 Jan 2016 16:30:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rHjJRiMVIkKf/74WbFtW7Yds2/0=; b=YJqtHG
	pAFUk14JQ55T0Yh+omBWqiK57CbVKqc17UqzveiE8NZapHIkj+PLJXHtRF16Ubb4
	nISUBbnsm7nG+5rdzNrWoIVKY17GHK4Mk0/u/lsBqpmTkrwpTPlCUNoJa3wMSRuX
	Pc8YA/3Orp4f23xUNEErLrusHSGV9vAts8ziA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TGlatbnD0lJi00kGwbUmlCbYfNw4+irH
	Fp7t5b6sVtb87vVz40K0vXP8S+d/aP8ujmw0WY+nVRsJDL8ab2ZYLNpx4M/9yKhF
	NG1CTzrXVXz8579zInyXfqG4ES2IJxIdkNR1L1fhvCnTIxNqLNRBK2QX3KXt7qCE
	VRWVfidA3Pw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F41D3C1BD;
	Wed, 20 Jan 2016 16:30:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 186473C1BB;
	Wed, 20 Jan 2016 16:30:30 -0500 (EST)
In-Reply-To: <1453260880-628-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 19 Jan 2016 19:34:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 078E0894-BFBD-11E5-9C71-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284470>

Stefan Beller <sbeller@google.com> writes:

> All submodules which are selected via submodule groups
> ("submodule.groups") are initialized if they were not initialized
> before updating the submodules.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 30 +++++++++++++++++++++++++++++-
>  t/t7400-submodule-basic.sh  | 26 ++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4684f16..def382e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -577,6 +577,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  
>  struct submodule_update_clone {
>  	/* states */
> +	struct string_list *submodule_groups;

Again, do we need a field named submodule_groups in a struct whose
name already makes it clear this is about submodule?

More importantly.

If this were used to implement "there are various groups defined,
and the user tells us that submodules in this and that groups are to
be automatically initialized", then naming the field with a name
that is more specific than just "groups" makes tons of sense, but
even in such a case, the best adjective to clarify what kind of
"group" this field is about is not "this is a submodule group".

The answer I would give to a question "what kind of group this field
is about?" would be "this is an auto-init group", so I'd have that
'auto-init' ness somewhere in its name.

> @@ -633,6 +634,7 @@ static int update_clone_get_next_task(struct child_process *cp,
>  		const char *update_module = NULL;
>  		char *url = NULL;
>  		int needs_cloning = 0;
> +		int in_submodule_groups = 0;

Likewise.  The significance of the membership in this group is
totally unclear from this variable name.  I read this boolean to be
keeping track of "is this submodule to be auto initialized"?
