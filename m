Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A951F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 10:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750740AbdKLK1t (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 05:27:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:53766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750723AbdKLK1r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 05:27:47 -0500
Received: (qmail 19705 invoked by uid 109); 12 Nov 2017 10:27:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 10:27:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13607 invoked by uid 111); 12 Nov 2017 10:28:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 05:28:00 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 10:27:39 +0000
Date:   Sun, 12 Nov 2017 10:27:39 +0000
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] link_alt_odb_entries: make empty input a noop
Message-ID: <20171112102739.6xtnnsmtabhnhrm5@sigill.intra.peff.net>
References: <20171107192239.6hinu235hfpwqpv6@kitenet.net>
 <20171108075336.is4awgyw53dohf7y@sigill.intra.peff.net>
 <xmqqd14pef5q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd14pef5q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 11:13:21AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So totally orthogonal to your bug, I wonder if we ought to be doing:
> >
> > diff --git a/sha1_file.c b/sha1_file.c
> > index 057262d46e..0b76233aa7 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -530,11 +530,11 @@ void prepare_alt_odb(void)
> >  	if (alt_odb_tail)
> >  		return;
> >  
> > -	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> > -	if (!alt) alt = "";
> > -
> >  	alt_odb_tail = &alt_odb_list;
> > -	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
> > +
> > +	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> > +	if (alt)
> > +		link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
> >  
> >  	read_info_alternates(get_object_directory(), 0);
> >  }
> >
> > to avoid hitting link_alt_odb_entries() at all when there are no
> > entries.
> 
> Sounds sane.

Here it is as a real patch. I actually bumped the check into the
function itself, since it keeps the logic all in one place. And as a
bonus, we save work if you truly have an empty environment variable or
info/alternates file, though I don't expect those are very common. :)

I also rebased on top of dc732bd5cb (read_info_alternates: read contents
into strbuf, 2017-09-19), which had a trivial textual conflict.

This should make Joey's immediate pain go away, though only by papering
it over. I tend to agree that we shouldn't be looking at $PWD at all
here.

-- >8 --
Subject: [PATCH] link_alt_odb_entries: make empty input a noop

If an empty string is passed to link_alt_odb_entries(), our
loop finds no entries and we link nothing. But we still do
some preparatory work to normalize the object directory
path, even though we'll never look at the result. This
triggers in basically every git process, since we feed the
usually-empty ALTERNATE_DB_ENVIRONMENT to the function.

Let's detect early that there's nothing to do and return.
While we're at it, let's treat NULL the same as an empty
string as a favor to our callers. That saves
prepare_alt_odb() from having to cover this case.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index d708981376..8a7c6b7eba 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -404,6 +404,9 @@ static void link_alt_odb_entries(const char *alt, int sep,
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
 
+	if (!alt || !*alt)
+		return;
+
 	if (depth > 5) {
 		error("%s: ignoring alternate object stores, nesting too deep.",
 				relative_base);
@@ -604,7 +607,6 @@ void prepare_alt_odb(void)
 		return;
 
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
-	if (!alt) alt = "";
 
 	alt_odb_tail = &alt_odb_list;
 	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
-- 
2.15.0.413.g6cc52d366b

