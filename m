From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 4/8] gitweb: Use print_diff_chunk() for both
 side-by-side and inline diffs
Date: Thu, 29 Mar 2012 19:31:52 +0200
Message-ID: <20120329193152.3d0f27e2@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1332543417-19664-5-git-send-email-michal.kiedrowicz@gmail.com>
	<201203281756.42653.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:32:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJCc-0003ob-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933505Ab2C2Rb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 13:31:58 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:57728 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759144Ab2C2Rb4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 13:31:56 -0400
Received: by wejx9 with SMTP id x9so1155533wej.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=tTczsoDMJrP0+HVlWFoU5NA4xLG5VLLdZUcN7eUozOw=;
        b=INmRFIalISuQ6ja6A3pV0Vk5TLs4t4k4S+y6PXOUkRHMRqeMQoFbKWPeVb2nkSLgKp
         WY0R2sh4IjIk1k26Mr7WsD7l8UY48QK+XCIsuG8v06YjhEs/U7b+d3v01/WcM3nzKIZW
         HjGFZjr+7ST5AknEv2XE0ddaZ3MivK+3iVMcZeTNs8vyKCzwkWjgNEXRE5wahlVxFEwM
         qLMcYRxgj4LI06mLrTCmdwsrbY9MOjBnSNuzE62963lJGOfe7D6b63XnVO/n1qjo0YjA
         akBuUP8O6EByosJO9A9N9UBEnZQh5RSFCNm+2sVJ3W3d2g6wAGx/xrmG6CDlmea8IoFO
         CUXg==
Received: by 10.180.102.102 with SMTP id fn6mr7642168wib.10.1333042315511;
        Thu, 29 Mar 2012 10:31:55 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id e6sm68585849wix.8.2012.03.29.10.31.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 10:31:55 -0700 (PDT)
In-Reply-To: <201203281756.42653.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194277>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
>=20
> > This renames print_sidebyside_diff_chunk() to print_diff_chunk() an=
d
> > makes use of it for both side-by-side and inline diffs.  Now diff l=
ines
> > are always accumulated before they are printed.  This opens the
> > possibility to preprocess diff output before it's printed, which is
> > needed for diff refinement highlightning (implemented in incoming
> > patches).
> >=20
> While I don't like that we use accumulator for something that was=20
> straightforwardly printed, I understand that it is necessary preproce=
ssing
> required for diff refinement highlighting.  Having refactoring upfron=
t
> is a good idea, making for easier review.

Yeah, this change doesn't make sense on its own but is required by late=
r
patch that needs whole chunk at once.

>=20
> > If left as is, the new function print_inline_diff_lines() could reo=
rder
>=20
> I think the previous paragraph is long enough that it would be better
> to repeat subject of this sentence, i.e. start with
>=20
>  "If print_diff_chunk() was left as is, the new function ..."

OK.

>=20
> > diff lines.  It first prints all context lines, then all removed li=
nes
> > and finally all added lines.  If the diff output consisted of mixed=
 added
