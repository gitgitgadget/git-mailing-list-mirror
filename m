From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/2] parse-options: export opterr, optbug
Date: Thu, 11 Aug 2011 05:42:36 -0500
Message-ID: <20110811104236.GB5012@elie.gateway.2wire.net>
References: <1313054138-30885-1-git-send-email-divanorama@gmail.com>
 <1313054138-30885-2-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 12:42:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrSiu-0005hM-ML
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 12:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab1HKKmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 06:42:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53906 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab1HKKmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 06:42:42 -0400
Received: by gya6 with SMTP id 6so1209925gya.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cLa/QUleRo8LNnKeBi4hPR6ShqiDlcbyVt1bBYTNFf4=;
        b=icYFXqOTmn4gH3H+CYkFI31Ok254ayD4MjClD0+TmxZ2vo3YEUl//LzZ0R4Lt6a2rD
         adsmnnpko6pkbJqeNpp6LsX72hDlGH+uKDefE03R9LDA7Sk1vzkP/ESpBFG6T2R9M7NE
         b5K//h+RW3aM2xY3otzjpoGdWb+rfQ8E4/gAI=
Received: by 10.42.244.3 with SMTP id lo3mr8810836icb.335.1313059361839;
        Thu, 11 Aug 2011 03:42:41 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id d8sm2929230icy.21.2011.08.11.03.42.40
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 03:42:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313054138-30885-2-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179107>

(+cc: Stephen)
Dmitry Ivankov wrote:

> opterror and optbug functions are used by some of parsing routines
> in parse-options.c to report errors and bugs respectively.
>
> Export these functions to allow more custom parsing routines to use
> them in a uniform way.

In other words, exposing opterror() allows custom option types to
behave more like the built-in ones when producing messages like
"option `<opt>' expects a numerical value".  What should they pass
in the "flags" argument?  Does this deserve a mention in the
"Option Callbacks" section of
Documentation/technical/api-parse-options.txt?

Would opterror() be enough?  I don't see any current users of optbug
outside of parse_options_check() (which is part of low-level
machinery).

Aside from that, seems sensible.

[quoting in full for Stephen's convenience.  One quick comment
below.]
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---
>  parse-options.c |    4 ++--
>  parse-options.h |    2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 879ea82..7b061af 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -12,14 +12,14 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>  #define OPT_SHORT 1
>  #define OPT_UNSET 2
>  
> -static int optbug(const struct option *opt, const char *reason)
> +int optbug(const struct option *opt, const char *reason)
>  {
>  	if (opt->long_name)
>  		return error("BUG: option '%s' %s", opt->long_name, reason);
>  	return error("BUG: switch '%c' %s", opt->short_name, reason);
>  }
>  
> -static int opterror(const struct option *opt, const char *reason, int flags)
> +int opterror(const struct option *opt, const char *reason, int flags)
>  {
>  	if (flags & OPT_SHORT)
>  		return error("switch `%c' %s", opt->short_name, reason);
> diff --git a/parse-options.h b/parse-options.h
> index 05eb09b..59e0b52 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -165,6 +165,8 @@ extern NORETURN void usage_msg_opt(const char *msg,
>  				   const char * const *usagestr,
>  				   const struct option *options);
>  
> +extern int optbug(const struct option *opt, const char *reason);
> +extern int opterror(const struct option *opt, const char *reason, int flags);
>  /*----- incremental advanced APIs -----*/

A blank line above the comment would make this more readable.

>  
>  enum {
> -- 

Except as noted above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Some (though not all) of the possible changes noted above implemented
below, plus an example caller (which made reading the patch a little
easier).  What do you think?

 builtin/read-tree.c |    2 +-
 parse-options.c     |    2 +-
 parse-options.h     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git c/builtin/read-tree.c i/builtin/read-tree.c
index df6c4c88..6013090c 100644
--- c/builtin/read-tree.c
+++ i/builtin/read-tree.c
@@ -53,7 +53,7 @@ static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 	opts = (struct unpack_trees_options *)opt->value;
 
 	if (opts->dir)
-		die("more than one --exclude-per-directory given.");
+		return opterror(opt, "can only be supplied once", 0);
 
 	dir = xcalloc(1, sizeof(*opts->dir));
 	dir->flags |= DIR_SHOW_IGNORED;
diff --git c/parse-options.c i/parse-options.c
index 7b061afc..777611b1 100644
--- c/parse-options.c
+++ i/parse-options.c
@@ -12,7 +12,7 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-int optbug(const struct option *opt, const char *reason)
+static int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name)
 		return error("BUG: option '%s' %s", opt->long_name, reason);
diff --git c/parse-options.h i/parse-options.h
index 59e0b524..6d31ad3a 100644
--- c/parse-options.h
+++ i/parse-options.h
@@ -165,8 +165,8 @@ extern NORETURN void usage_msg_opt(const char *msg,
 				   const char * const *usagestr,
 				   const struct option *options);
 
-extern int optbug(const struct option *opt, const char *reason);
 extern int opterror(const struct option *opt, const char *reason, int flags);
+
 /*----- incremental advanced APIs -----*/
 
 enum {
