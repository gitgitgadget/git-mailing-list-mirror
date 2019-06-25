Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2A01F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfFYKwt (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:52:49 -0400
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:50294 "EHLO
        ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfFYKws (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:52:48 -0400
X-Greylist: delayed 1211 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 06:52:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk;
         s=20180806.ppsw; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date
        :Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tpDj5ORt7ReJ4PgjvoMRbMBbslkdI/G9+XtXQ12nGp0=; b=dXSPiNce4tPV3p7ZN0E879bsFW
        dgZ83vaGzVP6kO6pbl3bKXcRGHW9wcDzskgAdSIxrvArf8BxBN0mRjjpnocPEtr/gymljazvxf98T
        4dyFHWwr6ndG3O4fhe+hqudWrXPdGsRnos54IvunoYLGfhvjxZrnKq5rw1128jT9q9is=;
X-Cam-AntiVirus: not scanned (internal relaying)
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from webmail-1a.csi.cam.ac.uk ([131.111.9.32]:35252)
        by ppsw-40.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.138]:25)
        with esmtp id 1hfike-001p7J-lt (Exim 4.92)
        (return-path <nwf20@cam.ac.uk>); Tue, 25 Jun 2019 11:32:36 +0100
Received: from [127.0.0.1] (helo=webmail-1.hermes.cam.ac.uk)
        by webmail-1a.csi.cam.ac.uk with esmtp id 1hfike-0002Zu-R3 (Exim 4.92)
        (return-path <nwf20@cam.ac.uk>); Tue, 25 Jun 2019 11:32:36 +0100
Received: from methi.cl.cam.ac.uk ([128.232.65.72])
 by webmail-1.hermes.cam.ac.uk
 with HTTP (HTTP/1.1 POST); Tue, 25 Jun 2019 11:32:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-User: nwf20
Date:   Tue, 25 Jun 2019 11:32:36 +0100
From:   "Dr N.W. Filardo" <nwf20@cam.ac.uk>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/5] repack: optionally assume transitive kept packs
In-Reply-To: <fbbbbd2e-3f0f-ffbb-e617-220602c9950f@gmail.com>
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
 <20190624120711.27744-5-nwf20@cl.cam.ac.uk>
 <fbbbbd2e-3f0f-ffbb-e617-220602c9950f@gmail.com>
Message-ID: <62970caebf1e341f72e46c1f2f98fa09@cam.ac.uk>
X-Sender: nwf20@cam.ac.uk
User-Agent: Roundcube Webmail/1.0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-06-24 14:21, Derrick Stolee wrote:
> On 6/24/2019 8:07 AM, Nathaniel Filardo wrote:
>> If the user is careful to mark .pack files as kept only when they
>> refer
>> to (other) kept packs, then we can rely on this when walking the
>> object
>> graph in subsequent repack operations and reduce the time and memory
>> spent building the object graph.
>> 
>> Towards that end, then, teach git repack to enumerate the COMMITs and
>> TREEs in kept packs and mark them as UNINTERESTING for pack-object's
>> operation.  Because this creates UNINTERESTING marks, we make repack's
>> --assume-pack-keep-transitive imply --sparse for pack-object to avoid
>> hauling the entire object graph into memory.
>> 
>> In testing with a 203GB repository with 80M objects, this amounts to
>> several gigabytes of memory and over ten minutes saved.  This machine
>> has 32G of RAM and the repository is on a fast SSD to speed testing.
> 
> Thanks for the performance details!

Happy to provide.  Hopefully they justify my desire to see these patches
land in mainline. :)

