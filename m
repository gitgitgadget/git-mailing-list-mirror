Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF971F859
	for <e@80x24.org>; Sun,  7 Aug 2016 05:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbcHGFMv (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 01:12:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39292 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbcHGFMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 01:12:50 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B55E83F38;
	Sun,  7 Aug 2016 05:12:28 +0000 (UTC)
Received: from redhat.com (vpn1-7-9.ams2.redhat.com [10.36.7.9])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u775CObk027037;
	Sun, 7 Aug 2016 01:12:25 -0400
Date:	Sun, 7 Aug 2016 08:12:23 +0300
From:	"Michael S. Tsirkin" <mst@redhat.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Martin Fick <mfick@codeaurora.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Subject: Re: storing cover letter of a patch series?
Message-ID: <20160807080857-mutt-send-email-mst@kernel.org>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
 <18979417.pyyHNUINeQ@mfick1-lnx>
 <xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
 <20160804234920.GA27250@redhat.com>
 <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 07 Aug 2016 05:12:28 +0000 (UTC)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 05, 2016 at 08:39:58AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Sep 10, 2015 at 11:39:49AM -0700, Junio C Hamano wrote:
> >> The problem with "empty commit trick" is that it is a commit whose
> >> sole purpose is to describe the series, and its presence makes it
> >> clear where the series ends, but the topology does not tell where
> >> the series begins, so it is an unsatisifactory half-measure.
> >
> > Actually, when using topic branches the series always ends at head, so
> > it's better to keep the empty commit where series begins.
> 
> But that would mean that you would need to destroy and recreate more
> commits than you would need to.  If you have a five-commit series
> (with the bottom "description" one, you would have six commits) and
> you are already happy with the bottom two but want to update the
> third one, you wuld have to "rebase -i" all six of them, reword the
> bottom "description" to adjust it to describe the new version of the
> third one _before_ you even do the actual update of the third one.
> 
> That somehow feels backwards, and that backward-ness comes from the
> fact that you abused a single-parent commit for the purpose it is
> not meant to be used (i.e. they are to describe individual changes),
> because you did not find a better existing mechanism (and I suspect
> there isn't any, in which case the solution is to invent one, not
> abusing an existing mechanism that is not suited for it).

A flag that marks a commit "beginning of series" then?

> If this were part of a workflow like this, I would understand it:
> 
>  * Build a N-commit series on a topic.
> 
>  * You keep a "local integration testing" branch ("lit"), forked
>    from a mainline and updated _every time_ you do something to your
>    topics.  You may or may not publish this branch.  This is the
>    aggregation of what you locally have done, a convenient place to
>    test individual topics together before they get published.

This seems to assume topic branches. I know you use them,
but not overyone does, I don't.

>  * A new topic, when you merge it to the "lit" branch, you describe
>    the cover as the merge commit message.
> 
>  * When you updated an existing topic, you tell a tool like "rebase
>    -i -p" to recreate "lit" branch on top of the mainline.  This
>    would give you an opportunity to update the cover.

Combining patchsets might need conflict resolution,
redoing this each time might be a lot of work.

> Now the tool support for the last one is the missing piece.  In
> addition to what "rebase -i -p" would, it at least need to
> automatically figure out which topics have been updated, so that
> their merge commit log messages need to be given in the editor to
> update, while carrying over the merge log message for other topics
> intact (by default).
> 
> With that, you should also be able to teach "format-patch --cover"
> to take these merge messages on "lit" into account when it creates
> the cover letter.
