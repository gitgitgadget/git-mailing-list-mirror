From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 16:45:03 -0700
Message-ID: <CAGZ79kbja85_wMVZwy9i--8F0e=iboaZuOjgbhMmF+8xuks7mA@mail.gmail.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
	<1460761306-18794-3-git-send-email-sbeller@google.com>
	<CA+P7+xq-njse8TKWExwKWx=6ynVNwM1ODHnTij6pdQNejvKT=g@mail.gmail.com>
	<CA+P7+xoMVzYwWv3=7hTUM7gMjm4i7Vv74aoyw17T_CbToZTVaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 01:45:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arDQH-0003d9-3Y
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 01:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbcDOXpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 19:45:06 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33884 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbcDOXpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 19:45:05 -0400
Received: by mail-ig0-f170.google.com with SMTP id gy3so8835408igb.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=OBpZmN9dL3Y/LRQXuYmeFJb3ZO+4UxR9M4+CBE8DDCM=;
        b=gUCE5TTJfjzxWZ/j30Qxh3YgVGJ4IBLs4mygZPX4EL/hlK7TNi3k2qvZ6Fa55neKAg
         WHUlodGdyTRUtGjmjYAuBOGohjogHc2KdHtDPVJBTRBc8omKyxwIhgN0rZH8o5xQJfJd
         C+TP1AZmPI7JZXUpEK61I0ocsfRbplrQhRjBB7jmqfK+4brE3pP+9U9L39T7BtAOt2fH
         tjoshV/naGxH2tMcRC48eR9DoF4lsBakkkQPphHHxPlLjDIf5m7fJnImzUZJaS9b8yQP
         37txwaXiRUrGjkNumNfbokEAjsuvHGpDikW7fDIOeW5/Bd2VTE4O25Q/ZOkaknriJzHs
         NogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=OBpZmN9dL3Y/LRQXuYmeFJb3ZO+4UxR9M4+CBE8DDCM=;
        b=RyaqHXxIbgXWiG6md5C5oTs912RSEfltn8vrhRkZn/QXrcLiczHGNieSy7+LeSnhby
         BRtaRScI67SYGxxNo/+b5l+VQv8ia5utGCRyeWrW5q+zPJv3u3DNpkNE4LP2h7GsMIOr
         3p3EjgjDa7mQL+Ax+tsW71GsYkEeRDQbfMrVpEN1c2v1xsVdST68/XFU2ljnyR1n7BK7
         XytxUJY/F17djKq24KmQDx4z8zeoETB/e99OX1SX5BwCmJkHksIgd6y+15q4za2ZEqVE
         GID7vGmu9h5BHf+HD1nTl0ISKU7847BSNGl/HWxEzAByLhc1zurrMR9DGIdknv43Wz1q
         Ea/g==
X-Gm-Message-State: AOPr4FWZ3dX7UZD+GGphofdcsxULtP2bz/ZGPn3PndZ5+lUpToe3Vtn1WuNDQl9jajZyHDQFT6Motq8kOAUQ7Lj8
X-Received: by 10.50.57.50 with SMTP id f18mr7900207igq.93.1460763903433; Fri,
 15 Apr 2016 16:45:03 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 16:45:03 -0700 (PDT)
In-Reply-To: <CA+P7+xoMVzYwWv3=7hTUM7gMjm4i7Vv74aoyw17T_CbToZTVaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291699>

On Fri, Apr 15, 2016 at 4:32 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Apr 15, 2016 at 4:05 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> There's a few places that will need cleaning up (comments and such)
>> that mention empty line still, but that's not surprising. I am going
>> to test this for a bit on my local repos, and see if it makes any
>> difference to the old heuristic as well.
>>
>> Thanks,
>> Jake
>>
>
> I ran this heuristic on git.git and it produces tons of false positive
> transforms which are much lease readable (to me at least), far more
> than those produced by the newline/blank link heuristic did.
>
> I think we should stick with the empty line heuristic instead of this
> version, even if it's easier to implement this version.

I agree. The heuristic is worse as we often have these 50:50 chances
of messing stuff up.

>
> We still would need to figure out how to handle CRLF properly but it's
> worth resolving that than this heuristic is.
>
> Thanks,
> Jake
