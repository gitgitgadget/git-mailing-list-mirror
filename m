From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/3] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 25 Mar 2015 02:42:21 -0400
Message-ID: <CAPig+cTWnLYU8wU+WjEVpDBuWS7of=wxrWnq7b9W-r=wQh5S1A@mail.gmail.com>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
	<1427174429-5876-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 07:42:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaf1L-0001BZ-T8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 07:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbbCYGm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 02:42:26 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:36290 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbbCYGmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 02:42:23 -0400
Received: by labe2 with SMTP id e2so11924653lab.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FfXoL6zVUZZjioZwi2eHBw0OYPmiAvx9jUXWxvKgkgg=;
        b=RBqZaGlyTdhkRS5UqSCV4whUlJwMyKlGd5Jo5nWS5FAaW3vrhfucDJj9RjJlNkLy+n
         ipyYTW0qBPE65zlHbZEyK5vFwTgOZa25fVPVg/766xJuCW9DFgoZ33vdLlmHJi+BYC2t
         QBqNQUwLxbE8fBp2qClJlNntiUs0YrA88xVwiLFOFxk2D7Ny5m2j4rtnbp1NVhGBWGKS
         GY6z/TwtGS830n/lzcDQQeVQCMuYhD7M8Nqf2zM1b+0bRMinNCQdfbLEWa0i7cvbF1+D
         8vsERVmU/ju5t8wvAvHZ7k1hCyGzlAwFp27I/X/FL++kj8YvIujQMvX1Ekos7y3UeUK0
         ZYYQ==
X-Received: by 10.152.20.232 with SMTP id q8mr7218460lae.102.1427265741610;
 Tue, 24 Mar 2015 23:42:21 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 24 Mar 2015 23:42:21 -0700 (PDT)
In-Reply-To: <1427174429-5876-3-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: iZCBvnRQEwhQoh161gbO3gmoYTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266265>

On Tue, Mar 24, 2015 at 1:20 AM, Paul Tan <pyokagan@gmail.com> wrote:
> t0302 now tests git-credential-store's support for the XDG user-specific
> configuration file $XDG_CONFIG_HOME/git/credentials. Specifically:
>
> * Ensure that the XDG file is strictly opt-in. It should not be created
>   by git at all times if it does not exist.
>
> * Conversely, if the XDG file exists, ~/.git-credentials should
>   not be created at all times.
>
> * If both the XDG file and ~/.git-credentials exists, then both files
>   should be used for credential lookups. However, credentials should
>   only be written to ~/.git-credentials.
>
> * Credentials must be erased from both files.
>
> * $XDG_CONFIG_HOME can be a custom directory set by the user as per the
>   XDG base directory specification. Test that git-credential-store
>   respects that, but defaults to "~/.config/git/credentials" if it does
>   not exist or is empty.
>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index f61b40c..4e1f8ec 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -6,4 +6,118 @@ test_description='credential-store tests'
>
>  helper_test store
>
> +test_expect_success 'get: use xdg file if home file is unreadable' '

I meant to mention this earlier. Does this test need to be protected
by the POSIXPERM prerequisite since it's using chmod?

    test_expect_success POSIXPERM 'get: ... unreadable' '

Otherwise, the test will likely fail on Windows.

> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
> +       chmod -r "$HOME/.git-credentials" &&
> +       mkdir -p "$HOME/.config/git" &&
> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
> +       check fill store <<-\EOF
> +       protocol=https
> +       host=example.com
> +       --
> +       protocol=https
> +       host=example.com
> +       username=xdg-user
> +       password=xdg-pass
> +       --
> +       EOF
> +'
