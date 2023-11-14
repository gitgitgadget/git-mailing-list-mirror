Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDB2E829
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCD0D7
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 14:04:36 -0800 (PST)
Received: (qmail 3792 invoked by uid 109); 14 Nov 2023 22:04:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Nov 2023 22:04:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21004 invoked by uid 111); 14 Nov 2023 22:04:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Nov 2023 17:04:37 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Nov 2023 17:04:34 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <20231114220434.GC12791@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <20231113220254.GA2065691@coredump.intra.peff.net>
 <ZVKkgpiFaOwwDcdw@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVKkgpiFaOwwDcdw@nand.local>

On Mon, Nov 13, 2023 at 05:34:42PM -0500, Taylor Blau wrote:

> > It might not be too hard to just let in-process callers access the
> > objects we've written. A quick and dirty patch is below, which works
> > with the test you suggested (the test still fails because it finds a
> > conflict, but it gets past the "woah, I can't find that sha1" part).
> 
> That's a very slick idea, and I think that this series has some legs to
> stand on now as a result.

I'm glad people seem to like it. ;)

I was mostly throwing it out there as an illustration, and I don't plan
on polishing it up further. But in case somebody else wants to work on
it, here are random extra thoughts on the topic:

  - rather than teach packfile.c about bulk checkin, I think it might be
    cleaner to let packed_git structs have a function pointer for
    accessing the index (and if NULL, naturally we'd open the .idx file
    in the usual way). And then bulk checkin could just register the
    "fake" packed_git

  - the flip side, though, is: would it be weird for other parts of the
    code to ever see the fake bulk packed_git in the list? It doesn't
    represent a real packfile the way the other ones do. So maybe it is
    better to keep it separate

  - I suspect this scheme may violate some bounds-checking of the
    packfiles. For example, we haven't written the hashfile trailer yet in
    the still-open packfile. But I think use_pack() assumes we always
    have an extra the_hash_algo->rawsz bytes of padding at the end. I'm
    not sure if that would ever cause us to accidentally read past the
    end of the file.

  - as you mentioned, an oidmap would be an obvious replacement for the
    existing unsorted list

  - the existing already_written() function faces the same problem. I
    don't think anybody cared because we'd usually only bulk checkin a
    few huge objects. But with --write-pack, we might write a lot of
    such objects, and the linear scan in already_written() makes it
    accidentally quadratic.

  - speaking of already_written(): it calls repo_has_object_file() to
    see if we can elide the write. It probably should be using
    freshen_*_object() in the usual way. Again, this is an existing bug
    but I suspect nobody noticed because the bulk checkin code path
    hardly ever kicks in.

-Peff
