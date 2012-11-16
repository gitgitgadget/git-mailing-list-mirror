From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t/t3511: demonstrate breakage in cherry-pick -s
Date: Thu, 15 Nov 2012 17:58:39 -0800
Message-ID: <7v8va28g1c.fsf@alter.siamese.dyndns.org>
References: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
 <1352943474-15573-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 02:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZBCq-0004gf-01
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 02:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937Ab2KPB6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 20:58:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55620 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851Ab2KPB6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 20:58:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E3869D6E;
	Thu, 15 Nov 2012 20:58:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O2DmLSs4RlxVRC+fkC+YuqhbbbM=; b=W6Atjr
	vKeeI9r7FGJqLbFG6kgEfxWd1hsxfH9ub62K+AqRunBwzOm2nfnBhiO/CQSfsVCj
	jcd159vvSOiUh4ihfUjJKvBo8HlrDFxkuCCb82A2CHfxxO7Bn92N3Wqc8NfKmj/d
	wwJEHNsMBwhv9PwT0YaYRnj0F7dOAl+Ohub1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ImO9zp7auzjoU8dr7dV6umtHgxTioL8/
	egDOZwkre26pN+VOMT9hKyT3ZpI5t+/kWIEXJMhlHEDKfF2xLNrAZjHgMD5RNgH+
	FRnoc4N5aWApMrOad/K8y9YGcvu247vJBHvvFmb7rDsUpRCSRKn5UB3zvkdNqRAh
	GzcV/yP57y4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B6A59D6D;
	Thu, 15 Nov 2012 20:58:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFAE99D6C; Thu, 15 Nov 2012
 20:58:40 -0500 (EST)
In-Reply-To: <1352943474-15573-2-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Wed, 14 Nov 2012 17:37:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24B71E84-2F91-11E2-8FFE-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209857>

Brandon Casey <drafnel@gmail.com> writes:

> The cherry-pick -s functionality is currently broken in two ways.
>
>    1. handling of rfc2822 continuation lines has a bug, and the
>       continuation lines are not handled correctly.

This is not limited to you, but people should think twice when
writing "has a bug" and "are not handled correctly" in their log
message.  Did you write what the expected and actual behaviours?

> +rfc2822_mesg="$non_rfc2822_mesg
> +
> +Signed-off-by: A.U. Thor
> + <author@example.com>
> +Signed-off-by: B.U. Thor <buthor@example.com>"

The S-o-b: lines are meant to record people's contact info in human
readable forms, and folding the lines like the above makes it a lot
harder to read.  They typically do not have to be folded.

Besides, the footer lines are *not* RFC2822 headers (and are not
used as such when send-email comes up with Cc: list) in the first
place; have we ever said anything about supporting the RFC2822 line
folding in the commit footer?  If not (and I am reasonably sure we
never have), I personally think we should actively *discourage* line
folding there.

>       i.e. we should produce this:
>
>          Signed-off-by: A.U. Thor <author@example.com>
>          (cherry picked from )
>          Signed-off-by: C O Mmitter <committer@example.com>
>
>       not
>
>          Signed-off-by: A.U. Thor <author@example.com>
>          (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
>
>          Signed-off-by: C O Mmitter <committer@example.com>

I can buy that, but then this makes it very clear that these footer
lines are not shaped like RFC2822 headers, no?

Thanks.
