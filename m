From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 1/2] Add a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 9 Jun 2011 20:21:38 -0400
Message-ID: <20110610002137.GA11585@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 02:21:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUpU0-0007BB-4h
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 02:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab1FJAVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 20:21:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39770
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877Ab1FJAVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 20:21:46 -0400
Received: (qmail 21587 invoked by uid 107); 10 Jun 2011 00:21:54 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 20:21:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 20:21:38 -0400
Content-Disposition: inline
In-Reply-To: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175591>

On Thu, Jun 09, 2011 at 03:15:59PM +0200, Jeremie Nikaes wrote:

> Partial cloning is supported using the following syntax :
> "git clone mediawiki::http://wikiurl##A_Page##Another_Page"
> As always, this url is kept in .git/config, helping to always keep
> track of these specific pages

Earlier today I posted a 10-patch series to allow git to handle
something like:

  git clone \
    -c mediawiki.page=GitWorkflows \
    -c mediawiki.page=Tig \
    https://git.wiki.kernel.org

and set that config into the .git/config file. The patch for the
mediawiki helper to actually read and use it (instead of the "##" syntax
in the url) is just:

---
diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index fd26f87..75c3537 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -11,10 +11,9 @@ use warnings;
 my $slash_replacement = "%2F";
 
 my $remotename = $ARGV[0];
-# Current syntax to fetch only a set of pages mediawiki::http://mediawikiurl##A_Page##Another_Page
-my @pages_titles = split(/##/,$ARGV[1]);
-my $url = shift (@pages_titles);
-
+my $url = $ARGV[1];
+my @pages_titles = `git config --get-all mediawiki.page`;
+chomp @pages_titles;
 
 # commands parser
 my $entry;
