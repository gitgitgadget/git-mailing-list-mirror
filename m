Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451E4202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdCOViW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:38:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:44856 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdCOViW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:38:22 -0400
Received: (qmail 4957 invoked by uid 109); 15 Mar 2017 21:38:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 21:38:21 +0000
Received: (qmail 31330 invoked by uid 111); 15 Mar 2017 21:38:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 17:38:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 17:38:18 -0400
Date:   Wed, 15 Mar 2017 17:38:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] rev-parse: simplify parsing of ref options
Message-ID: <20170315213818.qfccs2atfijngaxr@sigill.intra.peff.net>
References: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
 <20170315200802.r4un6p5admfu4h34@sigill.intra.peff.net>
 <xmqq8to6dz76.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8to6dz76.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 02:09:33PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This actually drops the last caller for for_each_branch_ref(). I'm not
> > sure if we shoulder consider cleaning up the proliferation of
> > for_each_ref() helpers.
> 
> That is certainly a good thing to do (but outside this series).
> 
> I am wondering if "git diff" could have chosen a better way to
> arrange deleted and inserted lines.  The first two if statements
> in the preimage corresponds to the new opt-with-value(branches)
> thing, the next two are repalced by opt-with-value(tags), an
> odd-man-out "--glob=" thing is replaced with handle_ref_opt(NULL),
> and then two "--remotes" thing are paired with the final
> opt-with-value(remotes) thing.  
> 
> That would break the usual expectation of seeing all "-" first and
> then "+" when there is no intervening " " context lines, so such an
> output might break tools, though (I do not think "git apply" would
> choke).

I think in this case you could still show it better with context lines
between. Something like:

@@ -749,42 +758,20 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
-			if (skip_prefix(arg, "--branches=", &arg)) {
-				for_each_glob_ref_in(show_reference, arg,
-					"refs/heads/", NULL);
-				clear_ref_exclusion(&ref_excludes);
-				continue;
-			}
-			if (!strcmp(arg, "--branches")) {
-				for_each_branch_ref(show_reference, NULL);
-				clear_ref_exclusion(&ref_excludes);
+			if (opt_with_value(arg, "--branches", &arg)) {
+				handle_ref_opt(arg, "refs/heads/");
 				continue;
 			}
-			if (skip_prefix(arg, "--tags=", &arg)) {
-				for_each_glob_ref_in(show_reference, arg,
-					"refs/tags/", NULL);
-				clear_ref_exclusion(&ref_excludes);
-			if (!strcmp(arg, "--tags")) {
-				for_each_tag_ref(show_reference, NULL);
-				clear_ref_exclusion(&ref_excludes);
+			if (opt_with_value(arg, "--tags", &arg)) {
+				handle_ref_opt(arg, "refs/tags/");
 				continue;
 			}
 			if (skip_prefix(arg, "--glob=", &arg)) {
-				for_each_glob_ref(show_reference, arg, NULL);
-				clear_ref_exclusion(&ref_excludes);
+				handle_ref_opt(arg, NULL);
 				continue;
 			}
-			if (skip_prefix(arg, "--remotes=", &arg)) {
-				for_each_glob_ref_in(show_reference, arg,
-					"refs/remotes/", NULL);
-				clear_ref_exclusion(&ref_excludes);
-			if (!strcmp(arg, "--remotes")) {
-				for_each_remote_ref(show_reference, NULL);
-				clear_ref_exclusion(&ref_excludes);
+			if (opt_with_value(arg, "--remotes", &arg)) {
+				handle_ref_opt(arg, "refs/remotes/");
 				continue;
 			}
 			if (skip_prefix(arg, "--exclude=", &arg)) {

I have no idea what heuristic might generate that diff, though. Using
--patience and --histogram does provided different results than Myers
for this case, but none produces the output above. The other two try to
push the new "--branches" lines up as a replacement for "--branches=",
but then you get a clump of "--branches", "--tags=", and "--tags".

-Peff
