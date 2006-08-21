From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 13:23:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608211319180.8662@chino.corp.google.com>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com> 
 <20060821101346.GA527@diku.dk> <59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="413982040-58002369-1156191798=:8662"
Cc: Jonas Fonseca <fonseca@diku.dk>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 22:24:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFGJL-0007It-Ku
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 22:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWHUUXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 16:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWHUUXs
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 16:23:48 -0400
Received: from smtp-out.google.com ([216.239.45.12]:43262 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750959AbWHUUXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 16:23:48 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7LKNTNJ022888;
	Mon, 21 Aug 2006 13:23:29 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=ktk1I2uObXFN637HJOoS/eST6acwuLOXwSTOzI4FHY2rz/RIRPZb5rqgjlRvPOy5h
	A8pILdvBLp3AcfEOgx5dg==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7LKNIoL004241;
	Mon, 21 Aug 2006 13:23:19 -0700
Received: by localhost (Postfix, from userid 24081)
	id BAC798800B; Mon, 21 Aug 2006 13:23:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id B39178800A;
	Mon, 21 Aug 2006 13:23:18 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <krh@bitplanet.net>
In-Reply-To: <59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25814>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--413982040-58002369-1156191798=:8662
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 21 Aug 2006, Kristian Høgsberg wrote:

> diff --git a/builtin-branch.c b/builtin-branch.c
> new file mode 100644
> index 0000000..4e8fa7d
> --- /dev/null
> +++ b/builtin-branch.c
> @@ -0,0 +1,227 @@
> +/*
> + * Builtin "git branch"
> + *
> + * Copyright (c) 2006 Kristian HÃ¸gsberg <krh@redhat.com>
> + * Based on git-branch.sh by Junio C Hamano.
> + */
> +
> +#include "cache.h"
> +#include "refs.h"
> +#include "commit.h"
> +#include "builtin.h"
> +
> +static const char builtin_branch_usage[] =
> +"git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r";
> +
> +
> +static const char *head;
> +static unsigned char head_sha1[20];
> +
> +static int in_merge_bases(const unsigned char *sha1,
> +			  struct commit *rev1,
> +			  struct commit *rev2)
> +{
> +	struct commit_list *bases, *b;
> +	int ret = 0;
> +
> +	bases = get_merge_bases(rev1, rev2, 1);
> +	for (b = bases; b != NULL; b = b->next) {

for (b = bases; b; b = b->next) {

> +		if (!hashcmp(sha1, b->item->object.sha1)) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +
> +	free_commit_list(bases);
> +	return ret;
> +}
> +
> +static void delete_branches(int argc, const char **argv, int force)
> +{
> +	struct commit *rev, *head_rev;
> +	unsigned char sha1[20];
> +	const char *name, *reflog;
> +	int i;
> +
> +	head_rev = lookup_commit_reference(head_sha1);
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(head, argv[i]))
> +			die("Cannot delete the branch you are currently on.");
> +
> +		name = git_path("refs/heads/%s", argv[i]);
> +		if (!resolve_ref(name, sha1, 1))
> +			die("Branch '%s' not found.", argv[i]);
> +
> +		rev = lookup_commit_reference(sha1);
> +		if (!rev || !head_rev)
> +			die("Couldn't look up commit objects.");
> +
> +		/* This checks whether the merge bases of branch and
> +		 * HEAD contains branch -- which means that the HEAD
> +		 * contains everything in both.
> +		 */
> +
> +		if (!force &&
> +		    !in_merge_bases(sha1, rev, head_rev)) {
> +			fprintf(stderr,
> +				"The branch '%s' is not a strict subset of your current HEAD.\n"
> +				"If you are sure you want to delete it, run 'git branch -D %s'.\n",
> +				argv[i], argv[i]);
> +			exit(1);
> +		}
> +
> +		unlink(name);
> +
> +		/* Unlink reflog if it exists. */
> +		reflog = git_path("logs/refs/heads/%s", argv[i]);
> +		unlink(reflog);
> +
> +		printf("Deleted branch %s.\n", argv[i]);
> +	}
> +}
> +
> +static int ref_index, ref_alloc;
> +static char **ref_list;
> +
> +static int append_ref(const char *refname, const unsigned char *sha1)
> +{
> +	if (ref_index >= ref_alloc) {
> +		ref_alloc = ref_alloc > 0 ? ref_alloc * 2 : 16;
> +		ref_list = realloc(ref_list, ref_alloc * sizeof (char *));

No space

> +	}
> +
> +	ref_list[ref_index++] = strdup(refname);
> +
> +	return 0;
> +}
> +
> +static int ref_cmp (const void *r1, const void *r2)

No space

> +{
> +	return strcmp (*(char **)r1, *(char **)r2);

No space

> +}
> +
> +static void print_ref_list(int remote_only)
> +{
> +	int i;
> +
> +	if (remote_only)
> +		for_each_remote_ref(append_ref);
> +	else
> +		for_each_branch_ref(append_ref);
> +
> +	qsort(ref_list, ref_index, sizeof (char *), ref_cmp);
> +

No space

> +	for (i = 0; i < ref_index; i++) {
> +		if (!strcmp(ref_list[i], head))
> +			printf("* %s\n", ref_list[i]);
> +		else
> +			printf("  %s\n", ref_list[i]);
> +	}
> +}
> +
> +static void create_reflog(struct ref_lock *lock)
> +{
> +	struct stat stbuf;
> +	int fd;
> +
> +	if (!stat(lock->log_file, &stbuf) && S_ISREG(stbuf.st_mode))
> +		return;
> +	if (safe_create_leading_directories(lock->log_file) < 0)
> +		die("Unable to create directory for %s.", lock->log_file);
> +	fd = open(lock->log_file, O_CREAT | O_TRUNC | O_WRONLY, 0666);
> +	if (fd < 0)
> +		die("Unable to create ref log %s: %s.",
> +		    lock->log_file, strerror(errno));
> +	close(fd);
> +}
> +
> +static void create_branch(const char *name, const char *start,
> +			  int force, int reflog)
> +{
> +	struct ref_lock *lock;
> +	unsigned char sha1[20];
> +	char ref[PATH_MAX], msg[PATH_MAX + 20];
> +
> +	snprintf(ref, sizeof ref, "refs/heads/%s", name);
> +	if (check_ref_format(ref))
> +		die("'%s' is not a valid branch name.", name);
> +
> +	if (resolve_ref(git_path(ref), sha1, 1)) {
> +		if (!force)
> +			die("A branch named '%s' already exists.", name);
> +		else if (!strcmp(head, name))
> +			die("Cannot force update the current branch.");
> +	}
> +
> +	if (get_sha1(start, sha1))
> +		die("Not a valid branch point: '%s'.", start);
> +
> +	lock = lock_any_ref_for_update(ref, NULL, 0);
> +	if (!lock)
> +		die("Failed to lock ref for update: %s.", strerror(errno));
> +	if (reflog)
> +		create_reflog(lock);
> +	snprintf(msg, sizeof msg, "branch: Created from %s", start);
> +	if (write_ref_sha1(lock, sha1, msg) < 0)
> +		die("Failed to write ref: %s.", strerror(errno));
> +}
> +
> +int cmd_branch(int argc, const char **argv, const char *prefix)
> +{
> +	int delete = 0, force_delete = 0, force_create = 0, remote_only = 0;
> +	int reflog = 0;
> +	int i, prefix_length;
> +	const char *p;
> +
> +	git_config(git_default_config);
> +
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +
> +		if (arg[0] != '-')
> +			break;
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			break;
> +		}
> +		if (!strcmp(arg, "-d")) {
> +			delete = 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-D")) {
> +			delete = 1;
> +			force_delete = 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-f")) {
> +			force_create = 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-r")) {
> +			remote_only = 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-l")) {
> +			reflog = 1;
> +			continue;
> +		}
> +		usage(builtin_branch_usage);
> +	}
> +
> +	prefix_length = strlen(git_path("refs/heads/"));
> +	p = resolve_ref(git_path("HEAD"), head_sha1, 0);
> +	if (!p)
> +		die("Failed to resolve HEAD as a valid ref.");
> +	head = strdup(p + prefix_length);
> +
> +	if (delete)
> +		delete_branches(argc - i, argv + i, force_delete);
> +	else if (i == argc)
> +		print_ref_list(remote_only);
> +	else if (argc - i == 1)
> +		create_branch(argv[i], head, force_create, reflog);
> +	else
> +		create_branch(argv[i], argv[i + 1], force_create, reflog);
> +
> +	return 0;
> +}
--413982040-58002369-1156191798=:8662--
