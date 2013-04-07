From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] format-patch: improve head calculation for
 cover-letter
Date: Sun, 07 Apr 2013 00:50:45 -0700
Message-ID: <7vbo9q93u2.fsf@alter.siamese.dyndns.org>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
 <1365318630-11882-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 09:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOkNI-0005zB-Ex
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161287Ab3DGHus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:50:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571Ab3DGHur (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:50:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D06510071;
	Sun,  7 Apr 2013 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pedg4VJtimY5dZJ0UKauP2zEvN4=; b=jNbDeo
	eSKnec/h+bgMq+pLrepqdjmqevxmbVxiM0q4YEHuuITc8w2ulH787VZ3S2wo16mz
	SISUhrChlCxn5z1Al/LmKuX6yhxqW/VfiEUEQYLaGzcDYhIrzCQiIatcfN2kSKbT
	+uL/oAUrIhXEhGQDGscn0vn1voe7EQONxW/eo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a8xgJQNAcrhmBGYPPOpLfeNxBFh6eb1n
	llyhuuEw5YWSPXkIZ6CPZsKq+83pyUO0tE58wW4MdLWgvHvxIs6OUD3D7s2fqhXL
	9EL/bYDOi//OvNWzL/TKE5suN0Z3+B+HBQQ14U4z/kCjXlG4HuuMCmCM15tegUG6
	aY/upYxgeZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40AB310070;
	Sun,  7 Apr 2013 07:50:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A14E81006E; Sun,  7 Apr
 2013 07:50:46 +0000 (UTC)
In-Reply-To: <1365318630-11882-3-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 7 Apr 2013 01:10:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB6B0696-9F57-11E2-8062-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220293>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If we do it after the revision traversal we can be sure that this is
> indeed a commit that will be processed (i.e. not a merge) and it's the
> top most one (thus removing the NEEDSWORK comment).

There may not be a single top-most one anyway (which is what that
"randomly pick" comment refers to and punts), so taking the tip
after traversal is just as good as doing it before.  So this is a
good change, but it still is punting.

The "head" is used only to produce the fake "From xxxxx <datestamp>"
line to mark the output as format-patch output to /etc/magic, so it
does not make sense to do anything fancier, like erroring out with
"You specified two or more tips and we cannot pick one".

So it is a good thing to punt.

I like this simplification.  Good job.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/log.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 8f0b2e8..6c78d7f 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1319,24 +1319,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	rev.show_root_diff = 1;
>  
>  	if (cover_letter) {
>  		if (!branch_name)
>  			branch_name = find_branch_name(&rev);
>  	}
> @@ -1372,6 +1354,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		list = xrealloc(list, nr * sizeof(list[0]));
>  		list[nr - 1] = commit;
>  	}
> +	if (nr > 0)
> +		head = list[0];
>  	total = nr;
>  	if (!keep_subject && auto_number && total > 1)
>  		numbered = 1;
