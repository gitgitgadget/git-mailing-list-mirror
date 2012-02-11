From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/8] gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
Date: Sat, 11 Feb 2012 07:53:41 -0800 (PST)
Message-ID: <m3k43ttlh9.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-3-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 16:53:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwFGm-000585-WB
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 16:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab2BKPxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 10:53:44 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50415 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab2BKPxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 10:53:43 -0500
Received: by eekc14 with SMTP id c14so1276273eek.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=KUAPS0+uAV72V/kCtbcObmDVMCyH2ehdfOIjq2W7MTE=;
        b=qPNE44w4PR9qrIV0PaHfbwrFPW3oxS4jLcn3hHkelr1hm1sbiPgumCyKmllWQos8B4
         Bh8AmEoVQU9dHpaDQL0ToA4WeBDX2JXtt7e4mB3gRYdC8bDZNyAvLzyACuazBvy8eRID
         FtR4cbkpsSxY0X2/LAIJeRua+ERxRSqPhV1F0=
Received: by 10.14.28.75 with SMTP id f51mr3198357eea.118.1328975622305;
        Sat, 11 Feb 2012 07:53:42 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id w60sm18515868eeb.4.2012.02.11.07.53.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 07:53:41 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1BFrdcM015918;
	Sat, 11 Feb 2012 16:53:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1BFrcLq015914;
	Sat, 11 Feb 2012 16:53:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-3-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190516>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> This renames print_sidebyside_diff_chunk() to print_diff_chunk() and
> makes use of it for both side-by-side and inline diffs. Now diff line=
s
> are always accumulated before they are printed. This opens the
> possibility to preprocess diff output before it's printed.
>=20
> The new function print_inline_diff_lines() could reorder diff lines.

I think you meant here "if left as is", isn't it?

> It first prints all context lines, then all removed lines and
> finally all added lines. If the diff output consisted of mixed added
> and removed lines, gitweb would reorder these lines. This is
> especially true for combined diff output, for example:
>=20
> 	 - removed line for first parent
> 	 + added line for first parent
> 	  -removed line for second parent
> 	 ++added line for both parents
>=20
> would be rendered as:
>=20
> 	- removed line for first parent
> 	 -removed line for second parent
> 	+ added line for first parent
> 	++added line for both parents

This is not "is especially true"; it can happen (though: can it
really?) in combined diff output; in ordinary diff you would always
have context or end/beginning of chunk between added and removed
lines.

>=20
> To prevent gitweb from reordering lines, print_diff_chunk() calls
> print_diff_lines() as soon as it detects that both added and removed
> lines are present and there was a class change.

You really should mention, in my opinion, that this change is
preparation for diff refinement highlighting (higlighting the
differing segments).

Otherwise I don't see the reason for it: ordinary diff didn't need the
fancy stuff with accumulating then printing, and could be send
straightly to output.  This adds complexity for non-sidebyside diff,
unnecessary if not for diff refinement highlighting.
=20
> Signed-off-by: Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  gitweb/gitweb.perl |   53 +++++++++++++++++++++++++++++++++++++-----=
---------
>  1 files changed, 38 insertions(+), 15 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1247607..ed63261 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4908,9 +4908,31 @@ sub print_sidebyside_diff_lines {
>  	}
>  }
> =20
> -sub print_sidebyside_diff_chunk {
> -	my @chunk =3D @_;
> +# Print context lines and then rem/add lines in inline manner.
> +sub print_inline_diff_lines {
> +	my ($ctx, $rem, $add) =3D @_;
> +
> +	print foreach (@$ctx);
> +	print foreach (@$rem);
> +	print foreach (@$add);
> +}
> +
> +# Print context lines and then rem/add lines.
> +sub print_diff_lines {
> +	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> +
> +	if ($diff_style eq 'sidebyside' && !$is_combined) {
> +		print_sidebyside_diff_lines($ctx, $rem, $add);
> +	} else {
> +		# default 'inline' style and unknown styles
> +		print_inline_diff_lines($ctx, $rem, $add);
> +	}
> +}

That looks nice.

BTW. I didn't examine the final code, but what happens for binary
diffs that git supports?  Is it handled outside print_diff_chunk()?

> +
> +sub print_diff_chunk {
> +	my ($diff_style, $is_combined, @chunk) =3D @_;
>  	my (@ctx, @rem, @add);
> +	my $prev_class =3D '';

Is $prev_class here class of previous chunk fragment or _previous class=
_
(i.e. always different from $class), or is it class of previous line?
It is not obvious here, from variable name.  Better name or at least
a comment would be appreciated.

> =20
>  	return unless @chunk;
> =20
> @@ -4935,9 +4957,13 @@ sub print_sidebyside_diff_chunk {
>  		}
> =20
>  		## print from accumulator when have some add/rem lines or end
> -		# of chunk (flush context lines)
> -		if (((@rem || @add) && $class eq 'ctx') || !$class) {
> -			print_sidebyside_diff_lines(\@ctx, \@rem, \@add);
> +		# of chunk (flush context lines), or when have add and rem
> +		# lines and new block is reached (otherwise add/rem lines could
> +		# be reordered)
> +		if (((@rem || @add) && $class eq 'ctx') || !$class ||
> +				(@rem && @add && $class ne $prev_class)) {

We usually use tabs to align, but spaces to indent in gitweb, so it
would be

> +		if (((@rem || @add) && $class eq 'ctx') || !$class ||
> +		    (@rem && @add && $class ne $prev_class)) {

Anyway, this conditional gets ridicously complicated.  I wonder if we
could simplify it.

If we allow printing context together widh added/removed lines, and
not as soon as possible, perhaps good conditional would be: class
changed, and accumulator for current class is full:

> +		if ($class ne $prev_class && @{ $acc{$class} }) {

Or something like that, where

        my %acc =3D (ctx =3D> \@ctx, add =3D> \@add, rem =3D> \@rem);

If we want to print context as soon as possible, like it was before
1st patch in this series, we could uuse the following conditional

> +		if ($class ne $prev_class &&=20
> +                 ($prev_class eq 'ctx' || @{ $acc{$class} })) {

Perhaps with "scalar @{ $acc{$class} }" if it would make things more
clear.

Though probably to avoid "Use of uninitialized value in string ne"
we would probably have to use empty string instead of undefined
value for "no class" case, i.e. beginning or end of chunk.

> +			print_diff_lines(\@ctx, \@rem, \@add, $diff_style,
> +					$is_combined);
>  			@ctx =3D @rem =3D @add =3D ();
>  		}
> =20
> @@ -4954,6 +4980,8 @@ sub print_sidebyside_diff_chunk {
>  		if ($class eq 'ctx') {
>  			push @ctx, $line;
>  		}
> +
> +		$prev_class =3D $class;
>  	}
>  }
[...] =20

--=20
Jakub Nar=EAbski
