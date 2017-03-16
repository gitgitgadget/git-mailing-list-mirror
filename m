Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CFF20323
	for <e@80x24.org>; Thu, 16 Mar 2017 18:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbdCPSCj (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 14:02:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:45242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752051AbdCPSCi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 14:02:38 -0400
Received: (qmail 18446 invoked by uid 109); 16 Mar 2017 18:02:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 18:02:31 +0000
Received: (qmail 13587 invoked by uid 111); 16 Mar 2017 18:02:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:02:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 14:02:27 -0400
Date:   Thu, 16 Mar 2017 14:02:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Devin Lehmacher <lehmacdj@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4 3/4] credential-cache: use XDG_CACHE_HOME for
 socket
Message-ID: <20170316180227.2ka4fsyigwr33cks@sigill.intra.peff.net>
References: <20170314003246.71586-4-lehmacdj@gmail.com>
 <20170316051827.97198-1-lehmacdj@gmail.com>
 <20170316051827.97198-4-lehmacdj@gmail.com>
 <xmqqd1dhchwy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1dhchwy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 09:20:29AM -0700, Junio C Hamano wrote:

> static char *get_socket_path(void)
> {
> 	struct stat st;
> 	char *path;
> 
> 	path = expand_user_path("~/.git-credential-cache");
> 	if (path && !stat(path, &st) && S_ISDIR(st.st_mode))) {
> 		free(path);
> 		path = expand_user_path("~/.git-credential-cache/socket");
> 	} else {
> 		path = xdg_cache_home("credential/socket");
> 	}                
> 	return path;
> }
> 
> The duplication of "~/.git-credential-cache" bothers me somewhat and
> perhaps people can suggest better ways to get rid of the dup.

Maybe:

  path = expand_user_path("~/.git-credential-cache");
  if (path && !stat(path, &st) && S_ISDIR(st.st_mode))) {
	char *new_path = xstrfmt("%s/socket", path);
	free(path);
	path = new_path;
  } else ...

-Peff
