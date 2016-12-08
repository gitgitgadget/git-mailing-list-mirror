Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14231FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 09:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933002AbcLIJNQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 04:13:16 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:57992 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932247AbcLIJNO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 04:13:14 -0500
X-Greylist: delayed 43238 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Dec 2016 04:13:14 EST
Received: from homiemail-a21.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 864154284
        for <git@vger.kernel.org>; Thu,  8 Dec 2016 13:12:34 -0800 (PST)
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id C3912300074;
        Thu,  8 Dec 2016 13:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=YnST/
        86kbZUQ9uhKJCsl6mWKsxs=; b=h88Dkyhk6b+or4diXXhKQuwyW2FwLyCcHnwAC
        B7IfbylWw+VjlYfe/gNasmzi9Q6CP9BZ3sRQ0tkfG0pMvqpYdAhWw3lj4aOlWtQQ
        /hWDhrWgaB1m5M4yMGUHLaBkAoS2kg9B3h/36Q+9zNYuBMro/FMj4GCFjfXbQv3X
        2uJfCo=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 424C2300061;
        Thu,  8 Dec 2016 13:12:33 -0800 (PST)
Message-ID: <1481231552.20894.20.camel@frank>
Subject: Re: [REGRESSION 2.10.2] problematic "empty auth" changes
From:   David Turner <novalis@novalis.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Thu, 08 Dec 2016 16:12:32 -0500
In-Reply-To: <alpine.DEB.2.20.1612081538260.23160@virtualbox>
References: <alpine.DEB.2.20.1612081538260.23160@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2016-12-08 at 15:47 +0100, Johannes Schindelin wrote:
> Hi Dave,
> 
> I got a couple of bug reports that claim that 2.10.2 regressed on using
> network credentials. That is, users regularly hit Enter twice when being
> asked for user name and password while fetching via https://, and cURL
> automatically used to fall back to using the login credentials (i.e.
> authenticating via the Domain controller).
> 
> Turns out those claims are correct: hitting Enter twice (or using URLs
> with empty user name/password such as https://:tfs:8080/) work in 2.10.1
> and yield "Authentication failed" in 2.10.2.
> 
> I tracked this down to 5275c3081c (http: http.emptyauth should allow empty
> (not just NULL) usernames, 2016-10-04) which all of a sudden disallowed
> empty user names (and now only handles things correctly when
> http.emptyAuth is set to true specifically).
> 
> This smells like a real bad regression to me, certainly given the time I
> had to spend to figure this out (starting from not exactly helpful bug
> reports, due to being very specific to their setups being private).
> 
> I am *really* tempted to change the default of http.emptyAuth to true, *at
> least* for Windows (where it is quite common to use your login credentials
> to authenticate to corporate servers).
> 
> Before I do anything rash, though: Do you see any downside to that?

I know of no reason that shouldn't work.  Indeed, it's what we use do
internally.  So far, nobody has reported problems.  That said, we have
exactly three sets of git servers that most users talk to (two different
internal; and occasionally github.com for external stuff).  So our
coverage is not very broad.

If you're going to do it, tho, don't just do it for Windows users -- do
it for everyone.  Plenty of Unix clients connect to Windows-based auth
systems.

That said, I could imagine that there are cases where it would cause
failures for a different set of users.  I don't know of any off the top
of my head, but this is not my area of expertise.

We could move closer to the old behavior with something like:

        if (!http_auth.username || !*http_auth.username) {
                if (curl_empty_auth)
                        curl_easy_setopt(result, CURLOPT_USERPWD, ":");
                if (!http_auth.username)
                        return;
        }

This is very ad-hoc, in that I have not examined exactly when
http_auth.username would be null vs empty; it merely attempts to get as
close as possible to the old behavior.

[Side note: I was curious if 26a7b23429 would have been a better fix for
our problem.  It appears that the answer is no; using that patch but
minus my 5275c3081c does not work for us.]


