From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 20:16:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081905580.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZf4-0005Tf-0l
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935086AbYBHUQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933349AbYBHUP7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:15:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:46667 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935743AbYBHUP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:15:56 -0500
Received: (qmail invoked by alias); 08 Feb 2008 20:15:53 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp028) with SMTP; 08 Feb 2008 21:15:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+w+lw1bHGwvhjFNR72SPFZ82vPV1jkJflIb5QCir
	QwFndaF+lcw8mb
X-X-Sender: gene099@racer.site
In-Reply-To: <200802081828.43849.kendy@suse.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73132>

Hi,

2nd part of my review:

On Fri, 8 Feb 2008, Jan Holesovsky wrote:

> +static void read_from_stdin(int *num, char ***records)
> +{
> +	char buffer[4096];
> +	size_t records_num, leftover;
> +	ssize_t ret;
> +
> +	*num = 0;
> +	leftover = 0;
> +
> +	records_num = 4096;
> +	(*records) = xmalloc(records_num * sizeof(char *));
> +
> +	do {
> +		char *p, *last;
> +
> +		ret = xread(0 /*stdin*/, buffer + leftover,
> +				sizeof(buffer) - leftover);
> +		if (ret < 0)
> +			die("read error on input: %s", strerror(errno));
> +
> +		last = buffer;
> +		for (p = buffer; p < buffer + leftover + ret; p++)
> +			if ((!*p || *p == '\n') && (p != last)) {
> +				if (*num >= records_num) {
> +					records_num *= 2;
> +					(*records) = xrealloc(*records,
> +							      records_num * sizeof(char*));
> +				}
> +
> +				if (p - last > 0) {
> +					(*records)[*num] =
> +						strndup(last, p - last);
> +					(*num)++;
> +				}
> +				last = p + 1;
> +			}
> +		memmove(buffer, last, leftover);
> +	} while (ret > 0);
> +
> +	if (leftover) {
> +		if (*num >= records_num) {
> +			records_num *= 2;
> +			(*records) = xrealloc(*records,
> +					      records_num * sizeof(char*));
> +		}
> +
> +		(*records)[*num] = strndup(buffer, leftover);
> +		(*num)++;
> +	}
> +}

I thought about this function again.  It seems we have something similar 
in builtin-pack-objects.c, which is easier to read.  The equivalent would 
be:

static void read_from_stdin(int *num, char ***records)
{
	char line[4096];
	int alloc = 0;

	*num = 0;
	*records = NULL;
	for (;;) {
		if (!fgets(line, sizeof(line), stdin)) {
			if (feof(stdin))
				break;
			if (!ferror(stdin))
				die("fgets returned NULL, not EOF, nor error!");
			if (errno != EINTR)
				die("fgets: %s", strerror(errno));
			clearerr(stdin);
			continue;
		}
		if (!line[0])
			continue;
		ALLOC_GROW(*records, *num + 1, alloc);
		(*records)[(*num)++] = xstrdup(line);
	}
}		

> diff --git a/git-clone.sh b/git-clone.sh
> index b4e858c..208e9fc 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -115,7 +115,7 @@ Perhaps git-update-server-info needs to be run there?"
>  quiet=
>  local=no
>  use_local_hardlink=yes
> -local_shared=no
> +shared=no
>  unset template
>  no_checkout=
>  upload_pack=
> @@ -143,7 +143,7 @@ do
>  	--no-hardlinks)
>  		use_local_hardlink=no ;;
>  	-s|--shared)
> -		local_shared=yes ;;
> +		shared=yes ;;
>  	--template)
>  		shift; template="--template=$1" ;;
>  	-q|--quiet)
> @@ -288,7 +288,7 @@ yes)
>  	( cd "$repo/objects" ) ||
>  		die "cannot chdir to local '$repo/objects'."
>  
> -	if test "$local_shared" = yes
> +	if test "$shared" = yes
>  	then
>  		mkdir -p "$GIT_DIR/objects/info"
>  		echo "$repo/objects" >>"$GIT_DIR/objects/info/alternates"
> @@ -364,11 +364,22 @@ yes)
>  		fi
>  		;;
>  	*)
> +		commits_only=
> +		if test "$shared" = yes
> +		then
> +			commits_only="--commits-only"
> +		fi
>  		case "$upload_pack" in
> -		'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
> -		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress "$repo" ;;
> +		'') git-fetch-pack --all -k $quiet $depth $no_progress $commits_only "$repo";;
> +		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress $commits_only "$repo" ;;
>  		esac >"$GIT_DIR/CLONE_HEAD" ||
>  			die "fetch-pack from '$repo' failed."
> +		if test "$shared" = yes
> +		then
> +			# Must be done after the fetch
> +			mkdir -p "$GIT_DIR/objects/info"
> +			echo "$repo" >> "$GIT_DIR/objects/info/remote_alternates"
> +		fi
>  		;;
>  	esac
>  	;;

