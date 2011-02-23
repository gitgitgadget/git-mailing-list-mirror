From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Recursive make and variations on the theme
Date: Wed, 23 Feb 2011 03:56:50 -0600
Message-ID: <20110223095650.GE30485@elie>
References: <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie>
 <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
 <20110223045143.GA11846@sigill.intra.peff.net>
 <20110223082929.GB30485@elie>
 <20110223084329.GA10738@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 10:58:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsBUI-00018x-Dn
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 10:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab1BWJ6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 04:58:16 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43999 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab1BWJ6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 04:58:11 -0500
Received: by vxi39 with SMTP id 39so2758418vxi.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 01:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HDg6o62jYhrrtBYJswbOJs7izIj2TX40z+Jmlr5Ekc4=;
        b=X7kyxPSG7mMjydaD1eeK+p58jARDfquZtiOKjy/flpbK9SeMGZpa0dLMUaiNPKJ+Uw
         l1iYFRbwHSurKiqd8B+B6e+8eocKnncSVm32GYGomhE6CWUMmDNmGKJIhafeseyArfoW
         jFBM1ukv5Ud7nnOCpHrfi1xhLtLDxMLUEg0Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JZUkQFzHxtXnhywYq+X3gJvQ8c2dg5LGSFk5OcPlYPHrBqU1T4vkCAxb2ZLKN/vLmj
         YXPyXjEGU8axhEpR5yjOGPJ6cvF2ImbtOwQ18OLZiAjBRHYIM3mf37TiS3JorzZNJzOu
         HgdBXUo/qt+VWfrvCFTB8wu/5g/GGxg/F9eL8=
Received: by 10.52.174.167 with SMTP id bt7mr161629vdc.221.1298455014808;
        Wed, 23 Feb 2011 01:56:54 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id l6sm3464905vcp.14.2011.02.23.01.56.52
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 01:56:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110223084329.GA10738@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167682>

Jeff King wrote:

> The problem is that no single make was
> allowed to see the whole dependency tree.
>
> I know GNU make does have some magic for communicating between recursive
> makes. Does it handle this situation?
>
> You can fix this with a rule like "only invoke recursive makes on
> directories _below_ you, never above or to the side". But then you can't
> run "make" from inside cmds/.

In that story, commands/Makefile would make commands/built-in.a and
various commands/foo.o.  The toplevel makefile would pass "make -C
commands" a long list of targets to build, presumably deduced from
$(MAKECMDGOALS).  Not pleasant, I agree.

>>      - keep careful track of what directory "make" was run from; [*]
>> [...]
>>     [*] is a little hazy and sounds hackish.
>
> Yeah, you have to be careful with paths.

It could be pretty simple by maintaining a $(prefix_) variable
representing the path from the cwd to the directory containing the
makefile.  Might try it out.

> I think a more sane way would
> be a single top-level Makefile that [...] contains everything

That sounds best to me in the short term, too.

> A dummy Makefile in each subdir that cd's to the toplevel and runs a
> specific target. So from the top-level, "make" would build everything,
> "make lib" would build stuff in the lib directory, and the Makefile in
> lib/ would just do "cd .. && make lib".

Yes, reasonable.

Ciao,
Jonathan
