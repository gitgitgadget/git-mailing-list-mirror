From: Magnus Therning <magnus@therning.org>
Subject: Re: [PATCH 1/2] doc/http-backend: clarify "half-auth" repo configuration
Date: Thu, 11 Apr 2013 08:57:13 +0200
Message-ID: <CAAExw5vNh=1B9pdyNiVU+-Nff_MaguGfE3czvMYiUhGhr2cz1Q@mail.gmail.com>
References: <20130411033022.GA14462@sigill.intra.peff.net>
	<20130411033211.GA14551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 08:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQBRe-0003wP-KL
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 08:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab3DKG5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 02:57:14 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:53269 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab3DKG5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 02:57:13 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so1134443iah.17
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 23:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=qQM+WozOMu4Vxkt25E07Ih9PyCVhGgShO6f6q2ZOr4w=;
        b=B3cFe3GThOpsWrkDVvFnyJjP+NbANfWA4JRU1oq+2q8OV+gqeF+6yuZBYdcSy+YLan
         0pe/c15EQvNaIdLpHEa3/jTnForiHdBv6MCT/iCSGyhrT3/U9usoW+Nsu9Tz03y/7NHz
         iUpZmF6/Xqe9AE0VMZdEDMuKz9TkwwJ+7IbeHKEa7qzn691Bo1rh1YNDnyNqNtakeX2f
         lVybR2QNZmRScNoVWzml0VFG8XH31DNow/v49wRKbzjVZX1YQMNCzojk93iCCzB/ihWF
         3sADvv4dCCx5EzFdbR5rYSVsLDQdGIxYTyKkyg1gevEVjYGmyb5ard1G660NEC5Fqehl
         QfOA==
X-Received: by 10.50.212.38 with SMTP id nh6mr14884600igc.72.1365663433331;
 Wed, 10 Apr 2013 23:57:13 -0700 (PDT)
Received: by 10.64.163.35 with HTTP; Wed, 10 Apr 2013 23:57:13 -0700 (PDT)
In-Reply-To: <20130411033211.GA14551@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlt2PqPjKy+KgGA6DQvo9+N9jZZhT4sIXqZg+G17VodZ79pWEriZEI5PN+b+tB/YHt297sX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220828>

On Thu, Apr 11, 2013 at 5:32 AM, Jeff King <peff@peff.net> wrote:
> When the http-backend is set up to allow anonymous read but
> authenticated write, the http-backend manual suggests
> catching only the "/git-receive-pack" POST of the packfile,
> not the initial "info/refs?service=git-receive-pack" GET in
> which we advertise refs.
>
> This does work and is secure, as we do not allow any write
> during the info/refs request, and the information in the ref
> advertisement is the same that you would get from a fetch.
>
> However, the configuration required by the server is
> slightly more complex. The default `http.receivepack`
> setting is to allow pushes if the webserver tells us that
> the user authenticated, and otherwise to return a 403
> ("Forbidden"). That works fine if authentication is turned
> on completely; the initial request requires authentication,
> and http-backend realizes it is OK to do a push.
>
> But for this "half-auth" state, no authentication has
> occurred during the initial ref advertisement. The
> http-backend CGI therefore does not think that pushing
> should be enabled, and responds with a 403. The client
> cannot continue, even though the server would have allowed
> it to run if it had provided credentials.
>
> It would be much better if the server responded with a 401,
> asking for credentials during the initial contact. But
> git-http-backend does not know about the server's auth
> configuration (so a 401 would be confusing in the case of a
> true anonymous server). Unfortunately, configuring Apache to
> recognize the query string and apply the auth appropriately
> to receive-pack (but not upload-pack) initial requests is
> non-trivial.
>
> The site admin can work around this by just turning on
> http.receivepack explicitly in its repositories. Let's
> document this workaround.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> My understanding is that you can do query-string matching through a
> clever use of mod-rewrite. I am not nearly clever nor interested in
> Apache enough to figure it out, but if somebody does, it would be nice
> to put the recipe here.
>
>  Documentation/git-http-backend.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
> index 7b1e85c..f43980f 100644
> --- a/Documentation/git-http-backend.txt
> +++ b/Documentation/git-http-backend.txt
> @@ -91,6 +91,15 @@ require authorization with a LocationMatch directive:
>  </LocationMatch>
>  ----------------------------------------------------------------
>  +
> +In this mode, the server will not request authentication until the
> +client actually starts the object negotiation phase of the push, rather
> +than during the initial contact.  For this reason, you must also enable
> +the `http.receivepack` config option in any repositories that should
> +accept a push. The default behavior, if `http.receivepack` is not set,
> +is to reject any pushes by unauthenticated users; the initial request
> +will therefore report `403 Forbidden` to the client, without even giving
> +an opportunity for authentication.
> ++
>  To require authentication for both reads and writes, use a Location
>  directive around the repository, or one of its parent directories:
>  +
> --
> 1.8.2.rc0.33.gd915649
>

As the dumb user who started the thread that lead to this proposed
change, I do think this makes the documentation much clearer and had I
read this I most probably would have managed to set up the webserver
on my own.

/M

-- 
Magnus Therning                      OpenPGP: 0xAB4DFBA4
email: magnus@therning.org   jabber: magnus@therning.org
twitter: magthe               http://therning.org/magnus
