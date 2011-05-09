From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: disallow '-' as tag name
Date: Mon, 09 May 2011 16:08:09 -0700
Message-ID: <7v62pjo4km.fsf@alter.siamese.dyndns.org>
References: <1304954496.11377.11.camel@kohr-ah>
 <7v39knpxbe.fsf@alter.siamese.dyndns.org> <4DC87113.4030204@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Vandiver <alex@chmrr.net>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:08:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZYu-0006BG-9S
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab1EIXIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:08:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1EIXIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:08:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 111994DED;
	Mon,  9 May 2011 19:10:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lXp0iwDLHRyOcJykLmZMS50WlFo=; b=Z5IlK5
	l+FNQdjILD6ZMvUeuEc22j4TLqndJVH6K5C31MkJ0yl8JVZCOcJNLXsOHLLKqbRD
	41CBZ8OoGNKKJ2jvsG3gqJsnRBpy1GNWvDqCuS+g4LxOI2kaLL6/BZyx7C4xBu+5
	NsWHB35eO7KPHk/rAV1nI26WzjC/dqhT3Sde4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BzOqxnO25H0ppzIEWdd+GARkWVti6Z1o
	PwY2x86T1TX3h+cQi0ZxRLGdvKfxO8LZ4XyUM9Hjh76ZeGsoNRlJacuWHDPn2mSf
	nmEYNiPGB1hzOOrBj6zvW0abINSM00CbB8FKnoKxqjfKxAYUy7vIfkunlrIHr1mK
	/CS22VbNgPw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB25D4DEC;
	Mon,  9 May 2011 19:10:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A23354DEB; Mon,  9 May 2011
 19:10:16 -0400 (EDT)
In-Reply-To: <4DC87113.4030204@elegosoft.com> (Michael Schubert's message of
 "Tue, 10 May 2011 00:56:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82FBAFB6-7A91-11E0-95DD-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173284>

Michael Schubert <mschub@elegosoft.com> writes:

> Add strbuf_check_tag_ref() as helper to check a refname for a tag.
>
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---

That was quick ;-).

>  builtin/tag.c |   30 ++++++++++++++++++++++--------
>  1 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index b66b34a..f087a7f 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -352,11 +352,26 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
> +{
> +	if (name[0] == '-')
> +		return CHECK_REF_FORMAT_ERROR;

So contrary to what the title claims, it forbids a tag that begins with '-',
e.g. '-foo', not just a single dash.  That is fine by me (we do the same
in strbuf-check-branch-ref) but it needs to be explained better.

> +	strbuf_reset(sb);
> +	strbuf_add(sb, "refs/tags/", 10);
> +	strbuf_add(sb, name, strlen(name));

strbuf_addf(sb, "refs/tags/%s", name)?

> +	if (sb->len > PATH_MAX)
> +		die(_("tag name too long: %.*s..."), 50, name);

I think that should be

	if (PATH_MAX <= sb->len)

but I do not see the point of checking against PATH_MAX if you are already
using a strbuf...
