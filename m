From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 jk/war-on-sprintf] read_branches_file: plug a FILE* leak
Date: Fri, 23 Oct 2015 10:18:25 -0700
Message-ID: <xmqqfv11pkpq.fsf@gitster.mtv.corp.google.com>
References: <2c89c60e470def8f85941933c9fafe4db314628a.1445579874.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	git-for-windows@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Oct 23 19:18:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpfzB-0003aY-UR
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 19:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbbJWRS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 13:18:28 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751305AbbJWRS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 13:18:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 60311244DA;
	Fri, 23 Oct 2015 13:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/AKynAfDxqzkWEgeo+B9CYZSRk4=; b=C0a8BW
	elkW07Ao+5eqfg/MivuY2B8TKZE9u3Y+HYpMaQLUKUFuWuXaAf7VhPKLt+AzKcrk
	6G1Jc4BtPSJaZULTPdVqDYEz57JIA0JoWQVljlru551gtKTilJOjxI+wTZ+air+z
	/mgFfW6kQpLmGOsPzz9jMRTgcTxzUKLBssjSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q9CYBE1gakOz2ma2s6dGJIaKNIIqDUcf
	sVIvxBbsvy0TODXwnlMrJx/ZeWFTvYdB0eQB8VY8OIAdS36hewnl7cAka+PFuDix
	R5wDZilmfFbELcmWJhLPZMjYHbxsCrOE4iCSlxuspHH0/3UKnDyN9kYffqf0VUXT
	xi9NnwfCSLw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54FE5244D9;
	Fri, 23 Oct 2015 13:18:27 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B9BC8244D7;
	Fri, 23 Oct 2015 13:18:26 -0400 (EDT)
In-Reply-To: <2c89c60e470def8f85941933c9fafe4db314628a.1445579874.git.j6t@kdbg.org>
	(Johannes Sixt's message of "Fri, 23 Oct 2015 08:02:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 12945A30-79AA-11E5-BD5F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280101>

Johannes Sixt <j6t@kdbg.org> writes:

> The earlier rewrite f28e3ab2 (read_branches_file: simplify string handling)
> of read_branches_file() lost an fclose() call. Put it back.
>
> As on Windows files that are open cannot be removed, the leak manifests in
> a failure of 'git remote rename origin origin' when the remote's URL is
> specified in .git/branches/origin, because by the time that the command
> attempts to remove this file, it is still open.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Thanks (and also for 2/2).

>  remote.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/remote.c b/remote.c
> index 1101f82..fb16153 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -282,6 +282,7 @@ static void read_branches_file(struct remote *remote)
>  		return;
>  
>  	strbuf_getline(&buf, f, '\n');
> +	fclose(f);
>  	strbuf_trim(&buf);
>  	if (!buf.len) {
>  		strbuf_release(&buf);
