From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 1/2] Add a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 9 Jun 2011 18:44:25 -0400
Message-ID: <20110609224424.GA5364@sigill.intra.peff.net>
References: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:44:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUnxs-0003YP-SJ
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab1FIWob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 18:44:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36938
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757042Ab1FIWo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 18:44:29 -0400
Received: (qmail 20618 invoked by uid 107); 9 Jun 2011 22:44:36 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 18:44:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 18:44:25 -0400
Content-Disposition: inline
In-Reply-To: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175585>

On Thu, Jun 09, 2011 at 03:15:59PM +0200, Jeremie Nikaes wrote:

> For now, the whole wiki is cloned, but it will be possible to clone only
> some pages: the clone is based on a list of pages which is now all
> pages.

This is not really true anymore, is it? Later you say:

> Partial cloning is supported using the following syntax :
> "git clone mediawiki::http://wikiurl##A_Page##Another_Page"
> As always, this url is kept in .git/config, helping to always keep
> track of these specific pages

so I think it is not "will be" possible any more.

> +sub get_pages{
> +	my $mediawiki = MediaWiki::API->new;
> +	$mediawiki->{config}->{api_url} = "$url/api.php";
> [...]
> +	} else {
> +		#the list of titles should follow the pattern 'page1|page2|...'
> +		my $titles = "";
> +		foreach my $title (@pages_titles){
> +			$titles.="$title|";
> +		}
> +		#supress the last | that is add in the foreach
> +		chop($titles);

This is usually spelled:

  my $titles = join('|', @pages_titles);

> +		$pages = $mediawiki->api({
> +			action => 'query',
> +			titles => $titles,
> +		});
> +		if (!defined($pages)) {
> +			print STDERR "fatal: None of the pages exist \n";
> +			exit 1;
> +		}

That's not an accurate error message. If the pages don't exist, we will
actually get back a set of pages with negative ids (so you can tell
which ones exist and which ones don't). If $pages is undefined, it's
actually not a valid mediawiki repo.

Also, according to the mediawiki API, we can send only 51 titles at a
time. So we need to break this into pieces.

However, I wonder if this code path is needed at all. We are mapping
titles to page ids, so that we can later ask mediawiki for revisions by
page id. But why not just ask for revisions by title, and skip this
extra round trip to the server?

Speaking of round trips, I did have an idea for reducing round-trips in
the "mostly up to date" case. We can ask for the revisions for multiple
titles at once (apparently up to 51, or 501 if you have special bot
privileges), but you will only get the latest revision for each. Which
isn't sufficient for us to do anything except tell whether or not there
are any revisions to fetch.

So without the optimization, with N pages we will make N requests for
new revisions. But with it, we will make N/51 requests for the latest
revisions, and then M (where M <= N) for every page that actually has
new content. In other words, it is a good optimization as long as less
than 49/51 pages have changed, on average. So it's bad for "clone", but
very good for a subsequent "fetch". The best case is a fetch where
nothing has changed, which should have 1/51th as many round-trips to
determine that is the case.

-Peff
