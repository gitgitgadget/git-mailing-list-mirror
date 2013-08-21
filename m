From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 01:25:27 -0700
Message-ID: <20130821082527.GC2802@elie.Belkin>
References: <5213EF74.7020408@googlemail.com>
 <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com, j6t@kdbg.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 10:25:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC3je-0001SS-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 10:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679Ab3HUIZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 04:25:39 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60135 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab3HUIZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 04:25:32 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so562397pad.33
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2zlB5eDzkMx+wzlsDHequdCKAJKiwn4+pNlbHVtBd/4=;
        b=gzs6i2hcsToY5sBRkE5WhWbyzMORIgUnR+uVUGCzpiAvahaR15Dzz9v1Tj7yTyl/aU
         oexUyESIM/saqg8qsaLIaOIDK5rNtUpdYqxjCebh7aP1AIls6gAgXrKAHYip1ICr8DU4
         QGyH8QVDVPJoa9JiC9TuBQ4aYMHLObAiYWo9vBpJEM674nQ3zNTxCRgxXi9zzXZrxwzb
         0ORIl6v5ZSsw6E994YGsAQtSFwyHYaa7fH9tu5jWL6Vd1LAkRS+/lmloXDmTJHV1dPdy
         wmqlNbkOI/+vyzM3PYawILdYznu7/1L/BtyKAltutPwGjkCl1EN/eQQLTPFR3vJDvV8u
         thOw==
X-Received: by 10.66.142.132 with SMTP id rw4mr8489663pab.6.1377073531828;
        Wed, 21 Aug 2013 01:25:31 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id iu10sm8647919pac.18.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 01:25:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232693>

Hi,

Stefan Beller wrote:

> [PATCH] repack: rewrite the shell script in C.

Thanks for your work so far.  This review will have mostly cosmetic
notes.  Hopefully others can try it out to see if the actual behavior
is good.

As a first nit: in git, as usual in emails, the style in subject lines
is not to end with a period.  The above subject line is otherwise good
(a nice summary that quickly explains the effect, which is handy in
e.g. abbreviated changelogs from release announcements).

> This is the beginning of the rewrite of the repacking.

This is a place to explain

 - the motivation / intended positive effect of the patch
 - any noticeable behavior changes
 - complications and other hints for people looking back and trying
   to understand this code

Based on the discussion before, I think the motivation is to get
closer to a goal of being able to have a core subset of git
functionality built in to git.  That would mean

 * people on Windows could get a copy of at least the core parts
   of Git without having to install a Unix-style shell

 * people deploying to servers don't have to rewrite the #! line
   or worry about the PATH and quality of installed POSIX
   utilities, if they are only using the built-in part written
   in C 

This patch is meant to be mostly a literal translation of the
git-repack script; the intent is that later patches would start using
more library facilities, but this patch is meant to be as close to a
no-op as possible so it doesn't do that kind of thing.

> All tests are constantly positive now.

This kind of changes-since-the-previous-iteration information that
doesn't need to be recorded in the commit log for posterity goes
after the "---" marker.

> 
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  Makefile                                        |   2 +-
[...]
> --- /dev/null
> +++ b/builtin/repack.c
> @@ -0,0 +1,361 @@
[...]
> +static int delta_base_offset = 0;

The "= 0" is automatic for statics without an initializer.  The
prevailing style in git is to leave it out.

Behavior change: in the script, wasn't the default "true"?

