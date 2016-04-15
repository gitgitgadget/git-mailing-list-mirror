From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/21] bisect: plug the biggest memory leak
Date: Fri, 15 Apr 2016 14:18:32 -0700
Message-ID: <xmqqh9f2a7vb.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-8-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:18:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arB8V-0007wL-Ek
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbcDOVSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:18:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752068AbcDOVSf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:18:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA21B138CA;
	Fri, 15 Apr 2016 17:18:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cahGwZm4tsKfADj3oZwpMHwkIus=; b=O5c5U3
	7fIONhZU3T1cSwWvFGbOFnJPs9UXwHee0g3PMfin7Ft/6vFOccRErueWETtfkx35
	TgmN11ttJgRO/F8HN36GrXkpH9JAdMlwAsOL576SB9KbUrcVv2l3JK4nZN7k8nRP
	58SHV2Sn9vN2nfsKh07PZJVrHEn8pMiWJROmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YMt41CZMOuuloJ0BkjzVjdwIJJOHiQOu
	jGOHVktIPbiyWEHqDVgXnn38E+Syt/kfDt01L+ylgDiEZ4DUsYSA62XJcnsMRQ39
	UzoUc0X+o3FQh7zajqAxlwri++fw5GAL7gpu2oEKmjdS5T9hZF5sYiu4c0ttZSaq
	C1tZKSkI094=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C14CA138C9;
	Fri, 15 Apr 2016 17:18:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E176138C6;
	Fri, 15 Apr 2016 17:18:33 -0400 (EDT)
In-Reply-To: <1460294354-7031-8-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BC438DC-034F-11E6-A297-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291665>

Stephan Beyer <s-beyer@gmx.net> writes:

> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  bisect.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/bisect.c b/bisect.c
> index 7996c29..901e4d3 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -984,6 +984,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  		exit(10);
>  	}
>  
> +	free_commit_list(revs.commits);
> +
>  	nr = all - reaches - 1;
>  	steps = estimate_bisect_steps(all);
>  	printf("Bisecting: %d revision%s left to test after this "

While I do not think this is wrong per-se (i.e. it is clear that we
no longer need revs.commits), after this the function will return to
the top-level caller and exit immediately, and I do not see anything
that desperately wants to use as much memory as available (i.e. would
be helped by this piece of memory released early).  "the biggest"
may be an overstatement ;-)
