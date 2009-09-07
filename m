From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/2] Add url.<base>.pushInsteadOf: URL rewriting for
 push only
Date: Mon, 7 Sep 2009 01:19:52 -0700
Message-ID: <20090907081952.GA21550@feather>
References: <cover.1252306396.git.josh@joshtriplett.org>
 <0be9995dcd7d48c918fa75f4d9e557a6144a047c.1252306396.git.josh@joshtriplett.org>
 <7vljkr2ntd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:20:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZSS-000208-7v
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZIGIUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbZIGIUF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:20:05 -0400
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:35897 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbZIGIUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:20:04 -0400
X-Greylist: delayed 4824 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2009 04:20:03 EDT
Received: from feather (pool-173-50-250-234.ptldor.fios.verizon.net [173.50.250.234])
	by relay2-v.mail.gandi.net (Postfix) with ESMTP id 0A966135D0;
	Mon,  7 Sep 2009 10:20:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vljkr2ntd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127902>

On Mon, Sep 07, 2009 at 12:53:18AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> > This configuration option allows systematically rewriting fetch-only
> > URLs to push-capable URLs when used with push.  For instance:
> >
> > [url "ssh://example.org/"]
> >     pushInsteadOf = "git://example.org/"
> >
> > This will allow clones of "git://example.org/path/to/repo" to
> > subsequently push to "ssh://example.org/path/to/repo", without manually
> > configuring pushurl for that remote.
> 
> Nice.

Thanks.

> > @@ -435,12 +449,13 @@ static void alias_all_urls(void)
> >  	for (i = 0; i < remotes_nr; i++) {
> >  		if (!remotes[i])
> >  			continue;
> > -		for (j = 0; j < remotes[i]->url_nr; j++) {
> > -			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
> > -		}
> >  		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
> >  			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
> >  		}
> > +		for (j = 0; j < remotes[i]->url_nr; j++) {
> > +			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
> > +			add_pushurl_alias(remotes[i], remotes[i]->url[j]);
> > +		}
> 
> Even if you have URL but not pushURL, now you get a corresponding pushURL
> for free by just adding pushinsteadof mapping that covers the URL without
> having to configue pushURL for each of them.

Yes, exactly.

> What happens if you already had a pair of concrete url and pushurl defined
> for one of your repositories (say git://git.kernel.org/pub/scm/git/git.git
> for fetch, ssh://x.kernel.org/pub/scm/git/git.git for push) at a site, and
> then upon seeing this new feature, added a pushinsteadof pattern that also
> covers the URL side of that pair (e.g. everything in git://git.kernel.org/
> is mapped to x.kernel.org:/ namespsace)?
> 
> Do you end up pushing to both (e.g. ssh://x.kernel.org/pub/scm/git/git.git
> and x.kernel.org:/pub/scm/git/git.git), or in such a case, the pushURL you
> gave explicitly prevents the pushinsteadof to give unexpected duplicates?

You get a duplicate:

~$ grep -B1 steadOf .gitconfig
[url "ssh://joshtriplett.org/"]
        pushInsteadOf="git://joshtriplett.org/"
~$ grep -B1 url .git/config
[remote "origin"]
        url = git://joshtriplett.org/git/home.git
        pushurl = ssh://joshtriplett.org/git/home.git
~$ ~/src/git/git push
Everything up-to-date
Everything up-to-date

Initially, that behavior seemed pretty reasonable to me; nothing else in
the remotes handling attempts to remove duplicates, and they seem
harmless enough and easily resolved by removing one or the other.  Now
that I think about it, though, an explicit pushurl should definitely
disable pushInsteadOf's implicit pushurls.  If you explicitly configure
a *different* pushurl for a remote, you may not *want* the default
pushurl that corresponds to your url.  For instance, consider what would
happen if you configure url to point to the main public repository and
pushurl to point to a private repository.  In this case, you definitely
don't want "git push" to helpfully push to the public repository as
well; if you do, you can easily enough add a second pushurl for that.

I can easily change the patch to make an explicit pushurl disable
pushInsteadOf.  Expect v2 shortly.

- Josh Triplett
