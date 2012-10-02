From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 3/5] diff: acknowledge --submodule=short command-line
 option
Date: Tue, 02 Oct 2012 21:24:36 +0200
Message-ID: <506B3F74.3020208@web.de>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com> <1349196670-2844-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ85L-0005dN-J3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab2JBTYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:24:41 -0400
Received: from mout.web.de ([212.227.17.11]:53526 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab2JBTYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:24:41 -0400
Received: from [192.168.178.41] ([91.3.177.137]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M0R25-1TZXuE1sSr-00uVY6; Tue, 02 Oct 2012 21:24:39
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1349196670-2844-4-git-send-email-artagnon@gmail.com>
X-Provags-ID: V02:K0:LeREzbU4DMOI7bT/rvUBBNV3MOpbAzv0ZlRaVej8lbt
 2cisqVVqOc55LOrAfwVFNQ/IDMzhr1EXSHRv3l7ibyfI0pCGda
 5roedst9hxabLnblYXBnmfxKAUISwAawKyhw5/CAmkww/V+9Gt
 GYDqEUI5gtuQjPefnqD8/mW3QtgFf1MDFT+/rJiP0AYg5v5VcS
 LskGxlpLGLd0lM5D8UIEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206837>

Am 02.10.2012 18:51, schrieb Ramkumar Ramachandra:
> Currently, the diff code does not differentiate between an explicit
> '--submodule=short' being passed, and no submodule option being passed
> on the command line.  Making this differentiation will be important
> when the command-line option can be used to override a
> "diff.submoduleFormat" configuration variable introduced in the next
> patch.

Wouldn't it be sufficient here to simply reset the log flag by using
"DIFF_OPT_CLR(options, SUBMODULE_LOG)"? This would avoid having to
use the last bit of the diffopt flags. And if I read the code correctly,
diff_opt_parse() is called by setup_revisions() which is called after
git_config(), so that should be safe. (And "textconv" uses the same
approach)

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  diff.c |    4 +++-
>  diff.h |   17 +++++++++--------
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 35d3f07..8ea40f9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3647,7 +3647,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  	} else if (!strcmp(arg, "--submodule"))
>  		DIFF_OPT_SET(options, SUBMODULE_LOG);
>  	else if (!prefixcmp(arg, "--submodule=")) {
> -		if (!strcmp(arg + 12, "log"))
> +		if (!strcmp(arg + 12, "short"))
> +			DIFF_OPT_SET(options, SUBMODULE_SHORT);
> +		else if (!strcmp(arg + 12, "log"))
>  			DIFF_OPT_SET(options, SUBMODULE_LOG);
>  	}
>  
> diff --git a/diff.h b/diff.h
> index a658f85..4115b49 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -77,14 +77,15 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
>  #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
>  #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
>  #define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
> -#define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
> -#define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
> -#define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
> -#define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
> -#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
> -#define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
> -#define DIFF_OPT_FUNCCONTEXT         (1 << 29)
> -#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
> +#define DIFF_OPT_SUBMODULE_SHORT     (1 << 23)
> +#define DIFF_OPT_SUBMODULE_LOG       (1 << 24)
> +#define DIFF_OPT_DIRTY_SUBMODULES    (1 << 25)
> +#define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 26)
> +#define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 27)
> +#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 28)
> +#define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 29)
> +#define DIFF_OPT_FUNCCONTEXT         (1 << 30)
> +#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 31)
>  
>  #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
>  #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
> 
