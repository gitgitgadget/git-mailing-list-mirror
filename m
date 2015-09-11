From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Makefile: use SHELL_PATH when running generate-cmdlist.sh
Date: Thu, 10 Sep 2015 20:35:07 -0400
Message-ID: <CAPig+cTQqVxo7qmFCu2h98+g2hrXogN785Wv1GRssHBtSm8VLA@mail.gmail.com>
References: <1441928227-830-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 11 02:35:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaCJe-0000SO-Cb
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 02:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbbIKAfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 20:35:08 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35173 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbIKAfH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 20:35:07 -0400
Received: by ykdu9 with SMTP id u9so76703315ykd.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 17:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=VaeR7ykk/eOWSWS1Bvmho8I8EloYJz378X/W9SeKohM=;
        b=VvaEBWCy5yAi5NFZMrOQOJUzZ5BqQLDYDe212vaZ7tS/oe9WJ3wEkTK7Jls/GG4Sva
         eZCE+lqJnPjo/f9kfIbxg75TOux60eiMrn7bnsXyFmJSAqPvWrZvOeU1m0aQAzq88W9e
         H/pN1tZwcWQ3b+5Kb3l8WWDantBLhElthLaPudyzsvKWvRfyzRYYYex5uD98IiwZ0TL7
         6YvqioPXvCKw15wLovTlmglLmoCdM4Gf7uYk7PnqUYFG9/t2HeZ/PAttIwZZquj8/9Ds
         hJcGIxqq/608TVOPm1fWMafiHM893q5dOlVBGHt85iF5oNEMkpD4QLK+hKihOJAqgjVc
         o/IQ==
X-Received: by 10.129.70.215 with SMTP id t206mr51084878ywa.4.1441931707050;
 Thu, 10 Sep 2015 17:35:07 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Thu, 10 Sep 2015 17:35:07 -0700 (PDT)
In-Reply-To: <1441928227-830-1-git-send-email-asedeno@mit.edu>
X-Google-Sender-Auth: 4y6fO_hzCAbJRo6ozzUDxOmA2UI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277649>

On Thu, Sep 10, 2015 at 7:37 PM, Alejandro R. Sede=C3=B1o <asedeno@mit.=
edu> wrote:
> Some /bin/sh implementations can't deal with $() arithmetic and comma=
nd
> substitution. If we already have a better shell on hand, we should us=
e it.
>
> Fixes the build on SunOS, probably others.

Makes sense. 527ec39^:generate-cmdlist.sh didn't use either of these
features, whereas 82aec45:generate-cmdlist.sh does, and older
(pre-POSIX) shells lacked these features. Thanks.

I'd probably re-word the commit message slightly to mention $(())
arithmetic expansion, not $(), and to state specifically $(...)
command substitution since saying only "command substitution" is
ambiguous considering that backtick `...` command substitution long
predates POSIX. Perhaps like this:

    Non-POSIX shells, such as /bin/sh on SunOS, do not support
    $((...)) arithmetic expansion or $(...) command substitution
    needed by generate-cmdlist.sh. Therefore, use the POSIX shell
    $(SHELL_PATH) when running generate-cmdlist.sh.

Other than that:

Acked-by: Eric Sunshine <sunshine@sunshineco.com>

> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> ---
> diff --git a/Makefile b/Makefile
> index ce0cfe2..6301cc8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1699,7 +1699,7 @@ $(BUILT_INS): git$X
>  common-cmds.h: generate-cmdlist.sh command-list.txt
>
>  common-cmds.h: $(wildcard Documentation/git-*.txt)
> -       $(QUIET_GEN)./generate-cmdlist.sh command-list.txt >$@+ && mv=
 $@+ $@
> +       $(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.=
txt >$@+ && mv $@+ $@
>
>  SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>         $(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_=
PATH_SQ):\
> --
> 2.5.2
