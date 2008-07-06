From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/14] Build in merge
Date: Sun, 6 Jul 2008 14:38:23 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807061433480.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <0cde1e7c930589364318b2d0344b345453e23586.1214918017.git.vmiklos@frugalware.org> <7vej67jt1e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 14:39:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFTWX-000195-5n
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 14:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbYGFMi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 08:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbYGFMi1
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 08:38:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:50786 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753569AbYGFMi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 08:38:26 -0400
Received: (qmail invoked by alias); 06 Jul 2008 12:38:24 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp006) with SMTP; 06 Jul 2008 14:38:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WlzRgn5sW0yyXwulDyPSzmKDxh5fBwQWcQ1lCtt
	T7rUcBFvNlfwwA
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vej67jt1e.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87522>

Hi,

On Sun, 6 Jul 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > diff --git a/builtin-merge.c b/builtin-merge.c
> > new file mode 100644
> > index 0000000..b261993
> > --- /dev/null
> > +++ b/builtin-merge.c
> > @@ -0,0 +1,1158 @@
> > +/*
> > + * Builtin "git merge"
> > + *
> > + * Copyright (c) 2008 Miklos Vajna <vmiklos@frugalware.org>
> > + *
> > + * Based on git-merge.sh by Junio C Hamano.
> > + */
> > +
> > +#include "cache.h"
> > +#include "parse-options.h"
> > +#include "builtin.h"
> > +#include "run-command.h"
> > +#include "path-list.h"
> > +#include "diff.h"
> > +#include "refs.h"
> > +#include "commit.h"
> > +#include "diffcore.h"
> > +#include "revision.h"
> > +#include "unpack-trees.h"
> > +#include "cache-tree.h"
> > +#include "dir.h"
> > +#include "utf8.h"
> > +#include "log-tree.h"
> > +#include "color.h"
> > +
> > +enum strategy {
> > +	DEFAULT_TWOHEAD = 1,
> > +	DEFAULT_OCTOPUS = 2,
> > +	NO_FAST_FORWARD = 4,
> > +	NO_TRIVIAL = 8
> > +};
> 
> Usually "enum foo" consists of possible values of "foo".  But this is
> not a list of strategies.  These are possible attributes to strategies.

My fault.  I avoid ugly #defines, so I suggested using an enum.

> > +static const char * const builtin_merge_usage[] = {
> > +	"git-merge [options] <remote>...",
> > +	"git-merge [options] <msg> HEAD <remote>",
> > +	NULL
> > +};
> > +
> > +static int show_diffstat = 1, option_log, squash;
> > +static int option_commit = 1, allow_fast_forward = 1;
> > +static int allow_trivial = 1, have_message;
> > +static struct strbuf merge_msg;
> > +static struct commit_list *remoteheads;
> > +static unsigned char head[20], stash[20];
> > +static struct path_list use_strategies;
> > +static const char *branch;
> > +
> > +static struct path_list_item strategy_items[] = {
> > +	{ "recur",      (void *)NO_TRIVIAL },
> > +	{ "recursive",  (void *)(DEFAULT_TWOHEAD | NO_TRIVIAL) },
> > +	{ "octopus",    (void *)DEFAULT_OCTOPUS },
> > +	{ "resolve",    (void *)0 },
> > +	{ "stupid",     (void *)0 },
> > +	{ "ours",       (void *)(NO_FAST_FORWARD | NO_TRIVIAL) },
> > +	{ "subtree",    (void *)(NO_FAST_FORWARD | NO_TRIVIAL) },
> > +};
> > +static struct path_list strategies = { strategy_items,
> > +	ARRAY_SIZE(strategy_items), 0, 0 };
> 
> This declaration is funnily line-wrapped.
> 
>         static struct path_list strategies = {
>                 strategy_items, ARRAY_SIZE(strategy_items), 0, 0,
>         };
> 
> But more problematic is that a path_list is inherently a dynamic data 
> structure (you can add and it reallocs), and this use of relying on the 
> knowledge that you happen to never add anything (nor subtract anything) 
> from the list is a mere hack.  If on the other hand you (and more 
> importantly other people who touch this implementation later) will never 
> add or remove items from this "strategies" array, you should make sure 
> at the interface level that nobody can -- one way to do so is not to 
> abuse path_list for something like this.
> 
> Come to think of it, wasn't the reason why the earlier "Why do you need 
> such distracting casts all over the place?" issue came up in another 
> patch because of this kind of (ab)use of path_list, which is an 
> inappropriate data structure for the job?

Well, it is not really an abuse if you think of path_list as a 
string_list, which it really is, and which should have happened a long 
time ago, but I gave up.

Anyway, the use of string_list here was originally to make lookup slightly 
more convenient, using an API, instead of reinventing the wheel over and 
over and over again, as can be seen nicely in some parts of Git's source 
code.

Given that we want to be able to add other strategies, I would have rather 
suggested fixing string_list to heed "alloc == 0" and _not_ realloc() in 
that case.

But given that you seem so sick and tired of string_list, and rather have 
a code duplication, I will not argue to that end anymore.

Tired,
Dscho
