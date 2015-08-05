From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git_open_noatime: return with errno=0 on success
Date: Wed, 5 Aug 2015 10:59:09 +0200
Message-ID: <CA+55aFx-WXxCbVTWdJHFf4WA2MNXS3UMerv4cD1wtsZGaQkJLw@mail.gmail.com>
References: <20150708123820.GA25269@musxeris015.imu.intel.com>
	<CAPig+cSacM_JwZzagOVZpMJF=oE7m3rMnq1eKr=aNsGY0vvmfQ@mail.gmail.com>
	<20150804082429.GA22271@musxeris015.imu.intel.com>
	<xmqqfv3y6a24.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Clemens Buchacher <clemens.buchacher@intel.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Martin_Schr=C3=B6der?= <martin.h.schroeder@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 11:00:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMuYz-0000x4-7L
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 11:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbbHEI7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 04:59:33 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34241 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbbHEI7K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 04:59:10 -0400
Received: by ioea135 with SMTP id a135so42768975ioe.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=A7taIf6Ot2CYwEB/RfO7fNevhvGA347gkgNr8xFO/Uo=;
        b=T5RYqTiYzPaCYj8u/EbWoACbTZZrqHwK0+xDOh4e48XjSRNUvF01Il5IJutN1c7bLR
         4XCkwHzEC1dLZiKN6bRX5wZFcNMTLPlVQupqTtajo5bGKck4bqu1pzaClvlwnip539qQ
         6T/EpQ8DOBUNUA3t2n9Fg/Ehv+fDTRR6oivHbu7thEzOOv6O1ffBSl4h8pKrpukO13vh
         E02uygJlpqWDz6qfXDNER3uckW1F8KcqimTvNbu87pQu/AR4xtzr8Gy2r8c2k6QX0BzJ
         YGpt+Y8zDjvzZaZj68wk4bIuXkFxCaglXVJ7S+h5nKjc9RyEaYK0rKv9VRIycoxi/IRb
         clPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=A7taIf6Ot2CYwEB/RfO7fNevhvGA347gkgNr8xFO/Uo=;
        b=PCfbpJWG1Bdbo2uCA12VeJpwiGKFERtDPPP1YQRFbW059Hd+gRLAUe59WIr1/bBVHy
         wWq872u5SDjGC4ik8ACIR2VEuMXF5bs2d5m6FUmRsoZ7QJr7X1F/SwkTeMWkHRm8cfU0
         zGyCm4C/S+N5Kc7ZvMk22hS7wLqF3Hn7cXkA4=
X-Received: by 10.107.167.207 with SMTP id q198mr10130623ioe.137.1438765149909;
 Wed, 05 Aug 2015 01:59:09 -0700 (PDT)
Received: by 10.36.219.130 with HTTP; Wed, 5 Aug 2015 01:59:09 -0700 (PDT)
In-Reply-To: <xmqqfv3y6a24.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: NwL0mERS7BihKFGMufG5i0eFV68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275358>

On Tue, Aug 4, 2015 at 11:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I would agree it is a good idea to clear it after seeing the first
> open fail due to lack of O_NOATIME before trying open for the second
> time, iow, more like this?

So I don't think this is _wrong_ per se, but I think the deeper issue
is that somebody cares about 'errno' here in the first place.

A stale 'errno' generally shouldn't matter, because we either

 (a) return success (and nobody should look at errno)

or

 (b) return an error later, without setting errno for that _later_ error.

and I think either of those two situations are the real bug, and this
"clear stale errno" is just a workaround.

But as mentioned, I don't think clearign errno is wrong, so I'm not
objecting to the patch. I just suspect there's something else goign on
too..

              Linus
