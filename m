From: Jeff King <peff@peff.net>
Subject: Re: git-reset HEAD --permissions-only
Date: Thu, 17 Mar 2011 02:01:29 -0400
Message-ID: <20110317060129.GC11931@sigill.intra.peff.net>
References: <illts0$c6q$1@dough.gmane.org>
 <20110315013223.GB31865@sigill.intra.peff.net>
 <4D800D0B.2000307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 07:02:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q06Hc-0004w6-Bq
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 07:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab1CQGBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 02:01:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44112
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab1CQGBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 02:01:34 -0400
Received: (qmail 20421 invoked by uid 107); 17 Mar 2011 06:02:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 02:02:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 02:01:29 -0400
Content-Disposition: inline
In-Reply-To: <4D800D0B.2000307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169211>

On Tue, Mar 15, 2011 at 08:06:19PM -0500, Neal Kreitzinger wrote:

> You are right about git checkout -p because there are alot of code
> changes to alot of files.  I haven't used git patches and I don't
> know perl.  However, your reasoning about the last example seems the
> most straight-forward so I used it.  I symptomatically validated my
> re-keying of the syntax as follows since TTBOMK I couldn't copy+paste
> your example due to whitespace:
> 
> git ls-files -sz | perl -0ne '/100(\d+).*?\t(.*)/
>  or next; -e $2 or next; chmod(oct($1), $2) or die "chmod failed: $!";'

The whitespace in what I sent was fine, though it's possible your MUA
mangled it.

It sounds like the solution worked for you, so cool. But I did have one
more thought to mention: since you are working with a vendor branch, you
should be able to have a "pristine" vendor branch complete with their
wrong permissions, and then build your permissions fixes on top of that.
And then when you merge the pristine branch up to your branch, git will
automatically resolve the permissions in favor of yours (because its
built on top).

So something like:

  # import initial vendor branch
  git init
  # untar or whatever happens to get the files
  tar xzf /path/to/vendor-1.0.tar.gz
  git add .
  git commit -m 'import vendor 1.0'

  # now move it to vendor branch and make our munged-vendor branch
  git branch vendor
  git checkout -b vendor-fixed vendor

  # now tweak permissions
  .. chmod or however you did it originally ...
  git add -u
  git commit -m 'fix broken vendor permissions'

  # and then built your real work on top of vendor-fixed
  git branch -f master vendor-fixed
  git checkout master

  # weeks pass; vendor releases 1.1
  git checkout vendor
  # untar or whatever we do to get the files
  tar xzf /path/to/vendor-1.1.tar.gz
  git add -A
  git commit -m 'import vendor 1.1'

  # now we merge it in, but our permissions fixes will be retained
  git checkout vendor-fixed
  git merge vendor
  # however we may still have to deal with new files
  ... chmod or whatever on new files ...
  git add -u
  git commit -m 'fix more broken vendor permissions'

...and repeat for each new version the vendor releases.

That gives you three branches: vendor with the pristine vendor source,
vendor-fixed with any baseline fixes (permissions changes in this case),
and then your real work goes on master (or on topic branches that get
merged to master).

You could also omit the vendor-fixed branch and just put your fixes on
the master branch. Doing it with the third branch, though, means you
will have a less noisy diff doing "git diff master vendor-fixed", since
it will not include all the permissions mucking.

-Peff
