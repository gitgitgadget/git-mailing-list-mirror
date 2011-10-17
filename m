From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: add a feature to show side-by-side diff
Date: Mon, 17 Oct 2011 14:24:51 -0700 (PDT)
Message-ID: <m34nz771mj.fsf@localhost.localdomain>
References: <CAFo4x0L4BAKnCDa1uEK0Rskd9kTsR-94D4mkYKnLGqVDnuyuBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 23:25:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFug7-0001tH-LM
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 23:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab1JQVYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 17:24:54 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57714 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab1JQVYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 17:24:53 -0400
Received: by eye27 with SMTP id 27so3392484eye.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ny4DR2OnGp2xF4zymoeQ8QP3yBNBBveBm7sHffaDCk0=;
        b=GJXHDcFFXidi3vL4CXxa6hJ2glqc+tcdTn3INzAPJhPnhk9E9gz8UHcjP/JBxC6GaP
         l67Xb4Di9LZiTlVWzJHzAegvD+bDRsQa5IlXrsItntrWxAKQBREDIQDFTOZZqH873ru4
         OsnbPYf7DO3Qq4PAUhhbInFry8bsJrIOm2KxU=
Received: by 10.223.60.73 with SMTP id o9mr26985611fah.18.1318886692101;
        Mon, 17 Oct 2011 14:24:52 -0700 (PDT)
Received: from localhost.localdomain (absh126.neoplus.adsl.tpnet.pl. [83.8.127.126])
        by mx.google.com with ESMTPS id c13sm10292650fai.3.2011.10.17.14.24.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 14:24:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9HLOVOJ014369;
	Mon, 17 Oct 2011 23:24:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9HLOLGY014365;
	Mon, 17 Oct 2011 23:24:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAFo4x0L4BAKnCDa1uEK0Rskd9kTsR-94D4mkYKnLGqVDnuyuBA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183825>

Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:

> gitweb currently has a feature to show diff but it doesn't support
> "side-by-side" style. This modification introduces:
>=20
>  * The "ds" query parameter to specify the style of diff.
>  * The format_diff_chunk() to reorganize an output of diff.
>  * The diff_nav() for form.

I would state it a bit differently.

I would say that this patch introduces support for side-by-side diff
in git_patchset_body, and that style of diff is controlled by newly
introduces 'diff_style' ("ds") parameter.

I would say a bit later that navigation bar got extended to make it
easy to switch between 'inline' and 'sidebyside' diff.

> ---
>  gitweb/gitweb.perl       |   81 ++++++++++++++++++++++++++++++++++++=
+++++----
>  gitweb/static/gitweb.css |   15 ++++++++
>  2 files changed, 88 insertions(+), 8 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 095adda..dca09dc 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -757,6 +757,7 @@ our @cgi_param_mapping =3D (
>  	extra_options =3D> "opt",
>  	search_use_regexp =3D> "sr",
>  	ctag =3D> "by_tag",
> +	diff_style =3D> "ds",
>  	# this must be last entry (for manipulation from JavaScript)
>  	javascript =3D> "js"
>  );

O.K.

> @@ -1072,6 +1073,8 @@ sub evaluate_and_validate_params {
>  		}
>  		$search_regexp =3D $search_use_regexp ? $searchtext : quotemeta $s=
earchtext;
>  	}
> +
> +	$input_params{diff_style} ||=3D 'inline';
>  }

O.K.
=20
>  # path to the current git repository
> @@ -2276,7 +2279,7 @@ sub format_diff_line {
>  		}
>  		$line =3D "<span class=3D\"chunk_info\">@@ $from_text $to_text @@<=
/span>" .
>  		        "<span class=3D\"section\">" . esc_html($section, -nbsp=3D=
>1) .
> "</span>";
> -		return "$div_open$line</div>\n";
> +		return $diff_class, "$div_open$line</div>\n";
>  	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
>  		my ($prefix, $ranges, $section) =3D $line =3D~ m/^(\@+) (.*?) \@+(=
=2E*)$/;
>  		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $t=
o_nlines);

If you are changing behavior of format_diff_line, by having it return
<class>, <formatted line> line pair, I think you should document it,
and change the name of function.

All format_* functions in gitweb return a single string, so that

  print format_*(...);

works.

> @@ -4828,8 +4831,32 @@ sub git_difftree_body {
>  	print "</table>\n";
>  }
>=20

It would be good idea to add some comment about this subroutine,
e.g. what parameters it accepts.  And perhaps how it works, as it is
not obvious.

> +sub format_diff_chunk {
> +	my @chunk =3D @_;
> +
> +	my $first_class =3D $chunk[0]->[0];
> +	my @partial =3D map { $_->[1] } grep { $_->[0] eq $first_class } @c=
hunk;
> +
> +	if (scalar @partial < scalar @chunk) {
> +		return join '', ("<div class=3D'chunk'><div class=3D'old'>",
> +		             @partial,
> +		             "</div>",
> +		             "<div class=3D'new'>",
> +		             (map {
> +		                 $_->[1];
> +		             } @chunk[scalar @partial..scalar @chunk-1]),
> +		             "</div></div>");
> +	} else {
> +		return join '', ("<div class=3D'chunk'><div class=3D'",
> +		             ($first_class eq 'add' ? 'new' : 'old'),
> +		             "'>",
> +		             @partial,
> +		             "</div></div>");
> +	}
> +}
> +
>  sub git_patchset_body {
> -	my ($fd, $difftree, $hash, @hash_parents) =3D @_;
> +	my ($fd, $is_inline, $difftree, $hash, @hash_parents) =3D @_;

Hmmm... shouldn't changing git_patchset_body signature (calling
convention) be mentioned in commit message?

