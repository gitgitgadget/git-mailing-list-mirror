Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3C320445
	for <e@80x24.org>; Fri, 13 Oct 2017 14:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbdJMOUI (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 10:20:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:52146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753415AbdJMOUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 10:20:07 -0400
Received: (qmail 23244 invoked by uid 109); 13 Oct 2017 14:20:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 14:20:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25664 invoked by uid 111); 13 Oct 2017 14:20:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 10:20:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 10:20:05 -0400
Date:   Fri, 13 Oct 2017 10:20:05 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
Subject: Re: git-clone causes out of memory
Message-ID: <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
References: <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
 <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
 <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
 <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
 <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
 <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
 <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
 <20171013135636.o2vhktt7aqx6luuy@sigill.intra.peff.net>
 <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 10:10:18AM -0400, Jeff King wrote:

> Hmm. So this patch makes it go fast:
> 
> diff --git a/revision.c b/revision.c
> index d167223e69..b52ea4e9d8 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -409,7 +409,7 @@ static void file_add_remove(struct diff_options *options,
>  	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
>  
>  	tree_difference |= diff;
> -	if (tree_difference == REV_TREE_DIFFERENT)
> +	if (tree_difference & REV_TREE_DIFFERENT)
>  		DIFF_OPT_SET(options, HAS_CHANGES);
>  }
>  
> 
> But that essentially makes the conditional a noop (since we know we set
> either NEW or OLD above and DIFFERENT is the union of those flags).
> 
> I'm not sure I understand why file_add_remove() would ever want to avoid
> setting HAS_CHANGES (certainly its companion file_change() always does).
> This goes back to Junio's dd47aa3133 (try-to-simplify-commit: use
> diff-tree --quiet machinery., 2007-03-14).
> 
> Maybe I am missing something, but AFAICT this was always buggy. But
> since it only affects adds and deletes, maybe nobody noticed? I'm also
> not sure if it only causes a slowdown, or if this could cause us to
> erroneously mark something as TREESAME which isn't (I _do_ think people
> would have noticed that).

Answering my own question a little, there is a hint in the comment
a few lines above:

  /*
   * The goal is to get REV_TREE_NEW as the result only if the
   * diff consists of all '+' (and no other changes), REV_TREE_OLD
   * if the whole diff is removal of old data, and otherwise
   * REV_TREE_DIFFERENT (of course if the trees are the same we
   * want REV_TREE_SAME).
   * That means that once we get to REV_TREE_DIFFERENT, we do not
   * have to look any further.
   */

So my patch above is breaking that. But it's not clear from that comment
why we care about knowing the different between NEW, OLD, and DIFFERENT.

Grepping around for REV_TREE_NEW and REV_TREE_OLD, I think the answer is
in try_to_simplify_commit():

     case REV_TREE_NEW:
              if (revs->remove_empty_trees &&
                  rev_same_tree_as_empty(revs, p)) {
                      /* We are adding all the specified
                       * paths from this parent, so the
                       * history beyond this parent is not
                       * interesting.  Remove its parents
                       * (they are grandparents for us).
                       * IOW, we pretend this parent is a
                       * "root" commit.
                       */
                      if (parse_commit(p) < 0)
                              die("cannot simplify commit %s (invalid %s)",
                                  oid_to_hex(&commit->object.oid),
                                  oid_to_hex(&p->object.oid));
                      p->parents = NULL;
              }
    /* fallthrough */
    case REV_TREE_OLD:
    case REV_TREE_DIFFERENT:

So when --remove-empty is not in effect (and it's not by default), we
don't care about OLD vs NEW, and we should be able to optimize further.

-Peff
