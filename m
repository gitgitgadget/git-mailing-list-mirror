From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC/PATCH] gc: do not explode objects which will be immediately
 pruned
Date: Tue, 10 Apr 2012 16:24:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1204101623010.16314@xanadu.home>
References: <20120407103008.GA11242@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 22:24:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHhc0-0005Ga-Io
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 22:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab2DJUYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 16:24:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42551 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab2DJUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 16:24:18 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M2A009LJ60HRAB0@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Apr 2012 16:24:18 -0400 (EDT)
In-reply-to: <20120407103008.GA11242@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195126>

On Sat, 7 Apr 2012, Jeff King wrote:

> When we pack everything into one big pack with "git repack
> -Ad", any unreferenced objects in to-be-deleted packs are
> exploded into loose objects, with the intent that they will
> be examined and possibly cleaned up by the next run of "git
> prune".
> 
> Since the exploded objects will receive the mtime of the
> pack from which they come, if the source pack is old, those
> loose objects will end up pruned immediately. In that case,
> it is much more efficient to skip the exploding step
> entirely for these objects.
> 
> This patch teaches pack-objects to receive the expiration
> information and avoid writing these objects out. It also
> teaches "git gc" to pass the value of gc.pruneexpire to
> repack (which in turn learns to pass it along to
> pack-objects) so that this optimization happens
> automatically during "git gc" and "git gc --auto".
> 
> Signed-off-by: Jeff King <peff@peff.net>

