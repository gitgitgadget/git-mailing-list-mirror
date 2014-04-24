From: Greg M <morenzg@gmail.com>
Subject: Re: error: git-remote-https died of signal 13
Date: Thu, 24 Apr 2014 08:11:39 -0400
Message-ID: <CAEHyFQJs2_hMU70ibSe8_k98M6bXrfFWTiHBKcu-473uNhWivQ@mail.gmail.com>
References: <CAEHyFQLmu4GWHcd+Xd6MOikf_LJgK0dGM7VXk6h6OLsud+-Wgw@mail.gmail.com>
	<20140423065938.GB20675@sigill.intra.peff.net>
	<CAEHyFQLPYh2b5CsmadazDJG3paHL7JDY4JhT=xf=wHXhLd=EkQ@mail.gmail.com>
	<20140424041504.GA17398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 24 14:12:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdIVT-0004ej-86
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 14:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbaDXMLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 08:11:51 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51720 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbaDXMLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 08:11:41 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so2161383wgh.27
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 05:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7v6IKfcSpRMBCzciTzCXsbtrENWwJns9ozZ6eNIOTzk=;
        b=DWJxbYIkENIVkWRU9S6/3cWbQRt4C8txbSnaplmToCOKzG6oV26Qwe4/IyzC+mqjKd
         sM+XHK1tHSYqq2IrZdbo5UP2MmCQG6Ow0MxwIm9nELqrKEjWRW6g9cYsbnaEdW3dQ4UL
         SuZesG/hFKtauTtn3Xih9CTDZ+c5pH3YMMnIkspiNm3Zwjj9rNZ3OowKHSEs0RVcRPYO
         bZGDLg0bDdf2kDzzG0CNFBvnVH7HJrxCq5NoCZcxvGv0sf2JIYIm2zZy7MeCMfen8BCh
         BHUqq1Hl6ByBt+q5+vbh4vwJjBwyZKvaeMwox2b2EPPCrZYLTbWPxtCtGwYQaORvmvA2
         X73A==
X-Received: by 10.180.106.134 with SMTP id gu6mr6060054wib.61.1398341500071;
 Thu, 24 Apr 2014 05:11:40 -0700 (PDT)
Received: by 10.227.107.70 with HTTP; Thu, 24 Apr 2014 05:11:39 -0700 (PDT)
In-Reply-To: <20140424041504.GA17398@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246963>

On Thu, Apr 24, 2014 at 12:15 AM, Jeff King <peff@peff.net> wrote:
> I suspect the curl patch below may fix it:
>
> diff --git a/lib/multi.c b/lib/multi.c
> index bc93264..72e4825 100644
> --- a/lib/multi.c
> +++ b/lib/multi.c
> @@ -1804,10 +1804,13 @@ static void close_all_connections(struct Curl_multi *multi)
>
>    conn = Curl_conncache_find_first_connection(multi->conn_cache);
>    while(conn) {
> +    SIGPIPE_VARIABLE(pipe_st);
>      conn->data = multi->closure_handle;
>
> +    sigpipe_ignore(conn->data, &pipe_st);
>      /* This will remove the connection from the cache */
>      (void)Curl_disconnect(conn, FALSE);
> +    sigpipe_restore(&pipe_st);
>
>      conn = Curl_conncache_find_first_connection(multi->conn_cache);
>    }

The patch fixes the problem,

Greg
