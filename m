From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 13:48:11 -0400
Message-ID: <CAPig+cS3_KVHvDL=nW+9dDveAp3MvAtjKyChPAOVXGfwZCQ5Ag@mail.gmail.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165545.GC23503@peff.net>
	<20150629222247.GA31607@flurp.local>
	<20150630102055.GA11928@peff.net>
	<xmqqr3ot6s9u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:48:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9zdq-0003ep-Ry
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 19:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbbF3RsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 13:48:13 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36661 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbbF3RsM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 13:48:12 -0400
Received: by ykdr198 with SMTP id r198so15933597ykd.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Euq6Z4CjUkJLpmjrRJy4jbtAUCSpCfyAK75sgqcZ5SU=;
        b=NEBqRUx+1wxgL+Qyco0c3J4FvSuMRhSIHG4/wUB8bCdaSbBFu6PL7KSZd9eP1vCcB6
         ah8ryaBudSIfM2U8t5odoV5naLY32vq4fSVnW1MCxxV7T3cQHTvY/1q1Q7FaNFc52/iA
         AjeOQbNp+G0tj9L8JXyHutT00mp2U2g0/HlrRnFWHeOtLcSQEpyYMUaSuKYQ2m+fLTRg
         QBvpgakIxxe8HjAXeXXnEoAxk+6Pucg4b2cydhhAKkPGZPp8MdHADiiWbp4m1ykFB1vY
         SpwkZ1n9WJwVEvPGpcmEm65PyX8kD/Ush3zKATPW5sUyBlhiHBs39Wp/MPwHBBfgXLk4
         EMcQ==
X-Received: by 10.129.91.135 with SMTP id p129mr27584620ywb.95.1435686491227;
 Tue, 30 Jun 2015 10:48:11 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 10:48:11 -0700 (PDT)
In-Reply-To: <xmqqr3ot6s9u.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 6b01_WKuS4GwIvj5fjC-7FXw6mM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273089>

On Tue, Jun 30, 2015 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Answering myself to my earlier question, the reason is because I was
> worried what happens when given fmt is a malformed strftime format
> specifier.  Perhaps it ends with a lone % and "% " may format to
> something unexpected, or something.

That's a good point. I had considered prepending the extra character
(space) rather than appending it but eventually rejected it to avoid
the expense of shifting the characters down by one before returning
the formatted string.

However, is it our responsibility to guard against a malformed format?
POSIX doesn't state the behavior of "% ", so I don't think we are any
worse off by appending space to a malformed format ending with "%"
since the malformed format could wreak havoc even without our
transformation.

> Are we checking an error from strftime(3)?

According to the "BUGS" section in POSIX:

    If the output string would exceed max bytes, errno is not set.
    This makes it impossible to distinguish this error case from
    cases where the format string legitimately produces a zero-length
    output string. POSIX.1-2001 does not specify any errno settings
    for strftime().

So, there does not seem to be a point in checking 'errno'.
