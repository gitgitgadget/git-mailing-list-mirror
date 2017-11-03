Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA7A20450
	for <e@80x24.org>; Fri,  3 Nov 2017 15:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbdKCPM3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 11:12:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63828 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752122AbdKCPM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 11:12:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E35E5A62E9;
        Fri,  3 Nov 2017 11:12:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qa7pZJRFf0AaVXX3MNgZdBHCOAI=; b=HIrINL
        sBWk5SSt9n7AwxXbjhNKuayGZZ36yq2tREXTj8kfOCiZRtu88ZyHoByL5F3RH9c6
        TXqGaIRH4cD7HO11tZ+sJKDJ/CVR6pSI6+poQyUAVpTWt+rYJ3Fe2tEzVvUg0Nsy
        0AYZ/WxSHoK+fAxa6A+N4Kpy9cbA2bI3JNl94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fto0IGp90FgCRY4G34gqY5J0HPQfSOf4
        Fnz9FVEuapK5L93QzRVXnPiVag7Ys0T7Xh+Yp5ivi4Wnp/Fa/1XNNuvjhfy3bP8t
        LCsxpWtOJbMZaPW1BNPRPkfbJ1F/iHkqZc9OiYGso9Fcj/xlhITOvvo029VW/ZDA
        9PsPdjaip5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9D5EA62E7;
        Fri,  3 Nov 2017 11:12:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41FE3A62E6;
        Fri,  3 Nov 2017 11:12:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/14] WIP Partial clone part 3: clone, fetch, fetch-pack, upload-pack, and tests
References: <20171102203129.59417-1-git@jeffhostetler.com>
Date:   Sat, 04 Nov 2017 00:12:25 +0900
In-Reply-To: <20171102203129.59417-1-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Thu, 2 Nov 2017 20:31:15 +0000")
Message-ID: <xmqqy3nno0py.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67516BE2-C0A9-11E7-985B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This is part 3 of 3 for partial clone.
> It assumes that part 1 [1] and part 2 [2] are in place.

Thanks.  As planned these replaced the partial clone with size
filter thing from Jonathan.  The resulting integration passed the
tests locally so I pushed it out.

By the way, the enhancement in this series made to list-objects.c
had a bit of interaction with the last round of Stefan's "describe
blob" topic when both were merged to 'pu'.  I think I resolved it
correctly, but the merge resolution can use extra sets of eyes.

diff --cc list-objects.c
index 5390a7440d,07a92f35fe..e05de01af1
--- a/list-objects.c
+++ b/list-objects.c
@@@ -220,32 -183,20 +220,22 @@@ static void add_pending_tree(struct rev
  	add_pending_object(revs, &tree->object, "");
  }
  
- static void do_traverse(struct rev_info *revs,
- 			show_commit_fn show_commit,
- 			show_object_fn show_object,
- 			void *show_data,
- 			filter_object_fn filter_fn,
- 			void *filter_data)
+ static void traverse_trees_and_blobs(struct rev_info *revs,
+ 				     struct strbuf *base,
+ 				     show_object_fn show_object,
 -				     void *data)
++				     void *show_data,
++				     filter_object_fn filter_fn,
++				     void *filter_data)
  {
  	int i;
- 	struct commit *commit;
- 	struct strbuf base;
  
- 	strbuf_init(&base, PATH_MAX);
- 	while ((commit = get_revision(revs)) != NULL) {
- 		/*
- 		 * an uninteresting boundary commit may not have its tree
- 		 * parsed yet, but we are not going to show them anyway
- 		 */
- 		if (commit->tree)
- 			add_pending_tree(revs, commit->tree);
- 		show_commit(commit, show_data);
- 	}
 -	assert(base->len == 0);
 -
++	assert(!base->len);
  	for (i = 0; i < revs->pending.nr; i++) {
  		struct object_array_entry *pending = revs->pending.objects + i;
  		struct object *obj = pending->item;
  		const char *name = pending->name;
  		const char *path = pending->path;
++
  		if (obj->flags & (UNINTERESTING | SEEN))
  			continue;
  		if (obj->type == OBJ_TAG) {
@@@ -257,47 -208,41 +247,76 @@@
  			path = "";
  		if (obj->type == OBJ_TREE) {
  			process_tree(revs, (struct tree *)obj, show_object,
- 				     &base, path, show_data,
 -				     base, path, data);
++				     base, path, show_data,
 +				     filter_fn, filter_data);
  			continue;
  		}
  		if (obj->type == OBJ_BLOB) {
  			process_blob(revs, (struct blob *)obj, show_object,
- 				     &base, path, show_data,
 -				     base, path, data);
++				     base, path, show_data,
 +				     filter_fn, filter_data);
  			continue;
  		}
  		die("unknown pending object %s (%s)",
  		    oid_to_hex(&obj->oid), name);
  	}
  	object_array_clear(&revs->pending);
- 	strbuf_release(&base);
+ }
+ 
 -void traverse_commit_list(struct rev_info *revs,
 -			  show_commit_fn show_commit,
 -			  show_object_fn show_object,
 -			  void *data)
++static void do_traverse(struct rev_info *revs,
++			show_commit_fn show_commit,
++			show_object_fn show_object,
++			void *show_data,
++			filter_object_fn filter_fn,
++			void *filter_data)
+ {
+ 	struct commit *commit;
+ 	struct strbuf csp; /* callee's scratch pad */
 -	strbuf_init(&csp, PATH_MAX);
+ 
++	strbuf_init(&csp, PATH_MAX);
+ 	while ((commit = get_revision(revs)) != NULL) {
+ 		/*
+ 		 * an uninteresting boundary commit may not have its tree
+ 		 * parsed yet, but we are not going to show them anyway
+ 		 */
+ 		if (commit->tree)
+ 			add_pending_tree(revs, commit->tree);
 -		show_commit(commit, data);
++		show_commit(commit, show_data);
+ 		if (revs->tree_blobs_in_commit_order)
 -			traverse_trees_and_blobs(revs, &csp, show_object, data);
++			traverse_trees_and_blobs(revs, &csp,
++						 show_object, show_data,
++						 filter_fn, filter_data);
+ 	}
 -	traverse_trees_and_blobs(revs, &csp, show_object, data);
 -
++	traverse_trees_and_blobs(revs, &csp,
++				 show_object, show_data,
++				 filter_fn, filter_data);
+ 	strbuf_release(&csp);
  }
 +
 +void traverse_commit_list(struct rev_info *revs,
 +			  show_commit_fn show_commit,
 +			  show_object_fn show_object,
 +			  void *show_data)
 +{
 +	do_traverse(revs, show_commit, show_object, show_data, NULL, NULL);
 +}
 +
 +void traverse_commit_list_filtered(
 +	struct list_objects_filter_options *filter_options,
 +	struct rev_info *revs,
 +	show_commit_fn show_commit,
 +	show_object_fn show_object,
 +	void *show_data,
 +	struct oidset *omitted)
 +{
 +	filter_object_fn filter_fn = NULL;
 +	filter_free_fn filter_free_fn = NULL;
 +	void *filter_data = NULL;
 +
 +	filter_data = list_objects_filter__init(omitted, filter_options,
 +						&filter_fn, &filter_free_fn);
 +	do_traverse(revs, show_commit, show_object, show_data,
 +		    filter_fn, filter_data);
 +	if (filter_data && filter_free_fn)
 +		filter_free_fn(filter_data);
 +}
