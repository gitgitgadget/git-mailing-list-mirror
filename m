Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C7F20A04
	for <e@80x24.org>; Thu, 25 May 2017 15:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165362AbdEYP7g (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 11:59:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:57962 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164811AbdEYP73 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 11:59:29 -0400
Received: (qmail 11246 invoked by uid 109); 25 May 2017 15:59:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 15:59:26 +0000
Received: (qmail 21321 invoked by uid 111); 25 May 2017 16:00:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 12:00:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 May 2017 11:59:24 -0400
Date:   Thu, 25 May 2017 11:59:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?utf-8?B?RsOpbGl4?= Saparelli <felix@passcod.name>,
        git@vger.kernel.org
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch
 tries to check out the master branch
Message-ID: <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net>
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
 <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
 <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
 <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
 <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>
 <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 12:13:03PM +0900, Junio C Hamano wrote:

> >> So if we wanted to improve this, I think the first step would be for the
> >> server to start sending symref lines for HEAD, even when it does not
> >> resolve to anything.
> >
> > Yup, noticed the same and I agree with your conclusion.
> 
> We probably should make head_ref_namespaced() to take the
> resolve_flags that is passed down thru refs_read_ref_full() down to
> refs_resolve_ref_unsafe().  For the purpose of the first call to it
> in upload-pack.c to call back find_symref(), we do not need and want
> to say RESOLVE_REF_READING (which requires a symref to be pointing
> at an existing ref).  I suspect all the other calls (there are 2
> other in unload-pack.c and yet another in http-backend.c) to the
> function should keep passing RESOLVE_REF_READING, as they do want to
> omit a symbolic ref that points at an unborn branch.

That would make head_ref() not function-pointer compatible with all the
other for_each_ref functions. I don't know how much that matters. The
revision.c parser does use function pointers, but it doesn't handle HEAD
specially.

So I kind of wonder if that code should simply be calling
resolve_ref_unsafe() itself in the first place. We know the only value
it's going to get is HEAD.

OTOH, it's possible that we would eventually want to report all symrefs,
including ones we find while traversing the refs. And in that sense, all
of the for_each_ref functions would want to learn about this. But for
ref advertisement I think that would need a protocol change anyway, so
I'm not sure it's worth worrying about.

The just-HEAD case could look like:

diff --git a/upload-pack.c b/upload-pack.c
index 97da13e6a..04a913ad1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -959,28 +959,25 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int find_symref(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+static void find_symref(const char *refname, struct string_list *out)
 {
 	const char *symref_target;
 	struct string_list_item *item;
 	struct object_id unused;
+	int flag;
 
-	if ((flag & REF_ISSYMREF) == 0)
-		return 0;
 	symref_target = resolve_ref_unsafe(refname, 0, unused.hash, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
-		die("'%s' is a symref but it is not?", refname);
-	item = string_list_append(cb_data, refname);
+		return;
+	item = string_list_append(out, refname);
 	item->util = xstrdup(symref_target);
-	return 0;
 }
 
 static void upload_pack(void)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
 
-	head_ref_namespaced(find_symref, &symref);
+	find_symref("HEAD", &symref);
 
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
