Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUnRVM9v"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE461732
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 12:36:37 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5178830F29;
	Fri,  8 Dec 2023 15:36:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uf8JQ3FTgfB9DbU2iGI+rCyvT+cRkU3raCfuA3
	gVovE=; b=KUnRVM9vqSqXadYmkuOHlFXGgKOsMH/ksaDFeamlsz0lEF5iG2QYR/
	EaGXZEnH8+wNGGLg/zqf0Ewc+KiBE5U18vfjo9B1KSWo6ttujSmcWkCJwxKkLll6
	sU/SUg+xGbGF0YmHDomobjwej1m21ahs9d0kpS0s0iUWw6o66+qlE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 49E1630F28;
	Fri,  8 Dec 2023 15:36:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E078E30F27;
	Fri,  8 Dec 2023 15:36:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Britton Kerin <britton.kerin@gmail.com>
Subject: Re: [BUG] rev-list doesn't validate arguments to -n option
In-Reply-To: <CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com>
	(Britton Kerin's message of "Thu, 7 Dec 2023 13:12:01 -0900")
References: <CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com>
Date: Sat, 09 Dec 2023 05:36:30 +0900
Message-ID: <xmqqy1e41lf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 78B9294C-9609-11EE-A633-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Britton Kerin <britton.kerin@gmail.com> writes:

> It tolerates non-numeric arguments and garbage after a number:
>
> For example:
>
> $ # -n 1 means same as -n 0:
> $ git rev-list -n q newest_commit
> $ git rev-list -n 0 newest_commit
> $ # Garbage after number is tolerated:
> $ git rev-list -n 1q newest_commit
> 3be33f83695088d968cf084a1a08bdcde25a8d7a
> $ git rev-list -n 2q newest_commit
> 3be33f83695088d968cf084a1a08bdcde25a8d7a
> 286e62e1b68e39334978e6222cbff187ecc17bcf

Indeed, unlike the option parsing for most commands, "rev-list" and
"log" family of commands in the oldest part of the system still use
hand-crafted option parsing and most notably use atoi() instead of a
more robust strtol() family of functions.  The same issue is present
for parsing things like "--max-count=1q" and "--skip=1q".

Perhaps a change along this line, plus a few new tests, would
suffice.  There are others (like "--max-age" we see in the post
context of the patch) that use atoi() but they probably should not
share the same machinery (most importantly, the type of the value)
as "--max-count", so I didn't touch it in the below.

 revision.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git c/revision.c w/revision.c
index 00d5c29bfc..99e838bbd1 100644
--- c/revision.c
+++ w/revision.c
@@ -2223,6 +2223,15 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static int parse_count(const char *arg)
+{
+	int count;
+
+	if (strtol_i(arg, 10, &count) < 0 || count < 0)
+		die("'%s': not a non-negative integer", arg);
+	return count;
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2249,26 +2258,24 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	}
 
 	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
-		revs->max_count = atoi(optarg);
+		revs->max_count = parse_count(optarg);
 		revs->no_walk = 0;
 		return argcount;
 	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
-		revs->skip_count = atoi(optarg);
+		revs->skip_count = parse_count(optarg);
 		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
 		/* accept -<digit>, like traditional "head" */
-		if (strtol_i(arg + 1, 10, &revs->max_count) < 0 ||
-		    revs->max_count < 0)
-			die("'%s': not a non-negative integer", arg + 1);
+		revs->max_count = parse_count(arg + 1);
 		revs->no_walk = 0;
 	} else if (!strcmp(arg, "-n")) {
 		if (argc <= 1)
 			return error("-n requires an argument");
-		revs->max_count = atoi(argv[1]);
+		revs->max_count = parse_count(argv[1]);
 		revs->no_walk = 0;
 		return 2;
 	} else if (skip_prefix(arg, "-n", &optarg)) {
-		revs->max_count = atoi(optarg);
+		revs->max_count = parse_count(optarg);
 		revs->no_walk = 0;
 	} else if ((argcount = parse_long_opt("max-age", argv, &optarg))) {
 		revs->max_age = atoi(optarg);
