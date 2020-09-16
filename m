Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE183C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF9920575
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgIPUCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:02:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:58958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbgIPUCH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 16:02:07 -0400
Received: (qmail 26407 invoked by uid 109); 16 Sep 2020 20:02:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 20:02:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32170 invoked by uid 111); 16 Sep 2020 20:02:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 16:02:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 16:02:03 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200916200203.GA37225@coredump.intra.peff.net>
References: <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915135428.GA28038@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915135428.GA28038@pflmari>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 03:54:28PM +0200, Alex Riesen wrote:

> Jeff King, Tue, Sep 15, 2020 15:05:06 +0200:
> > On Tue, Sep 15, 2020 at 01:50:25PM +0200, Alex Riesen wrote:
> > > Sure! Thinking about it, I actually would have preferred to have both: a
> > > config option and a command-line option. So that I can set --ipv4 in, say,
> > > ~/.config/git/config file, but still have the option to try --ipv6 from time
> > > to time to check if the network setup magically fixed itself.
> > > 
> > > What would the preferred name for that config option be? fetch.ipv?
> > 
> > It looks like we've got similar options for clone/pull (which are really
> > fetch under the hood of course) and push. We have the "transfer.*"
> > namespace which applies to both already. So maybe "transfer.ipversion"
> > or something?
> 
> Something like this?

That's the right direction, but I think we'd want to make sure it
impacted all of the spots that allow switching. "clone" on the fetching
side, but probably also "push".

Each of those commands could learn the same config, but it might be
easier to just enforce it in the transport layer. Something like this
maybe (compiled but not tested):

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a6d3268661..2f7a734eb2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1267,7 +1267,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
-	transport->family = family;
+	if (family)
+		transport->family = family;
 	if (upload_pack)
 		set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/builtin/push.c b/builtin/push.c
index bc94078e72..f7a40b65cd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -343,7 +343,8 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 	char *anon_url = transport_anonymize_url(transport->url);
 
 	transport_set_verbosity(transport, verbosity, progress);
-	transport->family = family;
+	if (family)
+		transport->family = family;
 
 	if (receivepack)
 		transport_set_option(transport,
diff --git a/transport.c b/transport.c
index 43e24bf1e5..92f81b414d 100644
--- a/transport.c
+++ b/transport.c
@@ -919,6 +919,20 @@ static struct transport_vtable builtin_smart_vtable = {
 	disconnect_git
 };
 
+enum transport_family default_transport_family(void)
+{
+	const char *v;
+
+	if (git_config_get_string_tmp("core.ipversion", &v))
+		return TRANSPORT_FAMILY_ALL;
+	else if (!strcmp(v, "ipv4"))
+		return TRANSPORT_FAMILY_IPV4;
+	else if (!strcmp(v, "ipv6"))
+		return TRANSPORT_FAMILY_IPV6;
+
+	die(_("invalid core.ipversion: %s"), v);
+}
+
 struct transport *transport_get(struct remote *remote, const char *url)
 {
 	const char *helper;
@@ -948,6 +962,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 			helper = xstrndup(url, p - url);
 	}
 
+	ret->family = default_transport_family();
+
 	if (helper) {
 		transport_helper_init(ret, helper);
 	} else if (starts_with(url, "rsync:")) {

A few notes:

  - it cheats a little by noting that command-line options can't get it
    to "ALL". It might be a bit cleaner if we have an explicit
    TRANSPORT_FAMILY_UNSET, and then resolve the default at look-up
    time.

  - it probably needs more "if (family)" spots in each command, which is
    unfortunate (which again might go away if "UNSET" is 0).

  - I waffled on the name. transfer.* is where we put things that apply
    to both push/fetch, but it's usually more related to the git layer.
    This is more of a core networking decision, and if we added other
    network programs, I'd expect them to respect it. So maybe "core." is
    a better namespace.

-Peff
