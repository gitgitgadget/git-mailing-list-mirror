From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] transport-helper: fix remote helper namespace regression
Date: Fri, 10 May 2013 13:28:11 -0700
Message-ID: <7vsj1uzijo.fsf@alter.siamese.dyndns.org>
References: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
	<1368187710-4434-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 22:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UatvW-00011I-W9
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 22:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab3EJU2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 16:28:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131Ab3EJU2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 16:28:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4C9D1D273;
	Fri, 10 May 2013 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PDMmSJx/7zlMQ8hcsuyQOlwqnJE=; b=u5lseG
	EEF94PDs43oywhqwVnX0+8jIybQFV2z9rfepYMgHnzHOF3bJ0NrrU3U5NKYgp29E
	osA6I0YjlPDDTKutz4fzZTJ9NBfVhKQ7L7j/GcEiRRVCJLb7hpCs+Ws6pokDnhAq
	3UX+MRS5O7xkuIESP2u1EOzvVNqgGtXfRMFcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r90mtHlVKEE7nnjtjZ6HOFLyVu7k9LUE
	BHMlB6teZ9VbpGqf6rxxOsRPBpqCRbFfrzUbA/uQX+QHGk5g66BGqUtKWPgsdvyQ
	skbPJMrhUvPTwEYc32dsffyhnRUiCN+TiX1sZq3rR/ktQhw7r69l86y2abE6IyUx
	eXfdHfAn88E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9ADB1D272;
	Fri, 10 May 2013 20:28:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F9561D269;
	Fri, 10 May 2013 20:28:21 +0000 (UTC)
In-Reply-To: <1368187710-4434-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 10 May 2013 07:08:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28239440-B9B0-11E2-93AA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223904>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +test_expect_success 'push update refs failure' '
> +	(cd local &&
> +	git checkout update &&
> +	echo "update fail" >>file &&
> +	git commit -a -m "update fail" &&
> +	git rev-parse --verify testgit/origin/heads/update >expect &&
> +	GIT_REMOTE_TESTGIT_PUSH_ERROR="non-fast forward" \
> +	test_expect_code 1 git push origin update &&

This is not portable; as the remainder of this subshell does not
mind having the environment, a simple fix may be something like:

	GIT_REMOTE_TESTGIT_PUSH_ERROR="..." &&
        exoprt GIT_REMOTE_TESTGIT_PUSH_ERROR &&
        test_expect_code 1 git push ... &&

> +	git rev-parse --verify testgit/origin/heads/update >actual &&
> +	test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'proper failure checks for fetching' '
>  	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
>  	export GIT_REMOTE_TESTGIT_FAILURE &&
> diff --git a/transport-helper.c b/transport-helper.c
> index f11d78a..2f5ac3f 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -705,7 +705,7 @@ static int push_update_ref_status(struct strbuf *buf,
>  
>  	(*ref)->status = status;
>  	(*ref)->remote_status = msg;
> -	return 0;
> +	return !(status == REF_STATUS_OK);
>  }
>  
>  static void push_update_refs_status(struct helper_data *data,
