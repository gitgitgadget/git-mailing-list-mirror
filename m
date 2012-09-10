From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Mon, 10 Sep 2012 12:09:29 +0100
Message-ID: <20120910110928.GA12974@atlantic.linksys.moosehall>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org>
 <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 13:09:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB1sD-0005wJ-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 13:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222Ab2IJLJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 07:09:36 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:35808 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233Ab2IJLJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 07:09:32 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 7FA292E39E;
	Mon, 10 Sep 2012 12:09:30 +0100 (BST)
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205117>

On Tue, Sep 04, 2012 at 08:06:12PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -273,7 +273,7 @@ static int add_files(struct dir_struct *dir, int flags)
> >                 fprintf(stderr, _(ignore_error));
> >                 for (i = 0; i < dir->ignored_nr; i++)
> >                         fprintf(stderr, "%s\n", dir->ignored[i]->name);
> > -               fprintf(stderr, _("Use -f if you really want to add them.\n"));
> > +               fprintf(stderr, _("Use -f if you really want to add them, or git check-ignore to see\nwhy they're ignored.\n"));
> >                 die(_("no files added"));
> >         }
> 
> String too long (> 80 chars).

You mean the line of code is too long, or the argument to _(), or
both?  I didn't like this either, but I saw that builtin/checkout.c
already did something similar twice, and I wasn't sure how else to do
it.  Suggestions gratefully received.

> > +static const char * const check_ignore_usage[] = {
> > +"git check-ignore pathname...",
> > +"git check-ignore --stdin [-z] < <list-of-paths>",
> > +NULL
> > +};
> > +
> > +static const struct option check_ignore_options[] = {
> > +       OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
> > +       OPT_BOOLEAN('z', NULL, &null_term_line,
> > +               "input paths are terminated by a null character"),
> > +       OPT_END()
> > +};
> 
> You may want to mark help strings ("read file names from stdin" and
> "input paths... null character") and check_ignore_usage[] for
> translation. Just wrap those strings with N_() and you'll be fine. For
> similar changes, check out nd/i18n-parseopt-help on branch 'pu'.

Thanks, I'll do that.

[snipped discussion of "include" / "exclude" which already continued elsewhere]

> > +static void check_ignore(const char *prefix, const char **pathspec)
> > +{
> > +       struct dir_struct dir;
> > +       const char *path;
> > +       char *seen = NULL;
> > +
> > +       /* read_cache() is only necessary so we can watch out for submodules. */
> > +       if (read_cache() < 0)
> > +               die(_("index file corrupt"));
> > +
> > +       memset(&dir, 0, sizeof(dir));
> > +       dir.flags |= DIR_COLLECT_IGNORED;
> > +       setup_standard_excludes(&dir);
> 
> You should support ignore rules from files and command line arguments
> too, like ls-files. For quick testing.

You mean --exclude, --exclude-from, and --exclude-per-directory?
Sure, although I have limited time right now, so maybe these could be
added in a later iteration?

> > +static NORETURN void error_with_usage(const char *msg)
> > +{
> > +       error("%s", msg);
> > +       usage_with_options(check_ignore_usage, check_ignore_options);
> > +}
> 
> Interesting. We have usage_msg_opt() in parse-options.c, but it's more
> verbose. Perhaps this function should be moved to parse-options.c
> because it may be useful to other commands as well?

I'll look into it.
