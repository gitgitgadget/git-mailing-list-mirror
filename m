From: Jeff King <peff@peff.net>
Subject: Re: git diff flags
Date: Sat, 8 May 2010 00:06:02 -0400
Message-ID: <20100508040602.GA14998@coredump.intra.peff.net>
References: <19428.27908.870639.422432@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sat May 08 06:08:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAbLP-00005e-02
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 06:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724Ab0EHEGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 00:06:08 -0400
Received: from peff.net ([208.65.91.99]:53490 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab0EHEGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 00:06:06 -0400
Received: (qmail 1280 invoked by uid 107); 8 May 2010 04:06:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 May 2010 00:06:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 May 2010 00:06:02 -0400
Content-Disposition: inline
In-Reply-To: <19428.27908.870639.422432@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146633>

On Fri, May 07, 2010 at 03:41:56PM -0400, Eli Barzilay wrote:

> There's something strange with how `git diff' parses its flags:

Yep.

>   git diff --some-bogus-flag
>   --> complains as expected

Yep.

>   git diff --follow
>   --> works but there's no mention of this in the man page, and it
>       doesn't look like it's doing anything

--follow is a "diff option" even though it is about revision
traversal. This is an artifact of the implementation, where
rename-following happens at a low level where we have only diff_options.
It should be possible to fix, though (parse the option at the revision
layer, but have it set the diff_options flag).

>   git diff -C -M
>   --> works as expected too

Yep.

>   git diff -CM
>   --> doesn't say anything (but it does exit with an error code)

The revision and diff parsers do not use parse_options, and thus don't
understand things like bundling. Even if they did, -C takes an optional
argument. In this case, the argument format is bogus, so it aborts, but
for some reason there is no error message (it is the same with -B, -M,
and -C).

>   git diff -CM --I-can-write-anything here!
>   --> does the same

Because we barfed at -CM already. It only looks funny because we didn't
bother to print a message.

Patches welcome.

-Peff
