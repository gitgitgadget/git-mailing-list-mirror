From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] connect.c: Fix memory leak
Date: Tue, 10 Mar 2015 15:35:50 -0700
Message-ID: <xmqq61a8zdix.fsf@gitster.dls.corp.google.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:35:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSko-0004A0-Lz
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbbCJWfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:35:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753160AbbCJWfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:35:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7F263E1A6;
	Tue, 10 Mar 2015 18:35:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=82trbohTiWuP0iODmhGdtsTJAFI=; b=HrdGX7
	L7H8ngAarnZpQ8coRf1dMEVIighGxGUThiM9nGh6YqfYUIi54Mjf/LtHrklQfFco
	JYIkRsqd/JBlUkGzhgUdt/wiIckdfRMxfAF8GWvNKUpFcjs11qwCdPEzdv06hKX9
	qXGJRw7Phwg1881rl1xWluuzGBaKLSnqdIh+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5PPWq8vkE7V2So0GqahtjbFedwN4JBN
	p9OM68VCEJjZHm/WXYnfJ1RXRCfQPIh8kun0QKyqNQO11N4XT4El8s3t9dhq570X
	FrfQk4NIisB7Ezd1qRkmvysLqL6CISmBWM6RpySJhy/Pka5zpaoHbnb4O2XXHMe8
	iQZbcsJhSTg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7CD63E1A5;
	Tue, 10 Mar 2015 18:35:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BFC43E1A4;
	Tue, 10 Mar 2015 18:35:51 -0400 (EDT)
In-Reply-To: <1425920304-22360-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 9 Mar 2015 09:58:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE34CCE4-C775-11E4-9A43-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265273>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  connect.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/connect.c b/connect.c
> index ce0e121..6090211 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -739,6 +739,7 @@ struct child_process *git_connect(int fd[2], const char *url,
>  
>  				free(hostandport);
>  				free(path);
> +				free(conn);
>  				return NULL;

The lack of sufficient context in the patch made me wonder if merely
freeing conn is sufficient or do we need some process related
clean-up before freeing it.

It appears that this codepath is used only when debugging with
CONNECT_DIAG_URL and we didn't start any process --- we only
cleared it with a few arrays initialized to empty at this point of
the code.

So it should be safe.  I wish I didn't have to do the digging
myself, though ;-)

>  			} else {
>  				ssh = getenv("GIT_SSH_COMMAND");
