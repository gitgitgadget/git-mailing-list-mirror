Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BB2D62C
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45B3591
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:37:38 -0700 (PDT)
Received: (qmail 7259 invoked by uid 109); 25 Oct 2023 07:37:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Oct 2023 07:37:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 515 invoked by uid 111); 25 Oct 2023 07:37:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Oct 2023 03:37:41 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Oct 2023 03:37:36 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 1/5] bulk-checkin: extract abstract
 `bulk_checkin_source`
Message-ID: <20231025073736.GB2145145@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <696aa027e46ddec310812fad2d4b12082447d925.1698101088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <696aa027e46ddec310812fad2d4b12082447d925.1698101088.git.me@ttaylorr.com>

On Mon, Oct 23, 2023 at 06:44:56PM -0400, Taylor Blau wrote:

> +struct bulk_checkin_source {
> +	off_t (*read)(struct bulk_checkin_source *, void *, size_t);
> +	off_t (*seek)(struct bulk_checkin_source *, off_t);
> +
> +	union {
> +		struct {
> +			int fd;
> +		} from_fd;
> +	} data;
> +
> +	size_t size;
> +	const char *path;
> +};

The virtual functions combined with the union are a funny mix of
object-oriented and procedural code. The bulk_checkin_source has
totally virtualized functions, but knows about all of the ancillary data
each set of virtualized functions might want. ;)

I think the more pure OO version would embed the parent, and have each
concrete type define its own struct type, like:

  struct bulk_checkin_source_fd {
	struct bulk_checkin_source src;
	int fd;
  };

That works great if the code which constructs it knows which concrete
type it wants, and can just do:

  struct bulk_checkin_source_fd src;
  init_bulk_checkin_source_from_fd(&src, ...);

If even the construction is somewhat virtualized, then you are stuck
with heap constructors like:

  struct bulk_checkin_source *bulk_checkin_source_from_fd(...);

Not too bad, but you have to remember to free now.

Alternatively, I think some of our other OO code just leaves room for
a type-specific void pointer, like:

  struct bulk_checkin_source {
	...the usual stuff...

	void *magic_type_data;
  };

and then the init_bulk_checkin_source_from_fd() function allocates its
own heap struct for the magic_type_data field and sticks the int in
there.

That said, both of those are a lot more annoying to use in C (more
boilerplate, more casting, and more opportunities to get something
wrong, including leaks). So I don't mind this in-between state. It is a
funny layering violating from an OO standpoint, but it's not like we
expect an unbounded set of concrete types to "inherit" from the source
struct.

-Peff
