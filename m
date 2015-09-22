From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 13:00:03 -0700
Message-ID: <xmqqlhby2pj0.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
	<xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
	<5600DF2D.9010202@web.de>
	<CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
	<xmqqy4fy2q6o.fsf@gitster.mtv.corp.google.com>
	<20150922194927.GA622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTjk-0006Tq-EG
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 22:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933595AbbIVUAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 16:00:18 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35249 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208AbbIVUAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 16:00:16 -0400
Received: by pacfv12 with SMTP id fv12so18303504pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3yRQfgbjqU4lBpRjGYpOJaU2tvu/emqSHtGP63vaI58=;
        b=xulyvdnKwHHcN4wBvXt1lfmR1EL+tr2E0uN85T2CYUqW40fhgAR51EY/x7GiVSd87J
         3QPdu94qYflxqzikMGYSxNS1pejCm7t9YlbTwHWZIbAUT/9OIFh49NffTD/XWTr7/n0o
         QbWQwWnVw9mJgodzbI7yn34ky1V1x3mDp4Z5cDQmaIUl6O+FkaLS1SDCxKE6vgirrNtJ
         X/WZlqz5oV53qI4xuaxVzbdM6PCU37xd0HXF/BaHI54Mljdq2uBsOLA1plCMx6qFJXOk
         afdOE7jD8C8kQq0kaWrG0jDBzLQBXrGCIbu8n1KXEK5IeJqC+Fy+zh0Ip+CcLVOG4thc
         b9fA==
X-Received: by 10.66.138.11 with SMTP id qm11mr17487634pab.126.1442952005791;
        Tue, 22 Sep 2015 13:00:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id xm4sm1192245pab.27.2015.09.22.13.00.04
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 13:00:04 -0700 (PDT)
In-Reply-To: <20150922194927.GA622@sigill.intra.peff.net> (Jeff King's message
	of "Tue, 22 Sep 2015 15:49:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278428>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 22, 2015 at 12:45:51PM -0700, Junio C Hamano wrote:
>
>> One caveat is that the caller may not know in the first place.
>> 
>> The last time I checked the existing callers of xread(), there were
>> a few that read from a file descriptor they did not open themselves
>> (e.g. unpack-objects that read from standard input).  The invoker of
>> these processes is free to do O_NONBLOCK their input stream for
>> whatever reason.
>
> Yeah. I do not think this is a bug at all; the user might have their
> reasons for handing off an O_NONBLOCK pipe. If we take xread() to mean
> "try to read from fd until we get a real error, some data, or an EOF",
> then it is perfectly reasonable to replace spinning on read() (which we
> do now) with a poll() for efficiency. The caller (and the user) does not
> have to care, and should not notice; the outcome will be the same.

I think we are in agreement, and that answers the question/guidance
Stefan asked earlier in $gmane/278414, which was:

> So rather a combination of both, with the warning only spewing every
> 5 seconds or such?

and the answer obviously is "No warning, do a poll() without timeout
to block".
