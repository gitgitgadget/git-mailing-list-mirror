Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E01C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 14:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjDCOdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 10:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjDCOdH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 10:33:07 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4312E7D
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 07:32:55 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 52537240008;
        Mon,  3 Apr 2023 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1680532373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABuPrhgb1bfKlXyrcYRmwA/guTzVtIEFqBVhJSCJg7w=;
        b=CsYURUCcqkbBpoOY/XB5gUCCX/Yjl6+PAw0y01p05RbdIhdQO718uNrSxUXyzYwrSlSzaD
        YWCz6Cu6gA5/eT2EpE2eJYIVza/mkCFyPOTRuSgcF9Rul0m1zeq7lnk814htUKc2+/fhNa
        qQpZTLYknUFGCza4dP77nTTVaPRDtHCPHEh/r5WsADcEkQNyIVhN4hYSuHtkZH1lVh3V/b
        3cclORVW3qrA3rbmdspcyxiHTNfCPQUhthw5SYtve2+yb/YuuvdJhU5qtzv0Uu812Dp7sZ
        7YV8NcSgsxBi7AFOuqEZW7JSkfECd2c0E4eHwKSY3lmycQ9M1CCvzsXJ0FcAyQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 03 Apr 2023 16:32:50 +0200
Message-Id: <CRN7096DENCQ.1HF4OQ0ZD4HFP@ringo>
Cc:     "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
From:   "Robin Jarry" <robin@jarry.cc>
To:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
X-Mailer: aerc/0.14.0-144-gf975689ea403
References: <20230402185635.302653-1-robin@jarry.cc>
 <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
In-Reply-To: <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Phillip Wood, Apr 03, 2023 at 16:09:
> > +  <patch-file> LF
>
> Usually git commands that produce or consume paths either use quoted=20
> paths terminated by LF or unquoted paths terminated by NUL. That way=20
> there is no ambiguity when a path contains LF.

I had never imagined that some twisted mind would insert LF in path
names but since nothing will forbid it, I agree that it is
a possibility.

I'm not sure what you mean by quoted paths, you mean adding literal
double quotes before printing them to the hook stdin? That means the
hook needs to handle de-quoting after reading, right?

> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 07f2a0cbeaad..bec4d0f4ab47 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -800,6 +800,7 @@ sub is_format_patch_arg {
> >   			validate_patch($f, $target_xfer_encoding);
> >   		}
> >   	}
> > +	validate_patch_series(@files)
>
> This happens fairly early, before the user has had a chance to edit the=
=20
> patches and before we have added all the recipient and in-reply-to=20
> headers to the patch files. Would it be more useful to validate what=20
> will actually be sent?

I agree that it would be better. I added the check here to be in line
with the existing sendemail-validate hook. I could move it after edition
and header finalization but then we would need to move
sendemail-validate as well for consistency. What do you think?

> > +	# The hook needs a correct cwd and GIT_DIR.
> > +	require Cwd;
> > +	my $cwd_save =3D Cwd::getcwd();
> > +	chdir($repo->wc_path() or $repo->repo_path()) or die("chdir: $!");
> > +	local $ENV{"GIT_DIR"} =3D $repo->repo_path();
>
> This looks like it is copied from the existing code but why do we need=20
> to do this? I'm struggling to come up with a scenario where "git=20
> send-email" can find the repository but the hook cannot.

Again, for consistency I assumed it would be best to keep the code
similar in both hooks. If you think it is safe to skip that check, I'll
remove it gladly.

> > +	# cannot use git hook run, it closes stdin before forking the hook
> > +	open(my $stdin, "|-", $validate_hook) or die("fork: $!");
>
> This passes $validate_hook to the shell to execute which is not what we=
=20
> want as it will split the hook path on whitespace etc. I think it would=
=20
> be better to use "git hook run --to-stdin" (see 0414b3891c (hook:=20
> support a --to-stdin=3D<path> option, 2023-02-08))

Ah that's a nice addition. I'll add that in v2.

Thanks for reviewing!
