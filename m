From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: parse_commit_text encoding fix
Date: Mon, 03 Aug 2009 23:59:44 -0700
Message-ID: <7viqh43vz3.fsf@alter.siamese.dyndns.org>
References: <9ab80d150908010955l3710c54bp9e2716570fd1d5ed@mail.gmail.com>
 <1249198944-19630-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Zolt=C3=A1n_F=C3=BCzesi?= <zfuzesi@eaglet.hu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYE06-0003f2-Rg
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbZHDG7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 02:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbZHDG7u
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:59:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462AbZHDG7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 02:59:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 57CEF1FCED;
	Tue,  4 Aug 2009 02:59:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 875891FCEC; Tue, 
 4 Aug 2009 02:59:46 -0400 (EDT)
In-Reply-To: <1249198944-19630-1-git-send-email-zfuzesi@eaglet.hu>
 (=?utf-8?Q?=22Zolt=C3=A1n_F=C3=BCzesi=22's?= message of "Sun\,  2 Aug 2009
 09\:42\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67584B70-80C4-11DE-858F-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124761>

Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu> writes:

> Call to_utf8 when parsing author and committer names, otherwise they =
will appear
> with bad encoding if they written by using chop_and_escape_str.
>
> Signed-off-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
> ---

Thanks, Zolt=C3=A1n.

We should be able to set up a script that scrapes the output to test th=
is
kind of thing.  We may not want to have a test pattern that matches too
strictly for the current structure and appearance of the output
(e.g. counting nested <div>s, presentation styles and such), but if we =
can
robustly scrape off HTML tags (e.g. "elinks -dump") and check the
remaining payload, it might be enough.

Jakub what do you think?  I suspect that scraping approach may turn out=
 to
be too fragile for tests to be worth doing, but I am just throwing out =
a
thought.

>  gitweb/gitweb.perl |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7fbd5ff..4f05194 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2570,7 +2570,7 @@ sub parse_commit_text {
>  		} elsif ((!defined $withparents) && ($line =3D~ m/^parent ([0-9a-f=
A-F]{40})$/)) {
>  			push @parents, $1;
>  		} elsif ($line =3D~ m/^author (.*) ([0-9]+) (.*)$/) {
> -			$co{'author'} =3D $1;
> +			$co{'author'} =3D to_utf8($1);
>  			$co{'author_epoch'} =3D $2;
>  			$co{'author_tz'} =3D $3;
>  			if ($co{'author'} =3D~ m/^([^<]+) <([^>]*)>/) {
> @@ -2580,10 +2580,9 @@ sub parse_commit_text {
>  				$co{'author_name'} =3D $co{'author'};
>  			}
>  		} elsif ($line =3D~ m/^committer (.*) ([0-9]+) (.*)$/) {
> -			$co{'committer'} =3D $1;
> +			$co{'committer'} =3D to_utf8($1);
>  			$co{'committer_epoch'} =3D $2;
>  			$co{'committer_tz'} =3D $3;
> -			$co{'committer_name'} =3D $co{'committer'};
>  			if ($co{'committer'} =3D~ m/^([^<]+) <([^>]*)>/) {
>  				$co{'committer_name'}  =3D $1;
>  				$co{'committer_email'} =3D $2;
> --=20
> 1.6.4.13.ge6580
