From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/send-pack.c: Respect http.signingkey
Date: Tue, 21 Jul 2015 15:24:19 -0700
Message-ID: <xmqqk2ttrvxo.fsf@gitster.dls.corp.google.com>
References: <1437516403-13622-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 00:24:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHfxa-0005Re-U6
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 00:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852AbbGUWYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 18:24:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35598 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbbGUWYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 18:24:22 -0400
Received: by pabkd10 with SMTP id kd10so54990428pab.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Qw53QaXkCMJ6DpAFivst+qP2+rw/rk5jQYC+M+jJ2CQ=;
        b=pq9S75nbFP0NBgys0Lm/3HQ0z4sSmU4zpEeUIzHhh5uOyxNXE2rHz+5Bxqo4wX/GZ4
         1fr5AeQ3/4tCcjNY2sHRhdxXFPEex9udaFO45Hk9osE6nxYfy2AzaaCWcpLJQhLIELK5
         RKFWZb1kzJafyC6mNqgieUWWcyytS5Xry1DCBSrcCwkvzWxu2krIxq4NMx/6t+cmyyMQ
         GJkmdfswZt9tD4XKJ3FLASeOu+JtDiQLh4FovUBLuUlIKgDmfVNiV3PqosNiuv89Lb5K
         f1xn64OQkpsEgO8/LdSg5F92mSsisfr+jCrc+o9lkoIpSD5xPqCPRynB2sAl/4MWhfjX
         R80A==
X-Received: by 10.70.90.193 with SMTP id by1mr24192999pdb.80.1437517461451;
        Tue, 21 Jul 2015 15:24:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id y1sm29363603pdy.2.2015.07.21.15.24.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 15:24:20 -0700 (PDT)
In-Reply-To: <1437516403-13622-1-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Tue, 21 Jul 2015 15:06:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274432>

Dave Borowitz <dborowitz@google.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Prior to this patch, when git-send-pack was exec'ed, as is done by
> git-remote-http, it did not reread the config, so it did not respect
> the configured value of http.signingkey. Thus it was impossible to
> specify a signing key over HTTP, other than the default key in the
> keyring having a User ID matching the "Name <email>" format.
>
> This patch at least partially fixes the problem by reading in the GPG
> config from within send-pack. It does not address the related problem
> of plumbing a value for this configuration option using
> `git -c http.signingkey push ...`.

I am hoping that "git -c user.signingkey=frotz push ..." would solve
that problem, but I probably am being too optimistic ;-)

Thanks.

>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  builtin/send-pack.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index b961e5a..23b2962 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -11,6 +11,7 @@
>  #include "transport.h"
>  #include "version.h"
>  #include "sha1-array.h"
> +#include "gpg-interface.h"
>  
>  static const char send_pack_usage[] =
>  "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]\n"
> @@ -113,6 +114,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	int from_stdin = 0;
>  	struct push_cas_option cas = {0};
>  
> +	git_config(git_gpg_config, NULL);
> +
>  	argv++;
>  	for (i = 1; i < argc; i++, argv++) {
>  		const char *arg = *argv;
