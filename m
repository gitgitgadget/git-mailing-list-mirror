Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529EC201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 01:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbdBRBSZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 20:18:25 -0500
Received: from avasout04.plus.net ([212.159.14.19]:46930 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbdBRBSW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 20:18:22 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id m1JB1u00222aPyA011JCSF; Sat, 18 Feb 2017 01:18:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=iKrn8l-KAAAA:8 a=AVuYBXsbilMcl9-jNMQA:9 a=QEXdDO2ut3YA:10
 a=vz8bQswTWcriz0i0jksL:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 02/19] builtin/diff-tree: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
 <20170218000652.375129-3-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3630da01-5af3-bc02-3a8c-1e3495512279@ramsayjones.plus.com>
Date:   Sat, 18 Feb 2017 01:18:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170218000652.375129-3-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/02/17 00:06, brian m. carlson wrote:
> Convert most leaf functions to struct object_id.  Rewrite several
> hardcoded numbers in terms of GIT_SHA1_HEXSZ, using an intermediate
> variable where that makes sense.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/diff-tree.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 8ce00480cd..1f1573bb2a 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -7,9 +7,9 @@
>  
>  static struct rev_info log_tree_opt;
>  
> -static int diff_tree_commit_sha1(const unsigned char *sha1)
> +static int diff_tree_commit_sha1(const struct object_id *oid)
>  {
> -	struct commit *commit = lookup_commit_reference(sha1);
> +	struct commit *commit = lookup_commit_reference(oid->hash);
>  	if (!commit)
>  		return -1;
>  	return log_tree_commit(&log_tree_opt, commit);
> @@ -18,22 +18,22 @@ static int diff_tree_commit_sha1(const unsigned char *sha1)
>  /* Diff one or more commits. */
>  static int stdin_diff_commit(struct commit *commit, char *line, int len)
>  {
> -	unsigned char sha1[20];
> -	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
> +	struct object_id oid;
> +	if (isspace(line[GIT_SHA1_HEXSZ]) && !get_oid_hex(line+GIT_SHA1_HEXSZ+1, &oid)) {
>  		/* Graft the fake parents locally to the commit */
> -		int pos = 41;
> +		int pos = GIT_SHA1_HEXSZ + 1;
>  		struct commit_list **pptr;
>  
>  		/* Free the real parent list */
>  		free_commit_list(commit->parents);
>  		commit->parents = NULL;
>  		pptr = &(commit->parents);
> -		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
> -			struct commit *parent = lookup_commit(sha1);
> +		while (line[pos] && !get_oid_hex(line + pos, &oid)) {
> +			struct commit *parent = lookup_commit(oid.hash);
>  			if (parent) {
>  				pptr = &commit_list_insert(parent, pptr)->next;
>  			}
> -			pos += 41;
> +			pos += GIT_SHA1_HEXSZ + 1;
>  		}
>  	}
>  	return log_tree_commit(&log_tree_opt, commit);
> @@ -42,11 +42,13 @@ static int stdin_diff_commit(struct commit *commit, char *line, int len)
>  /* Diff two trees. */
>  static int stdin_diff_trees(struct tree *tree1, char *line, int len)
>  {
> -	unsigned char sha1[20];
> +	struct object_id oid;
>  	struct tree *tree2;
> -	if (len != 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1))
> +	const int chunksz = GIT_SHA1_HEXSZ + 1;
> +	if (len != 2 * chunksz || !isspace(line[chunksz-1]) ||
> +		get_sha1_hex(line + chunksz, oid.hash))

I'm not sure that this is an improvement. The input expected in 'line'
is supposed to look like: '<sha1> + <space> + <sha1> + <\n>'. So your
'chunk' would be a <sha1> plus one 'char' of some sort. Except that the
caller of this function has already replaced the newline character with
a '\0' char (so strlen(line) would return 81), but still passes the
original line length! Also, note that this (and other functions in this
file) actually test for 'isspace(char)' rather than for a ' ' char!

Hmm, maybe just:

if (len < (2 * GIT_SHA1_HEXSZ + 1) || line[GIT_SHA1_HEXSZ] != ' ' ||
    get_sha1_hex(line + GIT_SHA1_HEXSZ + 1, oid.hash))

(or, perhaps, still call isspace() in this patch ...)

ATB,
Ramsay Jones

>  		return error("Need exactly two trees, separated by a space");
> -	tree2 = lookup_tree(sha1);
> +	tree2 = lookup_tree(oid.hash);
>  	if (!tree2 || parse_tree(tree2))
>  		return -1;
>  	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
> @@ -60,15 +62,15 @@ static int stdin_diff_trees(struct tree *tree1, char *line, int len)
>  static int diff_tree_stdin(char *line)
>  {
>  	int len = strlen(line);
> -	unsigned char sha1[20];
> +	struct object_id oid;
>  	struct object *obj;
>  
>  	if (!len || line[len-1] != '\n')
>  		return -1;
>  	line[len-1] = 0;
> -	if (get_sha1_hex(line, sha1))
> +	if (get_oid_hex(line, &oid))
>  		return -1;
> -	obj = parse_object(sha1);
> +	obj = parse_object(oid.hash);
>  	if (!obj)
>  		return -1;
>  	if (obj->type == OBJ_COMMIT)
> @@ -76,7 +78,7 @@ static int diff_tree_stdin(char *line)
>  	if (obj->type == OBJ_TREE)
>  		return stdin_diff_trees((struct tree *)obj, line, len);
>  	error("Object %s is a %s, not a commit or tree",
> -	      sha1_to_hex(sha1), typename(obj->type));
> +	      oid_to_hex(&oid), typename(obj->type));
>  	return -1;
>  }
>  
> @@ -141,7 +143,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  		break;
>  	case 1:
>  		tree1 = opt->pending.objects[0].item;
> -		diff_tree_commit_sha1(tree1->oid.hash);
> +		diff_tree_commit_sha1(&tree1->oid);
>  		break;
>  	case 2:
>  		tree1 = opt->pending.objects[0].item;
> @@ -164,9 +166,9 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  			opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
>  					       DIFF_SETUP_USE_CACHE);
>  		while (fgets(line, sizeof(line), stdin)) {
> -			unsigned char sha1[20];
> +			struct object_id oid;
>  
> -			if (get_sha1_hex(line, sha1)) {
> +			if (get_oid_hex(line, &oid)) {
>  				fputs(line, stdout);
>  				fflush(stdout);
>  			}
> 
