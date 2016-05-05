From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Thu, 5 May 2016 16:14:16 -0400
Message-ID: <20160505201416.GD9162@sigill.intra.peff.net>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
 <cover.1462342213.git.johannes.schindelin@gmx.de>
 <20160504062618.GA9849@sigill.intra.peff.net>
 <20160504074559.GA3077@sigill.intra.peff.net>
 <20160504080047.GA2436@sigill.intra.peff.net>
 <CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
 <20160505012219.GA15090@sigill.intra.peff.net>
 <xmqq60uscufw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:14:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayPfF-0007u8-PZ
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 22:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbcEEUOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 16:14:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:34712 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756005AbcEEUOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 16:14:21 -0400
Received: (qmail 15332 invoked by uid 102); 5 May 2016 20:14:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 May 2016 16:14:20 -0400
Received: (qmail 21953 invoked by uid 107); 5 May 2016 20:14:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 May 2016 16:14:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2016 16:14:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqq60uscufw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293675>

On Thu, May 05, 2016 at 09:59:15AM -0700, Junio C Hamano wrote:

> Sorry for the trouble.
> 
> I queued jk/submodule-c-credential to be mergeable to 'maint', as it
> could be argued two ways.  We can say that not propagating -c down
> is a bug and the series is a bugfix.  Or it is merely a known
> limitation and the series is a new feature.  I was leaning towards
> the former, but I was also willing to declare that is a known bug
> that will left unfixed in the maintenance track.

Ah, OK, that makes perfect sense.

> It probably is a good time to merge jk/submodule-config-sanitize-fix
> into jk/submodule-c-credential (i.e. a mere fast-forward), remove
> that "-fix" branch, and apply this patch directly on top of the
> resulting jk/submodule-c-credential.  That will make the whole thing
> a 13-patch series, consisting of:
> 
>  7 patches up to the current jk/submodule-c-credential
>   d1f8849 git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
>   14111fc git: submodule honor -c credential.* from command line
>   e70986d quote: implement sq_quotef()
>   7dad263 submodule: fix segmentation fault in submodule--helper clone
>   717416c submodule: fix submodule--helper clone usage
>   08e0970 submodule: check argc count for git submodule--helper clone
>   d10e3b4 submodule: don't pass empty string arguments to submodule--helper clone
>  
>  5 patches up to the current jk/submodule-config-sanitize-fix
>   c12e865 submodule: use prepare_submodule_repo_env consistently
>   4638728 submodule--helper: move config-sanitizing to submodule.c
>   860cba6 submodule: export sanitized GIT_CONFIG_PARAMETERS
>   455d22c t5550: break submodule config test into multiple sub-tests
>   1149ee2 t5550: fix typo in $HTTPD_URL
> 
>  1 patch (this one)
>   4e6706a submodule: stop sanitizing config options

That sounds reasonable. Note that the later patches drop the only caller
of the newly-introduced sq_quotef(). So we could revert e70986d
(omitting it from the series doesn't make sense, as it would leave a
broken state in the middle). I am also fine with leaving it. It seems
like a potentially useful addition.

I had originally thought after the final one that we could further clean
up by turning prepare_submodule_repo_env() into a static function. But
we can't; it gets called in one spot from submodule--helper. However,
while looking at it, I did notice that we probably want to squash this
into the final patch (since sanitize_submodule_config went away
completely):

diff --git a/submodule.h b/submodule.h
index 48690b1..869d259 100644
--- a/submodule.h
+++ b/submodule.h
@@ -43,19 +43,10 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 
-/*
- * This function is intended as a callback for use with
- * git_config_from_parameters(). It ignores any config options which
- * are not suitable for passing along to a submodule, and accumulates the rest
- * in "data", which must be a pointer to a strbuf. The end result can
- * be put into $GIT_CONFIG_PARAMETERS for passing to a sub-process.
- */
-int sanitize_submodule_config(const char *var, const char *value, void *data);
-
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific envirionment variables, but
- * retaining any config approved by sanitize_submodule_config().
+ * retaining any config in the environment.
  */
 void prepare_submodule_repo_env(struct argv_array *out);
 

-Peff
