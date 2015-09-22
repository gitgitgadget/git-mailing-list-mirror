From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 12:45:51 -0700
Message-ID: <xmqqy4fy2q6o.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
	<xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
	<5600DF2D.9010202@web.de>
	<CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:46:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTVo-00088Z-IR
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759044AbbIVTp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 15:45:56 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36158 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759674AbbIVTpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 15:45:53 -0400
Received: by pablk4 with SMTP id lk4so2109545pab.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ayNnWOQY8/lz2jUSD9xw1U85Fj+Ggqwu+R3TIhsal58=;
        b=M2M1MjDIUhqINX4cL2PS1iUvT0Bcnwp+FZMQZY6QhA1Y9nE11be8J/vnHMBozHJVRg
         XmalDNknyRh2UomuSJ/IW9wo1yeaYpuqrUwM3Cuj/wxVUIhdPY+LDc/D8YA4HNy4gKr+
         FRf6RzL7l5D7zGqI2+N6qA6T/ZMouOb962vmUWh5Vq7C+B+QxhiKlez69ODMALON0/eC
         i1q0oCbPR9G8dyMTRmsRi8VzKNTinXOZIsfr257bf8CnGMZWH4iNLHq073CTzWEcJavJ
         FQistU3tCEWNExgvjmR17XDbwVIgdtWQQOsjb2zf8VmOA2ImVSg6rGNcRvNauRYHp+0U
         MdJQ==
X-Received: by 10.68.88.69 with SMTP id be5mr32878301pbb.105.1442951153257;
        Tue, 22 Sep 2015 12:45:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id sl7sm3783286pbc.54.2015.09.22.12.45.52
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 12:45:52 -0700 (PDT)
In-Reply-To: <CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
	(Jacob Keller's message of "Mon, 21 Sep 2015 23:23:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278423>

Jacob Keller <jacob.keller@gmail.com> writes:

> I don't think this patch actually changes behavior as it stands now. I
> think Junio's suggestion does. Personally, I'd prefer some sort of
> warning when you use xread and get EAGAIN or EWOULDBLOCK. I'd rather
> see it somehow warn so that we can find the bug (since we really
> really shouldn't be calling xread with a blocking socket, especially
> if we have xread_noblock or similar as in this series.

One caveat is that the caller may not know in the first place.

The last time I checked the existing callers of xread(), there were
a few that read from a file descriptor they did not open themselves
(e.g. unpack-objects that read from standard input).  The invoker of
these processes is free to do O_NONBLOCK their input stream for
whatever reason.
