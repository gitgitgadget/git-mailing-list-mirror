Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5577D1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeKMCDF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 21:03:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:36010 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729553AbeKMCDF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 21:03:05 -0500
Received: (qmail 32484 invoked by uid 109); 12 Nov 2018 16:09:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 16:09:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12691 invoked by uid 111); 12 Nov 2018 16:08:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 11:08:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 11:09:10 -0500
Date:   Mon, 12 Nov 2018 11:09:10 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Geert Jansen <gerardu@amazon.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 6/9] sha1-file: use an object_directory for the main
 object dir
Message-ID: <20181112160910.GA7612@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145039.GF7400@sigill.intra.peff.net>
 <421d3b43-3425-72c9-218e-facd86e28267@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <421d3b43-3425-72c9-218e-facd86e28267@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 10:48:36AM -0500, Derrick Stolee wrote:

> > If the "the first one is the main store, the rest are alternates" bit is
> > too subtle, we could mark each "struct object_directory" with a bit for
> > "is_local".
> 
> This is probably a good thing to do proactively. We have the equivalent in
> the packed_git struct, but that's also because they get out of order. At the
> moment, I can't think of a read-only action that needs to treat the local
> object directory more carefully. The closest I know about is 'git
> pack-objects --local', but that also writes a pack-file.
> 
> I assume that when we write a pack-file to the "default location" we use
> get_object_directory() instead of referring to the default object_directory?

Generally, yes, though that should eventually be going away in favor of
accessing it via a "struct repository". And after my series,
get_object_directory() is just returning the_repository->objects->odb->path
(i.e., using the "first one is main" rule).

One thing that makes me nervous about a "local" flag in each struct is
that it implies that it's the source of truth for where to write to. So
what does git_object_directory() look like after that? Do we leave it
with the "first one is main" rule? Or does it become:

  for (odb = the_repository->objects->odb; odb; odb = odb->next) {
	if (odb->local)
		return odb->path;
  }
  return NULL; /* yikes? */

? That feels like it's making things more complicated, not less.

> > diff --git a/packfile.c b/packfile.c
> > index d6d511cfd2..1eda33247f 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -970,12 +970,12 @@ static void prepare_packed_git(struct repository *r)
> >   	if (r->objects->packed_git_initialized)
> >   		return;
> > -	prepare_multi_pack_index_one(r, r->objects->objectdir, 1);
> > -	prepare_packed_git_one(r, r->objects->objectdir, 1);
> > +
> >   	prepare_alt_odb(r);
> > -	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
> > -		prepare_multi_pack_index_one(r, odb->path, 0);
> > -		prepare_packed_git_one(r, odb->path, 0);
> > +	for (odb = r->objects->odb; odb; odb = odb->next) {
> > +		int local = (odb == r->objects->odb);
> 
> Here seems to be a place where `odb->is_local` would help.

Yes, though I don't mind this spot in particular, as the check is pretty
straight-forward.

I think an example that would benefit more is the check_and_freshen()
stuff. There we have two almost-the-same wrappers, one of which operates
on just the first element of the list, and the other of which operates
on all of the elements after the first.

It could become:

  static int check_and_freshen_odb(struct object_directory *odb_list,
				   const struct object_id *oid,
				   int freshen,
				   int local)
  {
	struct object_directory *odb;

	for (odb = odb_list; odb; odb = odb->next) {
		static struct strbuf path = STRBUF_INIT;

		if (odb->local != local)
			continue;

		odb_loose_path(odb, &path, oid->hash);
		return check_and_freshen_file(path.buf, freshen);
	}
  }

  int check_and_freshen_local(const struct object_id *oid, int freshen)
  {
	return check_and_freshen_odb(the_repository->objects->odb, oid,
				     freshen, 1);
  }

  int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
  {
	return check_and_freshen_odb(the_repository->objects->odb, oid,
				     freshen, 0);
  }

I'm not sure that is a big improvement over the patch we're replying to,
though.

-Peff
