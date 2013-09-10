From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Tue, 10 Sep 2013 20:46:52 +0100
Message-ID: <20130910194652.GP2582@serenity.lan>
References: <cover.1378840318.git.john@keeping.me.uk>
 <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
 <522F7509.1050100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 10 21:47:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJTtw-0001gl-PD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 21:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab3IJTrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 15:47:00 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:41973 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab3IJTq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 15:46:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2C0786064CC;
	Tue, 10 Sep 2013 20:46:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecyYGnvOToUN; Tue, 10 Sep 2013 20:46:58 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 707A1606506;
	Tue, 10 Sep 2013 20:46:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <522F7509.1050100@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234475>

On Tue, Sep 10, 2013 at 09:37:45PM +0200, Jens Lehmann wrote:
> Am 10.09.2013 21:13, schrieb John Keeping:
> > When using tab-completion, a directory path will often end with a
> > trailing slash which currently confuses "git rm" when dealing with
> 
> I think you meant to say "git reset" in the line above. Apart from
> that I'm all for it.

Yeah, you're right - I obviously got confused between the two patches :-(.
I'll wait for more feedback before submitting a re-roll.

> > submodules.  Now that we have parse_pathspec we can easily handle this
> > by simply adding the PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag.
> > 
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  builtin/reset.c            | 5 +++++
> >  t/t7400-submodule-basic.sh | 6 ++++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 5e4c551..9efac0f 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -220,8 +220,13 @@ static void parse_args(struct pathspec *pathspec,
> >  		}
> >  	}
> >  	*rev_ret = rev;
> > +
> > +	if (read_cache() < 0)
> > +		die(_("index file corrupt"));
> > +
> >  	parse_pathspec(pathspec, 0,
> >  		       PATHSPEC_PREFER_FULL |
> > +		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
> >  		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
> >  		       prefix, argv);
> >  }
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index 4192fe0..c268d3c 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -481,7 +481,7 @@ test_expect_success 'do not add files from a submodule' '
> >  
> >  '
> >  
> > -test_expect_success 'gracefully add submodule with a trailing slash' '
> > +test_expect_success 'gracefully add/reset submodule with a trailing slash' '
> >  
> >  	git reset --hard &&
> >  	git commit -m "commit subproject" init &&
> > @@ -495,7 +495,9 @@ test_expect_success 'gracefully add submodule with a trailing slash' '
> >  	git add init/ &&
> >  	test_must_fail git diff --exit-code --cached init &&
> >  	test $commit = $(git ls-files --stage |
> > -		sed -n "s/^160000 \([^ ]*\).*/\1/p")
> > +		sed -n "s/^160000 \([^ ]*\).*/\1/p") &&
> > +	git reset init/ &&
> > +	git diff --exit-code --cached init
> >  
> >  '
> >  
> > 
