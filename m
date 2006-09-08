From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] git-commit.sh: convert run_status to a C builtin
Date: Thu, 07 Sep 2006 17:20:20 -0700
Message-ID: <7vzmdbqke3.fsf@assigned-by-dhcp.cox.net>
References: <64c62cc942e872b29d7225999e74a07be586674a.1157610743.git.peff@peff.net>
	<20060907063621.GC17083@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 02:20:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLU6M-0007Nc-T8
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 02:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWIHAUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 20:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWIHAUG
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 20:20:06 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:32646 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751937AbWIHAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 20:20:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908002003.IIPL18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 20:20:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KcKu1V00f1kojtg0000000
	Thu, 07 Sep 2006 20:19:55 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060907063621.GC17083@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 7 Sep 2006 02:36:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26667>

Jeff King <peff@peff.net> writes:

> diff --git a/Makefile b/Makefile
> index 78748cb..d0ba3b5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -252,7 +252,7 @@ LIB_OBJS = \
>  	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
>  	write_or_die.o trace.o \
>  	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
> -	color.o
> +	color.o status.o
>  
>  BUILTIN_OBJS = \
>  	builtin-add.o \

At some point (this does not have to be part of this series), we
should demote DIFF_OBJS to just ordinary LIB_OBJS.  They used to
be special in that they are used only by handful special
commands, but these days more and more things are integrated and
it outlived its usefulness.

> +static const char runstatus_usage[] =
> +"git-runstatus [--color|--nocolor] [--amend] [--verbose]";
> +
> +int cmd_runstatus(int argc, const char **argv, const char *prefix)
> +{
> +	struct status s;
> +	int i;
> +
> +	git_config(git_status_config);
> +	status_prepare(&s);
> +
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], "--color"))
> +			status_use_color = 1;
> +		else if (!strcmp(argv[i], "--nocolor"))
> +			status_use_color = 0;
> +    else if (!strcmp(argv[i], "--amend")) {
> +      s.amend = 1;
> +      s.reference = "HEAD^1";
> +    }
> +    else if (!strcmp(argv[i], "--verbose"))
> +      s.verbose = 1;
> +		else
> +			usage(runstatus_usage);
> +	}
> +
> +	status_print(&s);
> +  return s.commitable ? 0 : 1;
> +}

Quite funny indentation style your MUA likes ;-).

> diff --git a/status.c b/status.c
> new file mode 100644
> index 0000000..82aa881
> --- /dev/null
> +++ b/status.c
> @@ -0,0 +1,283 @@
> +#include "status.h"

"status.h" and "struct status" somehow sounds too broad.
Granted, "object.h" is also broad, but in git context "object"
has a specific meaning.

Having said that I cannot come up with a good alternative name.
It is not "project status" nor "repository status".  It is
"working tree status", but that sounds very loooooooooooooooong.

> +	color_printf(color(STATUS_HEADER), "#\t");
> +	switch (p->status) {
> +	case DIFF_STATUS_ADDED:
> +		color_printf(c, "new file: %s\n", p->one->path); break;

Very nicely done.  Especially I liked that you are careful not
to paint leading '#\t' (which is noticeable when you use reverse
as an attribute).

> +static void
> +status_print_untracked(const struct status *s)
> +{
> +	struct dir_struct dir;
> +	const char *x;
> +	int i;
> +	int shown_header = 0;
> +
> +	memset(&dir, 0, sizeof(dir));
> +
> +	dir.exclude_per_dir = ".gitignore";
> +	x = git_path("info/exclude");
> +	if (file_exists(x))
> +		add_excludes_from_file(&dir, x);
> +
> +	read_directory(&dir, ".", "", 0);
> +	for(i = 0; i < dir.nr; i++) {
> +		/* check for matching entry, which is unmerged; lifted from
> +		 * builtin-ls-files:show_other_files */
> +		struct dir_entry *ent = dir.entries[i];
> +		int pos = cache_name_pos(ent->name, ent->len);
> +		struct cache_entry *ce;
> +		if (0 <= pos)
> +			die("bug in status_print_untracked");
> +		pos = -pos - 1;
> +		if (pos < active_nr) {
> +			ce = active_cache[pos];
> +			if (ce_namelen(ce) == ent->len &&
> +			    !memcmp(ce->name, ent->name, ent->len))
> +				continue;
> +		}
> +		if (!shown_header) {
> +			status_print_header("Untracked files",
> +				"use \"git add\" to add to commit");
> +			shown_header = 1;
> +		}
> +		color_printf(color(STATUS_HEADER), "#\t");
> +		color_printf(color(STATUS_UNTRACKED), "%.*s\n",
> +				ent->len, ent->name);
> +	}
> +}

Very nice code reuse.  I do not mean sarcasm -- the part copied
and pasted from ls-files is almost trivial to bother factoring
out.  What's nice is read_directory() does all what is needed to
deal with .gitignore files, which I forgot almost all about.

> +int status_foreach_cached(status_cb cb);
> +int status_foreach_updated(status_cb cb);
> +int status_foreach_changed(status_cb cb);
> +int status_foreach_untracked(status_cb cb);

I do not see them defined nor used...

I'll take only [1/3] for now but I am interested in 2 and 3.
