From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv9 3/4] ref namespaces: Support remote repositories via
 upload-pack and receive-pack
Date: Wed, 6 Jul 2011 22:31:22 -0700
Message-ID: <20110707053122.GA1798@leaf>
References: <cover.1309888001.git.josh@joshtriplett.org>
 <fff78c90d7f9deb0a8294fe3158ab0285e1610ff.1309888001.git.josh@joshtriplett.org>
 <7vy60bkzmf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 07:31:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QehBk-00022s-9d
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 07:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab1GGFbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 01:31:43 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46765 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab1GGFbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 01:31:42 -0400
X-Originating-IP: 217.70.178.137
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 5671117207E;
	Thu,  7 Jul 2011 07:31:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter8-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 2b4sU70ycqZE; Thu,  7 Jul 2011 07:31:38 +0200 (CEST)
X-Originating-IP: 50.43.15.19
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 64B50172074;
	Thu,  7 Jul 2011 07:31:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy60bkzmf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176747>

On Wed, Jul 06, 2011 at 11:55:36AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > Change upload-pack and receive-pack to use the namespace-prefixed refs
> > when working with the repository, and use the unprefixed refs when
> > talking to the client, maintaining the masquerade.  This allows
> > clone, pull, fetch, and push to work with a suitably configured
> > GIT_NAMESPACE.
> >
> > With appropriate configuration, this also allows http-backend to expose
> > namespaces as multiple repositories with different paths.  This only
> > requires setting GIT_NAMESPACE, which http-backend passes through to
> > upload-pack and receive-pack.
> >
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > Signed-off-by: Jamey Sharp <jamey@minilop.net>
> > ---
> >  builtin/receive-pack.c |   37 +++++++++++++++++++++++++++++++------
> >  upload-pack.c          |   15 ++++++++-------
> >  2 files changed, 39 insertions(+), 13 deletions(-)
> >
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index e1a687a..2d36378 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -120,9 +120,17 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
> >  	return 0;
> >  }
> >  
> > +static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *cb_data)
> > +{
> > +	path = strip_namespace(path);
> > +	if (!path)
> > +		path = ".have";
> > +	return show_ref(path, sha1, flag, cb_data);
> 
> At the first glance, this felt somewhat unoptimal as it forbids us from
> stuffing fake "ref" entries other than ".have" via the add_extra_ref()
> interface, and I wondered if it would make sense to do something like this
> instead:
> 
> 	const char *ns_path = strip_namespace(path);
>         if (!ns_path)
>         	ns_path = path;
> 	return show_ref(ns_path, sha1, flag, cb_data);
> 
> But that is flawed, and I think your patch does the right thing.  The
> justification is a bit subtle [*1*] and I think it needs to be explained
> in a comment around here, not just in the 0/4 cover letter message.

Will do.  How does the following coment sound?

/* We advertise refs outside our current namespace as .have refs, so
 * that the client can use them to minimize data transfer but will
 * otherwise ignore them. */

- Josh Triplett
