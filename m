From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 03/13] xread_nonblock: add functionality to read from fds nonblockingly
Date: Mon, 21 Sep 2015 17:10:09 -0700
Message-ID: <xmqqsi6771r2.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 02:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeBA2-0004Vk-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 02:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbbIVAKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 20:10:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36439 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbbIVAKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 20:10:11 -0400
Received: by padbj2 with SMTP id bj2so5396511pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IFMjaHEOKlaKjMd2qabtg/KLJnQPFo8rX+EyqkoLyx8=;
        b=sZBWFgK2UT49Ps4NOVI0NU2pym43UWKmAZhkTnxEWN24RtxNt4PoRE1hYhGTQKDxHu
         XX/1xNPMzH/1bUr5S81RzX/2gFLQjsE+xQ5ngNg/uHPCwIxvQvzRAtrKL/d/fn+4ahnx
         RCmu+R6/Byghch42Q+jc+v4Gi6NLprGASp98YGIyCvWrVinGPY+UUKcOZ6bLwa6aAfoK
         Eugv68xxveID3qCZyZQwq9IcElIARHKA/ywwZ4wNBlyoeePp5bX0jKUko/+EfNliyae4
         9k+NkSmw/uYDZP7VIrcYTUbfhkzi/CIME8PTfiyyOdAzUtZhxvZsRi+KYg8bX4hHYBiR
         VAHw==
X-Received: by 10.68.190.135 with SMTP id gq7mr20029950pbc.152.1442880610908;
        Mon, 21 Sep 2015 17:10:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id qo3sm26839157pac.10.2015.09.21.17.10.10
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 17:10:10 -0700 (PDT)
In-Reply-To: <1442875159-13027-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Sep 2015 15:39:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278366>

Stefan Beller <sbeller@google.com> writes:

> This wrapper just restarts on EINTR, but not on EAGAIN like xread
> does. This gives less guarantees on the actual reading rather than
> on returning fast.

The last sentence is a bit hard to parse, by the way.

It lets caller make some progress without stalling by marking the
file descriptor as nonblocking and calling this function, compared
to calling xread() which will not give control back until reading
the asked size (or EOF).

It is not like "reading in full is always the desireable thing to
do, and returning early is something that needs compromise on that
desirable behaviour to achieve", which was the way I read your
version.  These two kinds of callers want two different things, but
the phrase "less guarantees" conveys a misguided value judgement (in
that "wanting to read in full always trumps other considerations" is
the stance the person who is making the judgement makes) more than
useful information (e.g. "the caller may want the control back
without stalling, in which case this is a useful thing to use").

The implementation itself is exactly like we discussed, and looks
good.

Thanks.
