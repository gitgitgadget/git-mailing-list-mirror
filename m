Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DF91F462
	for <e@80x24.org>; Mon,  3 Jun 2019 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfFCWj2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 18:39:28 -0400
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:35142 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfFCWj2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jun 2019 18:39:28 -0400
Received: from resomta-po-01v.sys.comcast.net ([96.114.154.225])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id XvDVhpyWgd4wBXvbzhma2k; Mon, 03 Jun 2019 22:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559601567;
        bh=wwiA0CppbMkdXyQl7Ija8V0wcfCg9QkqCxnw+1d/kW0=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=3ORrYnp/lBEOQgGtlmZdl+KD0ZUoTjZmrIeUwOZPnATzWljj64Sc+MUb4Tggr+P+g
         Ci6QdFZSmMx9rZWvEgwwYDwkK/vsEXoJVvcLieHe3F7QS+QAzbvMDC6c0cLLpr8qc0
         O/SXKsSGqltfbC/z2nw8oYoNl1iTb4N6k5R0ijt6/69Pnn0bGJhpx5VgcUC2+KiKhl
         v90ix4cWrEbeaXMfxnm54W0BIlvPMp8uSyOYR+U6eoPZ/Z1fifzhESOkhjczSvKVtm
         i6tmcEqZMd28MGU4rfDPG8ZZiEHMfY4TizgphRuDWUhFUQ+bC9qmd4kRrUNUmM7SS+
         ujfI6R4/TYTLg==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a5aa:2f0c:f3a4:606c])
        by resomta-po-01v.sys.comcast.net with ESMTPSA
        id XvbxhwsL4lRViXvbyhqsjY; Mon, 03 Jun 2019 22:39:27 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Mon, 3 Jun 2019 15:39:25 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Matthew DeVore <matvore@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>, jrn@google.com,
        dstolee@microsoft.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 8/9] list-objects-filter-options: clean up use of
 ALLOC_GROW
Message-ID: <20190603223925.GH4641@comcast.net>
References: <20190601003603.90794-1-matvore@google.com>
 <20190601003603.90794-9-matvore@google.com>
 <CA+P7+xqqS8wMeNw1E8yXzStNHgrCU5ME1wpWckbPA7pBD3OBHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xqqS8wMeNw1E8yXzStNHgrCU5ME1wpWckbPA7pBD3OBHg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 03:07:40PM -0700, Jacob Keller wrote:
> > +/*
> > + * Similar to ALLOC_GROW but handles updating of the nr value and
> > + * zeroing the bytes of the newly-grown array elements.
> > + *
> > + * DO NOT USE any expression with side-effect for any of the
> > + * arguments.
> > + */
> 
> Since ALLOC_GROW already doesn't handle this safely, there isn't
> necessarily a reason to fix it, but you could read the macro values
> into temporary variables inside the do { } while(0) loop in order to
> avoid the multiple-expansion side effect issues...

For x I don't think that's possible since we don't know the pointer type. For
nr and alloc it doesn't make sense since they're being assigned to. For
`increase` I could try this:

	size_t ALLOC_GROW_BY__increase = (increase);

but I'm not sure how well this works when `increase` is a signed type. This
seemed sufficiently pitfall-y that I didn't attempt it. Relatedly, I was
thinking something like this would be nice, if anyone has time for such a
refactor:

struct growth_info {
	size_t nr, alloc;
}

And use that to replace individual "size_t foo_nr, foo_alloc"

And make ALLOC_GROW_BY use it. I think a bulk, maybe even most, ALLOC_GROW
invocations can be changed to ALLOC_GROW_BY.
