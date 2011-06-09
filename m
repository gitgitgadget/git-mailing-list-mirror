From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] config.c: Make git_config() work correctly when
 called recursively
Date: Thu, 9 Jun 2011 16:39:58 -0400
Message-ID: <20110609203958.GA4671@sigill.intra.peff.net>
References: <4DF106B8.2080902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, johan@herland.net
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 09 22:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUm1a-00068X-T6
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 22:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab1FIUkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 16:40:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47010
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611Ab1FIUkD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 16:40:03 -0400
Received: (qmail 19396 invoked by uid 107); 9 Jun 2011 20:40:09 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 16:40:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 16:39:58 -0400
Content-Disposition: inline
In-Reply-To: <4DF106B8.2080902@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175575>

On Thu, Jun 09, 2011 at 06:45:28PM +0100, Ramsay Jones wrote:

> The recursive call to git_config() is due to the "schizophrenic stat"
> functions on cygwin, and is arrived at as follows:
> 
>   cmd_notes() : builtin/notes.c:1057
>     =>copy() @1084: builtin/notes.c:605
>       =>notes_copy_from_stdin() @630: builtin/notes.c:418
>         =>init_copy_notes_for_rewrite() @426: builtin/notes.c:359
>           =>git_config() @384: config.c:876
> 
>   *cb=>notes_rewite_config() : builtin/notes.c:329
>     =>string_list_add_refs_by_glob() @348 : notes.c:936
>       =>for_each_glob_ref() @939: refs.c:815
>         =>for_each_glob_ref_in() @817: refs.c:785
>           =>for_each_ref() @809: refs.c:729
>             =>do_for_each_ref() @731: refs.c:658
>               =>get_loose_refs() @663: refs.c:359
>                 =>get_ref_dir() @368: refs.c:258
>                   =>stat() @299: compat/cygwin.h:8
> 
>   stat macro => indirect call: *cygwin_stat_fn : compat/cygwin.c:141
>     =>cygwin_stat_stub() : compat/cygwin.c:131
>       =>init_stat() @133: compat/cygwin.c:115
>         =>git_config() @118: config.c:876

Wow, that's quite a call-chain.

> I have not sent this patch to the list before, since I had planned to find
> a different solution first, so this (updated patch) is more by way of an
> extended bug-report! Having said that, it works fine ...

I think it's actually a pretty sane approach. Your other option would be
not lazily configuring cygwin stat, which means putting an extra very
early stat call somewhere.

But look at how deep the call chain above is. And consider how the bug
manifested itself: silently ignoring some config. So I wouldn't be
terribly surprised if there is another such recursion hiding somewhere,
or if we manage to introduce one accidentally in the future.

So making git_config safe for recursion seems like a good solution for
future maintainability.

>  config.c |   80 ++++++++++++++++++++++++++++++++++++++-----------------------

The patch looks sane from my quick skim, though:

> -static FILE *config_file;
> -static const char *config_file_name;
> -static int config_linenr;
> -static int config_file_eof;
> +typedef struct config_file {
> +	struct config_file *prev;
> +	FILE *f;
> +	const char *name;
> +	int linenr;
> +	int eof;
> +	struct strbuf value;
> +	char var[MAXNAME];
> +} config_file;
> +
> +static config_file *cf;

Since you've nicely encapsulated all of the global data in this struct,
maybe it is worth simply passing a struct pointer down the call-chain
instead of relying on a global pointer. Then you can let the language do
its job and stop managing the stack yourself.

-Peff