>  	my ($hash_parent) =3D $hash_parents[0];
>=20
>  	my $is_combined =3D (@hash_parents > 1);
> @@ -4940,12 +4967,31 @@ sub git_patchset_body {
>=20
>  		# the patch itself
>  	LINE:
> +		my @chunk;
>  		while ($patch_line =3D <$fd>) {
>  			chomp $patch_line;
>=20
>  			next PATCH if ($patch_line =3D~ m/^diff /);
>=20
> -			print format_diff_line($patch_line, \%from, \%to);
> +			my ($class, $line) =3D format_diff_line($patch_line, \%from, \%to=
);
> +			if ($is_inline) {
> +				print $line;
> +			} elsif ($class eq 'add' || $class eq 'rem') {
> +				push @chunk, [ $class, $line ];
> +			} else {
> +				if (@chunk) {
> +					print format_diff_chunk(@chunk);
> +					@chunk =3D ();
> +				} elsif ($class eq 'chunk_header') {
> +					print $line;
> +				} else {
> +					print '<div class=3D"chunk"><div class=3D"old">',
> +					      $line,
> +					      '</div><div class=3D"new">',
> +					      $line,
> +					      '</div></div>';
> +				}
> +			}

I wonder why you have output of context lines in side-by-side diff in
git_patchset_body, instead of having it all in format_diff_chunk.

Unless by chunk you mean something different than "unified format hunk"
that is defined e.g. in (diff.info)"Detailed Unified".

>  		}
>=20
>  	} continue {
> @@ -7053,7 +7099,8 @@ sub git_blobdiff {
>  	if ($format eq 'html') {
>  		print "<div class=3D\"page_body\">\n";
>=20
> -		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_ba=
se);
> +		git_patchset_body($fd, $input_params{diff_style} eq 'inline',
> +		                  [ \%diffinfo ], $hash_base, $hash_parent_base);
>  		close $fd;
>=20
>  		print "</div>\n"; # class=3D"page_body"
> @@ -7078,6 +7125,22 @@ sub git_blobdiff_plain {
>  	git_blobdiff('plain');
>  }
>=20
> +sub diff_nav {
> +	my ($style) =3D @_;
> +
> +	my %pairs =3D (inline =3D> 'inline', 'sidebyside' =3D> 'side by sid=
e');
> +	join '', ($cgi->start_form({ method =3D> 'get' }),
> +	          $cgi->hidden('p'),
> +	          $cgi->hidden('a'),
> +	          $cgi->hidden('h'),
> +	          $cgi->hidden('hp'),
> +	          $cgi->hidden('hb'),
> +	          $cgi->hidden('hpb'),
> +	          $cgi->popup_menu('ds', [keys %pairs], $style, \%pairs),
> +	          $cgi->submit('change'),
> +	          $cgi->end_form);
> +}

Why do you feel the need for form to select between diff formats,
instead of links switching between them, like for interactive and
non-interactive blame?

> +
>  sub git_commitdiff {
>  	my %params =3D @_;
>  	my $format =3D $params{-format} || 'html';
> @@ -7230,7 +7293,8 @@ sub git_commitdiff {
>  		my $ref =3D format_ref_marker($refs, $co{'id'});
>=20
>  		git_header_html(undef, $expires);
> -		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $form=
ats_nav);
> +		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash,
> +		                   $formats_nav . diff_nav($input_params{diff_styl=
e}));
>  		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $has=
h);
>  		print "<div class=3D\"title_text\">\n" .
>  		      "<table class=3D\"object_header\">\n";
> @@ -7284,7 +7348,8 @@ sub git_commitdiff {
>  		                  $use_parents ? @{$co{'parents'}} : $hash_parent)=
;
>  		print "<br/>\n";
>=20
> -		git_patchset_body($fd, \@difftree, $hash,
> +		git_patchset_body($fd, $input_params{diff_style} eq 'inline',
> +		                  \@difftree, $hash,
>  		                  $use_parents ? @{$co{'parents'}} : $hash_parent)=
;
>  		close $fd;
>  		print "</div>\n"; # class=3D"page_body"

Only commitdiff?  What about blobdiff?

> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 7d88509..dc84db2 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -618,6 +618,21 @@ div.remote {
>  	cursor: pointer;
>  }
>=20
> +/* side-by-side diff */
> +div.chunk {
> +	overflow: hidden;

???

> +}
> +
> +div.chunk div.old {
> +	float: left;
> +	width: 50%;
> +	overflow: hidden;
> +}
> +
> +div.chunk div.new {
> +	margin-left: 50%;
> +	width: 50%;
> +}

Hmmm... I think the way side-by-side diff is styled should be
explained in commit message, or in comments.

I also wonder if it wouldn't be simpler to use table here, instead of
fiddling with floats, widths and margins.

--=20
Jakub Nar=EAbski
