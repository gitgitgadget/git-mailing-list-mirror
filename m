From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/12] refs.c: pass NULL as *flags to read_ref_full
Date: Fri, 18 Jul 2014 15:31:20 -0700
Message-ID: <xmqqd2d2l2o7.fsf@gitster.dls.corp.google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-6-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 00:31:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Ggp-0004un-Em
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 00:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199AbaGRWb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 18:31:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55260 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400AbaGRWb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 18:31:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1222287AC;
	Fri, 18 Jul 2014 18:31:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RfD6rsrFDy+iCYN+WKNYgMSnpzk=; b=hbLEhZ
	+cHI0LUUSe/P7d1/fSusaBVidDbbDXpLrYttGw9na/zQz7VNYql56XdJ5vxzamGB
	g2kB2NGUsDKvpmsH8oAe+Tp/p8YqLb8xCxQX2R47dm8AURh66vOHLGWjY+UYC3x0
	4eQpXKwI/d3N7f1D19G8779YvHGt4pmvnd91M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uo952nPohBYEMM8ZKvB1J8feE3+j3h/Z
	lUC8NexUTWG2cheC/dyMN/ZdaH3eRyIt86+8QXXLDUg1iO4hLfa+YvcVlvdyHEgs
	tPBlVI6ejbW8MLx5qeDj7fvu8WmgiA0K+mRSNW1+Ez2g83zzGZbYst3i2C0wwWxo
	z3EFm54GQQE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D74FE287AA;
	Fri, 18 Jul 2014 18:31:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D24C7287A3;
	Fri, 18 Jul 2014 18:31:21 -0400 (EDT)
In-Reply-To: <1405549392-27306-6-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 16 Jul 2014 15:23:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E8F9D84-0ECB-11E4-A789-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253855>

Ronnie Sahlberg <sahlberg@google.com> writes:

> We call read_ref_full with a pointer to flags from rename_ref but since
> we never actually use the returned flags we can just pass NULL here instead.

Sensible, at least for the current callers.  I had to wonder if
rename_ref() would never want to take advantage of the flags return
parameter in the future, though.  For example, would it want to act
differently when the given ref turns out to be a symref?  Would it
want to report something when the ref to be overwritten was a broken
one?

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 7d65253..0df6894 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2666,7 +2666,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  		goto rollback;
>  	}
>  
> -	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
> +	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
>  	    delete_ref(newrefname, sha1, REF_NODEREF)) {
>  		if (errno==EISDIR) {
>  			if (remove_empty_directories(git_path("%s", newrefname))) {
