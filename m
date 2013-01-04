From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/19] dir.c: use a single struct exclude_list per
 source of excludes
Date: Fri, 04 Jan 2013 13:03:59 -0800
Message-ID: <7v1ue0veww.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-12-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrERN-0002q6-TI
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 22:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab3ADVEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 16:04:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240Ab3ADVED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 16:04:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A896CA964;
	Fri,  4 Jan 2013 16:04:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5QDcShlhPaaU8Irw7P2Hp5TwKmg=; b=LvMEhF
	wJKeKXVAAA4MZInyW+6ZRkBG3zQZ9K+AYL4I1rzB04o6pwX/3CP9wFW96grY+0S1
	XMR6cFv1vJpqByTDaaSkmuZAIPXkGihREpUyU7ZjZS6Jk0BlGIUG8TwER1Nun+DE
	nzg7+BTrnWTaupCKDkm9ap7upwA35vBKDLaBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yf5vwzqIaxkqWCExWEaf79ghV+4P9lIN
	LeXUkVJyPEwtLSiYah/6IXHBlyBxQkPFOWJ2YzniVYoDHtRIQYp3meQy/+lHXuxv
	mJ7Fxb1iil51v+IR1JkCgZfd2cvAdtaw5OI29WkEC5/d/Xrb2ZAyr3NsXB2J+NXc
	tL4b7xIlG7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 929BEA962;
	Fri,  4 Jan 2013 16:04:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E24CEA95F; Fri,  4 Jan 2013
 16:04:01 -0500 (EST)
In-Reply-To: <1356575558-2674-12-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 27 Dec 2012 02:32:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43FCC62A-56B2-11E2-8FB5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212640>

Adam Spiers <git@adamspiers.org> writes:

> diff --git a/builtin/clean.c b/builtin/clean.c
> index 0c7b3d0..bd18b88 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -97,9 +97,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	if (!ignored)
>  		setup_standard_excludes(&dir);
>  
> +	add_exclude_list(&dir, EXC_CMDL);
>  	for (i = 0; i < exclude_list.nr; i++)
>  		add_exclude(exclude_list.items[i].string, "", 0,
> -			    &dir.exclude_list[EXC_CMDL]);
> +			    &dir.exclude_list_groups[EXC_CMDL].ary[0]);

This looks somewhat ugly for two reasons.

 * The abstraction add_exclude() offers to its callers is just to
   let them add one pattern to the list of patterns for the kind
   (here, EXC_CMDL); why should they care about .ary[0] part?  Are
   there cases any sane caller (not the implementation of the
   exclude_list_group machinery e.g. add_excludes_from_... function)
   may want to call it with .ary[1]?  I do not think of any.
   Shouldn't the public API function add_exclude() take a pointer to
   the list group itself?

 * When naming an array of things, we tend to prefer naming it

     type thing[count]

   so that the second element can be called "thing[2]" and not
   "things[2]".  dir.exclude_list_group[EXC_CMDL] reads beter.

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index ef7f99a..c448e06 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -420,10 +420,10 @@ static int option_parse_z(const struct option *opt,
>  static int option_parse_exclude(const struct option *opt,
>  				const char *arg, int unset)
>  {
> -	struct exclude_list *list = opt->value;
> +	struct exclude_list_group *group = opt->value;
>  
>  	exc_given = 1;
> -	add_exclude(arg, "", 0, list);
> +	add_exclude(arg, "", 0, &group->ary[0]);

This is another example where the caller would wish to be able to say

	add_exclude(arg, "", 0, group);

instead.
