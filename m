From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 00:49:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608210045450.17336@chino.corp.google.com>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="413982040-564890857-1156146581=:17336"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 09:50:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF4Xt-00048M-86
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 09:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWHUHtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 03:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWHUHtw
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 03:49:52 -0400
Received: from smtp-out.google.com ([216.239.45.12]:50475 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030290AbWHUHtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 03:49:51 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7L7nkN1017288;
	Mon, 21 Aug 2006 00:49:46 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=W2YY5jdZl2rJPgqC2Sh7xfmUBBXEAPnf0mqw4w3fA4KBVZS2RscLSD7WkcmouJNEy
	bOEVNTWqi6t4GbQ2jiGBQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7L7nfSs002202;
	Mon, 21 Aug 2006 00:49:41 -0700
Received: by localhost (Postfix, from userid 24081)
	id 6BB5A87D71; Mon, 21 Aug 2006 00:49:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6696187D70;
	Mon, 21 Aug 2006 00:49:41 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <hoegsberg@gmail.com>
In-Reply-To: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25785>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--413982040-564890857-1156146581=:17336
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 20 Aug 2006, Kristian Høgsberg wrote:

> diff --git a/builtin-branch.c b/builtin-branch.c
> new file mode 100644
> index 0000000..25c6313
> --- /dev/null
> +++ b/builtin-branch.c
> @@ -0,0 +1,170 @@
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
> +    "git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r";
> +
> +
> +static int remote_only = 0;

Unnecessary initialization

> +static const char *head;
> +static unsigned char head_sha1[20];
> +
> +static int in_merge_bases(const unsigned char *sha1,
> +			  struct commit *rev1,
> +			  struct commit *rev2)
> +{
> +	struct commit_list *bases, *b;
> +
> +	bases = get_merge_bases(rev1, rev2, 1);
> +	for (b = bases; b != NULL; b = b->next) {
> +		if (!hashcmp(sha1, b->item->object.sha1)) {
> +			free_commit_list(bases);
> +			return 1;
> +		}
> +	}
> +
> +	free_commit_list(bases);
> +	return 0;

Make it cleaner for the future:
{
	int ret = 0;
	...
	for (b = bases; b; b = b->next) {
		if (!hashcmp(sha1, b->item->object.sha1)) {
			ret = 1;
			break;
		}
	}

	free_commit_list(bases);
	return ret;
}

> +}
> +
> +static void delete_branches(int argc, const char **argv, int force)
> +{
> +	struct commit *rev1, *rev2;
> +	unsigned char sha1[20];
> +	const char *p, *name;
> +	int i;
> +
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(head, argv[i]))
> +			die("Cannot delete the branch you are currently on.");
> +
> +		name = git_path("refs/heads/%s", argv[i]);
> +		p = resolve_ref(name, sha1, 1);
> +		if (p == NULL)
> +			die("Branch '%s' not found.", argv[i]);

p is unnecessary:
	if (!resolve_ref(name, sha1, 1))
		die(...);

> +
> +		rev1 = lookup_commit_reference(sha1);
> +		rev2 = lookup_commit_reference(head_sha1);

Are these both needed inside every iteration?

> +		if (!rev1 || !rev2)
> +			die("Couldn't look up commit objects.");
> +
> +		/* This checks wether the merge bases of branch and
> +		 * HEAD contains branch -- which means that the HEAD
> +		 * contains everything in both.
> +		 */
> +
> +		if (!force &&
> +		    !in_merge_bases(sha1, rev1, rev2)) {
> +			fprintf(stderr,
> +				"The branch '%s' is not a strict subset of your current HEAD.\n"
> +				"If you are sure you want to delete it, run 'git branch -D %s'.\n",
> +				argv[i], argv[i]);
> +			exit(1);
> +		}
> +
> +		unlink(name);
> +		printf("Deleted branch %s.\n", argv[i]);
> +	}
> +}
> +
> +static int show_reference(const char *refname, const unsigned char *sha1)
> +{
> +	int is_head = !strcmp(refname, head);
> +
> +	printf("%c %s\n", (is_head ? '*' : ' '), refname);
> +
> +	return 0;

Unnecessary variable

> +}
> +
> +static void create_branch (const char *name, const char *start, int force)

No space

		David
--413982040-564890857-1156146581=:17336--
