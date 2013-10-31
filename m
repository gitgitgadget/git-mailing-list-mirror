From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/16] revision: add missing include
Date: Thu, 31 Oct 2013 11:11:07 -0700
Message-ID: <xmqqppql71l0.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbwiC-0004xX-1K
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab3JaSLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:11:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425Ab3JaSLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:11:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABF6D4E420;
	Thu, 31 Oct 2013 14:11:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LSjs5czVVHOy1bmI46WwpluJRb4=; b=FGNKhKDT1uEND6zJJSa7
	cDZP3pQ4stgs7jOXnsVHfXvioSBk8P0yLK0hQLH16/xURdXPLbBnBYnLBxpU4+8u
	uf0XiMRrjznf4mVUOi0CeYJqq0PPnVl2Y27NbV2IS7vRj0cU/YUCVqIZOmAx3ugt
	Q8hBLWKjRYNX3fwR2bpte5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=N/8v9hksh757u0qWjbtke9/0vI6zvTxLdmbNnbAx1nMEV0
	GZJ4k4EQk0bVt2vB2OVOlQWj8v1vO9JKH+delfEkcwT53jChFsSvjOozi+TuXJf/
	IQPgEmKuzaXMfqihfVWZVVDk4kWOtaq4zm7Ha/uHaoChDVYV3KEBTmvmqwpbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 979474E41F;
	Thu, 31 Oct 2013 14:11:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8F984E41D;
	Thu, 31 Oct 2013 14:11:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1246CCE-4257-11E3-8E27-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237141>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise we might not have 'struct diff_options'.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  revision.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/revision.h b/revision.h
> index e7f1d21..89132df 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -5,6 +5,7 @@
>  #include "grep.h"
>  #include "notes.h"
>  #include "commit.h"
> +#include "diff.h"
>  
>  #define SEEN		(1u<<0)
>  #define UNINTERESTING   (1u<<1)

This is a step in the right direction to change the contract between
this header file and its consumers, but I think it falls short of
doing a good job at it.

The rule used to be that "if you use a declaration in revision.h,
you must include diff.h before including it, even if you do not use
any declaration made in diff.h yourself". 

The new rule this patch introduces is "if you use a declaration in
foo.h, include foo.h, period---foo.h should handle its requirement
on its own internally and consumers should not have to care", which
is much saner.

But the patch needs to also remove '#include "diff.h"' from existing
consumers that themselves do not use any declaration from "diff.h"
(e.g. bundle.c; there are others), while keeping the inclusion in
those that do (e.g. builtin/commit.c). That can be a separate patch
that immediately follow this one, or a part of the same patch.

Thanks.
