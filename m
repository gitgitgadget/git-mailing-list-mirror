From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2.5] Make git prune remove temporary packs that look like
 write failures
Date: Mon, 11 Feb 2008 11:10:36 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802111109500.2732@xanadu.home>
References: <Pine.GSO.4.63.0802070248190.15699@suma3>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	casey@nrlssc.navy.mil
To: David Steven Tweed <d.s.tweed@reading.ac.uk>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JObFg-0006wa-GA
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756738AbYBKQKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 11:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756654AbYBKQKj
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:10:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32577 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549AbYBKQKh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 11:10:37 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW3003WN0XO3FC0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Feb 2008 11:10:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.GSO.4.63.0802070248190.15699@suma3>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73549>

On Thu, 7 Feb 2008, David Steven Tweed wrote:

> Write errors when repacking (eg, due to out-of-space conditions)
> can leave temporary packs (and possibly other files beginning
> with "tmp_") lying around which no existing
> codepath removes and which aren't obvious to the casual user.
> These can also be multi-megabyte files wasting noticeable space.
> Unfortunately there's no way to definitely tell in builtin-prune
> that a tmp_ file is not being used by a concurrent process,
> such as a fetch. However, it is documented that pruning should
> only be done on a quiet repository and --expire is honoured
> (using code from Johannes Schindelin, along with a test case
> he wrote) so that its safety is the same as that of loose
> object pruning.
> 
> Since they might be signs of a problem (unlike orphaned loose
> objects) the names of any removed files are printed.
> 
> Signed-off-by: David Tweed (david.tweed@gmail.com)

Acked-by: Nicolas Pitre <nico@cam.org>

> ---
> 
> This version incorporates all the agreed with changes from the
> previous version, and includes Johannes Schindelin's
> modifications and also his test. If you want to change the attribution
> lines to be him that's fine.
> 
> (BTW, I won't be reading mail until after the weekend now.)
> 
>  builtin-prune.c  |   39 +++++++++++++++++++++++++++++++++++++++
>  t/t5304-prune.sh |   32 ++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 0 deletions(-)
>  create mode 100644 t/t5304-prune.sh
> 
> diff --git a/builtin-prune.c b/builtin-prune.c
> index b5e7684..f25ddb6 100644
> --- a/builtin-prune.c
> +++ b/builtin-prune.c
> @@ -83,6 +83,44 @@ static void prune_object_dir(const char *path)
>  	}
>  }
> 
> +/*
> + * Write errors (particularly out of space) can result in
> + * failed temporary packs (and more rarely indexes and other
> + * files begining with "tmp_") accumulating in the
> + * object directory.
> + */
> +static void remove_temporary_files(void)
> +{
> +	DIR *dir;
> +	struct dirent *de;
> +	char* dirname=get_object_directory();
> +
> +	dir = opendir(dirname);
> +	if (!dir) {
> +		fprintf(stderr, "Unable to open object directory %s\n",
> +			dirname);
> +		return;
> +	}
> +	while ((de = readdir(dir)) != NULL) {
> +		if (!prefixcmp(de->d_name, "tmp_")) {
> +			char name[PATH_MAX];
> +			int c = snprintf(name, PATH_MAX, "%s/%s",
> +					 dirname, de->d_name);
> +			if (c < 0 || c >= PATH_MAX)
> +				continue;
> +			if (expire) {
> +				struct stat st;
> +				if (stat(name, &st) != 0 || st.st_mtime >= expire)
> +					continue;
> +			}
> +			printf("Removing stale temporary file %s\n", name);
> +			if (!show_only)
> +				unlink(name);
> +		}
> +	}
> +	closedir(dir);
> +}
> +
>  int cmd_prune(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> @@ -115,5 +153,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
> 
>  	sync();
>  	prune_packed_objects(show_only);
> +	remove_temporary_files();
>  	return 0;
>  }
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> new file mode 100644
> index 0000000..6560af7
> --- /dev/null
> +++ b/t/t5304-prune.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Johannes E. Schindelin
> +#
> +
> +test_description='prune'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +
> +	: > file &&
> +	git add file &&
> +	test_tick &&
> +	git commit -m initial &&
> +	git gc
> +
> +'
> +
> +test_expect_success 'prune stale packs' '
> +
> +	orig_pack=$(echo .git/objects/pack/*.pack) &&
> +	: > .git/objects/tmp_1.pack &&
> +	: > .git/objects/tmp_2.pack &&
> +	test-chmtime -86501 .git/objects/tmp_1.pack &&
> +	git prune --expire 1.day &&
> +	test -f $orig_pack &&
> +	test -f .git/objects/tmp_2.pack &&
> +	! test -f .git/objects/tmp_1.pack
> +
> +'
> +
> +test_done
> 


Nicolas
