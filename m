From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 17:43:20 -0700
Message-ID: <xmqqzj0eynh3.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
	<xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
	<5600DF2D.9010202@web.de>
	<CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
	<xmqqy4fy2q6o.fsf@gitster.mtv.corp.google.com>
	<20150922194927.GA622@sigill.intra.peff.net>
	<xmqqlhby2pj0.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYKxNAXhbmXEtMeBYeGqu8i4bcUW_hpjLaPSF4p5O=uBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 02:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeY9g-0002dR-6K
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 02:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934621AbbIWAnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 20:43:24 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35064 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934570AbbIWAnX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 20:43:23 -0400
Received: by pacfv12 with SMTP id fv12so24194835pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 17:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0fiUYTK9Eey5sXJwP4expvJoysMvkvih5T78q1RL0ak=;
        b=hSMahMHeMRvzIt9DLBfqC736iE9iRoC49WlqhA1gBy8z5J4t6bwA0bl5i3LbyZb7gt
         Z5TZGNM6Dd4szztrgpKEq8gjMvIrs/FcNOhtXMpNozS8qH0wccFn+enLDP8pG4sanZmh
         M3bVfsRoy6XiUtxCwsC8NQ7TJ7W+LhJ9/mgBXHyJTzqbrWLRSMUwprHmBUu/kJ2Nefal
         H7EyqAXqRoy77cSeaDoYG1Qqj5nBtiei9LiRVnSHkhbyRvnlw4yIh63hrybJqoHAkn2G
         tUYza5NlysJ8lNFZHzJkqmm7bG+hYvObQHpH0L6Dcr4sITEffACvXWrWnmEnbemUO0UP
         BCIw==
X-Received: by 10.66.161.7 with SMTP id xo7mr7536331pab.57.1442969003287;
        Tue, 22 Sep 2015 17:43:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id hh3sm4502955pbc.8.2015.09.22.17.43.21
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 17:43:21 -0700 (PDT)
In-Reply-To: <CAGZ79kYKxNAXhbmXEtMeBYeGqu8i4bcUW_hpjLaPSF4p5O=uBg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Sep 2015 17:14:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278451>

Stefan Beller <sbeller@google.com> writes:

> We should not care if the call to poll failed, as we're in an infinite loop and
> can only get out with the correct read(..).

I think I agree with that reasoning.  The only thing we want out of
this call to poll(2) is to delay calling read(2) again when we know
we would get EAGAIN again; whether the reason why poll(2) returned
is because of some error or because some data has become ready on
the file descriptor, we no longer are in that "we know we would get
EAGAIN" situation and do want to call read(2), which would return
either the right error or perform a successful read to make some
progress.

Sounds sensible.
