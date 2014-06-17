From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] refs.c: SSE2 optimizations for check_refname_component
Date: Tue, 17 Jun 2014 10:35:43 -0700
Message-ID: <xmqqk38fmob4.fsf@gitster.dls.corp.google.com>
References: <1402974642-13808-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, neleai@seznam.cz,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 19:36:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwxId-0006aq-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 19:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933460AbaFQRf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 13:35:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64060 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933325AbaFQRfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 13:35:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B9C7C1F4E1;
	Tue, 17 Jun 2014 13:35:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=csIKqD5aID3mVwwTNN0aDFgwpP4=; b=t+MQC+
	Pwmgre8GqSAhgEHaVXbeZgksnjpLkeichHA4aokV1cz2xpHTCkrZPhvLlCRgjv8t
	v9Kh7HdCIY0xXqkanHC+1AlZTFKoDZ9OBKUAa3L2CE+t7cD/po1XK1VdsQ3FNUuV
	YnMAAYzkDM/8eRaPvMjwTURLGOjPHORj6Yhig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvTJ54fsgE136OTHXxFoxbrBZKroW/Ce
	1Z0kq9qlkFQPYpg/d7Hgk0ireCaO7PULAb9ReXrPqEtvvkvXfjep76R/mKkaYfFg
	0x+5hd/RclLtLBX3w7IfLgaIpiUK3L7H3RvIQpdeUdtDG5XMpVbcA2qJouosU2JU
	Yn9C6l5YV0k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B07EF1F4E0;
	Tue, 17 Jun 2014 13:35:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C218E1F4D7;
	Tue, 17 Jun 2014 13:35:42 -0400 (EDT)
In-Reply-To: <1402974642-13808-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 16 Jun 2014 23:10:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CE731604-F645-11E3-B931-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251927>

David Turner <dturner@twopensource.com> writes:

>  git-compat-util.h  |  11 +++
>  refs.c             | 223 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  t/t5511-refspec.sh |  20 +++++
>  3 files changed, 236 insertions(+), 18 deletions(-)

Hmph, on what branch are you basing your patch?  As a follow-up to
your dde8a902 (refs.c: optimize check_refname_component(),
2014-06-03) I originally tried to apply it on top of it but it does
not seem that the patch is based on that version; nor I have a blob
46139d2 on which the patch claims your refs.c changes are based on.

... goes and looks ...

Ahh, I think I know where it is broken.

> diff --git a/refs.c b/refs.c
> index 46139d2..5c2f68b 100644
> --- a/refs.c
> +++ b/refs.c
> ...
> @@ -46,17 +49,19 @@ static int check_refname_component(const char *refname, int flags)
>  		int ch = *cp & 255;
>  		unsigned char disp = refname_disposition[ch];
>  		switch(disp) {

There is a stylo here (missing SP after "switch"), which I already
have locally fixed before pushing it out on 'next'.  I'll fix up
this patch and try to apply.

Thanks.
