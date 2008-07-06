From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] Build in merge
Date: Sun, 06 Jul 2008 01:50:05 -0700
Message-ID: <7vej67jt1e.fsf@gitster.siamese.dyndns.org>
References: <0cde1e7c930589364318b2d0344b345453e23586.1214918017.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 10:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFPxn-0006ra-3C
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 10:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbYGFIuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 04:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYGFIuT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 04:50:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYGFIuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 04:50:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6264D1D54C;
	Sun,  6 Jul 2008 04:50:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 292781D54B; Sun,  6 Jul 2008 04:50:11 -0400 (EDT)
In-Reply-To: <0cde1e7c930589364318b2d0344b345453e23586.1214918017.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Tue, 1 Jul 2008 15:18:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E04A13C-4B38-11DD-8E96-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87507>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/builtin-merge.c b/builtin-merge.c
> new file mode 100644
> index 0000000..b261993
> --- /dev/null
> +++ b/builtin-merge.c
> @@ -0,0 +1,1158 @@
> +/*
> + * Builtin "git merge"
> + *
> + * Copyright (c) 2008 Miklos Vajna <vmiklos@frugalware.org>
> + *
> + * Based on git-merge.sh by Junio C Hamano.
> + */
> +
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "builtin.h"
> +#include "run-command.h"
> +#include "path-list.h"
> +#include "diff.h"
> +#include "refs.h"
> +#include "commit.h"
> +#include "diffcore.h"
> +#include "revision.h"
> +#include "unpack-trees.h"
> +#include "cache-tree.h"
> +#include "dir.h"
> +#include "utf8.h"
> +#include "log-tree.h"
> +#include "color.h"
> +
> +enum strategy {
> +	DEFAULT_TWOHEAD = 1,
> +	DEFAULT_OCTOPUS = 2,
> +	NO_FAST_FORWARD = 4,
> +	NO_TRIVIAL = 8
> +};

Usually "enum foo" consists of possible values of "foo".  But this is
not a list of strategies.  These are possible attributes to strategies.

> +static const char * const builtin_merge_usage[] = {
> +	"git-merge [options] <remote>...",
> +	"git-merge [options] <msg> HEAD <remote>",
> +	NULL
> +};
> +
> +static int show_diffstat = 1, option_log, squash;
> +static int option_commit = 1, allow_fast_forward = 1;
> +static int allow_trivial = 1, have_message;
> +static struct strbuf merge_msg;
> +static struct commit_list *remoteheads;
> +static unsigned char head[20], stash[20];
> +static struct path_list use_strategies;
> +static const char *branch;
> +
> +static struct path_list_item strategy_items[] = {
> +	{ "recur",      (void *)NO_TRIVIAL },
> +	{ "recursive",  (void *)(DEFAULT_TWOHEAD | NO_TRIVIAL) },
> +	{ "octopus",    (void *)DEFAULT_OCTOPUS },
> +	{ "resolve",    (void *)0 },
> +	{ "stupid",     (void *)0 },
> +	{ "ours",       (void *)(NO_FAST_FORWARD | NO_TRIVIAL) },
> +	{ "subtree",    (void *)(NO_FAST_FORWARD | NO_TRIVIAL) },
> +};
> +static struct path_list strategies = { strategy_items,
> +	ARRAY_SIZE(strategy_items), 0, 0 };

This declaration is funnily line-wrapped.

        static struct path_list strategies = {
                strategy_items, ARRAY_SIZE(strategy_items), 0, 0,
        };

But more problematic is that a path_list is inherently a dynamic data
structure (you can add and it reallocs), and this use of relying on the
knowledge that you happen to never add anything (nor subtract anything)
from the list is a mere hack.  If on the other hand you (and more
importantly other people who touch this implementation later) will never
add or remove items from this "strategies" array, you should make sure at
the interface level that nobody can -- one way to do so is not to abuse
path_list for something like this.

Come to think of it, wasn't the reason why the earlier "Why do you need
such distracting casts all over the place?" issue came up in another patch
because of this kind of (ab)use of path_list, which is an inappropriate
data structure for the job?

You would perhaps define:

	#define DEFAULT_TWOHEAD (1<<0)
	#define DEFAULT_OCTOPUS (1<<1)
	#define NO_FAST_FORWARD (1<<2)
	#define NO_TRIVIAL	(1<<3)

	static struct strategy {
        	char *name;
                unsigned attr;
	} all_strategy[] = {
                { "octopus",    DEFAULT_OCTOPUS },
                { "ours",       (NO_FAST_FORWARD | NO_TRIVIAL) },
                { "recur",      NO_TRIVIAL },
                { "recursive",  (DEFAULT_TWOHEAD | NO_TRIVIAL) },
                { "resolve",    0 },
                { "stupid",     0 },
                { "subtree",    (NO_FAST_FORWARD | NO_TRIVIAL) },
        };

And "unsorted_path_list_lookup()" can now become much more natural,
perhaps:

	static struct strategy *get_strategy(const char *name);

which has a more natural function signature and much better name.

Then, you would keep an array of pointers into all_strategy[] array to
represent the list of "-s strategy" given by the user:

	static struct strategy *use_strategy;
	static int use_strategy_alloc, use_strategy_nr;

and have a function that use s the standard ALLOC_GROW() and friends to
grow this.  The function will be named and written more naturally
(i.e. path_list_append_strategy() can go) --- this does not have anything
to do with path_list, but it is about "merge strategy".

But 99.9% of the time you would not have more than one elements ;-).