Please have a different option than --shared for lazy clones.  Maybe 
--lazy?  ;-)

I can see why you reused --shared, though.  But let's make this more 
fool-proof: a user should explicitely ask for a lazy clone.

> diff --git a/index-pack.c b/index-pack.c
> index 9fd6982..f2e6b7a 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -9,7 +9,7 @@
>  #include "progress.h"
>  
>  static const char index_pack_usage[] =
> -"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
> +"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--ignore-remote-alternates] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
>  
>  struct object_entry
>  {
> @@ -746,6 +746,8 @@ int main(int argc, char **argv)
>  					pack_idx_off32_limit = strtoul(c+1, &c, 0);
>  				if (*c || pack_idx_off32_limit & 0x80000000)
>  					die("bad %s", arg);
> +			} else if (!strcmp(arg, "--ignore-remote-alternates")) {
> +				disable_remote_alternates();
>  			} else
>  				usage(index_pack_usage);
>  			continue;

I might be missing something, but I do not believe this is necessary.  
index-pack only works on packs anyway.  Am I wrong?

> diff --git a/sha1_file.c b/sha1_file.c
> index 66a4e00..7d60be0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -14,6 +14,7 @@
>  #include "tag.h"
>  #include "tree.h"
>  #include "refs.h"
> +#include "run-command.h"
>  
>  #ifndef O_NOATIME
>  #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
> @@ -411,6 +412,205 @@ static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
>  	return NULL;
>  }
>  
> +static char *remote_alternates = NULL;
> +static int has_remote_alt_feature = -1;
> +
> +void disable_remote_alternates(void)
> +{
> +	has_remote_alt_feature = 0;
> +}
> +
> +static int has_remote_alternates(void)
> +{
> +	/* FIXME: does it make sense to support more URLs inside
> +	 * remote_alternates? */

I think it would make sense.  For example if you have a local machine 
which has most, but maybe not all, of the remote objects.

> +	struct stat st;
> +	const char remote_alt_file_name[] = "info/remote_alternates";

<bikeshedding>maybe remote-alternates (note the dash instead 
of the underscore)</bikeshedding>

> +	char path[PATH_MAX + 1 + sizeof remote_alt_file_name];
> +	int fd;
> +	char *map, *p;
> +	size_t mapsz;
> +
> +	if (has_remote_alt_feature != -1)
> +		return has_remote_alt_feature;
> +
> +	has_remote_alt_feature = 0;
> +
> +	sprintf(path, "%s/%s", get_object_directory(),
> +			remote_alt_file_name);
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return has_remote_alt_feature;
> +	else if (fstat(fd, &st) || (st.st_size == 0)) {
> +		close(fd);
> +		return has_remote_alt_feature;
> +	}
> +
> +	mapsz = xsize_t(st.st_size);
> +	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
> +	close(fd);
> +
> +	/* we support just one remote alternate for now,
> +	 * so read just the first entry */
> +	for (p = map; (p < map + mapsz) && (*p != '\n'); p++)
> +		;
> +
> +	remote_alternates = strndup(map, p - map);

Seems that you do something like the read_from_stdin() here, only from a 
file.  It appears to me as if the function wants to be a library function 
(taking a FILE * parameter, and maybe closing it after use, or even 
taking a filename parameter, which signifies stdin when NULL).

> +struct sha1_list {
> +	unsigned char sha1[20];
> +	struct sha1_list *next;
> +};

It'd be probably better to make this an array which uses ALLOC_GROW() in 
order to avoid memory fragmentation/allocation overhead.

> +	memset(&fetch_pack, 0, sizeof(fetch_pack));
> +	fetch_pack.in = dump_objects.out;
> +	fetch_pack.out = 1;
> +	fetch_pack.err = 2;
> +	fetch_pack.git_cmd = 1;
> +	fetch_pack.argv = argv;
> +
> +	err = run_command(&fetch_pack);
> +
> +	/* TODO better error handling - is the object really missing, or
> +	 * was it just a temporary network error? */
> +	if (err) {
> +		fprintf(stderr, "error %d while calling fetch-pack\n", err);
> +		return 0;

That is a

		return error("Error %d while calling fetch-pack", err);

And it does not really matter what type of error it is: you must report 
the error and continue without this object.

> +static int fill_remote_list(const unsigned char *sha1,
> +		const char *base, int baselen,
> +		const char *pathname, unsigned mode, int stage)
> +{
> +	if (!has_sha1_file_locally(sha1)) {
> +		struct sha1_list *item;
> +
> +		item = xmalloc(sizeof(*item));
> +		hashcpy(item->sha1, sha1);
> +		item->next = remote_list;
> +
> +		remote_list = item;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fetch_remote_sha1s_recursive(struct sha1_list *objects)
> +{
> +	struct sha1_list *list;
> +	int ret = 0;
> +
> +	/* first of all, fetch the missing objects */
> +	if (!fetch_remote_sha1s(objects))
> +		return 0;
> +
> +	remote_list = NULL;
> +
> +	list = objects;
> +	while (list) {
> +		struct tree *tree;
> +
> +		tree = parse_tree_indirect(list->sha1);
> +		if (tree) {
> +			read_tree_recursive(tree, "", 0, 0, NULL,
> +					fill_remote_list);
> +		}

The curly brackets are not necessary.  Plus, with fill_remote_list() as 
you defined it, it will break down with submodules (see 481f0ee6(Fix 
rev-list when showing objects involving submodules) for inspiration).

> +
> +		list = list->next;
> +	}
> +
> +	list = remote_list;
> +	if (!list)
> +		return 1; /* hooray, we have everything */
> +
> +	ret = fetch_remote_sha1s_recursive(list);

This just cries out loud for a non-recursive approach: have two arrays, 
clear the second, fetch the objects in the first array, then fill the 
second with the objects referred to by the first array's objects.  Then 
swap the arrays.  Loop.

> @@ -2316,6 +2532,18 @@ int has_sha1_file(const unsigned char *sha1)
>  	return find_sha1_file(sha1, &st) ? 1 : 0;
>  }
>  
> +int has_sha1_file(const unsigned char *sha1)
> +{
> +	if (has_sha1_file_locally(sha1))
> +		return 1;
> +
> +	/* download it if necessary */
> +	if (has_remote_alternates() && download_remote_sha1(sha1))

Maybe it would be nicer to have the has_remote_alternates() check only in 
download_remote_sha1()?  Same applies to read_sha1_file().

> @@ -106,9 +106,15 @@ static int do_rev_list(int fd, void *create_full_pack)
>  	if (create_full_pack)
>  		use_thin_pack = 0; /* no point doing it */
>  	init_revisions(&revs, NULL);
> -	revs.tag_objects = 1;
> -	revs.tree_objects = 1;
> -	revs.blob_objects = 1;
> +	if (!commits_only) {
> +		revs.tag_objects = 1;
> +		revs.tree_objects = 1;
> +		revs.blob_objects = 1;
> +	} else {
> +		revs.tag_objects = 0;
> +		revs.tree_objects = 0;
> +		revs.blob_objects = 0;
> +	}

Or

	revs.tag_objects = revs.tree_objects = revs.blob_objects
		= !commits_only;


> @@ -498,9 +525,15 @@ static void receive_needs(void)
>  		 * asks for something like "master~10" (symbolic)...
>  		 * would it make sense?  I don't know.
>  		 */
> -		o = lookup_object(sha1_buf);
> -		if (!o || !(o->flags & OUR_REF))
> -			die("git-upload-pack: not our ref %s", line+5);
> +		if (!exact_objects) {
> +			o = lookup_object(sha1_buf);
> +			if (!o || !(o->flags & OUR_REF))
> +				die("git-upload-pack: not our ref %s", line+5);
> +		} else {
> +			o = lookup_unknown_object(sha1_buf);
> +			if (!o)
> +				die("git-upload-pack: not an object %s", line+5);
> +		}

Hmm... AFAICT lookup_unknown_object() does not return NULL.  It creates a 
"none" object if it did not find anything under that sha1.

I think you'd rather want

 		o = lookup_object(sha1_buf);
-		if (!o || !(o->flags & OUR_REF))
+		if (!o || (!exact_objects && !(o->flags & OUR_REF)))
 			die("git-upload-pack: not our ref %s", line+5);

Puh.  What a big patch!  But as I said, it is nice to know somebody is 
working on this.  (I do not necessarily see possibilities to break it 
down into smaller chunks, though.)

But I think that your needs can be satisfied with partial shallow clones, 
too: e.g.

	$ mkdir my-new-workdir
	$ cd my-new-workdir
	$ git init
	$ git remote add -t master origin <url>
	$ git fetch --depth 1 origin
	$ git checkout -b master origin/master

I cannot think of a proper place to make this a one-shot command.

As you probably know, I am a strong believer in semantics, so I would hate 
"git clone" being taught to not clone the whole repository, but only a 
single branch.

But hey, I have been wrong before.

Ciao,
Dscho