>> All told, this test repository takes about 33 minutes elapsed (28
>> minutes in user code) and 3 GB of RAM to repack 12M objects occupying
>> 33GB scattered across 477 pack files not marked as kept (the remainder
>> of the objects are spread across three kept pack files).  The time and
>> RAM usage with --assume-pack-keep-transitive should be dominated by
>> factors proportional to the size and number of un-kept objects.
>> 
>> Without these optimizations, it takes about 45 minutes (34 minutes in
>> user code) and 7 GB of RAM to compute the same pack file.  The extra
>> time and total memory use are expected to be proportional to the kept
>> packs' size, not the working set of the repack.  The time discrepancy
>> can be expected to be more dramatic when the repository is on spinning
>> rust rather than SSD.
>> 
>> Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>
>> ---
>>  Documentation/git-repack.txt | 21 +++++++++++++
>>  builtin/repack.c             | 57
>> ++++++++++++++++++++++++++++++++++--
>>  2 files changed, 76 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/git-repack.txt
>> b/Documentation/git-repack.txt
>> index 836d81457a..014812c4bb 100644
>> --- a/Documentation/git-repack.txt
>> +++ b/Documentation/git-repack.txt
>> @@ -169,6 +169,27 @@ depth is 4095.
>>  	Pass the `--sparse` option to `git-pack-objects`; see
>>  	linkgit:git-pack-objects[1].
>> 
>> +--assume-pack-keep-transitive::
>> +	This flag accelerates the search for objects to pack by assuming
>> +	that commit objects found in kept packfiles make reference only
>> +	to that or other kept packfiles.  This is very useful if, for
>> +	example, this repository periodically repacks all reachable objects
>> +	and marks the resulting pack file as kept.
>> +
>> +	Because this option may prevent git from descending into kept packs,
>> +	no objects inside kept packs will be available for delta processing.
>> +	One should therefore restrict the use of this option to situations
>> +	where delta processing is disabled or when relatively large amounts
>> +	of data are considered and the relative gain of a wider set of
>> +	possible delta base objects is reduced.
>> +
>> +	The simplest way to ensure transitivity of kept packs is to run `git
>> +	repack` with `-a` (or `-A`) and `-d` and mark all resulting packs as
>> +	kept, never removing the kept marker.  In practice, one may wish to
>> +	wait to mark packs as kept until they are sufficiently large
>> +	(reducing the number of pack files necessary for a given set of
>> +	objects) but not so large as to be unwieldy.
>> +
>>  Configuration
>>  -------------
>> 
>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index 4cfdd62bb8..a2cd479686 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
>> @@ -11,6 +11,8 @@
>>  #include "midx.h"
>>  #include "packfile.h"
>>  #include "object-store.h"
>> +#include "revision.h"
>> +#include "list-objects.h"
>> 
>>  static int delta_base_offset = 1;
>>  static int pack_kept_objects = -1;
>> @@ -256,6 +258,30 @@ static void repack_promisor_objects(const struct
>> pack_objects_args *args,
>>  		die(_("could not finish pack-objects to repack promisor objects"));
>>  }
>> 
>> +static void apkt_show_commit(struct commit *commit, void *data)
>> +{
>> +	struct tree *tree;
>> +	struct pack_entry e;
>> +
>> +	if (!find_pack_entry(the_repository, &commit->object.oid, &e))
>> +		return;
>> +
>> +	if (!(e.p->pack_keep || e.p->pack_keep_in_core))
>> +		return;
>> +
>> +	tree = get_commit_tree(commit);
>> +	if (tree)
>> +		tree->object.flags |= UNINTERESTING;
>> +
>> +	write_oid(&commit->object.oid, e.p, 0, data);
>> +	write_oid(&tree->object.oid, NULL, 0, data);
>> +}
>> +
>> +static void apkt_show_object(struct object *obj, const char *name,
>> void *data)
>> +{
>> +	return;
>> +}
>> +
>>  #define ALL_INTO_ONE 1
>>  #define LOOSEN_UNREACHABLE 2
>> 
>> @@ -287,6 +313,7 @@ int cmd_repack(int argc, const char **argv, const
>> char *prefix)
>>  	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
>>  	int no_update_server_info = 0;
>>  	int midx_cleared = 0;
>> +	int assume_pack_keep_transitive = 0;
>>  	struct pack_objects_args po_args = {NULL};
>>  	int sparse = 0;
>> 
>> @@ -329,6 +356,8 @@ int cmd_repack(int argc, const char **argv, const
>> char *prefix)
>>  				N_("repack objects in packs marked with .keep")),
>>  		OPT_BOOL(0, "sparse", &sparse,
>>  			 N_("use the sparse reachability algorithm")),
>> +		OPT_BOOL(0, "assume-pack-keep-transitive",
>> &assume_pack_keep_transitive,
>> +				N_("assume kept packs reference only kept packs")),
>>  		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
>>  				N_("do not repack this pack")),
>>  		OPT_END()
>> @@ -346,6 +375,11 @@ int cmd_repack(int argc, const char **argv, const
>> char *prefix)
>>  	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
>>  		die(_("--keep-unreachable and -A are incompatible"));
>> 
>> +	if (assume_pack_keep_transitive) {
>> +		/* imply --honor-pack-keep */
>> +		pack_kept_objects = 0;
>> +	}
>> +
> 
> If you also set `sparse = 1;` here, then...

That seems reasonable.

>> -	if (sparse)
>> +	if (sparse || assume_pack_keep_transitive)
>>  		argv_array_push(&cmd.args, "--sparse");
> 
> ...this logic can stay the same. And be simpler.

Done.

>>  	if (repository_format_partial_clone)
>>  		argv_array_push(&cmd.args, "--exclude-promisor-objects");
>> @@ -407,12 +441,31 @@ int cmd_repack(int argc, const char **argv,
>> const char *prefix)
>>  		argv_array_push(&cmd.args, "--incremental");
>>  	}
>> 
>> -	cmd.no_stdin = 1;
>> +	cmd.in = -1;
>> +	cmd.no_stdin = !assume_pack_keep_transitive;
> 
> I wonder if this `cmd.in = -1;` needs to be here, or should be in
> the `if (assume_pack_keep_transitive)` block below.

It doesn't need to be, I suppose, but it seemed a little less subtle to
just assign it either way, as it will either be ignored or do the right
thing below.

>> 
>>  	ret = start_command(&cmd);
>>  	if (ret)
>>  		return ret;
>> 
>> +	if (assume_pack_keep_transitive) {
>> +		struct rev_info revs;
>> +		const char *revargv[] = { "skip", "--all", "--reflog",
>> "--indexed-objects", NULL };
>> +
>> +		repo_init_revisions(the_repository, &revs, NULL);
> 
>> +		revs.sparse_tree_walk = !!(sparse || assume_pack_keep_transitive);
> 
> Here is the bitflag! Excellent. Again, this can be simplified if we
> set `sparse = 1`
> in the first assume_pack_keep_transitive block.

In fact, maybe it should just be set to 1, because we're only here if...
.
I wonder if this is some cruft left over from how I developed the patch.
I'm OK with either "= 1" or "= sparse", as you prefer.

>> +		setup_revisions(sizeof(revargv)/sizeof(revargv[0]) - 1 , revargv,
>> &revs, NULL);
> 
> Some whitespace strangeness on this line.

Spurious space before , removed.

>> +		if (prepare_revision_walk(&revs))
>> +			die("revision walk setup failed");
> 
> This string should be localizable. It's not entirely your fault, since
> running
> 'git grep -A 1 prepare_revision_walk' shows a variety of different
> uses, most
> of which don't use the localizable string, but enough do that you could
> add it
> here.

Well, I'll try not to be a further bad example!

Thanks for the review.
--nwf;

