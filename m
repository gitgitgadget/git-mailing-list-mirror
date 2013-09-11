From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 09:20:43 +0100
Message-ID: <20130911082042.GR2582@serenity.lan>
References: <cover.1378840318.git.john@keeping.me.uk>
 <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
 <52300838.5040703@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 11 10:20:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJffW-0007CK-On
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 10:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab3IKIUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 04:20:53 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:56587 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3IKIUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 04:20:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id A45E822F3E;
	Wed, 11 Sep 2013 09:20:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0IW94s70GGT0; Wed, 11 Sep 2013 09:20:51 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 5A8B222F4A;
	Wed, 11 Sep 2013 09:20:44 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <52300838.5040703@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234550>

On Wed, Sep 11, 2013 at 08:05:44AM +0200, Johannes Sixt wrote:
> Am 10.09.2013 21:13, schrieb John Keeping:
> > When using tab-completion, a directory path will often end with a
> > trailing slash which currently confuses "git rm" when dealing with
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
> 
> When the index is now read here, I would have expected hunk in this
> patch that removes a read_cache() invocation.

I think that needs to look like this on top - there's also a
read_cache_unmerged() around line 68 but I don't think we can remove
that one.

-- >8 --
diff --git a/builtin/reset.c b/builtin/reset.c
index 9efac0f..800117f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -143,7 +143,6 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 
-	read_cache();
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
 	diffcore_std(&opt);
@@ -169,7 +168,7 @@ static void set_reflog_message(struct strbuf *sb, const char *action,
 
 static void die_if_unmerged_cache(int reset_type)
 {
-	if (is_merge() || read_cache() < 0 || unmerged_cache())
+	if (is_merge() || unmerged_cache())
 		die(_("Cannot do a %s reset in the middle of a merge."),
 		    _(reset_type_names[reset_type]));
