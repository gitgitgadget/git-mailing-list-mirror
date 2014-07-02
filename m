From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/7] replace: refactor replacing parents
Date: Wed, 02 Jul 2014 14:05:49 -0700
Message-ID: <xmqqtx6zfp3m.fsf@gitster.dls.corp.google.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.43446.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:06:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2RjC-00088g-B0
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 23:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbaGBVF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 17:05:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50578 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbaGBVF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 17:05:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1558F234FD;
	Wed,  2 Jul 2014 17:05:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7GTZ/FeN0PlB9q4z30PAUVtV3jE=; b=GgH+UW
	HihCURblbl4sq3GduaiINH4L73CKiyx+/F8xClcDY+cePUt0g/eqqJBe09Qy/Kp9
	miQljWfcuL9y4fNo5PDMtqf6M5+bl04w45sfV2JdMcJTczHL/ekbPP3+Uz9f/94f
	qXftc+rRM9XNETYA+BiZ1puvKg3IZWlAN3mtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ve6zW695a1aq27d7frP5MPnIAMjaa1y5
	eRCwXSoWXU2PLOcUL0CT8prhLu1P/3S/HIhftpANucbiMJCrD/ONKJ1DDjfgUm/I
	IDaYbhkWFU0GuV1Bu7ZeLNiMbSaSYWIPxVUXenbLsNKU9jStyvG+AxJyl9Ks5fqS
	QZ7iuIdg3FU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08779234FC;
	Wed,  2 Jul 2014 17:05:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EDD3F234F3;
	Wed,  2 Jul 2014 17:05:41 -0400 (EDT)
In-Reply-To: <20140628181117.5687.43446.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 28 Jun 2014 20:11:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A057EAD6-022C-11E4-94C6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252840>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/replace.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 3515979..ad47237 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -295,27 +295,14 @@ static int edit_and_replace(const char *object_ref, int force)
>  	return replace_object_sha1(object_ref, old, "replacement", new, force);
>  }
>  
> -static int create_graft(int argc, const char **argv, int force)
> +static void replace_parents(struct strbuf *buf, int argc, const char **argv)

It is somewhat strange to see that a new function introduced earlier
in the series is rewritten with a "refactoring".  Shouldn't the new
function have been done right from the beginning instead?

>  {
> -	unsigned char old[20], new[20];
> -	const char *old_ref = argv[0];
> -	struct commit *commit;
> -	struct strbuf buf = STRBUF_INIT;
>  	struct strbuf new_parents = STRBUF_INIT;
>  	const char *parent_start, *parent_end;
> -	const char *buffer;
> -	unsigned long size;
>  	int i;
>  
> -	if (get_sha1(old_ref, old) < 0)
> -		die(_("Not a valid object name: '%s'"), old_ref);
> -	commit = lookup_commit_or_die(old, old_ref);
> -
>  	/* find existing parents */
> -	buffer = get_commit_buffer(commit, &size);
> -	strbuf_add(&buf, buffer, size);
> -	unuse_commit_buffer(commit, buffer);
> -	parent_start = buf.buf;
> +	parent_start = buf->buf;
>  	parent_start += 46; /* "tree " + "hex sha1" + "\n" */
>  	parent_end = parent_start;
>  
> @@ -332,13 +319,34 @@ static int create_graft(int argc, const char **argv, int force)
>  	}
>  
>  	/* replace existing parents with new ones */
> -	strbuf_splice(&buf, parent_start - buf.buf, parent_end - parent_start,
> +	strbuf_splice(buf, parent_start - buf->buf, parent_end - parent_start,
>  		      new_parents.buf, new_parents.len);
>  
> +	strbuf_release(&new_parents);
> +}
> +
> +static int create_graft(int argc, const char **argv, int force)
> +{
> +	unsigned char old[20], new[20];
> +	const char *old_ref = argv[0];
> +	struct commit *commit;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *buffer;
> +	unsigned long size;
> +
> +	if (get_sha1(old_ref, old) < 0)
> +		die(_("Not a valid object name: '%s'"), old_ref);
> +	commit = lookup_commit_or_die(old, old_ref);
> +
> +	buffer = get_commit_buffer(commit, &size);
> +	strbuf_add(&buf, buffer, size);
> +	unuse_commit_buffer(commit, buffer);
> +
> +	replace_parents(&buf, argc, argv);
> +
>  	if (write_sha1_file(buf.buf, buf.len, commit_type, new))
>  		die(_("could not write replacement commit for: '%s'"), old_ref);
>  
> -	strbuf_release(&new_parents);
>  	strbuf_release(&buf);
>  
>  	if (!hashcmp(old, new))
