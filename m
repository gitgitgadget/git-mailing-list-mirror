From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] combine-diff.c: refactor: extract insert_path()
Date: Sat, 11 Apr 2015 13:14:28 -0700
Message-ID: <xmqqfv865snv.fsf@gitster.dls.corp.google.com>
References: <1428006853-21212-1-git-send-email-max@max630.net>
	<1428076716-4449-1-git-send-email-max@max630.net>
	<1428076716-4449-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 22:14:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yh1nc-0005aE-4Q
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 22:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377AbbDKUOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2015 16:14:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755291AbbDKUOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 16:14:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65CA44596E;
	Sat, 11 Apr 2015 16:14:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UHjhFXyPVQ5pXaQSnGEoqTPwG7s=; b=rK/qKo
	3VaoioQTsYqPdwRaq3jebalyvBXVs3QXf2x7xnR3/jdfGnDcivMsWVx4bDtScIme
	+8MlS9xIE7ZUcF9VKOHaapwwWQLRJZzPIcfpaYovvQu0mgCeGT/p1VQYR6V/3rJc
	wLMYICsXWdtYtjtjF1pl21ALGXGNpQkPa4Hgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YAscR/2vS9P7huGNbhqUcigkDX3zLAyk
	m9yMjp9t26XKNv4r9vJ5ikMNRAVT7eL+KUS9k7glSxrGYN3FbtBofhjfP+KpV0AJ
	9RpdxwmDW1WpQ9mHOD5N2iPrZqULDqX0BPc7qrcYV8KbgJRu5HdSMHHX/slYYl2W
	3+vgKYPdFpk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EA674596C;
	Sat, 11 Apr 2015 16:14:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D89DB4596B;
	Sat, 11 Apr 2015 16:14:29 -0400 (EDT)
In-Reply-To: <1428076716-4449-3-git-send-email-max@max630.net> (Max Kirillov's
	message of "Fri, 3 Apr 2015 18:58:34 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C239448-E087-11E4-BB5B-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267032>

Max Kirillov <max@max630.net> writes:

> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  combine-diff.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 8eb7278..a236bb5 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -22,6 +22,28 @@ static int compare_paths(const struct combine_diff_path *one,
>  				 two->path, strlen(two->path), two->mode);
>  }
>  
> +static void insert_path(struct combine_diff_path **pos, const char* path, int n, int num_parent, struct diff_filepair *queue_item)

This is overlong (and I wonder why I am not seeing the linewrap
problem with this one).  I'd suggest to split them perhaps in the
same way that compare_paths() match_string_spaces() and other
existing functions are defined?

Also the pointer-asterisk sticks to the variable name, not type,
i.e.

	static void insert_path(struct combine_diff_path **pos, const char *path,
				int n, int num_parent,
                                struct diff_filepair *queue_item)


> +{
