From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make -p --stat and --stat -p behave like --patch-with-stat
Date: Thu, 22 Jun 2006 11:58:27 -0700
Message-ID: <7vr71hkofg.fsf@assigned-by-dhcp.cox.net>
References: <20060622162511.4788505e.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 20:58:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtUO2-0004PJ-2M
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWFVS6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 14:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWFVS6a
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 14:58:30 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:33745 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161196AbWFVS63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 14:58:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622185828.WQMB27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 14:58:28 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22358>

Timo Hirvonen <tihirvon@gmail.com> writes:

> git log                    log only
> git log --stat             log with stat
> git log -p                 log with patch
> git log --stat -p          log with patch (no stat!)
> git log -p --stat          log with stat (no patch!)
> git log --patch-with-stat  log with patch and stat
>
> This patch makes -p --stat and --stat -p work like --patch-with-stat.
>
> Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
> ---
>
>   Maybe DIFF_FORMAT_* should be reworked instead but this was easy.
>
>   Only negative impact of this patch is that if you have a alias
>
>      l=log --stat
>
>   then you can't override --stat with "git l -p", it will still show
>   diffstat, but I don't think it matters.

I do not think it matters that much either, but DIFF_FORMAT_*
really should be reworked regardless.  --with-foo should really
be independent switches that can be added together, perhaps.

So how would we go about this?  A strawman.

The diff output has four parts, each of which can independently
be enabled.  When no options are specified on the command line,
each command has its own default but in general the low-level
commands default to raw output only, and the higher-level ones
default to patch output only.

The four parts are controlled with a bit each, and are output in
the fixed order (iow the order of the options given from the
command line does not matter): raw, stat, summary and patch.

When --name-only or --name-status is specified, that would be
the only thing that is output (iow the above four parts would
not be shown, just names optionally with the status are shown).

The four switches are: --raw, --stat, --summary and --patch.
Existing flags are supported as obvious shorthands to turn on
the corresponding bits:

	-p, -u			--patch
        --patch-with-raw	--raw --patch
        --patch-with-stat	--stat --patch

Anybody interested in doing a patch?
