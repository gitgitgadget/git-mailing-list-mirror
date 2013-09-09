From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] upload-pack: send keepalive packets during pack computation
Date: Mon, 9 Sep 2013 03:45:29 -0400
Message-ID: <CAPig+cTa2QYtQZ-kFCTTvhHC+saJS1o=5CyFwfwARXxg8sn-uA@mail.gmail.com>
References: <20130908085915.GA4097@sigill.intra.peff.net>
	<20130908090131.GA17060@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 09:45:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIwAB-0007Db-FQ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 09:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab3IIHpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 03:45:31 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:46072 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab3IIHpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 03:45:31 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so4573267lab.38
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+1zT+4Z9O6gqAXajvi/Jw5lP9LV6LFcT6ePcZ+riP8Y=;
        b=jJIh59mB0C74ib+m0KQ7GgYBhiqNNY91FURxVOeAAjZMgs0/JWufB8K4IbvbFCQwne
         SA6MdfNIRkzhpaqxDetWbexYhsIHOQpo8XHw1wyjEJ1qh9lzZQEMwaVaaMQnsYrx4tnD
         j6A+zfkla1IWrRKd4Vcd9+c5qxf081OX10MEckVw5/1sXYAW4C49ZnbbETFCNadam2xD
         2yq8cZ8Umk3I+/p6h4+FdqqxIpQJCUgXvf7tHuqNokEP56v3uTD3j01TCUxXCaPvEegi
         TjzY1O1NHwMRk5GfxCxA6VfQQ0TJmo5P5lAeO8PniLB3jzeea7BFtLNruAFdzAaUTsTh
         WV9A==
X-Received: by 10.152.120.5 with SMTP id ky5mr15373590lab.18.1378712729823;
 Mon, 09 Sep 2013 00:45:29 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 9 Sep 2013 00:45:29 -0700 (PDT)
In-Reply-To: <20130908090131.GA17060@sigill.intra.peff.net>
X-Google-Sender-Auth: UJJRVVNsfMUd-E5BLuyayItUTCU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234317>

On Sun, Sep 8, 2013 at 5:01 AM, Jeff King <peff@peff.net> wrote:
> Whenn upload-pack has started pack-objects, there may be a

s/Whenn/When/

> quiet period while pack-objects prepares the pack (i.e.,
> counting objects and delta compression).  Normally we would
> see (and send to the client) progress information, but if
> "--quiet" is in effect, pack-objects will produce nothing at
> all until the pack data is ready. On a large repository,
> this can take tens of seconds (or even minutes if the system
> is loaded or the repository is badly packed). Clients or
> intermediate proxies can sometimes give up in this
> situation, assuming that the server or connection has hung.
>
> This patch introduces a "keepalive" option; if upload-pack
> sees no data from pack-objects for a certain number of
> seconds, it will send an empty sideband data packet to let
> the other side know that we are still working on it.
>
> Signed-off-by: Jeff King <peff@peff.net>
