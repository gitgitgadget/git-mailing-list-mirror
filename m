From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 14/15] ref-filter: introduce contents_atom_parser()
Date: Tue, 05 Jan 2016 13:22:56 -0800
Message-ID: <xmqqio37iuvj.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-15-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:23:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGZ4L-00024l-6X
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 22:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbcAEVXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 16:23:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752645AbcAEVW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 16:22:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3929A387EB;
	Tue,  5 Jan 2016 16:22:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p70NzjPlJ8ryLmejFHMGgkny+9g=; b=qPsk0z
	GXmGLq7TjtT5K0Ao7JqXAPDSyN4Rft0no3mbIK2x97ofKcPpcCJFXWIKnd/AnFfx
	WfCrMV6CNkvU0fECyKUqTPOfxY62EiqDn2Hi2qA2f5TdDh366ZqUqwRF/cgKwXBW
	+hP08txOVmoo37UJ9s+I2SX/VjiZE8HcZmS+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IO45N4k2YLZHO1NjbhitZfqHqI9dYgcg
	5bdzUSGlx0LCgOqSxVvmK5cCB8EAMDAfKAFvqR1CI+B/qZBBT2ZHuk+TFPjzLk6i
	ns/uXFZ3fOiI2TF3lEdrZQrInvxBO8mEMgndO6ZBW6smFwI76tK/QJWk/j3y1XrE
	32kOYrmhxZs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 317F2387E8;
	Tue,  5 Jan 2016 16:22:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A2F6387E7;
	Tue,  5 Jan 2016 16:22:57 -0500 (EST)
In-Reply-To: <1451980994-26865-15-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 5 Jan 2016 13:33:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7DAABBF2-B3F2-11E5-9393-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283404>

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce contents_atom_parser() which will parse the '%(contents)'
> atom and store information into the 'used_atom' structure based on the
> modifiers used along with the atom.
>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c | 74 +++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 28 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 32b4674..9e61530 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -39,6 +39,10 @@ static struct used_atom {
>  		struct align align;
>  		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
>  			remote_ref;
> +		struct {
> +			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
> +			unsigned int nlines;
> +		} contents;
>  	} u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -96,6 +100,35 @@ static void remote_ref_atom_parser(struct used_atom *atom)
>  		die(_("unrecognized format: %%(%s)"), atom->name);
>  }
>  
> +static void contents_atom_parser(struct used_atom *atom)
> +{
> +	const char * buf;
> +
> +	if (match_atom_name(atom->name, "subject", &buf) && !buf) {
> +		atom->u.contents.option = C_SUB;
> +		return;
> +	} else if (match_atom_name(atom->name, "body", &buf) && !buf) {
> +		atom->u.contents.option = C_BODY_DEP;
> +		return;
> +	} if (!match_atom_name(atom->name, "contents", &buf))
> +		  die("BUG: parsing non-'contents'");

Did you really intend to say "if" here, not "else if"?

I also wonder if the "&& !buf" in the first two are correct.  What
should happen to "%(subject:foo)", which gives you a non-empty buf?
It may or may not be an error, but it should not fall thru and cause
"BUG:parsing non-contents", should it?

> +	if (!buf)
> +		atom->u.contents.option = C_BARE;
> +	else if (!strcmp(buf, "body"))
> +		atom->u.contents.option = C_BODY;
> +...
