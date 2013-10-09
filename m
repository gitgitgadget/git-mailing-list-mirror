From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCHv2 2/3] git-svn: Warn about changing default for
 --prefix in Git v2.0
Date: Tue, 8 Oct 2013 21:34:45 -0400
Message-ID: <CAPig+cRAg4NpAsUWGQPsLcaFmDn61POv1pdHKCrSyQbM0KgM4A@mail.gmail.com>
References: <20131003190139.GA8710@dcvr.yhbt.net>
	<1381015833-696-1-git-send-email-johan@herland.net>
	<1381015833-696-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, tfnico@gmail.com,
	Eric Wong <normalperson@yhbt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 03:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTift-0002NA-RL
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 03:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab3JIBev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 21:34:51 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35547 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962Ab3JIBes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 21:34:48 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so197536lbh.20
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 18:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3rAF6+PXlL+2wuTsIvWtGLwY+1eDn5DFZFNrAJ0f1Iw=;
        b=qAsgjqC5yU7rL/jIK/aJQ6UDCdzeSbztl53zghtsFumWt9D1658xUg4uRTAsc05MRv
         xxNBJni0g90KXJ8rZxSMroQyXuGfoUSM/aLla5A2ai96Y0dEWYM0JvO+cia4L9xblo1k
         bIskWRnkwoVQ3etAAYg9nxT6VTVY0dCgFpb5qtEwAng5XpcWGRFDDJ8ep0TEeBVKglDA
         jkVvTqycXMnYKCny9mHv6xpQW4afBHSw7tMK8sa0lr6i0guOQTdaxnOwpsjnfwlaYPdW
         4d0tKvgmXN5iF7tEkmNABbH+LpVakhARZU6GVH+IuRKKBsm2OPGEOr32hUXYYPweVoKz
         S8pw==
X-Received: by 10.152.203.233 with SMTP id kt9mr3878367lac.29.1381282485566;
 Tue, 08 Oct 2013 18:34:45 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 8 Oct 2013 18:34:45 -0700 (PDT)
In-Reply-To: <1381015833-696-2-git-send-email-johan@herland.net>
X-Google-Sender-Auth: r5aIfwxrJCK7prFyvn3aWZjYXxk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235799>

On Sat, Oct 5, 2013 at 7:30 PM, Johan Herland <johan@herland.net> wrote:
> diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
> index b7ef9e2..1c8d049 100755
> --- a/t/t9117-git-svn-init-clone.sh
> +++ b/t/t9117-git-svn-init-clone.sh
> @@ -52,4 +52,71 @@ test_expect_success 'clone to target directory with --stdlayout' '
>         rm -rf target
>         '
>
> +test_expect_success 'clone without -s/-T/-b/-t does not warn' '
> +       test ! -d trunk &&
> +       git svn clone "$svnrepo"/project/trunk 2>warning &&
> +       test_must_fail grep -q prefix warning &&
> +       rm -rf trunk &&
> +       rm -f warning
> +       '
> +
> +test_svn_configured_prefix () {
> +       prefix=$1

Did you want to maintain the &&-chain here?

> +       cat >expect <<EOF

And here?

> +project/trunk:refs/remotes/${prefix}trunk
> +project/branches/*:refs/remotes/${prefix}*
> +project/tags/*:refs/remotes/${prefix}tags/*
> +EOF
> +       test ! -f actual &&
> +       git --git-dir=project/.git config svn-remote.svn.fetch >>actual &&
> +       git --git-dir=project/.git config svn-remote.svn.branches >>actual &&
> +       git --git-dir=project/.git config svn-remote.svn.tags >>actual &&
> +       test_cmp expect actual &&
> +       rm -f expect actual
> +}
