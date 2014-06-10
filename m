From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "t0001: test git init when run via an alias"
Date: Tue, 10 Jun 2014 12:09:59 -0700
Message-ID: <CAPc5daW-1SbppkQicew4a60pQv-cfGXTim8zPrUBxvJ7MVXQcw@mail.gmail.com>
References: <20140606110935.GA14446@lanh> <1402220230-799-1-git-send-email-pclouds@gmail.com>
 <xmqqzjhk8ukk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	David Turner <dturner@twopensource.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 21:10:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuRRC-0006mW-Jx
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 21:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbaFJTKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 15:10:22 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40063 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaFJTKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 15:10:21 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so4260290lbi.13
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wcdQDqmPGN0+d++EihpMi1x1p7HWubVGsRNJnqW6nBM=;
        b=MUP1GM3cdRs45+7FJBDzK6asJclAwRxQ30RM+ezl79MHr/fGOMuXzVpPDyYeGJLXhG
         lIHqYyJbC0SjatL20HWJqkhRQ8gCO+gWK+m0A0K2xuqZ6ivGat/eOsK7t+O/02Y2bnYO
         yxLmmKaLEr3d0jEnlriftvjmbnd65MVQJCCi1iFdwzOMWGKqtrYbK2TV794zHPDb9OSI
         jfSIPnlceNIR+OO9vn5J76V8wrjtKuebW0AfA4T87jALDhmn8igKQDl33pjUrPNg6DAq
         NXINEA1WyJ0KNFca8u1oy74vwEMSz2Jc2Yq4i3mENRAp8PU8fGWnNioZG7WhDPD+3H0g
         wsFA==
X-Received: by 10.152.43.194 with SMTP id y2mr2619977lal.72.1402427419802;
 Tue, 10 Jun 2014 12:10:19 -0700 (PDT)
Received: by 10.112.172.103 with HTTP; Tue, 10 Jun 2014 12:09:59 -0700 (PDT)
In-Reply-To: <xmqqzjhk8ukk.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: W3e0GjEfub-KFhjb7Njo7TM_UU0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251218>

Oops; obviously the check must be for NULL-ness, i.e.

 if (!getcwd(...))
   die_errno(...);


On Tue, Jun 10, 2014 at 11:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I'd squash this in, though.
>
>  git.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index 6bb2043..9bfa8fb 100644
> --- a/git.c
> +++ b/git.c
> @@ -36,7 +36,8 @@ static void save_env(void)
>         if (saved_environment)
>                 return;
>         saved_environment = 1;
> -       getcwd(orig_cwd, sizeof(orig_cwd));
> +       if (getcwd(orig_cwd, sizeof(orig_cwd)))
> +               die_errno("cannot getcwd");
>         for (i = 0; i < ARRAY_SIZE(env_names); i++) {
>                 orig_env[i] = getenv(env_names[i]);
>                 if (orig_env[i])
