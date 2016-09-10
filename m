Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5477207E0
	for <e@80x24.org>; Sat, 10 Sep 2016 00:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbcIJAVw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 20:21:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40562 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbcIJAVw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 20:21:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 54536207DF;
        Sat, 10 Sep 2016 00:21:51 +0000 (UTC)
Date:   Sat, 10 Sep 2016 00:21:51 +0000
From:   Eric Wong <e@80x24.org>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git@vger.kernel.org
Subject: Re: git clone http://  fails some times with "Request for d53..
 aborted"
Message-ID: <20160910002151.GA8476@dcvr>
References: <20160909221942.GS9830@onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160909221942.GS9830@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Not sure how much time I'll have to continue in the next few weeks,
 just jotting down my debugging progress so far...)

Yaroslav Halchenko <yoh@onerussian.com> wrote:
> even when (v 2.7.0) ran on the box where the server is, so
> unlikely to be network issue
> 
> or from my laptop (v 2.9.3) with ok but wifi with a weakish signal to the
> access point:
> 
> $> ( set -e; for s in {1..100}; do rm -rf fbirn_phaseIII ; git clone http://datasets.datalad.org/nidm/fbirn_phaseIII/.git; done; )
> Cloning into 'fbirn_phaseIII'...
> Checking connectivity... done.
> Cloning into 'fbirn_phaseIII'...
> error: Request for d53302dfc7ad13b786923927021039d21a10d5bd aborted
> error: Unable to find d53302dfc7ad13b786923927021039d21a10d5bd under http://datasets.datalad.org/nidm/fbirn_phaseIII/.git
> Cannot obtain needed tree d53302dfc7ad13b786923927021039d21a10d5bd
> while processing commit 22dd4c49417cad6f4082ac2aebef45da8b6e473d.
> error: fetch failed.
> 
> even if I build fresh 2.10.0, discovered that we can trace now CURL calls

Also, GIT_CURL_VERBOSE=1 is useful, too

And GIT_HTTP_MAX_REQUESTS=1 (default 5) can be used to limit concurrency
if there's a suspected concurrency bug.

Initially, I was worried some of my 2.10.0 http-walker speedups were
responsible, but it does not seem to be the case since it happens on old
versions, too...

I'm trying with the following to track state==ABORTED requests:

diff --git a/http-walker.c b/http-walker.c
index 0b24255..4f25b07 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -56,6 +56,7 @@ static void start_object_request(struct walker *walker,
 
 	req = new_http_object_request(obj_req->repo->base, obj_req->sha1);
 	if (req == NULL) {
+		warning("obj aborted at %d", __LINE__);
 		obj_req->state = ABORTED;
 		return;
 	}
diff --git a/http.c b/http.c
index cd40b01..cac5db9 100644
--- a/http.c
+++ b/http.c
@@ -1022,6 +1022,8 @@ int start_active_slot(struct active_request_slot *slot)
 
 	if (curlm_result != CURLM_OK &&
 	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
+		warning("curl_multi_add_handle failed: %s",
+			curl_multi_strerror(curlm_result));
 		active_requests--;
 		slot->in_use = 0;
 		return 0;


And getting a few of the following:

	warning: curl_multi_add_handle failed: The easy handle is already added to a multi handle

	(error code: CURLM_ADDED_ALREADY)

I suspect there is some state management bug.   And yes, it's
intermittent, I'm testing from my server (dcvr.yhbt.net) with good
connectivity and it does not happen all the time.

It also happens regardless of GIT_HTTP_MAX_REQUESTS being 1 or 5
(default), too.

So yeah, hopefully this info is helpful to someone else on the list
in case I don't return soon.
