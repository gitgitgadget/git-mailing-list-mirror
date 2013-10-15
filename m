From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 01:47:01 +0200
Message-ID: <20131015234701.GY4589@mars-attacks.org>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
 <xmqq4n8ib0uv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 01:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWEKV-0005jG-7V
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 01:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759878Ab3JOXrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 19:47:06 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:42912 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759861Ab3JOXrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 19:47:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id D334F422A;
	Wed, 16 Oct 2013 01:47:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gKjIFxtTsRUo; Wed, 16 Oct 2013 01:47:16 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 299964E73;
	Wed, 16 Oct 2013 01:47:16 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 9B78543928; Wed, 16 Oct 2013 01:47:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqq4n8ib0uv.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236221>

On Tue, 15 Oct 2013, Junio C Hamano wrote:

> Nicolas Vigier <boklm@mars-attacks.org> writes:
> 
> > git rev-parse --parseopt does not allow us to see the difference
> > between an option with an optional argument starting with a dash, and an
> > option with an unset optional argument followed by an other option.
> >
> > If I use this script :
> >
> >   $ cat /tmp/opt.sh
> >   #!/bin/sh
> >   OPTIONS_SPEC="\
> >   git [options]
> >   --
> >   q,quiet         be quiet
> >   S,gpg-sign?     GPG-sign commit"
> >   echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- "$@"
> >
> > Then the following two commands give us the same result :
> >
> >   $ /tmp/opt.sh -S -q
> >   set -- -S -q --
> >   $ /tmp/opt.sh -S-q
> >   set -- -S '-q' --
> >
> > We cannot know if '-q' is an argument to '-S' or a new option.
> >
> > With this patch, rev-parse --parseopt will always give an argument to
> > optional options, as an empty string if the argument is unset.
> >
> > The same two commands now give us :
> >
> >   $ /tmp/opt.sh -S -q
> >   set -- -S '' -q --
> >   $ /tmp/opt.sh -S-q
> >   set -- -S '-q' --
> 
> Two are different, but the former "set -- -S '' -q --" is not what
> you want, either, no?  -S with an explicit empty argument and -S
> alone without argument may mean two totally different things, which
> is the whole point of "option with an optional parameter".  If some
> code that have been using "rev-parse --parseopt" was happy with
> 
> 	$ /tmp/opt.sh -S
>         set -- -S --
> 
> and then your updated version gave it this instead:
> 
> 	$ /tmp/opt.sh -S
>         set -- -S '' --
> 
> wouldn't it be a regression to them?

Indeed, this could be a regression to them. I couldn't find any script
using "rev-parse --parseopt" with an option with an optional argument,
but yes, it doesn't mean that nobody uses that.
