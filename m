From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv1] git-remote-mediawiki: import "File:" attachments
Date: Fri, 08 Jun 2012 16:42:53 +0200
Message-ID: <vpqmx4drhjm.fsf@bauges.imag.fr>
References: <1339165376-20267-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 16:43:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd0P6-0001z1-Q7
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760171Ab2FHOnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 10:43:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38685 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757632Ab2FHOnB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 10:43:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q58EY9nk000512
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 16:34:09 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sd0Os-0007XR-ES; Fri, 08 Jun 2012 16:42:54 +0200
In-Reply-To: <1339165376-20267-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
	(Pavel Volek's message of "Fri, 8 Jun 2012 16:22:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 16:34:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q58EY9nk000512
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339770854.17044@8CoWyX1AYCQ9m14RjzljYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199495>

Pavel Volek <Pavel.Volek@ensimag.imag.fr> writes:

> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki

If the patch adds support for [[File:...]], then it should remove/adapt
the comment at the top of the file :

# Known limitations:
#
# - Only wiki pages are managed, no support for [[File:...]]
#   attachments.

> @@ -212,59 +212,230 @@ sub get_mw_pages {
>  	my $user_defined;
>  	if (@tracked_pages) {
>  		$user_defined = 1;
> -		# The user provided a list of pages titles, but we
> -		# still need to query the API to get the page IDs.
> -
> -		my @some_pages = @tracked_pages;
> -		while (@some_pages) {
> -			my $last = 50;
> -			if ($#some_pages < $last) {
> -				$last = $#some_pages;
> -			}
> -			my @slice = @some_pages[0..$last];
> -			get_mw_first_pages(\@slice, \%pages);
> -			@some_pages = @some_pages[51..$#some_pages];
> -		}
> +		get_mw_tracked_pages(\%pages);
>  	}
>  	if (@tracked_categories) {
>  		$user_defined = 1;
> -		foreach my $category (@tracked_categories) {
> -			if (index($category, ':') < 0) {
> -				# Mediawiki requires the Category
> -				# prefix, but let's not force the user
> -				# to specify it.
> -				$category = "Category:" . $category;
> -			}
> -			my $mw_pages = $mediawiki->list( {
> -				action => 'query',
> -				list => 'categorymembers',
> -				cmtitle => $category,
> -				cmlimit => 'max' } )
> -			    || die $mediawiki->{error}->{code} . ': ' . $mediawiki->{error}->{details};
> -			foreach my $page (@{$mw_pages}) {
> -				$pages{$page->{title}} = $page;
> -			}
> -		}
> +		get_mw_tracked_categories(\%pages);
>  	}
>  	if (!$user_defined) {
> -		# No user-provided list, get the list of pages from
> -		# the API.
> -		my $mw_pages = $mediawiki->list({
> -			action => 'query',
> -			list => 'allpages',
> -			aplimit => 500,
> -		});
> -		if (!defined($mw_pages)) {
> -			print STDERR "fatal: could not get the list of wiki pages.\n";
> -			print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
> -			print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
> -			exit 1;
> +		 get_mw_all_pages(\%pages);
> +	}
> +	return values(%pages);
> +}

The refactoring is welcome, but it would have been better to make it in
a separate patch. The patch as you made it is long and hard to review,
because it combines several new features, and refactoring.

> +sub get_mw_tracked_pages {
> +	my $pages = shift;
> +	# The user provided a list of pages titles, but we
> +	# still need to query the API to get the page IDs.
> +	my @some_pages = @tracked_pages;
> +	while (@some_pages) {
> +		my $last = 50;
> +		if ($#some_pages < $last) {
> +			$last = $#some_pages;
> +		}
> +		my @slice = @some_pages[0..$last];
> +		get_mw_first_pages(\@slice, \%{$pages});
> +		@some_pages = @some_pages[51..$#some_pages];
> +	}
> +
> +	# Get pages of related media files.
> +	get_mw_linked_mediapages(\@tracked_pages, \%{$pages});
[...]
> +sub get_mw_linked_mediapages {

This is a nice feature, but I think it deserves to be configurable (if
the user explicitely specified one page, it actually seems strange to
import all the files it links to by default). Also, it should be
mentionned in the commit message.

Shouldn't the function be named get_mw_linked_mediafiles instead? In
general, the wording "media page" is used in many places in the code,
I prefer "media file" which is unambiguous.

> +sub get_mw_medafile_for_mediapage_revision {

medafile -> mediafile ?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
