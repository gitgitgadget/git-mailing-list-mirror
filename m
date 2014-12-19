From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 1/6] receive-pack.c: add protocol support to negotiate atomic
Date: Thu, 18 Dec 2014 20:05:38 -0500
Message-ID: <CAPig+cT1HGF+Vjc8Jag7UcsXUYegbdYjNAtJYgGgreR3tXrR0g@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418841177-12152-1-git-send-email-sbeller@google.com>
	<1418841177-12152-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 02:05:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1m0l-0001ew-U7
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 02:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbaLSBFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 20:05:39 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42078 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbaLSBFi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 20:05:38 -0500
Received: by mail-ob0-f172.google.com with SMTP id va8so8810065obc.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 17:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iAfT2fNqHN8GUFCjGl8beBf68XZqMaCix8izgVdD7Is=;
        b=qTz1GiRhoyCdc43qJeI3oA1RmnvMGYmrJrCNHLpr123CHhwOv5MYsjOHSQ/0MUg4IQ
         F0LL8JvqHclNp2M0+pEC/fG8ZvqOzwTweCHnBDVyZiB1WbK9t2MkoGGPmNWZOFKlFBMj
         /npxL+O89w8Y0dBhOL5LjDoCqldKHDWFqjQQsTjltWZU+O1UG/9XReaBnwUS1VR8C/bP
         RiIgSFt3vIBpBxpgB8tMujltF5Lxg6Hdk1leCDMB0GA5ZJXx8d77jpcSAtgDm5a49kZ5
         Lg7frymniLZcbzESXpJOZXLD+46bhZ/H1gKa9SCM1N0dHakLGsk7+cD1+sgNWwxNlFSp
         ZqBQ==
X-Received: by 10.236.89.172 with SMTP id c32mr4368741yhf.180.1418951138289;
 Thu, 18 Dec 2014 17:05:38 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Thu, 18 Dec 2014 17:05:38 -0800 (PST)
In-Reply-To: <1418841177-12152-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: JmmvF-2QyFEkhAvXm_PxH_WCErg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261544>

On Wed, Dec 17, 2014 at 1:32 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This adds support to the protocol between send-pack and receive-pack to
> * allow receive-pack to inform the client that it has atomic push capability
> * allow send-pack to request atomic push back.
>
> There is currently no setting in send-pack to actually request that atomic
> pushes are to be used yet. This only adds protocol capability not ability
> for the user to activate it.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
> index 6d5424c..68ec23d 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -244,6 +245,14 @@ respond with the 'quiet' capability to suppress server-side progress
>  reporting if the local progress reporting is also being suppressed
>  (e.g., via `push -q`, or if stderr does not go to a tty).
>
> +atomic
> +------
> +
> +If the server sends the 'atomic' capability it is capable of accepting
> +atomic pushes. If the pushing client requests this capability, the server
> +will update the refs in one single atomic transaction. Either all refs are

"one single atomic" sounds awfully redundant.

> +updated or none.
> +
>  allow-tip-sha1-in-want
>  ----------------------
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 32fc540..e76e5d5 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -328,6 +332,10 @@ int send_pack(struct send_pack_args *args,
>                         "Perhaps you should specify a branch such as 'master'.\n");
>                 return 0;
>         }
> +       if (args->atomic && !atomic_supported) {
> +               return error("server does not support atomic push.");

Just above this code, the 'args->push_cert' check uses die() rather
than error() when the remote side fails to support the requested
feature.

> +       }
> +       use_atomic = atomic_supported && args->atomic;
>
>         if (status_report)
>                 strbuf_addstr(&cap_buf, " report-status");
