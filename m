From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git issues with submodules
Date: Sun, 24 Nov 2013 17:29:22 +0100
Message-ID: <52922962.3090407@web.de>
References: <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com> <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com> <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com> <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com> <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com> <528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub> <20131122220953.GI4212@google.com> <52910BC4.1030800@web.de> <20131124005256.GA3500@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Nov 24 17:29:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkcZA-00033H-KA
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 17:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab3KXQ33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 11:29:29 -0500
Received: from mout.web.de ([212.227.15.3]:57062 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab3KXQ32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 11:29:28 -0500
Received: from [192.168.178.41] ([91.3.173.138]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0LcUIo-1VKsmO1DUs-00jp7n for <git@vger.kernel.org>;
 Sun, 24 Nov 2013 17:29:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131124005256.GA3500@sandbox-ub>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:iXlwVIrB+u7JaovFJ8EDDolkCnBYXCtKguBYuw3guxYOj+56HwG
 E6wPKF9YvAzRwMkygoq5AdaZYYOhaLA4qNEioAvaR01AOvc0+/IgkJUMYTE1XXNom2wUrze
 xBHAQua2DR03qwI5ZcrqrofiFhyDuomHyfJe6UL7Mu/v1LqpPDn1F9SAbA0ydwD5YZ0p/hW
 kSbEHfqqoHtjrmTFdb+Sg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238264>

Am 24.11.2013 01:52, schrieb Heiko Voigt:
> Hi,
> 
> On Sat, Nov 23, 2013 at 09:10:44PM +0100, Jens Lehmann wrote:
>> Am 22.11.2013 23:09, schrieb Jonathan Nieder:
>>> Heiko Voigt wrote:
>>>
>>>> After that we can discuss whether add should add submodules that are
>>>> tracked but not shown. How about commit -a ? Should it also ignore the
>>>> change? I am undecided here. There does not seem to be any good
>>>> decision. From the users point of view we should probably not add it
>>>> since its not visible in status. What do others think?
>>>
>>> I agree --- it should not add.
>>
>> I concur: adding a change that is hidden from the user during
>> the process is not a good idea.
> 
> Here is a patch achieving that. Still missing a test which I will add.

Looking good to me. Please add tests for "diff.ignoreSubmodules"
and "submodule.<name>.ignore", the latter both in .gitmodules and
.git/config. While doing some testing for this thread I found an
inconsistency in git show which currently honors the submodule
specific option only from .git/config and ignores it in the
.gitmodules file (depending on the outcome of the discussion on
what '--ignore-submodules=all' should ignore we might have to fix
that one afterwards).

I'd suggest to also add the --ignore-submodules option in another
patch on top, because the user should be able to override the
configuration either way. And what about having the '-f' option
imply '--ignore-submodules=none'?

> Cheers Heiko
> 
> ---8<----
> Subject: [PATCH] fix 'git add' to skip submodules configured as ignored
> 
> If submodules are configured as ignore=all they are not shown by status.
> Lets also ignore them when adding files to the index. This avoids that
> users accidentially add ignored submodules with: git add .
> 
> We achieve this by reading the submodule config and thus correctly
> initializing the infrastructure to take the ignore decision.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  builtin/add.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 226f758..2d0d2ef 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -15,6 +15,7 @@
>  #include "diffcore.h"
>  #include "revision.h"
>  #include "bulk-checkin.h"
> +#include "submodule.h"
>  
>  static const char * const builtin_add_usage[] = {
>  	N_("git add [options] [--] <pathspec>..."),
> @@ -378,6 +379,10 @@ static int add_config(const char *var, const char *value, void *cb)
>  		ignore_add_errors = git_config_bool(var, value);
>  		return 0;
>  	}
> +
> +	if (!prefixcmp(var, "submodule."))
> +		return parse_submodule_config_option(var, value);
> +
>  	return git_default_config(var, value, cb);
>  }
>  
> @@ -415,6 +420,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	int implicit_dot = 0;
>  	struct update_callback_data update_data;
>  
> +	gitmodules_config();
>  	git_config(add_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix, builtin_add_options,
> 