[...]
> +static void remove_temporary_files() {

Style: argument list should have "void".  (In C89 and C99, an empty
argument list means "having unspecified arguments" instead of "having
no arguments" as in C++.)

> +	DIR *dir;
> +	struct dirent *e;
> +	char *prefix, *path;
> +
> +	prefix = mkpathdup(".tmp-%d-pack", getpid());

pid_t is not guaranteed to be an "int", so this needs a cast.

> +	path = mkpathdup("%s/pack", get_object_directory());

The names "prefix" and "path" are quite generic.  What does this
function do?  A comment could help, e.g.:

	/*
	 * Remove temporary $GIT_OBJECT_DIRECTORY/pack/.tmp-$$-pack-* files.
	 */

> +
> +	dir = opendir(path);
> +	while ((e = readdir(dir)) != NULL) {

What happens if the directory does not exist?

> +		if (!prefixcmp(e->d_name, prefix)) {

The git-repack script removes $PACKTMP-*, but this code matches $PACKTMP*
instead.  Intentional?

> +			struct strbuf fname = STRBUF_INIT;
> +			strbuf_addf(&fname, "%s/%s", path, e->d_name);
> +			unlink(strbuf_detach(&fname, NULL));

This leaks fname (see Documentation/technical/api-strbuf.txt for an
explanation of strbuf_detach).

> +		}
> +	}
> +	free(prefix);
> +	free(path);
> +	closedir(dir);

I wonder if it would make sense for buffers to share space here.
E.g. something like

 {
	/*
	 * Remove temporary $GIT_OBJECT_DIRECTORY/pack/.tmp-$$-pack-* files.
	 */

	struct strbuf buf = STRBUF_INIT;
	size_t dirlen, prefixlen;
	DIR *dir;
	struct dirent *e;

	/* .git/objects/pack */
	strbuf_addstr(&buf, get_object_directory());
	strbuf_addstr(&buf, "/pack");
	dir = opendir(buf.buf);
	if (!dir)
		... handle error ...

	/* .git/objects/pack/.tmp-$$-pack-* */
	dirlen = buf.len + 1;
	strbuf_addf(&buf, "/.tmp-%d-pack-", getpid());
	prefixlen = buf.len - dirlen;

	while ((e = readdir(dir))) {
		if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
			continue;
		strbuf_setlen(&buf, dirlen);
		strbuf_addstr(&buf, e->d_name);
		unlink(buf.buf);
	}
	if (closedir(dir))
		... handle error ...

	strbuf_release(&buf);
 }

I dunno.

[...]
> +/*
> + * Fills the filename list with all the files found in the pack directory
> + * ending with .pack, without that extension.
> + */

Ideally a comment opening a function will save lazy readers the
trouble of reading the body of the function, by explaining what the
function is for and giving them some reliable summary of what its
effect will be.

The above comment doesn't do either: it doesn't make it clear why
the function exists, and it doesn't make the semantics precise:
should fname_list be empty before this function is called?  Are the
filenames filling it absolute or relative?  What happens if packdir
is unreadable or doesn't exist?  What happens to files without a .pack
extension?

Also, the above comment is in the wrong part of the file to maximally
help a lazy reader: it should be at the call site, so the reader
doesn't have to look for the function's definition at all.

> +void get_pack_filenames(char *packdir, struct string_list *fname_list)

File-local function should be static.

Missing "const" on packdir.

> +{
> +	DIR *dir;
> +	struct dirent *e;
> +	char *path, *suffix, *fname;
> +
> +	path = mkpath("%s/pack", get_object_directory());

Whenever I see the result of "mkpath" stored for more than a couple
of lines, I fret a little (since it's easy to scribble over the
rotating list of 4 get_pathname() buffers).  Would doing

	dir = opendir(mkpath(...))

directly work?  By the way, why does this function both compute
packdir and take it as an argument?

> +	suffix = ".pack";

Why not pass the string directly to suffixcmp and strlen?

> +	dir = opendir(path);

What happens if the packdir does not exist or cannot be read, or
another error occurs?

> +	while ((e = readdir(dir)) != NULL) {
> +		if (!suffixcmp(e->d_name, suffix)) {

Can decrease the indent and deal with the boring case early
by reversing the test:

		if (suffixcmp(...))
			continue;

[...]
> +void remove_pack(char *path, char* sha1)

Missing "const" on path.  The * in pointers sticks to the variable
name instead of its type.

> +{
> +	char *exts[] = {".pack", ".idx", ".keep"};
> +	int ext = 0;
> +	for (ext = 0; ext < 3; ext++) {

String constants are allowed in C to be assigned to a char * for
historical reasons, but it's never a good idea :), since they're
not mutable.

Array index is being assigned twice.  ARRAY_SIZE could make this
clearer:

 {
	const char *exts[] = {".pack", ... };
	int i;

	for (i = 0; i < ARRAY_SIZE(exts); i++)
		unlink(mkpath("%s/pack-%s%s", packdir, sha1, exts[i]));
 }

Is the sha1 parameter actually a sha1?

It wasn't obvious to me at first what this function is for.  Maybe
a name like remove_redundant_pack() would work.  E.g.:

	static void remove_redundant_pack(const char *pack_sha1)
	{
		const char *exts[] = {".pack", ".idx", ".keep"};
		struct strbuf buf = STRBUF_INIT;
		size_t plen;
		int i;

		strbuf_addf(&buf, "%s/pack-%s", get_object_directory(), pack_sha1);
		plen = buf.len;

		for (i = 0; i < ARRAY_SIZE(exts); i++) {
			strbuf_setlen(&buf, plen);
			strbuf_addstr(&buf, exts[i]);
			unlink(buf.buf);
		}
	}

[...]
> +int cmd_repack(int argc, const char **argv, const char *prefix) {
> +

Stray blank line.

> +	char *exts[2] = {".idx", ".pack"};

Missing "const".

> +	char *packdir, *packtmp, line[1024];

Fixed-size buffers are no fun.  Better to use a strbuf with
e.g. strbuf_getline (see Documentation/technical/api-strbuf.txt).

[...]
> +	struct option builtin_repack_options[] = {
> +		OPT_BOOL('a', NULL, &pack_everything,
> +				N_("pack everything in a single pack")),
> +		OPT_BOOL('A', NULL, &pack_everything_but_loose,
> +				N_("same as -a, and turn unreachable objects loose")),
> +		OPT_BOOL('d', NULL, &delete_redundant,
> +				N_("remove redundant packs, and run git-prune-packed")),
> +		OPT_BOOL('f', NULL, &no_reuse_delta,
> +				N_("pass --no-reuse-delta to git-pack-objects")),
> +		OPT_BOOL('F', NULL, &no_reuse_object,
> +				N_("pass --no-reuse-object to git-pack-objects")),
> +		OPT_BOOL('n', NULL, &no_update_server_info,
> +				N_("do not run git-update-server-info")),
> +		OPT__QUIET(&quiet, N_("be quiet")),
> +		OPT_BOOL('l', "local", &local,
> +				N_("pass --local to git-pack-objects")),
> +		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
> +				N_("with -A, do not loosen objects older than this Packing constraints")),

Do you mean
		... than this")),

		OPT_GROUP(N_("Packing constraints")),

?

[...]
> +	git_config(repack_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, builtin_repack_options,
> +				git_repack_usage, 0);
> +
> +	sigchain_push_common(remove_pack_on_signal);
> +
> +	packdir = mkpathdup("%s/pack", get_object_directory());
> +	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, getpid());

This filename pattern also appears higher in the file.  Maybe it's
possible for them to share a constant or something?  (If it's too
much fuss, no need to bother.)

> +	argv_array_push(&cmd_args, "pack-objects");
> +	argv_array_push(&cmd_args, "--keep-true-parents");
> +	argv_array_push(&cmd_args, "--honor-pack-keep");
> +	argv_array_push(&cmd_args, "--non-empty");
> +	argv_array_push(&cmd_args, "--all");
> +	argv_array_push(&cmd_args, "--reflog");
> +
> +	if (window)
> +		argv_array_pushf(&cmd_args, "--window=%u", window);
> +
> +	if (window_memory)
> +		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);

Style: I'd leave out these blank lines, so the reader can see more
of the arguments in one screenful.

Are these signed or unsigned integers?  What happens if I pass
a value < 0 or > INT_MAX?

[...]
> +	if (pack_everything + pack_everything_but_loose == 0) {

Probably easier to read as

	if (!pack_everything && !pack_everything_but_loose) {

> +		argv_array_push(&cmd_args, "--unpacked");
> +		argv_array_push(&cmd_args, "--incremental");
> +	} else {
> +		struct string_list fname_list = STRING_LIST_INIT_DUP;
> +		get_pack_filenames(packdir, &fname_list);
> +		for_each_string_list_item(item, &fname_list) {

The git-repack script uses "find", which scans the directory
recursively, though I'm not sure why.  (Probably not important?)

Instead of building a temporary and potentially long string_list
and then pruning it to build another list, why not build the list
of packs without a corresponding .keep file in a single pass?

> +			char *fname;
> +			fname = mkpathdup("%s/%s.keep", packdir, item->string);
> +			if (file_exists(fname)) {
> +				/* when the keep file is there, we're ignoring that pack */
> +			} else {
> +				string_list_append(&existing_packs, item->string);
> +			}

Simplifying, and avoiding braces around a single-line "if" body:

			if (!file_exists(mkpath(...)))
				string_list_append(...);

[...]
> +		if (existing_packs.nr && delete_redundant) {
> +			if (unpack_unreachable)
> +				argv_array_pushf(&cmd_args, "--unpack-unreachable=%s", unpack_unreachable);

Long line.

[...]
> +	count_packs = 0;
> +	out = xfdopen(cmd.out, "r");
> +	while (fgets(line, sizeof(line), out)) {
> +		/* a line consists of 40 hex chars + '\n' */

Time to sleep.  Stopping here for this round.

Hope that helps,
Jonathan
