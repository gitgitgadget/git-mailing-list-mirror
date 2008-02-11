From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 12:20:37 +0100
Message-ID: <8aa486160802110320h78f7228fg84ae2c4986f67372@mail.gmail.com>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de>
	 <20080211074817.GA18898@sigill.intra.peff.net>
	 <8c5c35580802110241i72169620s693a31f9a098f596@mail.gmail.com>
	 <20080211110816.GA6344@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lars Hjemli" <hjemli@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 12:21:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWiy-0006EV-2h
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 12:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbYBKLUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 06:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbYBKLUm
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 06:20:42 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:53253 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbYBKLUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 06:20:41 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3918649wra.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 03:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Q/HIABbpaEjYwzPlYOePnE9D7xV7jv8b2GX9C/CCqw0=;
        b=udQ1pBK9qCx7nBINGTlm52UOGPhW/jP/ejbESzZUkcAyzBVqOCXlfPVyYQ8EXQEn0jzj4myzntf1Y7RBnQWRhOJiY2KBTK9ixAuhOeXPA0039Pdc1kA1Oa6QTMcIEZOlhQQfg6qe2tcZIvcf7g61ctPYdL/NxZOPgJ7lUGTo6Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XL9tZAkDNJL53PILppe+B34/o3RdGJtWl9zPAgX4eTPbqghnEIm7vR8wyRvlJU4uJcawN4LzEnwapSA8MbGJRnP4/qDTDL53FqqVSh9KJ1m7ZIn73/tLGnMqOSKqhqJzTRaguqkaqhNIVMuWwn6wwSI4ZhgQB7cPMPS/bYAY63o=
Received: by 10.150.133.17 with SMTP id g17mr6521030ybd.27.1202728837854;
        Mon, 11 Feb 2008 03:20:37 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Mon, 11 Feb 2008 03:20:37 -0800 (PST)
In-Reply-To: <20080211110816.GA6344@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73517>

On Feb 11, 2008 12:08 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 11, 2008 at 11:41:05AM +0100, Lars Hjemli wrote:
>
> > > It may also be that multiple rename limits are appropriate. I don't mind
> > > waiting 30 seconds for rename detection during a particularly tricky
> > > merge. I probably do when running 'git-log -p'.
> >
> > Yeah, I guess we could add support for merge.renamelimit in addition
> > to diff.renamelimit (i.e. use diff.renamelimit if merge.renamelimit is
> > unspecified). And/or add the -l option of git-diff-* to
> > git-merge.sh/merge-recursive.c.
>
> Perhaps we should first figure out what reasonable default values are. I
> think the reported problem was not "Oh, I didn't expect my tweaked
> diff.renamelimit to affect merge" but rather "I didn't tweak
> diff.renamelimit at all".
>
> The mega-commit I was playing with that caused Linus to suggest
> diff.renamelimit in the first place is 374 by 641 (src by dest) and
> completes in ~15 minutes. The case recently reported in "git-revert is a
> memory hog" is 3541 by 8043, and doesn't complete ever.  We limit to 100
> by 100 by default.
>
> Steffen, can you tell us how large your rename set is (unfortunately,
> there is no way to get this information easily; you can stop
> merge-recursive in the debugger at diffcore-rename.c:457 and look at
> num_src and num_create). And how long it takes to run with
> diff.renamelimit turned off?
>
> That might give us a clue where a reasonable value is.

Additionally git could warn if the limit is reached in the merge.
Santi
