From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 11:04:05 -0700
Message-ID: <xmqqlhbxxbai.fsf@gitster.mtv.corp.google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
	<xmqqeghpzm0y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYaqFRPfRORbknTyez5u0d6_BD0d5wBtAnjSkb4sUBUBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 20:04:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeoOr-0002It-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 20:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbbIWSEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 14:04:09 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35611 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbbIWSEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 14:04:07 -0400
Received: by pacfv12 with SMTP id fv12so47543265pac.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+1O7Dcd5LPMBJra4IFOwS4DcGzvzV4Ly2twBbrRxckI=;
        b=I4B64RAiNCyKICM3FSlKF98JxDO0dMWK7W0WQHu0YcvWO9TQdV/4uSK9oA7gQ19yzg
         gwIyz3MG4pOlGM9yRQH1H/xa+OMfZqEID+NvQEwPSpugz4qf4uPF+L3o9TR4pdV2H7De
         j+BKjUapVxU+E25ywt4ZTFMNkXKUfJjUsrxuJawTLx5Eq67MuzeHjMeHt8wHac/XZXUD
         lgOgEwinYN5/onhIlA8dME3k2WzOcmsTHw9stJd/M0MfprA06xK4nXGhrrCMB0Azw1dA
         5nABXc/QKmjrJRb3lmFmGGFetSamszyKFU4dSTT2du/T7OSsV59Z9Rk4xtulS0Dqs58g
         6JLg==
X-Received: by 10.66.144.135 with SMTP id sm7mr39335298pab.106.1443031447427;
        Wed, 23 Sep 2015 11:04:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id si1sm9116746pbc.72.2015.09.23.11.04.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 11:04:06 -0700 (PDT)
In-Reply-To: <CAGZ79kYaqFRPfRORbknTyez5u0d6_BD0d5wBtAnjSkb4sUBUBA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 23 Sep 2015 10:53:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278492>

Stefan Beller <sbeller@google.com> writes:

> I modified the test-run-command test function to start up to 400 processes.
> (Most people will use less than 400 processes in the next 5 years), and run
> just as in t0061:
>
>     ./test-run-command run-command-parallel-400 sh -c "printf
> \"%s\n%s\n\" Hello World"
>
> The output felt immediate (not slowed down or anything).

I doubt that such an experiment has any value.  You are not driving
printf in real life.

You are running "git fetch" that are is a lot more heavy-weight.
Because once each of them started fully they will be network bound,
it is likely that you would want to run more processes than you have
core.
