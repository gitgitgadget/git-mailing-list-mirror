From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] rev-parse: add --filename-prefix option
Date: Mon, 8 Apr 2013 09:31:23 +0100
Message-ID: <20130408083123.GN2222@serenity.lan>
References: <cover.1365364193.git.john@keeping.me.uk>
 <ba2c7aa9eaa982306f1d5ad5ff2d26a6e2b8df85.1365364193.git.john@keeping.me.uk>
 <20130407221458.GE19857@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKA1-0002Am-NR
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933639Ab3DHIbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 04:31:35 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:53233 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab3DHIbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 04:31:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3A9A7161E3D3;
	Mon,  8 Apr 2013 09:31:33 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxO90p6RZ6BT; Mon,  8 Apr 2013 09:31:32 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C9DED161E415;
	Mon,  8 Apr 2013 09:31:25 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130407221458.GE19857@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220408>

On Sun, Apr 07, 2013 at 03:14:58PM -0700, Jonathan Nieder wrote:
> John Keeping wrote:
> 
> > This adds a prefix string to any filename arguments encountered after it
> > has been specified.
> 
> I assume this is a way of passing the prefix in?  In that case, I
> think a good UI would be
> 
> 	git rev-parse --prefix=Documentation/ <usual rev-parse args>
> 
> That sounds like a useful thing and would make the meaning very clear.

Yes (ish), the intended usage is something like this:

    prefix=$(git rev-parse --show-prefix)
    cd_to_toplevel
    ... parse options here ...
    # Convert remaining arguments (filenames) into top-level paths:
    eval "set $(git rev-parse --prefix "$prefix" --sq -- "$@")"

The "ish" is that my current implementation introduced a new variable
instead of simply resetting the existing "prefix" variable, which I
assume is what you mean.  That is probably simpler than my
implementation, but loses the ability to be at an intermediate level,
for example:

    cd Documentation/
    eval "set $(git rev-parse --prefix technical/ --sq -- api-strbuf.txt)"

> How does this interact with the following options?
> 
>  * --resolve-git-dir some/relative/path

It doesn't change this since --resolve-git-dir is handled separately
from the other argument parsing at the moment and you cannot specify
any other options with it.

>  * master:./path

I hadn't considered this case, but I think it should be inserting the
prefix into the path.  I suspect the easiest thing to do is simply make
the path part of that absolute, by combining both the prefix based on
$PWD and the prefix specified on the command line, but I haven't looked
at doing this yet.

The other think that's missing at the moment is that the prefix passed
to verify_filename should be modified by the one specified on the
command line.

> As for the patch itself, I haven't looked at it closely.  My only
> immediate reaction is that I wish it touched Documentation/ and t/. :)

I'll make sure the next version does.  This version was doing the
minimum required to make patch 2/2 possible, it certainly needs some
polish before it's more than a proof-of-concept.
