From: Jeff King <peff@peff.net>
Subject: Re: Giving command line parameter to textconv command?
Date: Tue, 15 Dec 2009 11:49:59 -0500
Message-ID: <20091215164959.GA21322@coredump.intra.peff.net>
References: <20091215071735.6117@nanako3.lavabit.com>
 <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
 <20091215121110.6117@nanako3.lavabit.com>
 <7vfx7c3hmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 17:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKabG-0001yG-Tx
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 17:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760532AbZLOQuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 11:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759885AbZLOQuH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 11:50:07 -0500
Received: from peff.net ([208.65.91.99]:60878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754566AbZLOQuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 11:50:05 -0500
Received: (qmail 25873 invoked by uid 107); 15 Dec 2009 16:54:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 15 Dec 2009 11:54:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2009 11:49:59 -0500
Content-Disposition: inline
In-Reply-To: <7vfx7c3hmb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135289>

On Mon, Dec 14, 2009 at 09:56:28PM -0800, Junio C Hamano wrote:

> Let's try to do a bit more work to make the coverage complete.  After
> scanning "git grep -e start_async -e run_command" output, here is what I
> came up with:
> 
>  - editor.c::launch_editor() that allows a custom editor named via
>    GIT_EDITOR does seem to honor your command line arguments.
> 
>  - pager.c::setup_pager() is used for GIT_PAGER and it does honor your
>    command line arguments.
> 
>  - ll-merge.c::ll_ext_merge() that is used to handle custom merge drivers
>    lets the user specify command line via templating to replace %O %A %B
>    and naturally it needs to be aware of the command line arguments.

I think it is important to note in user-facing documentation (like
release notes describing the proposed textconv change) that these are
not just "honor your command line arguments" but "execute your command
with /bin/sh". Maybe that is obviously how it is implemented, but I
think it should be made clear that you have the power to use (and
responsibility to protect yourself from) arbitrary shell code.

>  - diff.c::run_external_diff() that runs GIT_EXTERNAL_DIFF defines that
>    the command has to take 7 parameters in a fixed order, and is not
>    designed to permute its arguments like ll_ext_merge() does, but these
>    days people don't use it directly (they use it indirectly via
>    "difftool" wrapper), so it probably is not an issue.

There is also diff.*.command, which I think people _do_ set manually (I
used to, until I wrote textconv. :) ). It does not use the shell
currently. I agree that people almost certainly have to write a
shell-script wrapper anyway. But I wonder if we should pass it through
the shell, just for the sake of consistency with the other variables (in
particular, if textconv changes, I think diff.*.command is closely
related).

-Peff
