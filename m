Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,UNPARSEABLE_RELAY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983121F461
	for <e@80x24.org>; Mon, 26 Aug 2019 11:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfHZL5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 07:57:18 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:50163 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfHZL5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 07:57:18 -0400
X-Envelope-From: stsp@stsp.name
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id x7QBvFfO006905
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 13:57:15 +0200
Received: from localhost (jessup.stsp.name [local])
        by jessup.stsp.name (OpenSMTPD) with ESMTPA id bb555b8d;
        Mon, 26 Aug 2019 13:57:15 +0200 (CEST)
Date:   Mon, 26 Aug 2019 13:57:15 +0200
From:   Stefan Sperling <stsp@stsp.name>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fix segv with corrupt tag object
Message-ID: <20190826115715.GB71935@jessup.stsp.name>
References: <20190824230944.GA14132@jessup.stsp.name>
 <bcc29199-a4ac-6bdc-6715-9807737253d8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcc29199-a4ac-6bdc-6715-9807737253d8@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 09:52:56AM +0200, René Scharfe wrote:
> Am 25.08.19 um 01:09 schrieb Stefan Sperling:
> > A tag object which lacks newlines won't be parsed correctly.
> > Git fails to detect this error and crashes due to a NULL deref:
> >
> > $ git archive 1.0.0
> > Segmentation fault (core dumped)
> > $ git checkout 1.0.0
> > Segmentation fault (core dumped)
> > $
> 
> Good find.
> 
> >
> > See the attached tarball for a reproduction repository.
> > Also mirrored at https://stsp.name/git-checkout-tag-segv-repo.tgz
> >
> > With the patch below:
> >
> > $ git checkout 1.0.0
> > fatal: reference is not a tree: 1.0.0
> > $ git archive 1.0.0
> > fatal: not a tree object: a99665eea5ee50171b5b7249880aa2ae35e35823
> > $
> 
> Sign-off?

Added in new patch below.

> > diff --git a/tree.c b/tree.c
> > index 4720945e6a..92d8bd57a3 100644
> > --- a/tree.c
> > +++ b/tree.c
> > @@ -252,9 +252,11 @@ struct tree *parse_tree_indirect(const struct object_id *oid)
> >  			return (struct tree *) obj;
> >  		else if (obj->type == OBJ_COMMIT)
> >  			obj = &(get_commit_tree(((struct commit *)obj))->object);
> > -		else if (obj->type == OBJ_TAG)
> > +		else if (obj->type == OBJ_TAG) {
> >  			obj = ((struct tag *) obj)->tagged;
> > -		else
> > +			if (!obj)
> > +				return NULL;
> > +		} else
> 
> OK.
> 
> There seem to be some more placed the use ->tagged without
> checking (found with "git grep -wW tagged"):
> 
>   builtin/describe.c::describe_commit()
>   builtin/fast-export.c::handle_tag()
>   builtin/log.c::cmd_show()
>   builtin/replace.c::check_one_mergetag()
>   fsck.c::fsck_walk_tag() -- I'm not sure about that one
>   log-tree.c::show_one_mergetag()
>   packfile.c::add_promisor_object()
>   ref-filter.c::populate_value()
>   ref-filter.c::match_points_at()
>   walker.c::process_tag()
> 
> Ugh!  Do you perhaps want to have a go at them as well?

I think fixing all those places (and future occurrences) would be
the wrong approach. Having an incompletely parsed object run
around in the program is a bad idea in the first place.

The root cause of this bug seems to be that the valid assumption
that obj->parsed implies a successfully parsed object is broken by
parse_tag_buffer() because this function sets the 'parsed' flag even
if errors occur during parsing.

So I think the proper fix would be something like the new patch below.

> >  			return NULL;
> >  		if (!obj->parsed)
> >  			parse_object(the_repository, &obj->oid);
> >
> 
> 
> Hmm, I find it a bit sad that this function is almost a duplicate of
> sha1-name.c::repo_peel_to_type(), which already checks for ->tagged
> being NULL.

I'll leave this for someone else to mop up.
With the patch below checking ->tagged for NULL becomes redundant.
Correct code should be checking for parse errors and/or ->parsed instead.

Regards,
Stefan

From b1928cf610f44a2453c1b68b915e6de071c0c01d Mon Sep 17 00:00:00 2001
From: Stefan Sperling <stsp@stsp.name>
Date: Mon, 26 Aug 2019 13:08:20 +0200
Subject: [PATCH] do not mark invalid tag objects as 'parsed'

Prevents segfaults due to use of incompletely parsed tag objects,
as observed e.g. when 'git checkout' is used with a corrupt tag
object which lacks newline characters.

Always error out for tags which don't have a known object type and hence
cannot be resolved. Callers of parse_tag_buffer() will crash trying to
dereference a NULL tag->tagged pointer.

Signed-off-by: Stefan Sperling <stsp@stsp.name>
---
 tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tag.c b/tag.c
index 5db870edb9..74d0cee34e 100644
--- a/tag.c
+++ b/tag.c
@@ -141,7 +141,6 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 
 	if (item->object.parsed)
 		return 0;
-	item->object.parsed = 1;
 
 	if (size < the_hash_algo->hexsz + 24)
 		return -1;
@@ -167,8 +166,8 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 	} else if (!strcmp(type, tag_type)) {
 		item->tagged = (struct object *)lookup_tag(r, &oid);
 	} else {
-		error("Unknown type %s", type);
 		item->tagged = NULL;
+		return error("Unknown type %s", type);
 	}
 
 	if (bufptr + 4 < tail && starts_with(bufptr, "tag "))
@@ -187,6 +186,7 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 	else
 		item->date = 0;
 
+	item->object.parsed = 1;
 	return 0;
 }
 
-- 
2.22.0

