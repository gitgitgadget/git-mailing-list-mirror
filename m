Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE781F461
	for <e@80x24.org>; Tue, 27 Aug 2019 00:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfH0AZi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 20:25:38 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45658 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfH0AZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 20:25:38 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1i2PIi-0007FP-Sz; Tue, 27 Aug 2019 09:25:32 +0900
Date:   Tue, 27 Aug 2019 09:25:32 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] packfile: free packed_git memory when closing object
 store
Message-ID: <20190827002532.aqjbik6haoa5axhj@glandium.org>
References: <20190826024508.8444-1-mh@glandium.org>
 <xmqqftlnhkd6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftlnhkd6.fsf@gitster-ct.c.googlers.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 11:06:29AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  packfile.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > Note, I'm not sure this is the right place to do it.
> 
> I do not think this patch is complete, given that o->packed_git
> still has a non-NULL pointer.  IIRC, close_pack() was written for
> the explicit purpose of releasing resources while allowing us to
> reopen with open_packed_git() on it, so with the current
> arrangement, after releasing the resources held for this object
> store and doing something else, you should be able to come back to
> this object store and work in it again---this patch makes it harder
> if not impossible to do so.
> 
> I _think_ the patch is OK if you assigned NULL to o->packed_git,
> after making sure that the intention of all the callers of
> close_object_store() is to declare that this object store will not
> be accessed any longer during the lifetime of the process, and write
> it down as the contract between the callers and this function in a
> comment perhaps in packfile.h where the function is declared.

Maybe it would make more sense to do the complete cleanup in
raw_object_store_clear, then?

Relatedly, while looking around the other things that close_object_store
does, I saw that multi_pack_index is a sort of linked list... and
close_midx doesn't follow the links. Which raises the question whether
it should, or whether close_object_store should (considering it's
similar to packed_git in that regard, it would seem like
close_object_store should). It also raises the question what should be
free()ing multi_pack_index, because like packed_git, it's not free()d.

Mike
