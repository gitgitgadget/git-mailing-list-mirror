From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] upload-pack: fix off-by-one depth calculation in
 shallow clone
Date: Thu, 10 Jan 2013 20:26:27 -0800
Message-ID: <7vpq1ccpl8.fsf@alter.siamese.dyndns.org>
References: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
 <1357875005-21956-1-git-send-email-pclouds@gmail.com>
 <1357875005-21956-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 05:26:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtWCh-0003Ei-9a
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 05:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab3AKE0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 23:26:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab3AKE0a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2013 23:26:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7CDDB9D4;
	Thu, 10 Jan 2013 23:26:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Sy2RJkvPud0w
	2nUfd1KI8/QesA0=; b=UdGMGzLhsZOIG1lCVFeFedwpmx0j+YOsTJKtkrcROu3K
	8XF71p7FaKDhl56SlL6jAN5vfgc202o+2RBO04NBrl3uTUGT23mHmXjhRuIp98Y2
	3pl4h2Bl9ssltxsBwlHzTvVh93m0dGjteKaHRduXQRvPrPelrpY1rA8PcDoGFsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C7ATx/
	hvOhltX1V+QiR2JzKIhQrc4uDLfzu7tQtdxfBQPcq5IvCVeAHjViYBMF2H/YB7zO
	XCJ6QZKVRl4F4thTxFRx5E/ergwtL+QwYo7G//195DNlZyr2q+sResl2QWW7sGDv
	+W+6fir6LXFviVvebGeg4kjVJipRPPx9B0OKg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB60B9CF;
	Thu, 10 Jan 2013 23:26:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30933B9CB; Thu, 10 Jan 2013
 23:26:29 -0500 (EST)
In-Reply-To: <1357875005-21956-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 11 Jan
 2013 10:30:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11E42058-5BA7-11E2-9F27-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213174>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> get_shallow_commits() is used to determine the cut points at a given
> depth (i.e. the number of commits in a chain that the user likes to
> get). However we count current depth up to the commit "commit" but we
> do the cutting at its parents (i.e. current depth + 1). This makes
> upload-pack always return one commit more than requested. This patch
> fixes it.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  shallow.c             |  8 +++++++-
>  t/t5500-fetch-pack.sh | 25 +++++++++++++++++++------
>  2 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/shallow.c b/shallow.c
> index a0363de..6be915f 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -72,8 +72,14 @@ struct commit_list *get_shallow_commits(struct obj=
ect_array *heads, int depth,
>  		}
>  		if (parse_commit(commit))
>  			die("invalid commit");
> -		commit->object.flags |=3D not_shallow_flag;
>  		cur_depth++;
> +		if (cur_depth >=3D depth) {
> +			commit_list_insert(commit, &result);
> +			commit->object.flags |=3D shallow_flag;
> +			commit =3D NULL;
> +			continue;
> +		}
> +		commit->object.flags |=3D not_shallow_flag;
>  		for (p =3D commit->parents, commit =3D NULL; p; p =3D p->next) {
>  			if (!p->item->util) {
>  				int *pointer =3D xmalloc(sizeof(int));

Nice.  No protocol extensions, you update the server side, and an
old client starts getting the right number of generations.

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 6a6e672..58d3bdf 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -130,16 +130,25 @@ test_expect_success 'single given branch clone'=
 '
>  	test_must_fail git --git-dir=3Dbranch-a/.git rev-parse origin/B
>  '
> =20
> +test_expect_success 'clone shallow depth 1' '
> +	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0
> +	test "`git --git-dir=3Dshallow0/.git rev-list --count HEAD`" =3D 1
> +'

No &&-chaining?

Thanks.
