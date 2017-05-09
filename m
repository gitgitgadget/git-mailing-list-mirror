Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9C22018D
	for <e@80x24.org>; Tue,  9 May 2017 02:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbdEICKd (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:10:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:47758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbdEICKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:10:33 -0400
Received: (qmail 8781 invoked by uid 109); 9 May 2017 02:10:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 02:10:31 +0000
Received: (qmail 18370 invoked by uid 111); 9 May 2017 02:11:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 22:11:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 22:10:28 -0400
Date:   Mon, 8 May 2017 22:10:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: git-clone --config order & fetching extra refs during initial
 clone
Message-ID: <20170509021028.fr5mc76kcbpnn4zs@sigill.intra.peff.net>
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
 <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
 <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
 <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net>
 <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
 <20170503202224.arjszzbruxjgpkt5@sigill.intra.peff.net>
 <xmqq4lwu7r0s.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lwu7r0s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 10:33:39AM +0900, Junio C Hamano wrote:

> >> My patch deals with 'remote.<name>.refspec', i.e. 'remote->fetch'.
> >> Apparently some extra care is necessary for 'remote.<name>.tagOpt' and
> >> 'remote->fetch_tags', too.  Perhaps there are more, I haven't checked
> >> again, and maybe we'll add similar config variables in the future.  So
> >> I don't think that dealing with such config variables one by one in
> >> 'git clone', too, is the right long-term solution...  but perhaps it's
> >> sufficient for the time being?
> >
> > I think your patch is a strict improvement and we don't need to hold up
> > waiting for a perfect fix (and because of the --single-branch thing you
> > mentioned, this may be the best we can do anyway).
> 
> OK, so where does this patch stand now?  It already is too late for
> the upcoming release, but should we merge it to 'next' once the
> release is made, cook it in 'next' and shoot for the next release
> as-is, or do we want to allow minor tweaks before it hits 'next'?

I'd be OK with it as-is, but here are my nitpicks as a diff (keep the
assignment of refspec_count in one place, and free fetch_patterns as
soon as it is no longer used).

I actually think it might be nice to pull the whole thing out into its
own function, but the parameters it takes would be oddly specific.

diff --git a/builtin/clone.c b/builtin/clone.c
index 0630202c8..577529a11 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -861,7 +861,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 
 	struct refspec *refspec;
-	unsigned int refspec_count = 1;
+	unsigned int refspec_count;
 	const char **fetch_patterns;
 	const struct string_list *config_fetch_patterns;
 
@@ -994,6 +994,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	config_fetch_patterns = git_config_get_value_multi(key.buf);
 	if (config_fetch_patterns)
 		refspec_count = 1 + config_fetch_patterns->nr;
+	else
+		refspec_count = 1;
 	fetch_patterns = xcalloc(refspec_count, sizeof(*fetch_patterns));
 	fetch_patterns[0] = value.buf;
 	if (config_fetch_patterns) {
@@ -1003,6 +1005,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			fetch_patterns[i++] = fp->string;
 	}
 	refspec = parse_fetch_refspec(refspec_count, fetch_patterns);
+	free(fetch_patterns);
 
 	strbuf_reset(&key);
 	strbuf_reset(&value);
@@ -1129,7 +1132,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	free(fetch_patterns);
 	free(refspec);
 	return err;
 }

-Peff
