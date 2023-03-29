Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5FC6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 06:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjC2GHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2GHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 02:07:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3219DF9
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 23:07:10 -0700 (PDT)
Received: (qmail 8888 invoked by uid 109); 29 Mar 2023 06:07:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Mar 2023 06:07:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5710 invoked by uid 111); 29 Mar 2023 06:07:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Mar 2023 02:07:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Mar 2023 02:07:09 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
Message-ID: <20230329060709.GB1793752@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net>
 <xmqqzg7wczx7.fsf@gitster.g>
 <20230329023702.GA1793752@coredump.intra.peff.net>
 <20230329030432.GA1801645@coredump.intra.peff.net>
 <CAPig+cQexJ9s1f6tLLaq7baeVCKhazPBi_xQ6uybkQcJQ97geg@mail.gmail.com>
 <CAPig+cQiOGrDSUc34jHEBp87Rx-dnXNcPcF76bu0SJoOzD+1hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQiOGrDSUc34jHEBp87Rx-dnXNcPcF76bu0SJoOzD+1hw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 11:46:37PM -0400, Eric Sunshine wrote:

> > Yes, it would look something like that and you chose the correct spot
> > to detect the problem, but to get a "pretty" error message properly
> > positioned in the input, we need to capture the input stream position
> > of the here-doc tag itself in scan_heredoc_tag(). It doesn't look too
> > difficult, and I even started writing a bit of code to do it, but I'm
> > not sure how soon I can get around to finishing the implementation.
> 
> The attached patch seems to do the job. Apologies for Gmail messing up
> the whitespace. It's also attached to the email.

Thanks! I was going to say "please don't consider this urgent", but I
see that my nerd-snipe was successful. ;)

> This would probably make a good preparatory patch to your [3/4]. As
> mentioned earlier in the thread, the changes to scan_heredoc_tag ()
> capture the input-stream position of the here-doc tag itself, which is
> necessary since it would be too late to do so by the time the error is
> detected by swallow_heredocs(). I don't now when I'll get time to send
> this as a proper patch, so feel free to write a commit message and
> incorporate it into your series if you want to use it. And, of course,
> you have my sign-off already in the patch. It should be easy to add a
> test, as well, in t/chainlint, perhaps as
> unclosed-here-doc.{text,expect}.

Thanks, I can take it from here (and I agree doing it as prep for 3/4 is
good, as I can then omit a bunch of explanations there). Here are the
tests I'll squash in (along with your $indent fix):

diff --git a/t/chainlint/unclosed-here-doc-indent.expect b/t/chainlint/unclosed-here-doc-indent.expect
new file mode 100644
index 00000000000..6e17bb66336
--- /dev/null
+++ b/t/chainlint/unclosed-here-doc-indent.expect
@@ -0,0 +1,4 @@
+command_which_is_run &&
+cat >expect <<-\EOF ?!HERE?! &&
+we forget to end the here-doc
+command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc-indent.test b/t/chainlint/unclosed-here-doc-indent.test
new file mode 100644
index 00000000000..5c841a9dfd4
--- /dev/null
+++ b/t/chainlint/unclosed-here-doc-indent.test
@@ -0,0 +1,4 @@
+command_which_is_run &&
+cat >expect <<-\EOF &&
+we forget to end the here-doc
+command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc.expect b/t/chainlint/unclosed-here-doc.expect
new file mode 100644
index 00000000000..c53b6b794a7
--- /dev/null
+++ b/t/chainlint/unclosed-here-doc.expect
@@ -0,0 +1,7 @@
+command_which_is_run &&
+cat >expect <<\EOF ?!HERE?! &&
+	we try to end the here-doc below,
+	but the indentation throws us off
+	since the operator is not "<<-".
+	EOF
+command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc.test b/t/chainlint/unclosed-here-doc.test
new file mode 100644
index 00000000000..69d3786c348
--- /dev/null
+++ b/t/chainlint/unclosed-here-doc.test
@@ -0,0 +1,7 @@
+command_which_is_run &&
+cat >expect <<\EOF &&
+	we try to end the here-doc below,
+	but the indentation throws us off
+	since the operator is not "<<-".
+	EOF
+command_which_is_gobbled

-Peff