> > and removed lines, gitweb would reorder these lines.  This is true =
for
> > combined diff output, for example:
> >=20
> > 	 - removed line for first parent
> > 	 + added line for first parent
> > 	  -removed line for second parent
> > 	 ++added line for both parents
> >=20
> > would be rendered as:
> >=20
> > 	- removed line for first parent
> > 	 -removed line for second parent
> > 	+ added line for first parent
> > 	++added line for both parents
> >=20
> > To prevent gitweb from reordering lines, print_diff_chunk() calls
> > print_diff_lines() as soon as it detects that both added and remove=
d
> > lines are present and there was a class change.
> >=20
> O.K.
>=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> [...]
>=20
> > +# Print context lines and then rem/add lines in inline manner.
> > +sub print_inline_diff_lines {
> > +	my ($ctx, $rem, $add) =3D @_;
> > +
> > +	print foreach (@$ctx);
> > +	print foreach (@$rem);
> > +	print foreach (@$add);
>=20
> Why not simply
>=20
>   +	print @$ctx, @$rem, @$add;
>=20
> It is "print LIST" for a reason (and $\ is empty here in gitweb, as i=
t
> is empty by default).
>=20

OK, that's much better.  I really didn't like those 3 prints.

> > +}
> > +
> > +# Print context lines and then rem/add lines.
> > +sub print_diff_lines {
> > +	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> > +
> > +	if ($diff_style eq 'sidebyside' && !$is_combined) {
> > +		print_sidebyside_diff_lines($ctx, $rem, $add);
> > +	} else {
> > +		# default 'inline' style and unknown styles
> > +		print_inline_diff_lines($ctx, $rem, $add);
> > +	}
> > +}
>=20
> Very nice subroutine!
>=20
> > +
> > +sub print_diff_chunk {
> > +	my ($diff_style, $is_combined, @chunk) =3D @_;
> >  	my (@ctx, @rem, @add);
> > =20
> > +	# The class of the previous line.=20
> > +	my $prev_class =3D '';
> > +
> >  	return unless @chunk;
> > =20
> >  	# incomplete last line might be among removed or added lines,
> > @@ -5072,9 +5096,13 @@ sub print_sidebyside_diff_chunk {
> >  		}
> > =20
> >  		## print from accumulator when have some add/rem lines or end
> > -		# of chunk (flush context lines)
> > -		if (((@rem || @add) && $class eq 'ctx') || !$class) {
> > -			print_sidebyside_diff_lines(\@ctx, \@rem, \@add);
> > +		# of chunk (flush context lines), or when have add and rem
> > +		# lines and new block is reached (otherwise add/rem lines could
> > +		# be reordered)
> > +		if (((@rem || @add) && $class eq 'ctx') || !$class ||
> > +		    (@rem && @add && $class ne $prev_class)) {
> > +			print_diff_lines(\@ctx, \@rem, \@add, $diff_style,
> > +					$is_combined);
>=20
> Nitpick: the following _might_ be a tiny little bit more readable:
>=20
>   +			print_diff_lines(\@ctx, \@rem, \@add,
>   +			                 $diff_style, $is_combined);
>=20

OK.

> >  			@ctx =3D @rem =3D @add =3D ();
> >  		}
> > =20
> > @@ -5091,6 +5119,8 @@ sub print_sidebyside_diff_chunk {
> >  		if ($class eq 'ctx') {
> >  			push @ctx, $line;
> >  		}
> > +
> > +		$prev_class =3D $class;
> >  	}
> >  }
>=20
> Anyway nice change.
>  =20
> > @@ -5217,22 +5247,17 @@ sub git_patchset_body {
> >  			$diff_classes .=3D " $class" if ($class);
> >  			$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
> > =20
> > -			if ($diff_style eq 'sidebyside' && !$is_combined) {
> > -				if ($class eq 'chunk_header') {
> > -					print_sidebyside_diff_chunk(@chunk);
> > -					@chunk =3D ( [ $class, $line ] );
> > -				} else {
> > -					push @chunk, [ $class, $line ];
> > -				}
> > +			if ($class eq 'chunk_header') {
> > +				print_diff_chunk($diff_style, $is_combined, @chunk);
>=20
> Nice, pushing acting on $diff_style down to print_diff_chunk(), which
> simplifies code a bit.
>=20
> > +				@chunk =3D ( [ $class, $line ] );
>=20
> BTW. this could be simplified to
>=20
>   +				@chunk =3D ();
>   +				push @chunk, [ $class, $line ];
>=20
> Well, simplified after noticing the common part of those two branches
> of a conditional.
>=20
> But it really doesn't matter.

Sounds sensible.

>=20
> >  			} else {
> > -				# default 'inline' style and unknown styles
> > -				print $line;
> > +				push @chunk, [ $class, $line ];
> >  			}
> >  		}
> > =20
> >  	} continue {
> >  		if (@chunk) {
> > -			print_sidebyside_diff_chunk(@chunk);
> > +			print_diff_chunk($diff_style, $is_combined, @chunk);
> >  			@chunk =3D ();
> >  		}
> >  		print "</div>\n"; # class=3D"patch"
> > --=20
>=20
> BTW. I was wondering about binary files, but this commit wouldn't mak=
e
> it worse anyway as we parse diff output assuming unified-like diff fo=
r
> diff syntax highlighting... and binary diffs are shown as
>=20
>   "Binary files a/foo.png and b/foo.png differ"
>=20
> in extended diff header.

Yeah, this is what I wrote in the cover letter:

	* Ensured that binary patches are not supported in HTML format,
	  thus this series canot break it :) (answering Jakub's questions)

but maybe I wasn't clear enough.
