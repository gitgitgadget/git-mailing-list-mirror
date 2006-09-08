From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/4] Add git-archive
Date: Fri, 08 Sep 2006 22:21:25 +0200
Message-ID: <4501D0C5.702@lsrfire.ath.cx>
References: <450019C3.4030001@innova-card.com>	<11576347251776-git-send-email-vagabon.xyz@gmail.com> <7vodtrnl0f.fsf@assigned-by-dhcp.cox.net> <45013114.1070808@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 22:21:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLmqy-0001eq-5S
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 22:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWIHUV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 16:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWIHUV3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 16:21:29 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:33233
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751200AbWIHUV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 16:21:27 -0400
Received: from [10.0.1.3] (p508E5573.dip.t-dialin.net [80.142.85.115])
	by neapel230.server4you.de (Postfix) with ESMTP id 93E6119023;
	Fri,  8 Sep 2006 22:21:24 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <45013114.1070808@innova-card.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26706>

Only a few trivial comments, as I managed to catch a cold somehow and
can't think straight for longer than three seconds.

>  .gitignore                    |    1 
>  Documentation/git-archive.txt |  100 ++++++++++++++++++
>  Makefile                      |    3 -
>  archive.h                     |   41 +++++++
>  builtin-archive.c             |  225 +++++++++++++++++++++++++++++++++++++++++
>  builtin.h                     |    1 
>  generate-cmdlist.sh           |    1 
>  git.c                         |    1 
>  8 files changed, 372 insertions(+), 1 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 78cb671..a3e7ca1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -8,6 +8,7 @@ git-apply
>  git-applymbox
>  git-applypatch
>  git-archimport
> +git-archive
>  git-bisect
>  git-branch
>  git-cat-file
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> new file mode 100644
> index 0000000..913528d
> --- /dev/null
> +++ b/Documentation/git-archive.txt
> @@ -0,0 +1,100 @@
> +git-archive(1)
> +==============
> +
> +NAME
> +----
> +git-archive - Creates a archive of the files in the named tree
> +
> +
> +SYNOPSIS
> +--------
> +'git-archive' --format=<fmt> [--list] [--prefix=<prefix>/] [<extra>]
> +	      [--remote=<repo>] <tree-ish> [path...]
> +
> +DESCRIPTION
> +-----------
> +Creates an archive of the specified format containing the tree
> +structure for the named tree.  If <prefix> is specified it is
> +prepended to the filenames in the archive.
> +
> +'git-archive' behaves differently when given a tree ID versus when
> +given a commit ID or tag ID.  In the first case the current time is
> +used as modification time of each file in the archive.  In the latter
> +case the commit time as recorded in the referenced commit object is
> +used instead.  Additionally the commit ID is stored in a global
> +extended pax header if the tar format is used; it can be extracted
> +using 'git-get-tar-commit-id'. In ZIP files it is stored as a file
> +comment.
> +
> +OPTIONS
> +-------
> +
> +--format=<fmt>::
> +	Format of the resulting archive: 'tar', 'zip'...
> +
> +--list::
> +	Show all available formats.
> +
> +--prefix=<prefix>/::
> +	Prepend <prefix>/ to each filename in the archive.
> +
> +<extra>::
> +	This can be any options that the archiver backend understand.
> +
> +--remote=<repo>::
> +	Instead of making a tar archive from local repository,
> +	retrieve a tar archive from a remote repository.
> +
> +<tree-ish>::
> +	The tree or commit to produce an archive for.
> +
> +path::
> +	If one or more paths are specified, include only these in the
> +	archive, otherwise include all files and subdirectories.
> +
> +CONFIGURATION
> +-------------
> +By default, file and directories modes are set to 0666 or 0777 in tar
> +archives.  It is possible to change this by setting the "umask" variable
> +in the repository configuration as follows :
> +
> +[tar]
> +        umask = 002	;# group friendly
> +
> +The special umask value "user" indicates that the user's current umask
> +will be used instead. The default value remains 0, which means world
> +readable/writable files and directories.
> +
> +EXAMPLES
> +--------
> +git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)::
> +
> +	Create a tar archive that contains the contents of the
> +	latest commit on the current branch, and extracts it in
> +	`/var/tmp/junk` directory.
> +
> +git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz::
> +
> +	Create a compressed tarball for v1.4.0 release.
> +
> +git archive --format=tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz::
> +
> +	Create a compressed tarball for v1.4.0 release, but without a
> +	global extended pax header.
> +
> +git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs.zip::
> +
> +	Put everything in the current head's Documentation/ directory
> +	into 'git-1.4.0-docs.zip', with the prefix 'git-docs/'.
> +
> +Author
> +------
> +Written by Franck Bui-Huu and Rene Scharfe.
> +
> +Documentation
> +--------------
> +Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
> +
> +GIT
> +---
> +Part of the gitlink:git[7] suite
> diff --git a/Makefile b/Makefile
> index 389daf7..51ed4dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -242,7 +242,7 @@ LIB_FILE=libgit.a
>  XDIFF_LIB=xdiff/lib.a
>  
>  LIB_H = \
> -	blob.h cache.h commit.h csum-file.h delta.h \
> +	archive.h blob.h cache.h commit.h csum-file.h delta.h \
>  	diff.h object.h pack.h para-walk.h pkt-line.h quote.h refs.h \
>  	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
>  	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
> @@ -267,6 +267,7 @@ LIB_OBJS = \
>  BUILTIN_OBJS = \
>  	builtin-add.o \
>  	builtin-apply.o \
> +	builtin-archive.o \
>  	builtin-cat-file.o \
>  	builtin-checkout-index.o \
>  	builtin-check-ref-format.o \
> diff --git a/archive.h b/archive.h
> new file mode 100644
> index 0000000..24b016f
> --- /dev/null
> +++ b/archive.h
> @@ -0,0 +1,41 @@
> +#ifndef ARCHIVE_H
> +#define ARCHIVE_H
> +
> +#define MAX_EXTRA_ARGS	32
> +#define MAX_ARGS	(MAX_EXTRA_ARGS + 32)
> +
> +struct archiver_args {
> +	const char *base;
> +	struct tree *tree;
> +	const unsigned char *commit_sha1;
> +	time_t time;
> +	const char **pathspec;
> +	void *extra;
> +};
> +
> +typedef int (*write_archive_fn_t)(struct archiver_args *);
> +
> +typedef void *(*parse_extra_args_fn_t)(int argc, const char **argv);
> +
> +struct archiver {
> +	const char *name;
> +	const char *remote;
> +	struct archiver_args args;
> +	write_archive_fn_t write_archive;
> +	parse_extra_args_fn_t parse_extra;
> +};
> +
> +extern struct archiver archivers[];
> +
> +extern int parse_archive_args(int argc,
> +			      const char **argv,
> +			      struct archiver *ar);
> +
> +extern void parse_treeish_arg(const char **treeish,
> +			      struct archiver_args *ar_args,
> +			      const char *prefix);
> +
> +extern void parse_pathspec_arg(const char **pathspec,
> +			       struct archiver_args *args);
> +
> +#endif	/* ARCHIVE_H */
> diff --git a/builtin-archive.c b/builtin-archive.c
> new file mode 100644
> index 0000000..5671cbd
> --- /dev/null
> +++ b/builtin-archive.c
> @@ -0,0 +1,225 @@
> +/*
> + * Copyright (c) 2006 Franck Bui-Huu
> + * Copyright (c) 2006 Rene Scharfe
> + */
> +#include <time.h>
> +#include "cache.h"
> +#include "builtin.h"
> +#include "archive.h"
> +#include "commit.h"
> +#include "tree-walk.h"
> +#include "exec_cmd.h"
> +#include "pkt-line.h"
> +
> +static const char archive_usage[] = \
> +"git-archive --format=<fmt> [--prefix=<prefix>/] [<extra>] <tree-ish> [path...]";
> +
> +
> +struct archiver archivers[] = { };
> +
> +
> +static int run_remote_archiver(struct archiver *ar, int argc,
> +			       const char **argv)
> +{
> +	char *url, buf[1024];
> +	int fd[2], i, len, rv;
> +	pid_t pid;
> +
> +	sprintf(buf, "git-upload-archive");
> +
> +	url = strdup(ar->remote);

xstrdup()

> +	pid = git_connect(fd, url, buf);
> +	if (pid < 0)
> +		return pid;
> +
> +	for (i = 1; i < argc; i++) {
> +		if (!strncmp(argv[i], "--remote=", 9))
> +			continue;
> +		packet_write(fd[1], "argument %s\n", argv[i]);
> +	}
> +	packet_flush(fd[1]);
> +
> +	len = packet_read_line(fd[0], buf, sizeof(buf));
> +	if (!len)
> +		die("git-archive: expected ACK/NAK, got EOF");
> +	if (buf[len-1] == '\n')
> +		buf[--len] = 0;
> +	if (strcmp(buf, "ACK")) {
> +		if (len > 5 && !strncmp(buf, "NACK ", 5))
> +			die("git-archive: NACK %s", buf + 5);
> +		die("git-archive: protocol error");
> +	}
> +
> +	len = packet_read_line(fd[0], buf, sizeof(buf));
> +	if (len)
> +		die("git-archive: expected a flush");
> +
> +	/* Now, start reading from fd[0] and spit it out to stdout */
> +	rv = copy_fd(fd[0], 1);
> +
> +	close(fd[0]);
> +	rv |= finish_connect(pid);
> +
> +	return !!rv;
> +}
> +
> +static int init_archiver(const char *name, struct archiver *ar)
> +{
> +	int rv = -1, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
> +		if (!strcmp(name, archivers[i].name)) {
> +			memcpy(ar, &archivers[i], sizeof(struct archiver));
> +			rv = 0;
> +			break;
> +		}
> +	}
> +	return rv;
> +}
> +
> +void parse_pathspec_arg(const char **pathspec, struct archiver_args *ar_args)
> +{
> +	ar_args->pathspec = get_pathspec(ar_args->base, pathspec);
> +}
> +
> +void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
> +		       const char *prefix)
> +{
> +	const char *name = argv[0];
> +	const unsigned char *commit_sha1;
> +	time_t archive_time;
> +	struct tree *tree;
> +	struct commit *commit;
> +	unsigned char sha1[20];
> +
> +	if (get_sha1(name, sha1))
> +		die("Not a valid object name");
> +
> +	commit = lookup_commit_reference_gently(sha1, 1);
> +	if (commit) {
> +		commit_sha1 = commit->object.sha1;
> +		archive_time = commit->date;
> +	} else {
> +		archive_time = time(NULL);
> +	}
> +
> +	tree = parse_tree_indirect(sha1);
> +	if (tree == NULL)
> +		die("not a tree object");
> +
> +	if (prefix) {
> +		unsigned char tree_sha1[20];
> +		unsigned int mode;
> +		int err;
> +
> +		err = get_tree_entry(tree->object.sha1, prefix,
> +				     tree_sha1, &mode);
> +		if (err || !S_ISDIR(mode))
> +			die("current working directory is untracked");
> +
> +		free(tree);
> +		tree = parse_tree_indirect(tree_sha1);
> +	}
> +	ar_args->tree = tree;
> +	ar_args->commit_sha1 = commit_sha1;
> +	ar_args->time = archive_time;
> +}
> +
> +static const char *default_parse_extra(struct archiver *ar,
> +				       const char **argv)
> +{
> +	static char msg[64];
> +
> +	snprintf(msg, sizeof(msg) - 4, "'%s' format does not handle %s",
> +		 ar->name, *argv);
> +
> +	return strcat(msg, "...");
> +}
> +
> +int parse_archive_args(int argc, const char **argv, struct archiver *ar)
> +{
> +	const char *extra_argv[MAX_EXTRA_ARGS];
> +	int extra_argc = 0;
> +	const char *format = NULL; /* some default values */

This comment does not convey any information.

> +	const char *remote = NULL;
> +	const char *base = "";
> +	int list = 0;
> +	int i;
> +
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +
> +		if (!strcmp(arg, "--list") || !strcmp(arg, "-l")) {
> +			list = 1;
> +			continue;
> +		}
> +		if (!strncmp(arg, "--format=", 9)) {
> +			format = arg + 9;
> +			continue;
> +		}
> +		if (!strncmp(arg, "--prefix=", 9)) {
> +			base = arg + 9;
> +			continue;
> +		}
> +		if (!strncmp(arg, "--remote=", 9)) {
> +			remote = arg + 9;
> +			continue;
> +		}
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			break;
> +		}
> +		if (arg[0] == '-') {
> +			extra_argv[extra_argc++] = arg;

Overrun is not checked.

> +			continue;
> +		}
> +		break;
> +	}
> +	if (list) {
> +		if (!remote) {
> +			for (i = 0; i < ARRAY_SIZE(archivers); i++)
> +				printf("%s\n", archivers[i].name);
> +			exit(0);
> +		}
> +		die("--list and --remote are mutually exclusive");
> +	}

