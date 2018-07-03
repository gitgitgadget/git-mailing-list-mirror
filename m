Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0423C1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeGCV70 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:59:26 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:42558 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753180AbeGCV7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:59:25 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1faTKS-00032B-N2; Wed, 04 Jul 2018 06:59:20 +0900
Date:   Wed, 4 Jul 2018 06:59:20 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fast-import: Don't count delta attempts against an empty
 buffer
Message-ID: <20180703215920.wjzhhp5yn3mt6rqw@glandium.org>
References: <20180630214106.19848-1-mh@glandium.org>
 <xmqqmuv8qhzt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmuv8qhzt.fsf@gitster-ct.c.googlers.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 11:41:42AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > When the reference buffer is empty, diff_delta returns NULL without
> > really attempting anything, yet fast-import counts that as a delta
> > attempt.
> 
> But that is an attempt nevertheless, no?  Attempted and failed to
> find anything useful, that is.  What problem are you trying to solve
> and what issue are you trying to address, exactly?
> 
> ... goes and reads the patch ...
> 
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  fast-import.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fast-import.c b/fast-import.c
> > index 4d55910ab9..12195d54d7 100644
> > --- a/fast-import.c
> > +++ b/fast-import.c
> > @@ -1076,7 +1076,7 @@ static int store_object(
> >  		return 1;
> >  	}
> >  
> > -	if (last && last->data.buf && last->depth < max_depth
> > +	if (last && last->data.len && last->data.buf && last->depth < max_depth
> >  		&& dat->len > the_hash_algo->rawsz) {
> >  
> >  		delta_count_attempts_by_type[type]++;
> 
> This is a misleading patch as the title and the proposed log message
> both talk about "attempts are counted but we didn't actually do
> anything", implying that the only problem is that the counter is not
> aligned with reality.  The fact that the post-context we see here
> only shows the "counting" part does not help us, either.
> 
> But the next line in the post-context is actually code that does
> something important, which is ...
> 
> 		delta = diff_delta(last->data.buf, last->data.len,
> 			dat->buf, dat->len,
> 			&deltalen, dat->len - the_hash_algo->rawsz);
> 	} else
> 		delta = NULL;
> 
> 
> ... and makes the reader realize that the change itself is much
> better than the patch with 3-line context, the title, and the
> proposed log message advertises it as ;-)
> 
> How about selling it this way instead?
> 
> 	fast-import: do not call diff_delta() with empty buffer
> 
> 	We know diff_delta() returns NULL, saying "no good delta
> 	exists for it", when fed an empty data.  Check the length of
> 	the data in the caller to avoid such a call.  
> 
> 	This incidentally reduces the number of attempted deltification
> 	we see in the final statistics.
> 
> or something like that?

Fair enough. Do you want me to send a v2 with this description?

Mike