Looks fine to me.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  builtin/gc.c                         |   23 +++++++++++++++--------
>  builtin/pack-objects.c               |   25 +++++++++++++++++++++++--
>  git-repack.sh                        |   10 +++++++++-
>  t/t7701-repack-unpack-unreachable.sh |   14 ++++++++++++++
>  4 files changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 271376d..1bc2fe3 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -144,6 +144,19 @@ static int too_many_packs(void)
>  	return gc_auto_pack_limit <= cnt;
>  }
>  
> +static void add_repack_all_option(void)
> +{
> +	if (prune_expire && !strcmp(prune_expire, "now"))
> +		append_option(argv_repack, "-a", MAX_ADD);
> +	else {
> +		append_option(argv_repack, "-A", MAX_ADD);
> +		if (prune_expire) {
> +			append_option(argv_repack, "--unpack-unreachable", MAX_ADD);
> +			append_option(argv_repack, prune_expire, MAX_ADD);
> +		}
> +	}
> +}
> +
>  static int need_to_gc(void)
>  {
>  	/*
> @@ -160,10 +173,7 @@ static int need_to_gc(void)
>  	 * there is no need.
>  	 */
>  	if (too_many_packs())
> -		append_option(argv_repack,
> -			      prune_expire && !strcmp(prune_expire, "now") ?
> -			      "-a" : "-A",
> -			      MAX_ADD);
> +		add_repack_all_option();
>  	else if (!too_many_loose_objects())
>  		return 0;
>  
> @@ -227,10 +237,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  					"run \"git gc\" manually. See "
>  					"\"git help gc\" for more information.\n"));
>  	} else
> -		append_option(argv_repack,
> -			      prune_expire && !strcmp(prune_expire, "now")
> -			      ? "-a" : "-A",
> -			      MAX_ADD);
> +		add_repack_all_option();
>  
>  	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
>  		return error(FAILED_RUN, argv_pack_refs[0]);
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 7b07c09..1861093 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -63,6 +63,7 @@ static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
>  static int non_empty;
>  static int reuse_delta = 1, reuse_object = 1;
>  static int keep_unreachable, unpack_unreachable, include_tag;
> +static unsigned long unpack_unreachable_expiration;
>  static int local;
>  static int incremental;
>  static int ignore_packed_keep;
> @@ -2249,6 +2250,10 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
>  		if (!p->pack_local || p->pack_keep)
>  			continue;
>  
> +		if (unpack_unreachable_expiration &&
> +		    p->mtime < unpack_unreachable_expiration)
> +			continue;
> +
>  		if (open_pack_index(p))
>  			die("cannot open pack index");
>  
> @@ -2315,6 +2320,21 @@ static int option_parse_index_version(const struct option *opt,
>  	return 0;
>  }
>  
> +static int option_parse_unpack_unreachable(const struct option *opt,
> +					   const char *arg, int unset)
> +{
> +	if (unset) {
> +		unpack_unreachable = 0;
> +		unpack_unreachable_expiration = 0;
> +	}
> +	else {
> +		unpack_unreachable = 1;
> +		if (arg)
> +			unpack_unreachable_expiration = approxidate(arg);
> +	}
> +	return 0;
> +}
> +
>  static int option_parse_ulong(const struct option *opt,
>  			      const char *arg, int unset)
>  {
> @@ -2392,8 +2412,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			 "include tag objects that refer to objects to be packed"),
>  		OPT_BOOL(0, "keep-unreachable", &keep_unreachable,
>  			 "keep unreachable objects"),
> -		OPT_BOOL(0, "unpack-unreachable", &unpack_unreachable,
> -			 "unpack unreachable objects"),
> +		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, "time",
> +		  "unpack unreachable objects newer than <time>",
> +		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
>  		OPT_BOOL(0, "thin", &thin,
>  			 "create thin packs"),
>  		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
> diff --git a/git-repack.sh b/git-repack.sh
> index 624feec..7579331 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -15,6 +15,7 @@ F               pass --no-reuse-object to git-pack-objects
>  n               do not run git-update-server-info
>  q,quiet         be quiet
>  l               pass --local to git-pack-objects
> +unpack-unreachable=  with -A, do not loosen objects older than this
>   Packing constraints
>  window=         size of the window used for delta compression
>  window-memory=  same as the above, but limit memory size instead of entries count
> @@ -33,6 +34,8 @@ do
>  	-a)	all_into_one=t ;;
>  	-A)	all_into_one=t
>  		unpack_unreachable=--unpack-unreachable ;;
> +	--unpack-unreachable)
> +		unpack_unreachable="--unpack-unreachable=$2"; shift ;;
>  	-d)	remove_redundant=t ;;
>  	-q)	GIT_QUIET=t ;;
>  	-f)	no_reuse=--no-reuse-delta ;;
> @@ -76,7 +79,12 @@ case ",$all_into_one," in
>  		if test -n "$existing" -a -n "$unpack_unreachable" -a \
>  			-n "$remove_redundant"
>  		then
> -			args="$args $unpack_unreachable"
> +			# This may have arbitrary user arguments, so we
> +			# have to protect it against whitespace splitting
> +			# when it gets run as "pack-objects $args" later.
> +			# Fortunately, we know it's an approxidate, so we
> +			# can just use dots instead.
> +			args="$args $(echo "$unpack_unreachable" | tr ' ' .)"
>  		fi
>  	fi
>  	;;
> diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
> index 200ab61..b8d4cde 100755
> --- a/t/t7701-repack-unpack-unreachable.sh
> +++ b/t/t7701-repack-unpack-unreachable.sh
> @@ -95,4 +95,18 @@ test_expect_success 'unpacked objects receive timestamp of pack file' '
>  	compare_mtimes < mtimes
>  '
>  
> +test_expect_success 'do not bother loosening old objects' '
> +	obj1=$(echo one | git hash-object -w --stdin) &&
> +	obj2=$(echo two | git hash-object -w --stdin) &&
> +	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
> +	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
> +	git prune-packed &&
> +	git cat-file -p $obj1 &&
> +	git cat-file -p $obj2 &&
> +	test-chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
> +	git repack -A -d --unpack-unreachable=1.hour.ago &&
> +	git cat-file -p $obj1 &&
> +	test_must_fail git cat-file -p $obj2
> +'
> +
>  test_done
> -- 
> 1.7.10.11.g901cee
> 
