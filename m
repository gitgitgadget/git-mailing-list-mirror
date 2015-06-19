From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight unevenly-sized hunks
Date: Fri, 19 Jun 2015 10:20:00 -0700
Message-ID: <xmqqlhffaa4f.fsf@gitster.dls.corp.google.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
	<xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
	<CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
	<xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
	<20150618190417.GA12769@peff.net>
	<alpine.DEB.2.20.8.1506181536070.4322@idea>
	<20150618204505.GD14550@peff.net> <20150618212356.GA20271@peff.net>
	<20150619035408.GA23679@peff.net>
	<xmqqmvzwb8vk.fsf@gitster.dls.corp.google.com>
	<20150619053223.GA27241@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Palka <patrick@parcs.ath.cx>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 19:20:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5zxY-0005Mo-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 19:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbbFSRUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 13:20:03 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33938 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbbFSRUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 13:20:02 -0400
Received: by iebmu5 with SMTP id mu5so79007987ieb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eMl7BvUuRk+u8lpcgU4sEV1QjcA3pPuqGKDRnc4FXjE=;
        b=FrAa+YMyrehZj81j2cJrkz+x3FmL586YUBv5ghBz7jdM3xSxgn0Ikwr8pQgMyHwMVY
         DRNYyquszFfobjv4OWM+hTuNnBLGVycAt5zH8oO+AN2AgEDXlAQDwalHjNSOCLSuCAZH
         bcME63VXeuZ/yHQDjO9osTGBtJjB6gsMG5CWAJhq64tKOCVf9SILBJpsFZ4C3Q2v/FV7
         BgDwsTe1bZC9J435U9gU0aPAxAQ04Kniaff93R6RxaBNaXLhNitqYcIyqovmdU56kWJ6
         LnwjILNjRuBh9tPGGpp0ii42gXQXWI6uh6cbRp/SxQE+EUOzZhw3bJcOcf7oU7/koNB6
         dVrQ==
X-Received: by 10.42.154.5 with SMTP id o5mr7708168icw.16.1434734402271;
        Fri, 19 Jun 2015 10:20:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id x3sm2066666igl.2.2015.06.19.10.20.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 10:20:01 -0700 (PDT)
In-Reply-To: <20150619053223.GA27241@peff.net> (Jeff King's message of "Fri,
	19 Jun 2015 01:32:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272169>

Jeff King <peff@peff.net> writes:

> I do strip it off, so it is OK for it to be different in both the
> pre-image and post-image. But what I can't tolerate is the
> intermingling with actual data:
>
>   +\t\t\x1b[32m;foo
>   +\t\x1b[32m;bar

I think that depends on the definition of "strip it off" ;-)  What I
meant was that whitespace coloring can appear anywhere on the line,
e.g.

    echo COPYING whitespace=tab-in-indent,-space-before-tab >.gitattributes
    printf " \tHeh\n" >>COPYING
    git diff

will give you

    <new> + <reset> SP <wserror> HT <reset> <new> Heh <reset> LF

Obviously, stripping "+" painted in "new" is not sufficient.

	Side note: hmm, shouldn't that SP painted in <new>, though?

> I think this "array of spans" is the only way to go. Otherwise whichever
> markup scheme processes the hunk first ruins the data for the next
> processor.

Yes, I agree with that 100%.
