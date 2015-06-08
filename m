From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/6] am --skip/--abort: improve index/worktree cleanup
Date: Mon, 8 Jun 2015 10:04:42 -0700
Message-ID: <CAGZ79kZj1vFj9VFAzJdv-nE=Lqcbz2BXXrao1KPdrYw_yYeyhA@mail.gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20Tq-0003rc-DQ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbbFHREx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:04:53 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:34024 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbFHREn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:04:43 -0400
Received: by yhid80 with SMTP id d80so33028069yhi.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DMXmErTW4/ZDj2kQHbPWqKvBOIr18PjC2OhmBG48VlU=;
        b=odnHehgB+k/LdgwbtSk7v0CVzm2UoFPA3/zXxreVK18RRazQSg4qNVZN/aplyXq2TG
         Y8rO4wgmWPnrnr5r0fOwhL/ucBEbnaGmhBw7+lKFxAKaRu3LMygp8oI0R446Barxf1hb
         ZRlDS5Xrobj0qyZ30+SZyOueg6aNdEVa6X5smikg5YnMRXgFMTsdux+j4x9i9LGah2/s
         GpBdus09TwxCsQExrCpvIBrX9nAhrkK5n++qN9zP6z2LX7LdUHax2wvcTB4ppePyqBDW
         iNfZTsWMgEZVLca0WgU9DiLm+O0L/6BD6X4ps6A1vXeD3lIPqFw4ezmh0bNYO3z6Ymfo
         /1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DMXmErTW4/ZDj2kQHbPWqKvBOIr18PjC2OhmBG48VlU=;
        b=Sl0aEPGT7s4YOxfUdGcE82EnK2VpVVXRGPqasGOINfO+IcM1pPXB8JkI6xmWcuzNSC
         gA9vLZDXnmAUCt7B1n+4i8r96BtzoXf9fjXC58hvnm3zvAjCS5DaE/wX0e5JLMvBrLWy
         ZnsO4+3tZ6Yrwksu+qucSWqgufYnaTSv8tx0GDEHBgkDPXkI+UA/4plK4PiCOOe5hCH0
         hgs48qxtlrHKWSAl1RIYUjahIHXj4L1euT2HBgjfr8TnKp9oRvVRkxqR88R5matgCvEf
         dQSAuEmJtBCfcvYVXrdJGn3y3tX4ypaMST9v0c0C7vocuQPqsN4utXdxbTMlsVNUHzZn
         F2iA==
X-Gm-Message-State: ALoCoQmNFMLkVNqDDOYd7aucrWGYEgQAhGGEwEk6WQ2f47s8LjrxjbjGYM3rz0Yl4VDxJMjkroOv
X-Received: by 10.13.213.212 with SMTP id x203mr17064633ywd.174.1433783082879;
 Mon, 08 Jun 2015 10:04:42 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Mon, 8 Jun 2015 10:04:42 -0700 (PDT)
In-Reply-To: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271080>

On Sat, Jun 6, 2015 at 4:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Currently git-am attempts to clean up the index/worktree when skipping or
> aborting, but does not do it very well:
>
> * While it discards conflicted index entries, it does not remove any other
>   modifications made to the index due to a previous threeway merge.
>
> * It expects HEAD/ORIG_HEAD to exist, and thus does not clean up the index when
>   on an unborn branch.
>
> This patch series addresses the above two general problems by making the calls
> to git-read-tree aware of the differences between our current index and
> HEAD/ORIG_HEAD, and by explictly defining what happens when we are on an unborn
> branch.
>
>
> Paul Tan (6):
>   am --skip: revert changes introduced by failed 3way merge
>   am -3: support 3way merge on unborn branch
>   am --skip: support skipping while on unborn branch
>   am --abort: revert changes introduced by failed 3way merge
>   am --abort: support aborting to unborn branch
>   am --abort: keep unrelated commits on unborn branch

The whole series looks good to me.

Thanks,
Stefan

>
>  git-am.sh           | 31 ++++++++++++++------
>  t/t4151-am-abort.sh | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+), 8 deletions(-)
>
> --
> 2.1.4
>
