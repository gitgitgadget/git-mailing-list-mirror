From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/8] gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
Date: Wed, 28 Mar 2012 16:56:41 +0100
Message-ID: <201203281756.42653.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-5-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCvF1-0002MN-HS
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758343Ab2C1P4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 11:56:48 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41875 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758302Ab2C1P4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:56:45 -0400
Received: by wgbdr13 with SMTP id dr13so1121858wgb.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=EUqRtU73C8wLGFYUjCvR5W3REUP7grQzXwavLY+5NS0=;
        b=GUI8E6mq5S1p8kzLuF6p/JIWbtFp8+4rYieE73OyneoyiYr1b3IjLRIK2w6ZMJ4WcX
         3cFByeR3uBxa72ErOsjddWHcoL7HwpbGQuZjdrFVj8z8zNxmtgIYV7YjEmX1x0WDzpYQ
         G1CptqQ4CtVUsmtwEJY4Ry0Agv2ICiVW8wGEehKJqavKQQs/LbQPlnsEFzGf1ilCIx7x
         sJDjAW6jMbth4UsMFQdW+o1Upcy3YPLilfR2yVt+lGQg1vrjou75KBO4ZpaDt5t0Pkvb
         dLhAlABOmZS6DSUR3zNfPQgER52uBC2zzbU6PjudZ7pAkgwPBXWD9E31Ib7cAIEGjDh0
         hlmA==
Received: by 10.180.85.70 with SMTP id f6mr8417486wiz.5.1332950203966;
        Wed, 28 Mar 2012 08:56:43 -0700 (PDT)
Received: from [192.168.1.13] (euy254.neoplus.adsl.tpnet.pl. [83.20.196.254])
        by mx.google.com with ESMTPS id l5sm58895727wia.11.2012.03.28.08.56.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 08:56:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1332543417-19664-5-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194140>

On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> This renames print_sidebyside_diff_chunk() to print_diff_chunk() and
> makes use of it for both side-by-side and inline diffs.  Now diff lin=
es
> are always accumulated before they are printed.  This opens the
> possibility to preprocess diff output before it's printed, which is
> needed for diff refinement highlightning (implemented in incoming
> patches).
>=20
While I don't like that we use accumulator for something that was=20
straightforwardly printed, I understand that it is necessary preprocess=
ing
required for diff refinement highlighting.  Having refactoring upfront
is a good idea, making for easier review.

> If left as is, the new function print_inline_diff_lines() could reord=
er

I think the previous paragraph is long enough that it would be better
to repeat subject of this sentence, i.e. start with

 "If print_diff_chunk() was left as is, the new function ..."

> diff lines.  It first prints all context lines, then all removed line=
s
> and finally all added lines.  If the diff output consisted of mixed a=
dded
> and removed lines, gitweb would reorder these lines.  This is true fo=
r
> combined diff output, for example:
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
>=20
> To prevent gitweb from reordering lines, print_diff_chunk() calls
> print_diff_lines() as soon as it detects that both added and removed
> lines are present and there was a class change.
>=20
O.K.

> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
[...]

> +# Print context lines and then rem/add lines in inline manner.
> +sub print_inline_diff_lines {
> +	my ($ctx, $rem, $add) =3D @_;
> +
> +	print foreach (@$ctx);
> +	print foreach (@$rem);
> +	print foreach (@$add);

Why not simply

  +	print @$ctx, @$rem, @$add;

It is "print LIST" for a reason (and $\ is empty here in gitweb, as it
is empty by default).

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

Very nice subroutine!

> +
> +sub print_diff_chunk {
> +	my ($diff_style, $is_combined, @chunk) =3D @_;
>  	my (@ctx, @rem, @add);
> =20
> +	# The class of the previous line.=20
> +	my $prev_class =3D '';
> +
>  	return unless @chunk;
> =20
>  	# incomplete last line might be among removed or added lines,
> @@ -5072,9 +5096,13 @@ sub print_sidebyside_diff_chunk {
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
> +		    (@rem && @add && $class ne $prev_class)) {
> +			print_diff_lines(\@ctx, \@rem, \@add, $diff_style,
> +					$is_combined);

Nitpick: the following _might_ be a tiny little bit more readable:

  +			print_diff_lines(\@ctx, \@rem, \@add,
  +			                 $diff_style, $is_combined);

>  			@ctx =3D @rem =3D @add =3D ();
>  		}
> =20
> @@ -5091,6 +5119,8 @@ sub print_sidebyside_diff_chunk {
>  		if ($class eq 'ctx') {
>  			push @ctx, $line;
>  		}
> +
> +		$prev_class =3D $class;
>  	}
>  }

Anyway nice change.
 =20
> @@ -5217,22 +5247,17 @@ sub git_patchset_body {
>  			$diff_classes .=3D " $class" if ($class);
>  			$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
> =20
> -			if ($diff_style eq 'sidebyside' && !$is_combined) {
> -				if ($class eq 'chunk_header') {
> -					print_sidebyside_diff_chunk(@chunk);
> -					@chunk =3D ( [ $class, $line ] );
> -				} else {
> -					push @chunk, [ $class, $line ];
> -				}
> +			if ($class eq 'chunk_header') {
> +				print_diff_chunk($diff_style, $is_combined, @chunk);

Nice, pushing acting on $diff_style down to print_diff_chunk(), which
simplifies code a bit.

> +				@chunk =3D ( [ $class, $line ] );

BTW. this could be simplified to

  +				@chunk =3D ();
  +				push @chunk, [ $class, $line ];

Well, simplified after noticing the common part of those two branches
of a conditional.

But it really doesn't matter.

>  			} else {
> -				# default 'inline' style and unknown styles
> -				print $line;
> +				push @chunk, [ $class, $line ];
>  			}
>  		}
> =20
>  	} continue {
>  		if (@chunk) {
> -			print_sidebyside_diff_chunk(@chunk);
> +			print_diff_chunk($diff_style, $is_combined, @chunk);
>  			@chunk =3D ();
>  		}
>  		print "</div>\n"; # class=3D"patch"
> --=20

BTW. I was wondering about binary files, but this commit wouldn't make
it worse anyway as we parse diff output assuming unified-like diff for
diff syntax highlighting... and binary diffs are shown as

  "Binary files a/foo.png and b/foo.png differ"

in extended diff header.
--=20
Jakub Narebski
Poland
