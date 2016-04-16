From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 18:07:54 -0700
Message-ID: <CA+P7+xq_Uei_ybEjJ=PPWtruk5uB5Dp2KajA=5G6TSWU0_g2kw@mail.gmail.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
 <1460761306-18794-3-git-send-email-sbeller@google.com> <xmqqd1pq74ys.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 03:08:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arEim-0005j3-Pl
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 03:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbcDPBIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 21:08:15 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33292 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcDPBIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 21:08:14 -0400
Received: by mail-io0-f177.google.com with SMTP id o126so150647937iod.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aEx/2/ax8VGKLQ1hLE68Ns/tBxsmGMDjeLjHZKNUCX8=;
        b=Ex5DQM+m2mDuIbltPNU1+Ik+1PXvEOeDQNgtNmlIJBxIrc9aZZRenjAbFo/w2rfyul
         sD71MGG1nHCHWT8oNurcI/wsNwpUhljfRp5yCs0l4DuNDfOyExrGLb8m7loFwz6qD+Lo
         B7mfRczOZ6SKW8iiM06jCTXmcgRaxbaIM6IPa1GIUiVEJE40Lo9/aQcpoJNKw5SypCea
         SknBM/E6yJ3kyu7n1j9Ko8P4WXZBeybY6Ku8UG7X4VvOkcQ9/yBkObz936oz5a2mTjNv
         vxn1J+u+pW9fLVeJrfqG3Nih1YPJLBn6jNXXQhClFhQajWcBIGTcnusXz6av/E8wS8SI
         ve6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aEx/2/ax8VGKLQ1hLE68Ns/tBxsmGMDjeLjHZKNUCX8=;
        b=LuNSWyoj0uloFJeGdsKb1iy/7bWzOZCtIN3sVb5BNgPmkUq01o46y9/BfVWWgMkktr
         XhhA+DrXdCz34qsqhERqrQ9XbHOAYb5BBs3DpGHgs0KXmjrxRveQBb98U8uz7TYj7dsQ
         rPiCn1KkB498CeZGnQ4ULlhoeSF+wmdmyYjwBx3u+vNYab0EMVBCcO/zbXgTiDUd+Xf8
         idvAg/wJNFlNhPkHq5bbN5fVxKKVWOr8mqrFI8t+upEqAQ+xM2d8jk+Hbf0N7+eFtFMY
         cHPx5GKHJJr91CgKECQ/RPm1+LQlHCR6TPDPGSFZq4u0SJ/ESU5vudkkORPTn4bNc21Q
         SNMg==
X-Gm-Message-State: AOPr4FVwS0yp2znoufEXFh312JlWKiW+Zna/koBId0If6PcHhSrj/g+N+VnX2/0SBzusmjwWmFn7RmTA9leihw==
X-Received: by 10.107.136.69 with SMTP id k66mr29151287iod.0.1460768893657;
 Fri, 15 Apr 2016 18:08:13 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 18:07:54 -0700 (PDT)
In-Reply-To: <xmqqd1pq74ys.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291714>

On Fri, Apr 15, 2016 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static int line_length(const char *recs)
>> +{
>> +     char *s = strchr(recs, '\n');
>> +     return s ? s - recs : strlen(recs);
>> +}
>
> It seems that you guys are discarding this "number of bytes on a
> line, no matter what these bytes are" idea, so this may be moot, but
> is there a guarantee that reading through recs until you happen to
> see a NUL is safe?
>
> Shouldn't the code that accesses a "line" be using the same "from
> here to there", i.e. recs[]->ptr, recs[]->size, interface to avoid
> having to scan the underlying string in an unbounded way?
>
>

I think we're going to make use of xdl_blankline instead of this or
our own "is_emptyline"

Thanks,
Jake
