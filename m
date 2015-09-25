From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Fri, 25 Sep 2015 11:29:31 -0700
Message-ID: <xmqqa8sa4ak4.fsf@gitster.mtv.corp.google.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<20150925162615.GF8417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfXkq-0004KV-5d
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 20:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbbIYS3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 14:29:35 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34266 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbbIYS3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 14:29:34 -0400
Received: by padhy16 with SMTP id hy16so112691725pad.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=m5Wh0BCUP90lYXTpMPCjvaD0UFkokSTFlh2S+EV0G/c=;
        b=hnxnRWd7EwEM02nNNyZZVv99NfpF/x4y5r5uCby07TLds3hFufrsfrodRb8M5nmKGZ
         f8v7vkaiE4qHD9ZiW08XHNhhr9ASXE9EZnWivPDT5XrY532oZgYefHFPbR3eAazCYwrY
         7GiJYlMe75hr+7HMO8/He8V0r6DKYqwdYNqXAGRXTtUx+pUt13kUO0tKjpQuRVDCy60V
         vsPTBegewrfHG+gzqLeJED5Q4pMCKgsyn66e91YkZcZvpRoQ2nAuFmI8vUsrF10L69U1
         dzVoP0P2ZIZFXQ3w7EEL0kcwTI9XMBewhUkpUQzURshN+8xiidiAWeLjbYZKNPkHJPT1
         /Exg==
X-Received: by 10.68.250.98 with SMTP id zb2mr9139793pbc.40.1443205773599;
        Fri, 25 Sep 2015 11:29:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id f5sm5151794pas.23.2015.09.25.11.29.31
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 11:29:32 -0700 (PDT)
In-Reply-To: <20150925162615.GF8417@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 25 Sep 2015 12:26:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278672>

Jeff King <peff@peff.net> writes:

> If the point is for clients not to trust GitHub, though, it doesn't
> really matter what GitHub does with the cert, as long as it is put
> somewhere that clients know to get it.

Correct.  A spiffy Web interface that says "Click this button and we
show you the output of GPG signature verification" would not help.
The push certificate is all about allowing third-parties to conduct
an independent audit, so anything the hosting site computes using
the certificates does not add value, unless the certificates
themselves are exported for such an independent audit.

If somebody found a change to "git push" that makes it pick the
user's wallet and sends a few coins every time it talks to the
hosting site, the hosting site can say it is not their doing by
showing that the tip of the commit that contains such a change came
from me, and it is not their evil doing.  Push certificates help the
hosting site prove their innocence, and those who do not trust the
site can still be convinced by the claim.

There is one scenario that signed push would not help very much,
though.  The hosting site cannot deny that it did not receive a
push.

Following such an incident (perhaps the evil change came as a side
effect of a innocuous looking patch), I would push a commit that
fixes such an issue out to the hosting site (with signed commit).
But if the hosting site deliberately keeps the tip of the branch
unmodified (e.g. you can appear to accept the push to the pusher,
without updating what is served to the general public), there will
be more people who will fetch from the hosting site to contaminate
their copy of git and the damage will spread in the meantime.

When I finally complain to the hosting site that it is deliberately
rejecting the fix that would rob them the illicit revenue source, it
does not help the hosting site to keep copies of push certificates
when it wants to refute such a complaint.  "We publish all push
certificates and there is no record that gitster already tried to
fix the issue" has to be taken with faith in that scenario.

So push certificate is not perfect.  But it does protect hosting
sites and projects hosted on them.

>  So I wonder if it would be
> helpful to have a microformat that the client would use to look at this.
> E.g., it would fetch the cert tree, then confirm that the current ref
> values match the latest cert.

Yeah, that is one possibility.  Just a single flat file that
concatenates all the push cert in the received order would do as an
export format, too ;-)
