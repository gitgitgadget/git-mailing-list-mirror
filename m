Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E524207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 22:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933599AbcI3Woy (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:44:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:50719 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932805AbcI3Wox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:44:53 -0400
Received: (qmail 11451 invoked by uid 109); 30 Sep 2016 22:44:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 22:44:53 +0000
Received: (qmail 14813 invoked by uid 111); 30 Sep 2016 22:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 18:45:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 18:44:50 -0400
Date:   Fri, 30 Sep 2016 18:44:50 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/6] tmp-objdir: introduce API for temporary object
 directories
Message-ID: <20160930224450.zewgfqelljiwowh6@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193613.dwpjiw5xps6a3wgj@sigill.intra.peff.net>
 <b7136f0690244aee94ff2db726a7edce@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7136f0690244aee94ff2db726a7edce@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 09:32:04PM +0000, David Turner wrote:

> > +static void env_append(struct argv_array *env, const char *key, const
> > +char *val) {
> > +	const char *old = getenv(key);
> > +
> > +	if (!old)
> > +		argv_array_pushf(env, "%s=%s", key, val);
> > +	else
> > +		argv_array_pushf(env, "%s=%s%c%s", key, old, PATH_SEP,
> > val); 
> >+}
> 
> I would like a comment explaining this function. 

I'll squash in:

diff --git a/tmp-objdir.c b/tmp-objdir.c
index c92e6cc..a98c246 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -70,6 +70,13 @@ static void remove_tmp_objdir_on_signal(int signo)
 	raise(signo);
 }
 
+/*
+ * These env_* functions are for setting up the child environment; the
+ * "replace" variant overrides the value of any existing variable with that
+ * "key". The "append" variant puts our new value at the end of a list,
+ * separated by PATH_SEP (which is what separate values in
+ * GIT_ALTERNATE_OBJECT_DIRECTORIES).
+ */
 static void env_append(struct argv_array *env, const char *key, const char *val)
 {
 	const char *old = getenv(key);

> > + * Finalize a temporary object directory by migrating its objects into
> > +the main
> > + * object database.
> > + */
> 
> This should mention that it frees its argument.

And:

diff --git a/tmp-objdir.h b/tmp-objdir.h
index aa47aa9..b1e45b4 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -35,7 +35,8 @@ const char **tmp_objdir_env(const struct tmp_objdir *);
 
 /*
  * Finalize a temporary object directory by migrating its objects into the main
- * object database.
+ * object database, removing the temporary directory, and freeing any
+ * associated resources.
  */
 int tmp_objdir_migrate(struct tmp_objdir *);
 

-Peff
