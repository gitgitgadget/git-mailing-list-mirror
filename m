From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Sun, 05 Feb 2012 15:31:17 -0800
Message-ID: <7vvcnkeu2i.fsf@alter.siamese.dyndns.org>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 00:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuBYL-0000Wp-Vf
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 00:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab2BEXbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 18:31:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488Ab2BEXbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 18:31:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 499C26D92;
	Sun,  5 Feb 2012 18:31:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8TdFPbBbC0EQ2ZSJUGkm1hwRCEY=; b=oEFHWF
	bYmXv5TjDt9t9MiDxyzS52m4TWedjYRfU8pzv8z1SyGaNu00l6ZSFCvcntNXC8p0
	stD+iO0EK9vYGak3Z7AY+MAvVMUocK+gMRbXUS7O/tk676oxGNvGBOghy2iVF6ck
	OXfXaA1NSEl/DUmkaFL2sUciSMAsH7iaQcM/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GUTuLRj9l5bVj+l4fAUAA1l4XaSse1sh
	YhL51a2xcRiOfUOabpSL0eBfhVI8zvHN7wIAY5sPiRtg3n5pkTMEhsucMCi4sLed
	kZ455m7zyTSMvxNMgOEpY5ZOgZr+GrLHRBWJyMSFT89nbGb5WLkq7qgMCbV4sRsg
	SxF9vJm7tVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 415646D91;
	Sun,  5 Feb 2012 18:31:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE85A6D90; Sun,  5 Feb 2012
 18:31:18 -0500 (EST)
In-Reply-To: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com> (Tom
 Grennan's message of "Sun, 5 Feb 2012 14:28:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8127AF6E-5051-11E1-B4D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189985>

Tom Grennan <tmgrennan@gmail.com> writes:

> @@ -105,16 +107,28 @@ static int show_reference(const char *refname, const unsigned char *sha1,
>  				return 0;
>  		}
>  
> +		buf = read_sha1_file(sha1, &type, &size);
> +		if (!buf || !size)
> +			return 0;
> +
> +		if (filter->points_at) {
> +			unsigned char tagged_sha1[20];
> +			if (memcmp("object ", buf, 7) \
> +			    || buf[47] != '\n' \
> +			    || get_sha1_hex(buf + 7, tagged_sha1) \
> +			    || memcmp(filter->points_at, tagged_sha1, 20)) {

Do we need these backslashes at the end of these lines?

> @@ -143,16 +157,20 @@ static int show_reference(const char *refname, const unsigned char *sha1,
>  }
>  
>  static int list_tags(const char **patterns, int lines,
> -			struct commit_list *with_commit)
> +			struct commit_list *with_commit,
> +			unsigned char *points_at)
>  {

It strikes me somewhat odd that you can give a list of commits to filter
when using "--contains" (e.g. "--contains v1.7.9 --contains 1.7.8.4"), but
you can only ask for a single object with "--points-at" from the UI point
of view.

> @@ -375,12 +393,28 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
>  	return check_refname_format(sb->buf, 0);
>  }
>  
> +int parse_opt_points_at(const struct option *opt, const char *arg, int unset)
> +{
> +	unsigned char *sha1;
> +
> +	if (!arg)
> +		return -1;
> +	sha1 = xmalloc(20);
> +	if (get_sha1(arg, sha1)) {
> +		free(sha1);
> +		return error("malformed object name %s", arg);
> +	}
> +	*(unsigned char **)opt->value = sha1;
> +	return 0;
> +}

We are ignoring earlier --points-at argument without telling the user that
we do not support more than one.

Would it become too much unnecessary addition of new code if you supported
multiple --points-at on the command line for the sake of consistency?

> @@ -417,6 +451,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_LASTARG_DEFAULT,
>  			parse_opt_with_commit, (intptr_t)"HEAD",
>  		},
> +		{
> +			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
> +			"print only annotated|signed tags of the object",
> +			PARSE_OPT_LASTARG_DEFAULT,
> +			parse_opt_points_at, (intptr_t)"HEAD",
> +		},

I wonder if defaulting to HEAD even makes sense for --points-at. When you
are chasing a bug and checked out an old version that originally had
problem, "git tag --contains" that defaults to HEAD does have a value. It
tells us what releases are potentially contaminated with the buggy commit.

But does a similar use case support points-at that defaults to HEAD?

Other than that, thanks for a pleasant read.
