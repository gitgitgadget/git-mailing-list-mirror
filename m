Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837A7C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 23:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADAB20738
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 23:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JM5D/jro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgFXXpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:45:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38176 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731184AbgFXXpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 19:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593042348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pX1IBP+C+o1erPNnpyb5gB2xMptKybKShK3Jkp8wRG4=;
        b=JM5D/jrouCf735hOfzKmIAKY87ZGZeSYRlQEjs//gAPI0UptFV41ImEjtanbTnGgfNuxst
        VSBxfETJ0THm2EYA7xT46lcHdLk95Ua8OxTIOQLHqeU+TJb54nBAZF8Lj9a15UedYTw8QP
        ALJIspp8sbgUALXW1WICWt5QucoN7Q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-hVdXSg9LMRuCj00vKcSIeg-1; Wed, 24 Jun 2020 19:45:44 -0400
X-MC-Unique: hVdXSg9LMRuCj00vKcSIeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1B41464;
        Wed, 24 Jun 2020 23:45:43 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C66B160C87;
        Wed, 24 Jun 2020 23:45:42 +0000 (UTC)
Date:   Wed, 24 Jun 2020 19:45:39 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: restore --in-reply-to superseding behavior
Message-ID: <20200624234539.GH1987277@optiplex-lnx>
References: <20200624195520.2062298-1-aquini@redhat.com>
 <xmqqo8p85eud.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8p85eud.fsf@gitster.c.googlers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 02:33:14PM -0700, Junio C Hamano wrote:
> Rafael Aquini <aquini@redhat.com> writes:
> 
> > git send-email --in-reply-to= fails to override the email headers,
> > if they're present in the output of format-patch, which breakes the
> 
> Will do s/breakes/breaks/ while applying.
>

UGH! I've been fat-fingering typos the whole day, today... Sorry about
that one.

 
> It makes me wonder, however, why it is a good idea to have the I-R-T
> in the format patch output in the first place.
> 
> >  			elsif (/^In-Reply-To: (.*)/i) {
> > -				$in_reply_to = $1;
> > +				if (!$initial_in_reply_to) {
> > +					$in_reply_to = $1;
> > +				}
> 
> I can see how this would work the way it should for the first
> message we send out, so it would work well for a single patch.
> 
> But what does this change do to the chaining (either making [PATCH
> 1/N] thru [PATCH N/N] as responses to the cover letter [PATCH 0/N],
> or making [PATCH n+1/N] as response to [PATCH n/N] for 1 <= n < N)
> of multiple messages?
> 
> When you prepare a series whose 1..N/N are all pointing at 0/N with
> the already prepared In-Reply-To (so you have N+1 files to send
> out), wouldn't you want to make 0/N a reply to a particular message
> you specify on the command line, while keeping the relationship
> among your messages intact?  Doesn't having $initial_in_reply_to
> (i.e. command line override) help above code break the chaning?
>

This change will make all emails to appear as a reply to the msgid
fed to --in-reply-to. I see your point, though, and at its light 
I think now this patch, is actually incomplete. 

With this change we get back the override desired behavior,
but it also breaks the contract, according to the man page.

"
 --in-reply-to=<identifier>
     Make the first mail (or all the mails with --no-thread) appear as a reply to the given Message-Id, which
     avoids breaking threads to provide a new patch series. The second and subsequent emails will be sent as
     replies according to the --[no-]chain-reply-to setting.
"

I drove the change based on my usecase, which is marginal to the
multi-part reply case. 

I guess we just need the following, for a complete solution:



diff --git a/git-send-email.perl b/git-send-email.perl
index dc95656f75..768296ea0a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1699,10 +1699,14 @@ sub process_file {
 				$xfer_encoding = $1 if not defined $xfer_encoding;
 			}
 			elsif (/^In-Reply-To: (.*)/i) {
-				$in_reply_to = $1;
+				if (!$initial_in_reply_to || $thread) {
+					$in_reply_to = $1;
+				}
 			}
 			elsif (/^References: (.*)/i) {
-				$references = $1;
+				if (!$initial_in_reply_to || $thread) {
+					$references = $1;
+				}
 			}
 			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
 				push @xh, $_;

