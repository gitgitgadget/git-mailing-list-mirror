From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] rm: re-use parse_pathspec's trailing-slash removal
Date: Wed, 11 Sep 2013 09:24:41 +0100
Message-ID: <20130911082441.GS2582@serenity.lan>
References: <cover.1378840318.git.john@keeping.me.uk>
 <b16901cdc3d433a8e0f7078475cb06f90b4590dd.1378840318.git.john@keeping.me.uk>
 <CACsJy8Dw+RJor-XfjFQC5U5Pt39TZ656fEnkFxpDnx=kTqvADQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 10:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJfjO-0004BD-5V
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 10:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab3IKIYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 04:24:51 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:59076 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3IKIYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 04:24:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id CD8E122F15;
	Wed, 11 Sep 2013 09:24:49 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EWaF+XvEYKHo; Wed, 11 Sep 2013 09:24:49 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 709D022B56;
	Wed, 11 Sep 2013 09:24:43 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CACsJy8Dw+RJor-XfjFQC5U5Pt39TZ656fEnkFxpDnx=kTqvADQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234551>

On Wed, Sep 11, 2013 at 02:48:51PM +0700, Duy Nguyen wrote:
> On Wed, Sep 11, 2013 at 2:13 AM, John Keeping <john@keeping.me.uk> wrote:
> > Instead of re-implementing the "remove trailing slashes" loop in
> > builtin/rm.c just pass PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP to
> > parse_pathspec.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  builtin/rm.c | 20 ++++----------------
> >  1 file changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/builtin/rm.c b/builtin/rm.c
> > index 9b59ab3..3a0e0ea 100644
> > --- a/builtin/rm.c
> > +++ b/builtin/rm.c
> > @@ -298,22 +298,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
> >         if (read_cache() < 0)
> >                 die(_("index file corrupt"));
> >
> > -       /*
> > -        * Drop trailing directory separators from directories so we'll find
> > -        * submodules in the index.
> > -        */
> > -       for (i = 0; i < argc; i++) {
> > -               size_t pathlen = strlen(argv[i]);
> > -               if (pathlen && is_dir_sep(argv[i][pathlen - 1]) &&
> > -                   is_directory(argv[i])) {
> > -                       do {
> > -                               pathlen--;
> > -                       } while (pathlen && is_dir_sep(argv[i][pathlen - 1]));
> > -                       argv[i] = xmemdupz(argv[i], pathlen);
> > -               }
> > -       }
> > -
> > -       parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
> > +       parse_pathspec(&pathspec, 0,
> > +                      PATHSPEC_PREFER_CWD |
> > +                      PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> 
> I notice that _CHEAP implementation and the removed code are not
> exactly the same. But I think they have the same purpose so it's
> probably ok even there are some subtle behavioral changes.

Providing that there's only one trailing slash, the user-visible effect
should be the same since the only case affected by that is submodules.
In fact _CHEAP does better in the case where the submodule does not
exist in the working tree.

> You may want to improve _CHEAP to remove consecutive trailing slashes
> (i.e. foo//// -> foo) too. And maybe is is_dir_sep() instead of
> explicit == '/' comparison in there.

Sounds good, I'll try to look at that tonight.

> > +                      prefix, argv);
> >         refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
> >
> >         seen = xcalloc(pathspec.nr, 1);
