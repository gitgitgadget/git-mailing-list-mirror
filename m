From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCHv1] git-remote-mediawiki: import "File:" attachments
Date: Fri, 08 Jun 2012 18:20:59 +0200
Message-ID: <4FD2266B.3040706@ensimag.imag.fr>
References: <1339165376-20267-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 18:21:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd1vz-0006V0-Gn
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 18:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761939Ab2FHQVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 12:21:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57429 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761314Ab2FHQVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 12:21:04 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q58GCGXj017723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 18:12:16 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q58GL0Jj012088;
	Fri, 8 Jun 2012 18:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <1339165376-20267-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 18:12:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q58GCGXj017723
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339776737.22163@PfA495L0G9e8usaPI5RlcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199510>



On 08/06/2012 16:22, Pavel Volek wrote:
> From: Volek Pavel<me@pavelvolek.cz>
>
> The current version of the git-remote-mediawiki supports only import =
and export
> of the pages, doesn't support import and export of file attachements =
which are
> also exposed by MediaWiki API. This patch adds the functionality to i=
mport the
> last versions of the files and all versions of description pages for =
these
> files.
>
> Signed-off-by: Pavel Volek<Pavel.Volek@ensimag.imag.fr>
> Signed-off-by: NGUYEN Kim Thuat<Kim-Thuat.Nguyen@ensimag.imag.fr>
> Signed-off-by: ROUCHER IGLESIAS Javier<roucherj@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy<Matthieu.Moy@imag.fr>
> ---

>   contrib/mw-to-git/git-remote-mediawiki | 290 ++++++++++++++++++++++=
+++++------
>   1 file changed, 244 insertions(+), 46 deletions(-)

I am wondering why are you showing the removal for a v1 patch ?

