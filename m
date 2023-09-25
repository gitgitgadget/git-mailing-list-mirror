Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D8ACE7A9B
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 16:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjIYQR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjIYQR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 12:17:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B57292
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 09:17:50 -0700 (PDT)
Received: (qmail 7477 invoked by uid 109); 25 Sep 2023 16:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Sep 2023 16:17:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14481 invoked by uid 111); 25 Sep 2023 16:17:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Sep 2023 12:17:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Sep 2023 12:17:48 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
Message-ID: <20230925161748.GA2149383@coredump.intra.peff.net>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRGdvRQuj4zllGnm@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 10:48:29AM -0400, Todd Zullinger wrote:

> From the peanut gallery... could the presence or lack of the
> Email::Valid perl module be a factor?

Ah, thanks! The thought of differing modules even occurred to me, since
I know we have a few optimistic dependencies, but when I looked I didn't
manage to find that one (somehow I thought Mail::Address was the
interesting one here; I think I might be getting senile).

With Email::Valid installed, I can reproduce with just (in git.git, but
I think it would work in any repo):

  $ echo "exit 0" >.git/hooks/sendemail-validate
  $ chmod +x .git/hooks/sendemail-validate
  $ git send-email --dry-run -1 --to=foo@example.com,bar@example.com
  error: unable to extract a valid address from: foo@example.com,bar@example.com

Disabling the hook with "chmod -x" makes the problem go away (and this
is with current "master", hence the more readable error message).

I think the issue is that a8022c5f7b ends up in extract_valid_address()
via this call stack:

  $ = main::extract_valid_address('foo@example.com,bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 1161
  $ = main::extract_valid_address_or_die('foo@example.com,bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 2087
  @ = main::unique_email_list('foo@example.com,bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 1507
  @ = main::gen_header() called from file '/home/peff/compile/git/git-send-email' line 2113
  . = main::validate_patch('/tmp/WfoPQSKCUa/0001-The-twelfth-batch.patch', 'auto') called from file '/home/peff/compile/git/git-send-email' line 815

whereas prior to that commit, we hit it later:

  $ = main::extract_valid_address('foo@example.com') called from file '/home/peff/compile/git/git-send-email' line 1166
  @ = main::validate_address('foo@example.com') called from file '/home/peff/compile/git/git-send-email' line 1189
  @ = main::validate_address_list('foo@example.com', 'bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 1348
  @ = main::process_address_list('foo@example.com,bar@example.com') called from file '/home/peff/compile/git/git-send-email' line 1091

So the issue is the call to gen_header() added in validate_patch(). We
won't yet have processed the address lists by that point. We can move
those calls up, but it requires moving a bit of extra code, too (like
the parts prompting for the "to" list if it isn't filled in).

Possibly the validation checks need to be moved down, if they want to
see a more complete view of the emails. But now we're doing more work
(like asking the user to write the cover letter!) before we do
validation, which is probably bad.

So I dunno. Maybe gen_header() should be lazily doing this
process_address_list() stuff? I'm not very familiar with the send-email
code, so I'm not sure what secondary effects that could have.

-Peff
