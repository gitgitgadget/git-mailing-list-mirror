From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] file import functionality for git-remote-mw
Date: Mon, 04 Jun 2012 22:54:11 +0200
Message-ID: <vpqd35en6h8.fsf@bauges.imag.fr>
References: <1338837351-8996-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 22:54:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbeIA-0007jo-Kd
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab2FDUyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:54:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49184 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab2FDUyR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:54:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54KjcdW026991
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 22:45:38 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbeI0-0000y2-7U; Mon, 04 Jun 2012 22:54:12 +0200
In-Reply-To: <1338837351-8996-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
	(Pavel Volek's message of "Mon, 4 Jun 2012 21:15:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 22:45:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54KjcdW026991
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339447541.80118@6TpMJqAM8l4UQIP1/6K5fQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199187>

Pavel Volek <Pavel.Volek@ensimag.imag.fr> writes:

> +sub get_mw_media_pages {
> +	mw_connect_maybe();
> +
> +	my %pages; # hash on page titles to avoid duplicates
> +
> +	# get all pages for mediafiles (they are in different namespace)
> +	# only one namespace can be queried at the same moment
> +	my $mw_pages = $mediawiki->list({
> +		action => 'query',
> +		list => 'allpages',
> +		apnamespace => get_mw_namespace_id("File"),
> +		aplimit => 500,
> +	});

This seems to be done unconditionally. Is this reasonable if the user
has explicitely set remote.origin.pages or remote.origin.categories?

Actually, shouldn't this be added to get_mw_pages, next to the code
dealing with these two variables? Perhaps the function should be
split into multiple functions, along the lines of:

sub get_mw_pages {
	mw_connect_maybe();

        my %pages;
	if (@tracked_pages) {
		$user_defined = 1;
		get_mw_tracked_pages(\%pages);
	}
	if (@tracked_categories) {
		$user_defined = 1;
		get_mw_tracked_categories(\%pages);
	}
	if (!$user_defined) {
		get_mw_all_pages(\%pages);
	}
	return values(%pages);
}

And your code would need to take these 3 options into account.

> +sub get_all_mw_pages() {
> +	my @pages = get_mw_pages();
> +	my @media_pages = get_mw_media_pages();
> +	push(@pages,@media_pages);

Space after comma.

> +# Returns MediaWiki id for a canonical namespace name. Ex.: "File", "Project".
> +sub get_mw_namespace_id() {
> +	mw_connect_maybe();
> +	my $name = shift;
> +	my $query = {
> +		action => 'query',
> +		meta => 'siteinfo',
> +		siprop => 'namespaces',
> +	};
> +	my $result = $mediawiki->api($query);

It may make sense to cache the result, to avoid querying the API
multiple times if you call the function more than once. We can even
cache this in a configuration variable as the namespace identifiers are
unlikely to change for a given wiki.

> +	if (!defined($file)){

Space between ) and { please.

> +		my @prefix = split (":",$page_title);

Space after , please.

> +		if ($prefix[0] eq "File" || $prefix[0] eq "Image") {
> +			# check if there is a corresponding mediafile with the same timestamp => it is page
> +			# for new verion of the file (not only for new version of the description of the file)

> +			# => download corresponding file version

Don't make long lines like this. In general, we avoid lines longer than
80 characters (or even a bit less), these are >100 and the following are
worse.

Long lines are usually an indication that you did not structure your
code into functions, and this diagnosis seems to apply here.

> +			my ($imageid,$imageinfo) = each ( %{$result->{query}->{pages}} );

Space after ",".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
