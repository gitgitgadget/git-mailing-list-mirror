From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH] Add `log.decorate' configuration variable.
Date: Wed, 17 Feb 2010 15:04:21 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002171427080.3414@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am> <7vljespt2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 03:16:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhZSo-00032e-1I
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 03:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933971Ab0BQCQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 21:16:11 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:49006 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933927Ab0BQCQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 21:16:09 -0500
Received: from idran.drake.org.nz (ip-118-90-92-203.xdsl.xnet.co.nz [118.90.92.203])
	by ananke.wxnz.net (Postfix) with ESMTP id 4DF9F171CFB;
	Wed, 17 Feb 2010 15:12:09 +1300 (NZDT)
In-Reply-To: <7vljespt2l.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140198>

On Tue, 16 Feb 2010, Junio C Hamano wrote:

> This needs some test to make sure that it triggers when configuration is
> set, it doesn't when configuration is not set [...]

Done get wat you mean?

> [...] and it doesn't for commands
> in log family when it shouldn't (most notably, format-patch).

Good point, and looking at the code "log.decorate" only has an affect after
cmd_log_init() is called, which is call by cmd_whatchanged(), cmd_show(), 
cmd_log_reflog() and cmd_log() so only those command are affected
(notably not format-patch).

However if thats not disirable, we could always add
'whatchanged.decorate', 'show.decorate' and reflog.decorate'. 
 
> > +log.decorate::
> > +	Print out the ref names of any commits that are shown by the log
> > +	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
> > +	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
> > +	specified, the full ref name (including prefix) will be printed.
> > +	This is the same as the log commands '--decorate' option.
> 
> This should be the same as --decorate option, so it should be possible to
> set it as a boolean true to mean "short", i.e.
> 
> 	[log]
>         	decorate
> 		decorate = true
> 
> should be treated exactly the same way as
> 
> 	[log]
>         	decorate = short

I thought about that but did not want start adding git_config_XXX()
functions, but you want to add git_config_maybe_bool() then I would agree
with add your patch on top (and you should do so).

While on the subject of git_config I think die_bad_config() should be an
extern (i.e. decleared in cache.h and a static function) so that it could
be used in git_XXX_config functions for handling error.  Something like:

diff --git a/builtin-log.c b/builtin-log.c
index f096eea..a41a7bb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -264,6 +264,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 			decoration_style = DECORATE_FULL_REFS;
 		else if (!strcmp(value, "short"))
 			decoration_style = DECORATE_SHORT_REFS;
+		else
+			die_bad_config(var);
 		return 0;
 	}
 	if (!strcmp(var, "log.showroot")) {

-- 
Steven
UNIX is basically a simple operating system,
but you have to be a genius to understand the simplicity  --- dmr
