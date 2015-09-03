From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove perl dependant commands if NO_PERL is set
Date: Thu, 03 Sep 2015 13:04:34 -0700
Message-ID: <xmqqy4gni819.fsf@gitster.mtv.corp.google.com>
References: <1441309604-91875-1-git-send-email-garga@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: garga@FreeBSD.org
X-From: git-owner@vger.kernel.org Thu Sep 03 22:04:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXakS-0005tG-B5
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757437AbbICUEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 16:04:36 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36701 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651AbbICUEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 16:04:35 -0400
Received: by pacwi10 with SMTP id wi10so333527pac.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XfDDgz9zqxcND2M1bzgJ7GIulLOIH4rDpZcQoWdXDog=;
        b=fNjS3QkxIILPBX9eby2ggOMI1mJasja+9JcagN31B4gWE7re2SmcnV/p9svV91gGg/
         AQjHelJci2Kxl2bKoT9hBV9RzGDpmuLqu4FHBOo21UZjMndoxSKyyatZoTQWc9+aMXxq
         F4sSDpamSYYM6jQcL3IMY6YthZS+ADpHBgCQcUyn8qZnNyBa7aB9m2BhIk9+jC9RSBXX
         1AR3OXJEsk/xSdCLr96vzM5HOp4n3JXLX2dAaJHeHn9xlUMUYEwngguBEvoUiy65lsim
         c8PjlsDPxjiEVRJueuePdgME7uN3aP08NGBaX0NviNLpYewpFeFzlpmCijoukTt5AO1i
         9Dhw==
X-Received: by 10.66.221.193 with SMTP id qg1mr73393184pac.103.1441310675559;
        Thu, 03 Sep 2015 13:04:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id hv3sm26148467pbb.83.2015.09.03.13.04.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 13:04:34 -0700 (PDT)
In-Reply-To: <1441309604-91875-1-git-send-email-garga@FreeBSD.org>
	(garga@freebsd.org's message of "Thu, 3 Sep 2015 16:46:44 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277250>

garga@FreeBSD.org writes:

> From: Renato Botelho <garga@FreeBSD.org>
>
> git-submodule and git-request-pull are written in sh but use perl
> internally. Add them to be replaced by unimplemented.sh when NO_PERL
> flag is set
>
> Signed-off-by: Renato Botelho <garga@FreeBSD.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index e326fa0..4dae0ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1795,7 +1795,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
>  	chmod +x $@+ && \
>  	mv $@+ $@
>  else # NO_PERL
> -$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
> +$(SCRIPT_PERL_GEN) git-instaweb git-submodule git-request-pull: % : unimplemented.sh
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>  	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \

Thanks, but this I suspect is insufficient.  In the pre-context of
your patch, you can see we have a rule to create git-instaweb when
NO_PERL is not in effect, so either way, we only have one rule to
create git-instaweb.

You are not disabling the rule to create the real git-submodule
and git-request-pull when NO_PERL is in effect with this patch,
without it, 'make' cannot tell which variant of git-submodule and
git-request-pull needs to be built.

I agree replacing commands with unimplemented may be a good thing; I
do not object to the goal of the patch.  But hopefully you now see
why it is too late to start discussing it with 2.6 as the goal.
