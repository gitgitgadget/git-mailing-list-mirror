From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Reimplement read_tree_recursive() using
 tree_entry_interesting()
Date: Thu, 24 Mar 2011 12:07:26 -0700
Message-ID: <7vpqpg8hht.fsf@alter.siamese.dyndns.org>
References: <AANLkTinYB=ZUTe29Y9ibLVL5z3KhiYmnCpCGcHx=18RJ@mail.gmail.com>
 <1300977675-6243-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 20:07:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2psn-0001dw-Jx
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 20:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933797Ab1CXTHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 15:07:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932334Ab1CXTHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 15:07:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB5E94CD1;
	Thu, 24 Mar 2011 15:09:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3gs1jg8SEGGN
	ZKYR598wgWt+GsE=; b=kjhF+rfpzRRP48luRPK0C7n1n3r0jPwHH2sdVgD3iehg
	UNk4lAsf8xNzizExTshoFZxcXmeaxOloazC2Zt4h5J/+u0BC7oagTgWAsmINR3cp
	CMfKpGDtiiEsijft/XZZPZq+DsIxIPNThrs+P/e38KIHQddZYIFXT1q60W6oJ7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QNksPx
	P4y3P+eYjC3+6/Td02eyoFVTWkE1kNqIk91H2c1dHFeVInbxUcDbkUH5Gu29gcPp
	mNoAA2b8eu2iY6wFkJwS6AQSUrgkKl5m1Jauwd8qfdZ36gVXq50t3uXr311rfQiO
	07AD2qgAs0okbth2gFL1oF9FAdF7w0shmHX3g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8D0A4CD0;
	Thu, 24 Mar 2011 15:09:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7D68D4CCF; Thu, 24 Mar 2011
 15:09:10 -0400 (EDT)
In-Reply-To: <1300977675-6243-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 24 Mar
 2011 21:41:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 357B25AC-564A-11E0-9C04-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169938>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> read_tree_recursive() uses a very similar function, match_tree_entry,=
 to
> tree_entry_interesting() to do its path matching. This patch kills
> match_tree_entry() in favor of tree_entry_interesting().
> ...
> +int read_tree_recursive(struct tree *tree,
> +			const char *base, int baselen,
> +			int stage, const char **match,
> +			read_tree_fn_t fn, void *context)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	struct pathspec pathspecs;
> +	int i, ret;
> +
> +	init_pathspec(&pathspecs, match);
> +	for (i =3D 0; i < pathspecs.nr; i++)
> +		pathspecs.items[i].has_wildcard =3D 0;

I think this is going in the right direction, but I have been hoping th=
at
we would eventually stop passing "const char **" pointers around when t=
he
caller specifies what are the set of paths that are to be affected.

We still retain "const char **raw" field in "struct pathspec" even afte=
r
your previous series, but I think that is because there still are too m=
any
callers that already have a "struct pathspec *pathspec" but pass only t=
hat
field (i.e. "pathspec->raw") down the callchain, and converting all the
callees was a bit too much to chew on during the previous series (which=
 I
consider is fine and sane).  The eventual goal should be for such calle=
rs
to pass the "pathspec" itself, so that the callees can learn wildcardin=
g
and all the "magic" fun stuff later.

As read_tree_recursive() has only 6 external callers, it may be a good
place to start that conversion.  Another offender is fill_directory() i=
n
dir.c that are used in 6 places.

Thanks.
