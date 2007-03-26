From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] gitweb: Add treediff
Date: Mon, 26 Mar 2007 23:05:48 +0200
Message-ID: <20070326210548.GD1128@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621755-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548623081-git-send-email-mkoegler@auto.tuwien.ac.at> <200703261912.27612.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVwOA-0005st-Pc
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 23:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbXCZVFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 26 Mar 2007 17:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbXCZVFv
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 17:05:51 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58401 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbXCZVFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 17:05:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D746C73827C6;
	Mon, 26 Mar 2007 23:05:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9iudU5gi6lH2; Mon, 26 Mar 2007 23:05:48 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 4A2BD73839AD; Mon, 26 Mar 2007 23:05:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200703261912.27612.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43187>

On Mon, Mar 26, 2007 at 06:12:27PM +0100, Jakub Narebski wrote:
> On Sun, Mar 25, 2007, Martin Koegler wrote:
> > treediff supports comparing different trees. A tree can be specifie=
d
> > either as hash or as base hash and filename.
>=20
> I'd use "treediff" view, or git_treediff subroutine. Just a minor nit=
=2E
> =20
> > +sub git_treediff {
> > +	my $format =3D shift || 'html';
> > +	my $from =3D $file_parent || "";
> > +	my $to =3D $file_name || "";
>=20
> I'd use  $file_name || '';  here, and of course
>=20
> +	my $from =3D $file_parent || $file_name || '';
>=20
> The unwritten rule is that we use 'fp' parameter (thet $file_parent
> variable is set) only=20

How do I specifiy the root tree (=3Dtree in commit) with hpb/fp, as fp
can not be empty, but only undefined?

> > +
> > +	if (!defined $hash) {
> > +		if (!defined $hash_base) {
> > +			die_error('','tree parameter missing');
>=20
> This conflicts with the coding style used elsewhere in the gitweb
> (the informal coding convention / guideline for gitweb).
>=20
> First, we either use  undef  and not  ''  to say: use default value
> of the first parameter (HTTP status) of die_error, or provide our
> own value in single quotes.
>=20
> Second, the second parameter, error message, is a sentence (without
> final fullstop) describing error; it means starting it with capital
> letter. And we use double quotes for this parameter.
>=20
> Examples:
> 	die_error(undef, "Couldn't find base commit");
> 	die_error(undef, "Unknown commit object");
> 	die_error(undef, "No file name defined");
> 	die_error(undef, "Open git-diff-tree failed");
>=20
> 	die_error('403 Permission denied', "Permission denied");
> 	die_error('404 Not Found', "File name not defined");
> 	die_error('404 Not Found', "Not enough information to find object");
> 	die_error('400 Bad Request', "Object is not a blob");

I didn't know this. I'll change this.

> > +		}
> > +		$hash =3D $hash_base;
> > +		$hash .=3D ":".$file_name if (defined $file_name);
> > +	}
> > +
> > +	if (!defined $hash_parent) {
> > +		if (!defined $hash_parent_base) {
> > +			die_error('','tree parameter missing');
> > +		}
> > +		$hash_parent =3D $hash_parent_base;
> > +		$hash_parent .=3D ":".$file_parent if (defined $file_parent);
>=20
> The same problem as above: we do not set 'fp' parameter (and $file_pa=
rent
> variable) if name does not change. So you should use instead:
>=20
> +		$hash_parent .=3D ":".($file_parent || $file_name)
> +			if (defined $file_parent || defined $file_name);
>=20

Same as above: How to specifiy the root tree with hpb/fp?

> > +		if (defined $hash_parent_base && (my %co =3D parse_commit($hash_=
parent_base))) {
> > +	 		$formats_nav .=3D " | from: ".
> > +				$cgi->a({-href =3D> href(action=3D>"commit",
> > +			        	               hash=3D>$hash_parent_base)},
> > +				        "commit")
> > +				." | ".
> > +				$cgi->a({-href =3D> href(action=3D>"commitdiff",
> > +				                       hash=3D>$hash_parent_base)},
> > +				        "commitdiff")
> > +				." | ".
> > +				$cgi->a({-href =3D> href(action=3D>"tree",
> > +						       hash=3D>$co{'tree'},
> > +				                       hash_base=3D>$hash_parent_base)},
> > +				        "tree");
> > +		}
> > +	}
>=20
> This depends if the similar change (feature) for "blobdiff" view
> (in git_blobdiff subroutine) is accepted. Perhaps this could be
> separated into separate patch?

I'll do that.

> > +
> > +	# read treediff
> > +	my $fd;
> > +	my @difftree;
> > +	if ($format eq 'html') {
> > +		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
> > +			"--no-commit-id", "--patch-with-raw", "--full-index",
> > +			$hash_parent, $hash, "--"
> > +			or die_error(undef, "Open git-diff-tree failed");
> > +
> > +		while (my $line =3D <$fd>) {
> > +			chomp $line;
> > +			# empty line ends raw part of diff-tree output
> > +			last unless $line;
> > +			push @difftree, $line;
> > +		}
>=20
> This is also common with git_commitdiff. Should be it put into separa=
te
> subroutine? Or do this refactoring in another patch?

I would like to save the refactoring for later. Maybe we will need a
change, which will not work for git_commitdiff.

> > +
> > +	} elsif ($format eq 'plain') {
> > +		my $filename =3D basename($project) . "-diff.patch";
> > +
>=20
> In "commitdiff_plain" view we use
>=20
> 		my $filename =3D basename($project) . "-$hash.patch";
>=20
> Perhaps we should use the same: "-diff.patch" does not make much sens=
e.
> Is it a typo?

No. What unique name do you propose? It needs to include $hash and $has=
e_parent.
In this case, $hash could be $hash_base:$file_name, I'm not sure, how t=
o escape=20
$file_name.

mfg Martin K=F6gler
