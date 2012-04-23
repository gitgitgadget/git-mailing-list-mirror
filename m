From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 1/3] git-svn: use POSIX::sigprocmask to block signals
Date: Mon, 23 Apr 2012 10:33:43 -0700
Message-ID: <xmqqipgqjqtk.fsf@junio.mtv.corp.google.com>
References: <cover.1335198921.git.rkagan@mail.ru>
	<d21d7433574e8ea7628320dbe1a5fc0dc9d94e64.1335198921.git.rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:33:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMN9A-0003XK-Qg
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 19:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab2DWRdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 13:33:47 -0400
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:33789 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753421Ab2DWRdq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 13:33:46 -0400
Received: by laai8 with SMTP id i8so580452laa.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 10:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=aoAB2yLYXZ704gLBt58Y6WzV6LwiDD+03t5QhmOnAtM=;
        b=S74DicoIKnXS3nWtO8Nb2tEYaSvPFHmTI/73eGMs4C5chFuy8y/Fr3sxQ5/tarkNoM
         IjKWxWptI8BRgynkrBVxbc05c6r//Ub63JTedapWKAKHxA1kMAs3B2S8IhhD+C/GTRt+
         j94sb0Pqj0NtrQIo9hJBzWp6BDE9mwg3HwUbsVu6PaYiCycEtXhklPfDSt8vl3QfYalE
         dGS1fH/YK8Hx90zW5qHJotD9GCkIrVAJRj3uxAcYfzWRm3uBTt2GHt8dpiaivT/Tzinr
         S0zC0tJwv96l7kWh0+WVxWhsHZL5+ekZTLLCEKp0sftAyxWMU6ZR4r4S0VM8oAIhFcW3
         c9Rg==
Received: by 10.14.100.207 with SMTP id z55mr3986900eef.4.1335202424652;
        Mon, 23 Apr 2012 10:33:44 -0700 (PDT)
Received: by 10.14.100.207 with SMTP id z55mr3986883eef.4.1335202424524;
        Mon, 23 Apr 2012 10:33:44 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si15233394eei.3.2012.04.23.10.33.44
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 10:33:44 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 556ED20004E;
	Mon, 23 Apr 2012 10:33:44 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 9B04FE120A; Mon, 23 Apr 2012 10:33:43 -0700 (PDT)
In-Reply-To: <d21d7433574e8ea7628320dbe1a5fc0dc9d94e64.1335198921.git.rkagan@mail.ru>
	(Roman Kagan's message of "Mon, 2 Apr 2012 17:29:32 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnSCnPgDzu5gCgAwPv1MI7yCgjJu5b7fpxxkLaR1sn34XbWA03hf5mwtsDcy0iezOIJxe189AdPjIvmIynZ2TzqgpV7lvARMh82Y03mgf5UBSIvIo9BsPT1WC67DtTVG0d6yVbhV4EnMQhbB0Mu3zN+noi6oVa+XS5bqadXb8MzcUD5kgQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196151>

Roman Kagan <rkagan@mail.ru> writes:

> rev_map_set() tries to avoid being interrupted by signals.

The wording "tries to avoid" was unclear and I had to read the code
twice.  The code defers the signal processing but still wants to get the
signal after it is done what it is doing, which is different from simply
"ignoring", which is another way to "try to avoid".

> The conventional way to achieve this is through sigprocmask(), which is
> available in the standard POSIX module.
>
> This is implemented by this patch.  One important consequence of it is
> that the signal handlers won't be unconditionally set to SIG_DFL anymore
> upon the first invocation of rev_map_set() as they used to.

That may be the first degree consequence (another is what happens when
you received signals of different kinds while in the blocked section),
but how would that difference affect the overall program execution?

> [That said, I'm not convinced that messing with signals is necessary
> (and sufficient) here at all, but my perl-foo is too weak for a more
> intrusive change.]

Everything you discussed above in the log message before "That said"
part made sense.  Instead of catching and setting a single $sig and
replaying that later, potentially losing accumulated signals that are of
different kinds, blocking before entering the part you do not want to
get interrupted and unblocking after you are done is better done using
sigprocmask.

If the problem to solve is to implement deferral and delayed signal
processing correctly, I think your patch did the right thing, but your
"necessary/sufficient" comment implies that the problem you were trying
to address is _different_ from that.  But it is not clear what it is.

Could you elaborate on it a bit more here, or if it will become clear in
the later patch, then please drop that parenthesized part out of the log
message.
