Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE5D2EF
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C241891
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 00:29:42 -0700 (PDT)
Received: (qmail 13550 invoked by uid 109); 20 Oct 2023 07:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 07:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11812 invoked by uid 111); 20 Oct 2023 07:29:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 03:29:46 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 03:29:41 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/7] merge-ort: implement support for packing objects
 together
Message-ID: <20231020072941.GD1642714@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697736516.git.me@ttaylorr.com>

On Thu, Oct 19, 2023 at 01:28:38PM -0400, Taylor Blau wrote:

> This is a new round that is significantly simplified thanks to
> another very helpful suggestion[1] from Junio. By factoring out a common
> "deflate object to pack" that takes an abstract bulk_checkin_source as a
> parameter, all of the earlier refactorings can be dropped since we
> retain only a single caller instead of multiple.

FWIW, I gave this a read-over and did not see anything wrong (on the
contrary, I think the new abstractions make it quite easy to follow).

Two thoughts that occurred to me while reading it (but neither
actionable for your series):

  - Having not worked with the bulk-checkin code much before, I thought
    it only put in one blob per pack, and thus you'd have to teach it to
    handle multiple objects, too. But fortunately I was wrong, and it
    handles this case already. (I mention this mainly because we had
    talked about it off-list a few weeks ago, and some of my confusion
    may have seeped into my comments then).

  - I did briefly wonder if we need this SOURCE abstraction at all. The
    file source assumes we can seek() and read(), so it must be a
    regular file. We could probably just mmap() it and treat it as
    in-core, too (this is what index_fd() and index_path() do under the
    hood!). But it would probably be a disservice to any platforms that
    do not support mmap, as the fallback is to read into a full buffer
    (and the whole point of the bulk checkin code is to avoid that).

-Peff
