From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] fetch-pack: don't resend known-common refs in
 find_common
Date: Wed, 22 Oct 2014 09:41:46 +0200
Message-ID: <1413963706.11656.5.camel@seahawk>
References: <1413884908.4175.49.camel@seahawk>
	 <20141021144838.GA11589@seahawk>
	 <xmqqd29l1f3p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 09:41:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgqYQ-0000Kn-1B
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 09:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbaJVHlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 03:41:52 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:33952 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558AbaJVHlu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 03:41:50 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so2387638lab.41
        for <git@vger.kernel.org>; Wed, 22 Oct 2014 00:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=2FHajd1I5BOV7EveZ7XAu62u9imBphNxidNZJLYnzEc=;
        b=G09/qxqly+nm65fkzX18Dsd1WpRbEofqmYGr6uUBzE/nnsypH+kVoZcUylI5BKDYAJ
         oiR4dJfSIyKmobkYgSYIXJyEVmXX4/uMBQuZpHpzf2f8wO6+K1iSPWheaG5eyAAzVdpg
         9MZaQfZkNSUoIas5FSO3fmF4mqkF8Hi9GUSfFcdYvSqzYly7Z+abn9GqzFiVZ5eYYGMD
         ACF9uqa8d4+W5PGcm1pEzYn4wbvrHJdJ5qobcNM4m73BiHb33u7QIOYfmaBXnWB6Hjqe
         BOLx4Bpb5a+BHAJeP6l3To2BFVU39zqoVaUIolYWRJAba6z0VtZBVJaO5wGLJC8Aes/N
         S1FQ==
X-Gm-Message-State: ALoCoQn+m8qujmM3LhduH0wDXB+KnmzdYwiJEXV8jv4a0ErT+JryvC/fGV5PJ7651o5y0odnrRPR
X-Received: by 10.112.172.231 with SMTP id bf7mr1020357lbc.100.1413963708909;
        Wed, 22 Oct 2014 00:41:48 -0700 (PDT)
Received: from [10.155.73.62] (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id am7sm5446938lbc.41.2014.10.22.00.41.47
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 00:41:48 -0700 (PDT)
In-Reply-To: <xmqqd29l1f3p.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On di, 2014-10-21 at 10:56 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > By not clearing the request buffer in stateless-rpc mode, fetch-pack
> > would keep sending already known-common commits, leading to ever bigger
> > http requests, eventually getting too large for git-http-backend to
> > handle properly without filling up the pipe buffer in inflate_request.
> > ---
> > I'm still not quite sure whether this is the right thing to do, but make
> > test still passes :) The new testcase demonstrates the problem, when
> > running t5551 with EXPENSIVE, this test will hang without the patch to
> > fetch-pack.c and succeed otherwise.
> 
> IIUC, because "stateless" is just that, i.e. the server-end does not
> keep track of what is already known, not telling what is known to be
> common in each request would fundamentally break the protocol.  Am I
> mistaken?

That sounds plausible, but why then does the fetch complete with this
line removed, and why does 'make test' still pass? I tried to understand
the protocol, but the documentation has TODO's in some critical
places :)

And if that's true, it means the inflate_request / upload-pack
interaction should be fixed, so more than 64k (current linux pipe buffer
size) of uncompressed data is supported. I see two options:

* Turning that interaction into a more cooperative process, with a
  select/poll loop
* Make upload-pack buffer its entire response when run in stateless_rpc
  mode until it has consumed all of the request

The latter sounds easier to do, but not being very familiar with the
protocol, I may have missed something obvious.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
