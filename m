From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] grep: skip files outside sparse checkout area
Date: Fri, 31 Jul 2009 09:42:55 -0700
Message-ID: <7vljm4st0w.fsf@alter.siamese.dyndns.org>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
 <1248850154-5469-2-git-send-email-pclouds@gmail.com>
 <1248850154-5469-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:43:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWvCJ-0000Mu-Jg
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbZGaQnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 12:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbZGaQnA
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:43:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZGaQm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 12:42:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ABF901BB40;
	Fri, 31 Jul 2009 12:42:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EB2561BB3F; Fri,
 31 Jul 2009 12:42:56 -0400 (EDT)
In-Reply-To: <1248850154-5469-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 29 Jul
 2009 16\:49\:11 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34F7A340-7DF1-11DE-833B-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124581>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ---
>  Documentation/git-grep.txt |    4 +++-
>  builtin-grep.c             |    7 ++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)

I do not think you can call this "CE_VALID fixup".  This is a possibly
useful but nevertheless a new, different behaviour.

We probably want opt->ignoreassumeunchanged in struct grep_opt, and
control it via grep.ignoreassumeunchanged configuration, that perhaps
defaults to true (i.e. "ignore"), with a command line override.

Oh, and perhaps a shorter-and-sweeter name than "ignoreAssumeUnchanged"=
=2E

> diff --git a/builtin-grep.c b/builtin-grep.c
> index ad0e0a5..55078cb 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -455,6 +455,8 @@ static int external_grep(struct grep_opt *opt, co=
nst char **paths, int cached)
>  			continue;
>  		if (!pathspec_matches(paths, ce->name, opt->max_depth))
>  			continue;
> +		if (ce->ce_flags & CE_VALID)
> +			continue;

The test probably should come before pathspec_matches().

> @@ -522,8 +524,11 @@ static int grep_cache(struct grep_opt *opt, cons=
t char **paths, int cached,
>  				continue;
>  			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0);
>  		}
> -		else
> +		else {
> +			if (ce->ce_flags & CE_VALID)
> +				continue;
>  			hit |=3D grep_file(opt, ce->name);
> +		}
>  		if (ce_stage(ce)) {
>  			do {
>  				nr++;

I do not think the new code in this hunk will be reached as the other a=
rm
of the "else" greps in the index when CE_VALID is set.

Has this series been tested or self-reviewed yet?
