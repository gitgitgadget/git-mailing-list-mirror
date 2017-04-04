Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C523720964
	for <e@80x24.org>; Tue,  4 Apr 2017 13:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbdDDNco (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 09:32:44 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:56784 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdDDNcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 09:32:43 -0400
Received: from hex.gevaerts.be ([84.195.65.126])
        by xavier.telenet-ops.be with bizsmtp
        id 4DYh1v00h2jSfkL01DYhcy; Tue, 04 Apr 2017 15:32:42 +0200
Received: from fg by hex.gevaerts.be with local (Exim 4.84_2)
        (envelope-from <fg@gevaerts.be>)
        id 1cvOZd-00047e-OB
        for git@vger.kernel.org; Tue, 04 Apr 2017 15:32:41 +0200
Date:   Tue, 4 Apr 2017 15:32:41 +0200
From:   Frank Gevaerts <frank@gevaerts.be>
To:     git@vger.kernel.org
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170404133241.GA15588@gevaerts.be>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
X-flash-is-evil: do not use it
X-virus: If this mail contains a virus, feel free to send one back
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 03, 2017 at 10:54:38PM -0400, Jeff King wrote:
> A nearby thread raised the question of whether we can rely on a version
> of libcurl that contains a particular feature. The version in question
> is curl 7.11.1, which came out in March 2004.

I had a quick look at the 7.11.1 support, and I found that current git
actually doesn't build with anything older than curl 7.19.4. The issue
is aeae4db174, which moved some stuff to a helper function but didn't
copy the corresponding #ifdefs.

With that issue fixed, I could build with versions back to 7.12.2, which
is the oldest curl version I could get to build on my modern system.
Note that while I could build with those versions, I didn't actually
check if the result worked.

I'd say it's going to be increasingly likely with time that similar
issues will crop up for such old versions of dependencies.

Frank

diff --git a/http.c b/http.c
index 96d84bbed..8c782a086 100644
--- a/http.c
+++ b/http.c
@@ -674,6 +674,7 @@ void setup_curl_trace(CURL *handle)
        curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
 
+#if LIBCURL_VERSION_NUM >= 0x071304
 static long get_curl_allowed_protocols(int from_user)
 {
        long allowed_protocols = 0;
@@ -689,6 +690,7 @@ static long get_curl_allowed_protocols(int from_user)
 
        return allowed_protocols;
 }
+#endif
 
 static CURL *get_curl_handle(void)
 {

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