Not sure if we really need a list option.  I guess it only really
makes sense if we have more than five formats.  I have no _strong_
feelings against it, though. *shrug*

> +	if (argc - i < 1) {
> +		die("%s", archive_usage);

usage()

> +	}
> +	if (!format){
> +		die("You must specify an archive format");
> +	}
> +	if (init_archiver(format, ar) < 0) {
> +		die("Unknown archive format '%s'", format);
> +	}
> +	if (extra_argc && !remote) {
> +		if (!ar->parse_extra) {
> +			die("%s", default_parse_extra(ar, extra_argv));
> +		}
> +		ar->args.extra = ar->parse_extra(extra_argc, extra_argv);
> +	}
> +	ar->remote = remote;
> +	ar->args.base = base;
> +
> +	return i;
> +}
> +
> +int cmd_archive(int argc, const char **argv, const char *prefix)
> +{
> +	struct archiver ar;
> +	int tree_idx;
> +
> +	tree_idx = parse_archive_args(argc, argv, &ar);
> +
> +	if (ar.remote)
> +		return run_remote_archiver(&ar, argc, argv);
> +
> +	if (prefix == NULL)
> +		prefix = setup_git_directory();
> +
> +	argv += tree_idx;
> +	parse_treeish_arg(argv, &ar.args, prefix);
> +	parse_pathspec_arg(argv + 1, &ar.args);
> +
> +	return ar.write_archive(&ar.args);
> +}
> diff --git a/builtin.h b/builtin.h
> index 8472c79..2391afb 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -15,6 +15,7 @@ extern int write_tree(unsigned char *sha
>  
>  extern int cmd_add(int argc, const char **argv, const char *prefix);
>  extern int cmd_apply(int argc, const char **argv, const char *prefix);
> +extern int cmd_archive(int argc, const char **argv, const char *prefix);
>  extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
>  extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
>  extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index ec1eda2..5450918 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -12,6 +12,7 @@ struct cmdname_help common_cmds[] = {"
>  sort <<\EOF |
>  add
>  apply
> +archive
>  bisect
>  branch
>  checkout
> diff --git a/git.c b/git.c
> index 82c8fee..c62c5cf 100644
> --- a/git.c
> +++ b/git.c
> @@ -218,6 +218,7 @@ static void handle_internal_command(int 
>  	} commands[] = {
>  		{ "add", cmd_add, RUN_SETUP },
>  		{ "apply", cmd_apply },
> +		{ "archive", cmd_archive },
>  		{ "cat-file", cmd_cat_file, RUN_SETUP },
>  		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
>  		{ "check-ref-format", cmd_check_ref_format },
