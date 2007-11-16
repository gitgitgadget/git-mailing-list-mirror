From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-commit: fix "git add x y && git commit y"
 committing x, too
Date: Fri, 16 Nov 2007 00:43:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711160036450.30886@racer.site>
References: <Pine.LNX.4.64.0711150038020.4362@racer.site> 
 <1195138198-24511-1-git-send-email-krh@redhat.com> 
 <Pine.LNX.4.64.0711151611090.30886@racer.site> <1195146094.21076.6.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 01:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IspJj-0002Yc-91
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 01:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765669AbXKPAnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765674AbXKPAnt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 19:43:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:60653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765441AbXKPAnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 19:43:47 -0500
Received: (qmail invoked by alias); 16 Nov 2007 00:43:44 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp001) with SMTP; 16 Nov 2007 01:43:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FALsgnwIF6KbhhmT4pzkN9KgY9fCBiXZIhZmPZn
	UARuoVLKoyH4fL
X-X-Sender: gene099@racer.site
In-Reply-To: <1195146094.21076.6.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65182>

Hi,

On Thu, 15 Nov 2007, Kristian H?gsberg wrote:

> On Thu, 2007-11-15 at 16:11 +0000, Johannes Schindelin wrote:
> > Earlier, builtin commit would implicitly commit also the staged
> > changes.
> > 
> > This patch fixes that.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 
> > 	The function reset_index_to_head() could be moved to somewhere
> > 	more central and be reused in builtin-reset.c instead of
> > 	reset_index_file() later...
> > 
> >  builtin-add.c     |    1 +
> >  builtin-commit.c  |   30 +++++++++++++++++++++++++++++-
> >  t/t7500-commit.sh |   10 ++++++++++
> >  3 files changed, 40 insertions(+), 1 deletions(-)
> > 
> > diff --git a/builtin-add.c b/builtin-add.c
> > index 77dcde6..017c8f2 100644
> > --- a/builtin-add.c
> > +++ b/builtin-add.c
> > @@ -100,6 +100,7 @@ static void update_callback(struct diff_queue_struct *q,
> >  		case DIFF_STATUS_UNMERGED:
> >  		case DIFF_STATUS_MODIFIED:
> >  		case DIFF_STATUS_TYPE_CHANGED:
> > +		case DIFF_STATUS_ADDED:
> >  			add_file_to_cache(path, verbose);
> >  			break;
> >  		case DIFF_STATUS_DELETED:
> > diff --git a/builtin-commit.c b/builtin-commit.c
> > index 535039c..0dc6e1c 100644
> > --- a/builtin-commit.c
> > +++ b/builtin-commit.c
> > @@ -19,6 +19,7 @@
> >  #include "strbuf.h"
> >  #include "utf8.h"
> >  #include "parse-options.h"
> > +#include "unpack-trees.h"
> >  
> >  static const char * const builtin_commit_usage[] = {
> >  	"git-commit [options] [--] <filepattern>...",
> > @@ -77,6 +78,31 @@ static struct option builtin_commit_options[] = {
> >  	OPT_END()
> >  };
> >  
> > +static int reset_index_to_head(void)
> > +{
> > +	struct unpack_trees_options opts;
> > +	struct tree_desc tree_desc;
> > +	struct tree *tree;
> > +	unsigned char sha1[20];
> > +
> > +	/* ignore if it is an initial commit */
> > +	if (get_sha1("HEAD", sha1))
> > +		return 0;
> > +	tree = parse_tree_indirect(sha1);
> > +	if (!tree || parse_tree(tree))
> > +		return error("Could not get HEAD's tree");
> > +	init_tree_desc(&tree_desc, tree->buffer, tree->size);
> > +
> > +	memset(&opts, 0, sizeof(opts));
> > +	opts.index_only = 1;
> > +	opts.merge = 1;
> > +	opts.head_idx = 1;
> > +	opts.fn = oneway_merge;
> > +	if (unpack_trees(1, &tree_desc, &opts))
> > +		return error("Could not reset temporary index to HEAD");
> > +	return 0;
> > +}
> > +
> >  static char *prepare_index(const char **files, const char *prefix)
> >  {
> >  	int fd;
> > @@ -120,12 +146,14 @@ static char *prepare_index(const char **files, const char *prefix)
> >  			die("failed to read HEAD tree object");
> >  	}
> >  
> > +	if (reset_index_to_head())
> > +		die ("failed to reset temporary index to HEAD");
> > +
> 
> If you look just above where you added these lines, there is code to
> deal with this case, except it doesn't work.  I was trying to fix this
> too by adding a discard_cache() call before building the temp index, but
> then I couldn't add the files in question because the index was now
> newer than those files.  Anyway, I don't know if your code is better
> that just doing read_tree(), but we should only have one or the other in
> there.

It's not only about discarding the cache.  It's also about avoiding do 
regenerate the index completely; this would waste time, especially for big 
trees.

But the code you are referencing is only updating the index.  The code I 
added is to build the temporary index in a correct manner.

Unfortunately, I guess that the index as calculated by the code you are 
referencing would be needed to show the correct status.

Therefore I propose to use a different struct index_state, copied from the 
current one, for reset_index_to_head(), add_files_to_index() and 
write_index() instead of working on the_index.

But that has to be done by somebody else than me, or wait for Tuesday, as 
I will be travelling.

Ciao,
Dscho
