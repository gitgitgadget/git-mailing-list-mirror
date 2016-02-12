From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv10 5/7] git submodule update: have a dedicated helper for cloning
Date: Fri, 12 Feb 2016 14:27:06 -0800
Message-ID: <CAGZ79kZrLVVJ6kfm2FS2xaaqw100hFF7+Y4yZ4aU2bH5=Aj7-Q@mail.gmail.com>
References: <1455242592-19352-1-git-send-email-sbeller@google.com>
	<1455242592-19352-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 23:27:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUMBF-0007Yo-C0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 23:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbcBLW1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 17:27:09 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35574 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbcBLW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 17:27:07 -0500
Received: by mail-io0-f176.google.com with SMTP id g203so80558735iof.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 14:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xuzX29FIM2H6RqLxx70MBv1oTPUDRoMFEqrLce9I9Ug=;
        b=fvuhFnVm+99X2lR2zlkE7DASu3eg7izqnek6tAo0wZNzEQ7ZG75LMuIhOTzn1882q4
         hi0K6btEiNv8tnpaEufwaMbkAORQuBrBXeIfBgLg0rCbQiYU8sqBd1C9nxP9kuk6H/SA
         uP9t/FWU5auBNrz/fTm+cHg3pll6ANhMfSJlOygsljdEv148YeaY7coDfEgxUHC+VyL+
         dNUo1htw579qIBYYTbOn/5fB17KNZefsj3+lXT4T+heEclEwqWx8/GB4UXZWfru9yOM/
         SlTdem8fVsgYtR/O0nbCzQfT4HRDuxs8lfSmHzBH9bkHichVrPzxQ/pSgl87bbZOuxAz
         Puvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xuzX29FIM2H6RqLxx70MBv1oTPUDRoMFEqrLce9I9Ug=;
        b=RGxol1jEt2SdLyyIPvny5SGARljFvt7EovUqKabP2435usmdMfAbFK/BjoG9lBF3ze
         GImL9+pNbG1Ng52zYOpTXOuGVeKNCF1QD/wz/BBj+iWZR8RfazPXjJIOIaOixf5QEp7d
         6n45DbA5WTUv1Bksw3v9wWRjodgABj6v4WnyWBjVjFKF0NHzSp8voXWuTevHafrPUc0p
         X6CuCBzJp+t3al7o7Vc6LgmqkFcaV6UzWtIOhU1gqbvzKyXrgO08tkBfpDB76Be3Db2q
         ziqHsRwM9jl7pOSVvi2/0BX8a/o0mSFtgXhRtuhpNJMRllyR+23wt1Rmp7yCxrx69B30
         VcoQ==
X-Gm-Message-State: AG10YOTwQ44JfyOBiAgQvM2TdbhR/YV82vqx201vFdkWSoSGZHBTUjrn9WvxLErU7s/MQWGSbjuzKu0HSEWsdNE/
X-Received: by 10.107.137.100 with SMTP id l97mr6324597iod.110.1455316027047;
 Fri, 12 Feb 2016 14:27:07 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 12 Feb 2016 14:27:06 -0800 (PST)
In-Reply-To: <1455242592-19352-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286080>

On Thu, Feb 11, 2016 at 6:03 PM, Stefan Beller <sbeller@google.com> wrote:
> This introduces a new helper function in git submodule--helper
> which takes care of cloning all submodules, which we want to
> parallelize eventually.
>
> Some tests (such as empty URL, update_mode=none) are required in the
> helper to make the decision for cloning. These checks have been
> moved into the C function as well (no need to repeat them in the
> shell script).
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 236 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  45 +++------
>  2 files changed, 247 insertions(+), 34 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff..e865fca 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -255,6 +255,241 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static int git_submodule_config(const char *var, const char *value, void *cb)
> +{
> +       return submodule_config(var, value, cb);
> +}

This is the thing I forgot to address.
Next reroll will inline submodule_config directly.

Stefan
