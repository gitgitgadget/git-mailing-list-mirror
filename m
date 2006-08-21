From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 12:13:46 +0200
Message-ID: <20060821101346.GA527@diku.dk>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 12:13:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF6n5-0001EF-AY
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 12:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWHUKNw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Aug 2006 06:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWHUKNw
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 06:13:52 -0400
Received: from [130.225.96.91] ([130.225.96.91]:41402 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751826AbWHUKNv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 06:13:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id BDB15770020;
	Mon, 21 Aug 2006 12:13:48 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30728-15; Mon, 21 Aug 2006 12:13:47 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2CA7377001F;
	Mon, 21 Aug 2006 12:13:47 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 969E06DF845; Mon, 21 Aug 2006 12:12:33 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0BAF1629F8; Mon, 21 Aug 2006 12:13:46 +0200 (CEST)
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <hoegsberg@gmail.com>
Content-Disposition: inline
In-Reply-To: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25793>

Kristian H=F8gsberg <hoegsberg@gmail.com> wrote Sun, Aug 20, 2006:
> diff --git a/builtin-branch.c b/builtin-branch.c
> new file mode 100644
> index 0000000..25c6313
> --- /dev/null
> +++ b/builtin-branch.c
> @@ -0,0 +1,170 @@
> +/*
> + * Builtin "git branch"
> + *
> + * Copyright (c) 2006 Kristian H=F8gsberg <krh@redhat.com>
> + * Based on git-branch.sh by Junio C Hamano.
> + */
> +
> +#include "cache.h"
> +#include "refs.h"
> +#include "commit.h"
> +#include "builtin.h"
> +
> +static const char builtin_branch_usage[] =3D
> +    "git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<star=
t-point>]] | -r";

The norm seems to be that the usage string should not be indented.

> +
> +
> +static int remote_only =3D 0;

This could be local to cmd_branch.=20

> +static const char *head;
> +static unsigned char head_sha1[20];
> +
> +static int in_merge_bases(const unsigned char *sha1,
> +			  struct commit *rev1,
> +			  struct commit *rev2)
> +{
> +	struct commit_list *bases, *b;
> +
> +	bases =3D get_merge_bases(rev1, rev2, 1);
> +	for (b =3D bases; b !=3D NULL; b =3D b->next) {
> +		if (!hashcmp(sha1, b->item->object.sha1)) {
> +			free_commit_list(bases);
> +			return 1;
> +		}
> +	}
> +
> +	free_commit_list(bases);
> +	return 0;
> +}
> +
> +static void delete_branches(int argc, const char **argv, int force)
> +{
> +	struct commit *rev1, *rev2;
> +	unsigned char sha1[20];
> +	const char *p, *name;
> +	int i;
> +
> +	for (i =3D 0; i < argc; i++) {
> +		if (!strcmp(head, argv[i]))
> +			die("Cannot delete the branch you are currently on.");
> +
> +		name =3D git_path("refs/heads/%s", argv[i]);
> +		p =3D resolve_ref(name, sha1, 1);
> +		if (p =3D=3D NULL)
> +			die("Branch '%s' not found.", argv[i]);
> +
> +		rev1 =3D lookup_commit_reference(sha1);
> +		rev2 =3D lookup_commit_reference(head_sha1);
> +		if (!rev1 || !rev2)
> +			die("Couldn't look up commit objects.");
> +
> +		/* This checks wether the merge bases of branch and

			       whether

> +		 * HEAD contains branch -- which means that the HEAD
> +		 * contains everything in both.
> +		 */
> +
> +		if (!force &&
> +		    !in_merge_bases(sha1, rev1, rev2)) {
> +			fprintf(stderr,
> +				"The branch '%s' is not a strict subset of your current HEAD.\n"
> +				"If you are sure you want to delete it, run 'git branch -D %s'.\=
n",
> +				argv[i], argv[i]);
> +			exit(1);
> +		}
> +
> +		unlink(name);
> +		printf("Deleted branch %s.\n", argv[i]);
> +	}
> +}
> +
> +static int show_reference(const char *refname, const unsigned char *=
sha1)
> +{
> +	int is_head =3D !strcmp(refname, head);
> +
> +	printf("%c %s\n", (is_head ? '*' : ' '), refname);
> +
> +	return 0;
> +}
> +
> +static void create_branch (const char *name, const char *start, int =
force)
> +{
> +	struct ref_lock *lock;
> +	unsigned char sha1[20];
> +	char ref[PATH_MAX];
> +
> +	snprintf(ref, sizeof ref, "refs/heads/%s", name);
> +	if (check_ref_format(ref + 5))
> +		die("'%s' is not a valid branch name.", name);

Why not simply check_ref_format(name)?

> +
> +	if (resolve_ref(ref, sha1, 1)) {

All other places that call resolve_ref passes a ref created with
git_path. I don't know if this should too.

> +		if (!force)
> +			die("A branch named '%s' already exists.", name);
> +		else if (!strcmp(head, name))
> +			die("Cannot force update the current branch.");
> +	}
> +
> +	if (get_sha1(start, sha1))
> +		die("Not a valid branch point: '%s'", start);

Missing punctuation at the end.

> +
> +	lock =3D lock_any_ref_for_update(ref, NULL, 0);
> +	if (!lock)
> +		die("Failed to lock ref for update: %s.", strerror(errno));
> +	if (write_ref_sha1(lock, sha1, NULL) < 0)
> +		die("Failed to write ref: %s.", strerror(errno));
> +}
> +
> +int cmd_branch(int argc, const char **argv, const char *prefix)
> +{
> +	int delete =3D 0, force_delete =3D 0, force_create =3D 0;
> +	int i, prefix_length;
> +	const char *p;
> +
> +	git_config(git_default_config);
> +
> +	for (i =3D 1; i < argc; i++) {
> +		const char *arg =3D argv[i];
> +
> +		if (arg[0] !=3D '-')
> +			break;
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			break;
> +		}
> +		if (!strcmp(arg, "-d")) {
> +			delete =3D 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-D")) {
> +			delete =3D 1;
> +			force_delete =3D 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-f")) {
> +			force_create =3D 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-r")) {
> +			remote_only =3D 1;
> +			continue;
> +		}
> +		die(builtin_branch_usage);

Perhaps usage() would be more appropriate here.

> +	}
> +
> +	prefix_length =3D strlen(git_path("refs/heads/"));
> +	p =3D resolve_ref(git_path("HEAD"), head_sha1, 0);
> +	if (!p)
> +		die("Failed to resolve HEAD as a valid ref");

Ending punctuation.

> +	head =3D strdup(p + prefix_length);
> +
> +	if (delete)
> +		delete_branches(argc - i, argv + i, force_delete);
> +	else if (i =3D=3D argc && remote_only)
> +		for_each_remote_ref(show_reference);
> +	else if (i =3D=3D argc)
> +		for_each_branch_ref(show_reference);
> +	else if (argc - i =3D=3D 1)
> +		create_branch (argv[i], head, force_create);
> +	else
> +		create_branch (argv[i], argv[i + 1], force_create);

It would be more consistent to leave out the space before the
paranthesis. Also goes for the implementation of create_branch as
already mentioned.

> +
> +	return 0;
> +}

--=20
Jonas Fonseca