>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-g=
it/git-remote-mediawiki
> index c18bfa1..9f21217 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -212,59 +212,230 @@ sub get_mw_pages {
>   	my $user_defined;
>   	if (@tracked_pages) {
>   		$user_defined =3D 1;
> -		# The user provided a list of pages titles, but we
> -		# still need to query the API to get the page IDs.
> -
> -		my @some_pages =3D @tracked_pages;
> -		while (@some_pages) {
> -			my $last =3D 50;
> -			if ($#some_pages<  $last) {
> -				$last =3D $#some_pages;
> -			}
> -			my @slice =3D @some_pages[0..$last];
> -			get_mw_first_pages(\@slice, \%pages);
> -			@some_pages =3D @some_pages[51..$#some_pages];
> -		}
> +		get_mw_tracked_pages(\%pages);
>   	}
>   	if (@tracked_categories) {
>   		$user_defined =3D 1;
> -		foreach my $category (@tracked_categories) {
> -			if (index($category, ':')<  0) {
> -				# Mediawiki requires the Category
> -				# prefix, but let's not force the user
> -				# to specify it.
> -				$category =3D "Category:" . $category;
> -			}
> -			my $mw_pages =3D $mediawiki->list( {
> -				action =3D>  'query',
> -				list =3D>  'categorymembers',
> -				cmtitle =3D>  $category,
> -				cmlimit =3D>  'max' } )
> -			    || die $mediawiki->{error}->{code} . ': ' . $mediawiki->{erro=
r}->{details};
> -			foreach my $page (@{$mw_pages}) {
> -				$pages{$page->{title}} =3D $page;
> -			}
> -		}
> +		get_mw_tracked_categories(\%pages);
>   	}
>   	if (!$user_defined) {
> -		# No user-provided list, get the list of pages from
> -		# the API.
> -		my $mw_pages =3D $mediawiki->list({
> -			action =3D>  'query',
> -			list =3D>  'allpages',
> -			aplimit =3D>  500,
> -		});
> -		if (!defined($mw_pages)) {
> -			print STDERR "fatal: could not get the list of wiki pages.\n";
> -			print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
> -			print STDERR "fatal: make sure '$url/api.php' is a valid page.\n"=
;
> -			exit 1;
> +		 get_mw_all_pages(\%pages);
> +	}
> +	return values(%pages);
> +}
> +
> +sub get_mw_all_pages {
> +	my $pages =3D shift;
> +	# No user-provided list, get the list of pages from the API.
> +	my $mw_pages =3D $mediawiki->list({
> +		action =3D>  'query',
> +		list =3D>  'allpages',
> +		aplimit =3D>  500,
> +	});
> +	if (!defined($mw_pages)) {
> +		print STDERR "fatal: could not get the list of wiki pages.\n";
> +		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
> +		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
> +		exit 1;
> +	}
> +	foreach my $page (@{$mw_pages}) {
> +		$pages->{$page->{title}} =3D $page;
> +	}
> +
> +	# Attach list of all pages for meadia files from the API,
> +	# they are in a different namespace, only one namespace
> +	# can be queried at the same moment
> +	my $mw_mediapages =3D $mediawiki->list({
> +		action =3D>  'query',
> +		list =3D>  'allpages',
> +		apnamespace =3D>  get_mw_namespace_id("File"),
> +		aplimit =3D>  500,
> +	});
> +	if (!defined($mw_mediapages)) {
> +		print STDERR "fatal: could not get the list of media file pages.\n=
";
> +		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
> +		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
> +		exit 1;
> +	}
> +	foreach my $page (@{$mw_mediapages}) {
> +		$pages->{$page->{title}} =3D $page;
> +	}
> +}
> +
> +sub get_mw_tracked_pages {
> +	my $pages =3D shift;
> +	# The user provided a list of pages titles, but we
> +	# still need to query the API to get the page IDs.
> +	my @some_pages =3D @tracked_pages;
> +	while (@some_pages) {
> +		my $last =3D 50;
> +		if ($#some_pages<  $last) {
> +			$last =3D $#some_pages;
> +		}
> +		my @slice =3D @some_pages[0..$last];
> +		get_mw_first_pages(\@slice, \%{$pages});
> +		@some_pages =3D @some_pages[51..$#some_pages];
> +	}
> +
> +	# Get pages of related media files.
> +	get_mw_linked_mediapages(\@tracked_pages, \%{$pages});
> +}
> +
> +sub get_mw_tracked_categories {
> +	my $pages =3D shift;
> +	foreach my $category (@tracked_categories) {
> +		if (index($category, ':')<  0) {
> +			# Mediawiki requires the Category
> +			# prefix, but let's not force the user
> +			# to specify it.
> +			$category =3D "Category:" . $category;
>   		}
> +		my $mw_pages =3D $mediawiki->list( {
> +			action =3D>  'query',
> +			list =3D>  'categorymembers',
> +			cmtitle =3D>  $category,
> +			cmlimit =3D>  'max' } )
> +			|| die $mediawiki->{error}->{code} . ': '
> +				. $mediawiki->{error}->{details};
>   		foreach my $page (@{$mw_pages}) {
> -			$pages{$page->{title}} =3D $page;
> +			$pages->{$page->{title}} =3D $page;
> +		}
> +
> +		my @titles =3D map $_->{title}, @{$mw_pages};
> +		# Get pages of related media files.
> +		get_mw_linked_mediapages(\@titles, \%{$pages});
> +	}
> +}
> +
> +sub get_mw_linked_mediapages {
> +	my $titles =3D shift;
> +	my @titles =3D @{$titles};
> +	my $pages =3D shift;
> +
> +	# pattern 'page1|page2|...' required by the API
> +	my $mw_titles =3D join('|', @titles);
> +
> +	# Media files could be included or linked from
> +	# a page, get all related
> +	my $query =3D {
> +		action =3D>  'query',
> +		prop =3D>  'links|images',
> +		titles =3D>  $mw_titles,
> +		plnamespace =3D>  get_mw_namespace_id("File"),
> +		pllimit =3D>  500,
> +	};

Why a comma after 500 ?

> +	my $result =3D $mediawiki->api($query);


What happened if the titles in the query contains special character=20
which are not allowed by mediawiki for filename like { or [.
Maybe you should build a test for it and if it doesn't work try out the=
=20
functions called:
     mediawiki_clean/smudge_filename
in the file git-remote-mediawiki


> +
> +	while (my ($id, $page) =3D each(%{$result->{query}->{pages}})) {
> +		my @titles;
> +		if (defined($page->{links})) {
> +			my @link_titles =3D map $_->{title}, @{$page->{links}};
> +			push(@titles, @link_titles);
> +		}
> +		if (defined($page->{images})) {
> +			my @image_titles =3D map $_->{title}, @{$page->{images}};
> +			push(@titles, @image_titles);
> +		}
> +		if (@titles) {
> +			get_mw_first_pages(\@titles, \%{$pages});
>   		}
>   	}
> -	return values(%pages);
> +}
> +
> +sub get_mw_medafile_for_mediapage_revision {
> +	# Name of the file on Wiki, with the prefix.
> +	my $mw_filename =3D shift;
> +	my $timestamp =3D shift;
> +	my %mediafile;
> +
> +	# Search if on MediaWiki exists a media file with given
> +	# timestamp and in that case download the file.
> +	my $query =3D {
> +		action =3D>  'query',
> +		prop =3D>  'imageinfo',
> +		titles =3D>  $mw_filename,
> +		iistart =3D>  $timestamp,
> +		iiend =3D>  $timestamp,
> +		iiprop =3D>  'timestamp|archivename',
> +		iilimit =3D>  1,
> +	};

Why a comma after iilimit ? (end of list of parameter here I think...)

> +	my $result =3D $mediawiki->api($query);
> +
> +	my ($fileid, $file) =3D each ( %{$result->{query}->{pages}} );
> +	if (defined($file->{imageinfo})) {
> +		my $fileinfo =3D pop(@{$file->{imageinfo}});
> +		if (defined($fileinfo->{archivename})) {
> +			return; # now we are not able to download files from archive
> +		}
> +
> +		my $filename; # real filename without prefix
> +		if (index($mw_filename, 'File:') =3D=3D 0) {
> +			$filename =3D substr $mw_filename, 5;
> +		} else {
> +			$filename =3D substr $mw_filename, 6;
> +		}
> +
> +		$mediafile{title} =3D $filename;
> +		$mediafile{content} =3D download_mw_mediafile($mw_filename);
> +	}
> +	return %mediafile;
> +}
> +
> +# Returns MediaWiki id for a canonical namespace name.
> +# Ex.: "File", "Project".
> +# Looks for the namespace id in the local configuration
> +# variables, if it is not found asks MW API.
> +sub get_mw_namespace_id {
> +	mw_connect_maybe();
> +
> +	my $name =3D shift;
> +
> +	# Look at configuration file, if the record
> +	# for that namespace is already stored.
> +	my @tracked_namespaces =3D split(/[ \n]/, run_git("config --get-all=
 remote.". $remotename .".namespaces"));

Broken indentation/line too long ?

> +
> +	# NS not found =3D>  get namespace id from MW and store it in
> +	# configuration file.
> +	my $query =3D {
> +		action =3D>  'query',
> +		meta =3D>  'siteinfo',
> +		siprop =3D>  'namespaces',
> +	};

Same here concerning comma.

> +	my $result =3D $mediawiki->api($query);
> +
> +	while (my ($id, $ns) =3D each(%{$result->{query}->{namespaces}})) {
> +		if (defined($ns->{canonical})&&  ($ns->{canonical} eq $name)) {
> +			run_git("config --add remote.". $remotename .".namespaces ". $nam=
e ."=3D". $ns->{id});
> +			return $ns->{id};
> +		}
> +	}
> +	die "Namespace $name was not found on MediaWiki.";
> +}
> +
> +sub download_mw_mediafile {
> +	my $filename =3D shift;
> +
> +	$mediawiki->{config}->{files_url} =3D $url;
> +
> +	my $file =3D $mediawiki->download( { title =3D>  $filename } );

Just wondering: What happened if $filename contains some forbidden=20
character on wiki's filename such as '{' or '|' ?
I am worrying about it because i've got some similar issues in my own=20
work on tests for git-remote-mediawiki.

Hope I helped :).

Simon

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
