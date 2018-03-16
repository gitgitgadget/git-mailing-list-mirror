Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459671F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCPVSk (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:18:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:60058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751233AbeCPVSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:18:39 -0400
Received: (qmail 10212 invoked by uid 109); 16 Mar 2018 21:18:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Mar 2018 21:18:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1082 invoked by uid 111); 16 Mar 2018 21:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Mar 2018 17:19:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Mar 2018 17:18:37 -0400
Date:   Fri, 16 Mar 2018 17:18:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] routines to generate JSON data
Message-ID: <20180316211837.GB12333@sigill.intra.peff.net>
References: <20180316194057.77513-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316194057.77513-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 07:40:55PM +0000, git@jeffhostetler.com wrote:

> This patch series adds a set of utility routines to compose data in JSON
> format into a "struct strbuf".  The resulting string can then be output
> by commands wanting to support a JSON output format.
> 
> This is a stand alone patch.  Nothing currently uses these routines.  I'm
> currently working on a series to log "telemetry" data (as we discussed
> briefly during Ævar's "Performance Misc" session [1] in Barcelona last
> week).  And I want emit the data in JSON rather than a fixed column/field
> format.  The JSON routines here are independent of that, so it made sense
> to submit the JSON part by itself.
> 
> Back when we added porcelain=v2 format to status, we talked about adding a
> JSON format.  I think the routines in this patch would let us easily do
> that, if someone were interested.  (Extending status is not on my radar
> right now, however.)

I really like the idea of being able to send our machine-readable output
in some "standard" syntax for which people may already have parsers. But
one big hangup with JSON is that it assumes all strings are UTF-8. That
may be OK for telemetry data, but it would probably lead to problems for
something like status porcelain, since Git's view of paths is just a
string of bytes (not to mention possible uses elsewhere like author
names, subject lines, etc).

Before we commit to a standardized format, I think we need to work out
a solution there (because I'd much rather not go down this road for
telemetry data only to find that we cannot use the same standardized
format in other parts of Git).

Some possible solutions I can think of:

  1. Ignore the UTF-8 requirement, making a JSON-like output (which I
     think is what your patches do). I'm not sure what problems this
     might cause on the parsing side.

  2. Specially encode non-UTF-8 bits. I'm not familiar enough with JSON
     to know the options here, but my understanding is that numeric
     escapes are just for inserting unicode code points. _Can_ you
     actually transport arbitrary binary data across JSON without
     base64-encoding it (yech)?

  3. Some other similar format. YAML comes to mind. Last time I looked
     (quite a while ago), it seemed insanely complex, but I think you
     could implement only a reasonable subset. OTOH, I think the tools
     ecosystem for parsing JSON (e.g., jq) is much better.

> Documentation for the new API is given in json-writer.h at the bottom of
> the first patch.

The API generally looks pleasant, but the nesting surprised me.  E.g.,
I'd have expected:

  jw_array_begin(out);
  jw_array_begin(out);
  jw_array_append_int(out, 42);
  jw_array_end(out);
  jw_array_end(out);

to result in an array containing an array containing an integer. But
array_begin() actually resets the strbuf, so you can't build up nested
items like this internally. Ditto for objects within objects. You have
to use two separate strbufs and copy the data an extra time.

To make the above work, I think you'd have to store a little more state.
E.g., the "array_append" functions check "out->len" to see if they need
to add a separating comma. That wouldn't work if we might be part of a
nested array. So I think you'd need a context struct like:

  struct json_writer {
    int first_item;
    struct strbuf out;
  };
  #define JSON_WRITER_INIT { 1, STRBUF_INIT }

to store the state and the output. As a bonus, you could also use it to
store some other sanity checks (e.g., keep a "depth" counter and BUG()
when somebody tries to access the finished strbuf with a hanging-open
object or array).

> I wasn't sure how to unit test the API from a shell script, so I added a
> helper command that does most of the work in the second patch.

In general I'd really prefer to keep the shell script as the driver for
the tests, and have t/helper programs just be conduits. E.g., something
like:

  cat >expect <<-\EOF &&
  {"key": "value", "foo": 42}
  EOF
  test-json-writer >actual \
    object_begin \
    object_append_string key value \
    object_append_int foo 42 \
    object_end &&
  test_cmp expect actual

It's a bit tedious (though fairly mechanical) to expose the API in this
way, but it makes it much easier to debug, modify, or add tests later
on (for example, I had to modify the C program to find out that my
append example above wouldn't work).

-Peff
