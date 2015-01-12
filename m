From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv12 06/10] receive-pack.c: negotiate atomic push support
Date: Mon, 12 Jan 2015 18:29:52 -0500
Message-ID: <CAPig+cQv6Dr7z56qXiqzZLmuBt=_TWcPSpQSTyLv0euT-k+umA@mail.gmail.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
	<1420687404-13997-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAoQo-0005oG-UC
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 00:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbALX3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 18:29:55 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:53457 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbbALX3x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 18:29:53 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so10586036ykp.11
        for <git@vger.kernel.org>; Mon, 12 Jan 2015 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ab/cm+b4DzoWJjcMCuCv+j9aP171HN1+dMq47irYuGc=;
        b=d2T3AIbteAKfaiPG1D3TP++DRfbPYMlMN3QSqBb4E/60ejOeydf6JbSFE+LhZK49+4
         60d3zINV22WdAtGac529NBGnFQh3IPnc3BS+FQdQuUONdFEYZaLmwoMLUoE6QO7kNl9k
         5lB6PYqprjkybNvECapmILU1LXjcX7rvncGR39ljbRvc7fXV46jnZPbBfZ1KZXKG+X1d
         txdToMnmsB0G+sygsrIvTf9bIsZzisorccNxHCCE2ZbFrPW2BHNHtIorID//IqVNpcTs
         BLe3SX0Tr0lklIW7A+4r1423W0pswNvCw1w4ROiJgrWwDf1peyGrXkbcF3y5DK8/GnGY
         J4jg==
X-Received: by 10.236.202.238 with SMTP id d74mr24316533yho.166.1421105392791;
 Mon, 12 Jan 2015 15:29:52 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 12 Jan 2015 15:29:52 -0800 (PST)
In-Reply-To: <1420687404-13997-7-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: TpGyCoZdPsVTARs8Af0kVh3KcwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262302>

On Wed, Jan 7, 2015 at 10:23 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This adds the atomic protocol option to allow
> receive-pack to inform the client that it has
> atomic push capability.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     v9:
>      We can configure the remote if it wants to advertise
>      atomicity!
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 362d33f..4c069c5 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -159,6 +160,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>                 return 0;
>         }
>
> +       if (strcmp(var, "receive.advertiseatomic") == 0) {
> +               advertise_atomic_push = git_config_bool(var, value);
> +               return 0;
> +       }

Is this needed only to support the tests you add in t5543, or do you
intend it to be useful to end users?

If it is for end users, then it deserves to be documented. Is also
deserves proper mention and justification in the commit message.

If it's only intended to assist automated testing, then perhaps
control it via an environment variable rather than a configuration
option. (See, for instance, GIT_TEST_SPLIT_INDEX or GIT_USE_LOOKUP as
precedent.)

> +
>         return git_default_config(var, value, cb);
>  }
>
> @@ -174,6 +180,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
>
>                 strbuf_addstr(&cap,
>                               "report-status delete-refs side-band-64k quiet");
> +               if (advertise_atomic_push)
> +                       strbuf_addstr(&cap, " atomic");
>                 if (prefer_ofs_delta)
>                         strbuf_addstr(&cap, " ofs-delta");
>                 if (push_cert_nonce)
> @@ -1263,6 +1271,9 @@ static struct command *read_head_info(struct sha1_array *shallow)
>                                 use_sideband = LARGE_PACKET_MAX;
>                         if (parse_feature_request(feature_list, "quiet"))
>                                 quiet = 1;
> +                       if (advertise_atomic_push
> +                           && parse_feature_request(feature_list, "atomic"))
> +                               use_atomic = 1;
>                 }
>
>                 if (!strcmp(line, "push-cert")) {
> --
> 2.2.1.62.g3f15098
