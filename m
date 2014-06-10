From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/15] provide helpers to access the commit buffer
Date: Tue, 10 Jun 2014 04:00:34 -0400
Message-ID: <CAPig+cTkwFVDEj7L6qriNP9-Qsu=B-wJsv0z1b++u57dir8XOw@mail.gmail.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609181158.GH20315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 10:00:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuGz6-0003HD-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 10:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbaFJIAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 04:00:36 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:50046 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbaFJIAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 04:00:35 -0400
Received: by mail-yh0-f47.google.com with SMTP id v1so1304704yhn.34
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GbXnj/t4yqsdbPICKKtdKw1psXCjr061KwI+ltCr8do=;
        b=NRp5lRDmC9jqvS7elH72lHpfy8Vh/yp9mBqWG7GIm9rYpfdOfcVwn/SwLxl5u8QWFN
         fLvZb43JuvbBNYJoYtMxZiEki2+SgbEOMsfPUvyQsgnLZA3Z4OqLCKcfIYTsU61zNPf5
         +bLLybyrztwquB/mxyFl9duQWvStmhlc6nXh3nOQWj6fDOnCStZe10lqgFS68Y1K4V+s
         m+iQO1Bz1x1LjQbvnHM7xEIGIoRmtf/ccMuKU2R4ZrkNrOePJM8GhsBoIwBcxsxqI7c4
         O86HwzzXH0cPInWN18f8c+doWSKAKli+Ki6rtLO/wAfYU+CNpm6BVXG4saOd2wWG5NZ6
         7OXA==
X-Received: by 10.236.126.174 with SMTP id b34mr20833361yhi.56.1402387234506;
 Tue, 10 Jun 2014 01:00:34 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 10 Jun 2014 01:00:34 -0700 (PDT)
In-Reply-To: <20140609181158.GH20315@sigill.intra.peff.net>
X-Google-Sender-Auth: 4KMOGu3gYuDofHiAEYOnIddujp8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251171>

On Monday, June 9, 2014, Jeff King <peff@peff.net> wrote:
> Many sites look at commit->buffer to get more detailed
> information than what is in the parsed commit struct.
> However, we sometimes drop commit->buffer to save memory,
> in which case the caller would need to read the object
> afresh. Some callers do this (leading to duplicated code),
> and others do not (which opens the possibility of a segfault
> if somebody else frees the buffer).
>
> Let's provide a pair of helpers, "get" and "unuse", that let
> callers easily get the buffer. They will use the cached
> buffer when possible, and otherwise load from disk using
> read_sha1_file.
>
> Note that we also need to add a "get_cached" variant which
> returns NULL when we do not have a cached buffer. At first
> glance this seems to defeat the purpose of "get", which is
> to always provide a return value. However, some log code
> paths actually use the NULL-ness of commit->buffer as a
> boolean flag to decide whether to try to printing the

s/printing/print/ ... or some other variation of the phrase.

> commit. At least for now, we want to continue supporting
> that use.
>
> Signed-off-by: Jeff King <peff@peff.net>
