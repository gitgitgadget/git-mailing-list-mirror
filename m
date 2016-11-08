Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4142022A
	for <e@80x24.org>; Tue,  8 Nov 2016 00:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbcKHAal (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:30:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:40001 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbcKHAah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:30:37 -0500
Received: (qmail 21534 invoked by uid 109); 8 Nov 2016 00:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 00:30:37 +0000
Received: (qmail 17659 invoked by uid 111); 8 Nov 2016 00:31:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 19:31:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 19:30:34 -0500
Date:   Mon, 7 Nov 2016 19:30:34 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
Message-ID: <20161108003034.apydvv3bav3s7ehq@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
 <CAGyf7-HWAMF8S+Bw3wcwJCS1Subc28KHjpSCc1__0qn-GSMyvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-HWAMF8S+Bw3wcwJCS1Subc28KHjpSCc1__0qn-GSMyvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 03:42:35PM -0800, Bryan Turner wrote:

> > @@ -335,7 +340,9 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
> >         }
> >
> >         strbuf_add_absolute_path(&objdirbuf, get_object_directory());
> > -       normalize_path_copy(objdirbuf.buf, objdirbuf.buf);
> > +       if (strbuf_normalize_path(&objdirbuf) < 0)
> > +               die("unable to normalize object directory: %s",
> > +                   objdirbuf.buf);
> 
> This appears to break the ability to use a relative alternate via an
> environment variable, since normalize_path_copy_len is explicitly
> documented "Returns failure (non-zero) if a ".." component appears as
> first path"

That shouldn't happen, though, because the path we are normalizing has
been converted to an absolute path via strbuf_add_absolute_path. IOW, if
your relative path is "../../../foo", we should be feeding something
like "/path/to/repo/.git/objects/../../../foo" and normalizing that to
"/path/to/foo".

But in your example, you see:

  error: unable to normalize alternate object path: ../0/objects

which cannot come from the code above, which calls die(). It should be
coming from the call in link_alt_odb_entry().

I think what is happening is that relative paths via environment
variables have always been slightly broken, but happened to mostly work.
In prepare_alt_odb(), we call link_alt_odb_entries() with a NULL
relative_base. That function does two things with it:

  - it may unconditionally dereference it for an error message, which
    would cause a segfault. This is impossible to trigger in practice,
    though, because the error message is related to the depth, which we
    know will always be 0 here.

  - we pass the NULL along to the singular link_alt_odb_entry().
    That function only creates an absolute path if given a non-NULL
    relative_base; otherwise we have always fed the path to
    normalize_path_copy, which is nonsense for a relative path.

    So normalize_path_copy() was _always_ returning an error there, but
    we ignored it and used whatever happened to be left in the buffer
    anyway. And because of the way normalize_path_copy() is implemented,
    that happened to be the untouched original string in most cases. But
    that's mostly an accident. I think it would not be for something
    like "foo/../../bar", which is technically valid (if done from a
    relative base that has at least one path component).

    Moreover, it means we don't have an absolute path to our alternate
    odb. So the path is taken as relative whenever we do an object
    lookup, meaning it will behave differently between a bare repository
    (where we chdir to $GIT_DIR) and one with a working tree (where we
    are generally in the root of the working tree). It can even behave
    differently in the same process if we chdir between object lookups.

So it did happen to work, but I'm not sure it was planned (and obviously
we have no test coverage for it). More on that below.

> Other commits, like [1], suggest the ability to use relative paths in
> alternates is something still actively developed and enhanced. Is it
> intentional that this breaks the ability to use relative alternates?
> If this is to be the "new normal", is there any other option when
> using environment variables besides using absolute paths?

No, I had no intention of disallowing relative alternates (and as you
noticed, a commit from the same series actually expands the use of
relative alternates). My use has been entirely within info/alternates
files, though, not via the environment.

As I said, I'm not sure this was ever meant to work, but as far as I can
tell it mostly _has_ worked, modulo some quirks. So I think we should
consider it a regression for it to stop working in v2.11.

The obvious solution is one of:

  1. Stop calling normalize() at all when we do not have a relative base
     and the path is not absolute. This restores the original quirky
     behavior (plus makes the "foo/../../bar" case work).

     If we want to do the minimum before releasing v2.11, it would be
     that. I'm not sure it leaves things in a very sane state, but at
     least v2.11 does no harm, and anybody who cares can build saner
     semantics for v2.12.

  2. Fix it for real. Pass a real relative_base when linking from the
     environment. The question is: what is the correct relative base? I
     suppose "getcwd() at the time we prepare the alt odb" is
     reasonable, and would behave similarly to older versions ($GIT_DIR
     for bare repos, top of the working tree otherwise).

     If we were designing from scratch, I think saner semantics would
     probably be always relative from $GIT_DIR, or even always relative
     from the object directory (i.e., behave as if the paths were given
     in objects/info/alternates). But that breaks compatibility with
     older versions. If we are treating this as a regression, it is not
     very friendly to say "you are still broken, but you might just need
     to add an extra '..' to your path".

So I dunno. I guess that inclines me towards (1), as it lets us punt on
the harder question.

-Peff
