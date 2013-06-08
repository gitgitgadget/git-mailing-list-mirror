From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] status: introduce status.short to enable --short by default
Date: Sat, 8 Jun 2013 20:55:19 +0530
Message-ID: <CALkWK0kvKzFoZmz313hR-3Z71y-MDPT37BfUi7Qrgy7hz_sErQ@mail.gmail.com>
References: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 17:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlL1v-0007zM-8c
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 17:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab3FHP0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 11:26:01 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:63759 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3FHP0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 11:26:00 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so8127452iea.39
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C6kljsDmlKdzb/ycN+E7nCmUBGZEFeXkk5XIhU1trsU=;
        b=HmAnKOSKQX0eKTteBVbqv7Dy3+CdnotRUIvtmSjKi0BFcKbS7onU8K7hxSGmT9AKVE
         202fmGeL3XzcsVLBwTgeEQ2EGoodS9UbG50Ly9OYyUOoOR9GE+nXmWp4PotndM6HAIEs
         pf+GBinFoxlCeKtQ27DhXfffspoSA/eDT+qv0xBJ2dtW1qinGAhJuz8HqY70QFu2AArp
         QKipM2bGlHmsall1axFWV7MznfLnhE9x6WOCSeAnGu5vW27oJZAMAx5P50Ik5akxYhG/
         AL9cr3qtbR5da5t56bi9UMAD/YZe3t9SchD0rmF7AuorXq9lsPiZG0cAN8B+HeJ82oHi
         uN1g==
X-Received: by 10.50.55.99 with SMTP id r3mr1064587igp.0.1370705160403; Sat,
 08 Jun 2013 08:26:00 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 08:25:19 -0700 (PDT)
In-Reply-To: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226833>

Jorge Juan Garcia Garcia wrote:
> Some people always run 'git status -s'.
> The configuration variable status.short allows to set it by default.

Good feature.

> @@ -1112,6 +1112,15 @@ static int git_status_config(const char *k, const char *v, void *cb)
>                         s->submodule_summary = -1;
>                 return 0;
>         }
> +       if (!strcmp(k, "status.short")) {
> +               if (!v)
> +                       return config_error_nonbool(k);
> +               if (git_config_bool(k,v)) {
> +                       status_format = STATUS_FORMAT_SHORT;
> +                       wt_shortstatus_print(s);
> +               }
> +               return 0;
> +       }

Incorrect.  This is the wrong place to use config_error_nonbool():
this is very much a bool, and a "[status] short" in ~/.gitconfig
should not error out (all boolean variables behave in the same
manner).  When in doubt, consult config_error_nonbool(); there's
clearly a comment stating:

/*
 * Call this to report error for your variable that should not
 * get a boolean value (i.e. "[my] var" means "true").
 */

Also, why are you calling wt_shortstatus_print() here, instead of
returning control to cmd_status(), which is going to do it anyway?
