From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] git-web--browser: avoid errors in terminal when running
 Firefox on Windows
Date: Fri, 11 Nov 2011 23:48:30 +0400
Message-ID: <20111111234830.32dccd87@zappedws>
References: <20111003095731.GB16078@sigill.intra.peff.net>
	<1321028283-17307-1-git-send-email-Alex.Crezoff@gmail.com>
	<20111111183555.GC16055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 11 20:49:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROx6U-0000Up-LP
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 20:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab1KKTsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 14:48:51 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55174 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab1KKTsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 14:48:50 -0500
Received: by bke11 with SMTP id 11so3574341bke.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=u68bmhP0UFNJRhG1eW/sGy6e7kv6e8oAjuau8nNzNQ4=;
        b=jpDl2DoMI3lltcMC5oeF7ObHTHyuR4tbaoFyjw8RZTN9shYn/1ekUohbPY2hqQQCXU
         LFKGgdfffoiu536uPDP/cvLmfGV3FQOCNmEnD/TYwBYsDY55nDlRYIncPxpu/cJ7PTDu
         hR/GYZBEp2v7nq2wnH0b0pSLFSol/vvSbX/1Q=
Received: by 10.205.119.202 with SMTP id fv10mr5744186bkc.46.1321040928633;
        Fri, 11 Nov 2011 11:48:48 -0800 (PST)
Received: from zappedws (ppp91-77-45-140.pppoe.mtu-net.ru. [91.77.45.140])
        by mx.google.com with ESMTPS id x14sm12788186bkf.10.2011.11.11.11.48.44
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 11:48:48 -0800 (PST)
In-Reply-To: <20111111183555.GC16055@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185280>

> >  test_expect_success \
> > +	'Firefox below v2.0 paths are properly quoted' '
> > +	echo fake: http://example.com/foo >expect &&
> > +	cat >"fake browser" <<-\EOF &&
> > +	#!/bin/sh
> > +
> > +	if [ "$1" == "-version" ]; then
> 
> Using "==" is a bashism. Just use "=".
Thanks (I have no skills enough in this area)
> 
> Also, a style nit, but we usually spell this "test" and not "[". I
> admit I don't care much, though.

Oh, I see

> 
> > +		# Firefox (in contrast to w3m) is run in
> > background (with &)
> > +		# so redirect output to "actual"
> > +		echo fake: "$@" > actual
> > +	fi
> > +	EOF
> > +	chmod +x "fake browser" &&
> > +	git config browser.firefox.path "`pwd`/fake browser" &&
> > +	git web--browse --browser=firefox \
> > +		http://example.com/foo &&
> > +	test_cmp expect actual
> 
> Hmm. So we are running the fake browser in the background, but then
> check that it has written something as soon as web--browse exits.
> Isn't that a race condition? I.e., we could run "test_cmp" before the
> browser has actually written anything?
eeehh... you're right...
but even on slow Windows Cygwin it is passed )

> I'm not sure there's a good way to do it.  You would need either to
> wait some pre-determined "it could not possibly take it longer than N
> seconds to run" sleep, or we need some kind of synchronization point.
> We can't wait call "wait" on the child PID (if we even have it,
> because it's not our child).
hmm... we can delete "actual" file and wait its appearance (with
some timeout), no ? but I didn't see in tests anything like this
> -Peff
