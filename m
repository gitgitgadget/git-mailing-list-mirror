From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] mw-to-git: use git-credential's URL parser
Date: Wed, 18 Jul 2012 08:28:48 -0400
Message-ID: <20120718122848.GB11482@sigill.intra.peff.net>
References: <20120718120307.GA6399@sigill.intra.peff.net>
 <20120718120656.GD6726@sigill.intra.peff.net>
 <vpqd33tjlzm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:28:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTNB-0004bR-2t
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab2GRM2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:28:52 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39111
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab2GRM2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:28:51 -0400
Received: (qmail 19370 invoked by uid 107); 18 Jul 2012 12:28:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 08:28:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 08:28:48 -0400
Content-Disposition: inline
In-Reply-To: <vpqd33tjlzm.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201685>

On Wed, Jul 18, 2012 at 02:24:13PM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -216,7 +190,9 @@ sub credential_write {
> >  sub credential_run {
> >  	my $op = shift;
> >  	my $credential = shift;
> > +	my $url = shift;
> >  	my $pid = open2(my $reader, my $writer, "git credential $op");
> > +	print $writer "url=$url\n" if defined $url;
> >  	credential_write($credential, $writer);
> >  	print $writer "\n";
> >  	close($writer);
> > @@ -246,10 +222,10 @@ sub mw_connect_maybe {
> >  	$mediawiki = MediaWiki::API->new;
> >  	$mediawiki->{config}->{api_url} = "$url/api.php";
> >  	if ($wiki_login) {
> > -		my %credential = credential_from_url($url);
> > +		my %credential;
> >  		$credential{username} = $wiki_login;
> >  		$credential{password} = $wiki_passwd;
> > -		credential_run("fill", \%credential);
> > +		credential_run("fill", \%credential, $url);
> >  		my $request = {lgname => $credential{username},
> >  			       lgpassword => $credential{password},
> >  			       lgdomain => $wiki_domain};
> 
> I would find it more elegant not to special-case the URL field, and just
> 
>   my %credential = ('url' => $url);
> 
> but I'm fine with your version too.

I started with a version that did that, but there are two complications:

  1. credential_write needs to know that the 'url' field must come
     first, as it overwrites the other fields. So we end up
     special-casing it either way.

  2. Git hands us back the broken-down version, which we add to the
     credential. So it is superfluous to keep sending 'url' for the
     other, non-fill interactions. I don't think it's technically wrong,
     but it also seemed inelegant. Having "credential_write" delete the
     'url' field seemed even more inelegant.

> Other than that, and for the 4 patches of the serie:
> 
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks.

-Peff
