From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] clone: fix refspec on "--single-branch" option
Date: Fri, 14 Sep 2012 16:25:40 +0200
Message-ID: <CAN0XMOJFG2_Ju8fcAcyTiUc3owjedpKX+LpHdBWdym36Hm0LdA@mail.gmail.com>
References: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
	<1347599357-15533-1-git-send-email-ralf.thielow@gmail.com>
	<7vr4q56uae.fsf@alter.siamese.dyndns.org>
	<7vipbh6qxa.fsf@alter.siamese.dyndns.org>
	<CACsJy8BLwd=XeHFqg5jb=yx3p6xdKuzvG+KvfotfLf0vfSZdRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 16:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCWq7-0001HB-2t
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 16:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636Ab2INOZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 10:25:43 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39815 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab2INOZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 10:25:42 -0400
Received: by wgbdr13 with SMTP id dr13so3585066wgb.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FIbdV4f8SMqAuNfSAMErihDPMEeQd7y4t8nJZrj0KXI=;
        b=seLSJ+EQhUALcOPCgnpyZt0yOs2iL/PI39c9H80+xxVbfDDe18DWl5jQITC5WK+ybV
         JNiUcsBV77DlJj5bI9Ukezj6OV9Ko7VmzpfWUbIbMTb4rJ8NjU41TIEwbmWuKRwcWZwe
         lDpTPUAMV19SZj+isplZqCzd8kPJhLJB/3emC+EsO4L2jFgCWGllzP2rnmCCrhKhenc5
         7VrBSSHmm0cVlmWmqyqxt8lVbU0Sa6UKOjrdxg7Hgfoi2x8Zug7+e3KAh+jvG9DgNHa6
         m2HSv5RXUsV45PmmL3if3tEuRMuaKAkfGR3Z0tPs2MYmKcG8zjZ22qYPy0Hf7xsgd85h
         ZT5Q==
Received: by 10.217.1.197 with SMTP id n47mr1596673wes.27.1347632740485; Fri,
 14 Sep 2012 07:25:40 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Fri, 14 Sep 2012 07:25:40 -0700 (PDT)
In-Reply-To: <CACsJy8BLwd=XeHFqg5jb=yx3p6xdKuzvG+KvfotfLf0vfSZdRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205492>

On Fri, Sep 14, 2012 at 3:10 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Fri, Sep 14, 2012 at 1:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Who guarantees at this point in the codepath that option_branch is
>>> set when option_single_branch is non-zero?  Until we talk with the
>>> remote, "clone --single-branch" without an explicit "--branch" will
>>> not learn which branch at the remote we are going to fetch (it will
>>> be their HEAD).
>>>
>>> I wonder if this should be more like this:
>>>
>>>       if (option_single_branch) {
>>>               if (option_branch)
>>>                       Your patch "+refs/heads/foo:refs/remotes/origin/foo";
>>>               else
>>>                       "HEAD";
>>>         } else {
>>>               Original "+refs/heads/*:refs/remotes/origin/*";
>>>       }
>>>
>>> That is, "clone --single-branch" will continue fetching from and
>>> integrating with their HEAD without storing any remote tracking
>>> branch.
>>
>> Alternatively, if you can move the logic to set up this
>> configuration further down so that it happens after we talked to the
>> other side and figured out remote_head_points_at, you could instead
>> set it up to keep a single remote tracking branch.
>
> That sounds reasonable. I have a question though, what should a user
> do when he/she want to fetch all branches again? Messing up with
> refspec in config file is not something I would like to do.
>

$ git remote set-branches <remote> "*"

> Perhaps a heuristic in git-fetch to detect "single branch" situation
> and ignore refspec? We could hint people that refspecs are not
> followed when remote has more than one branch. They could either fetch
> the another branch explicitly, which turns off the heuristic, or turn
> off the advice.
>

Such an advice when using "--single-branch" is a good idea, i think.
Something like "The remote <remote> is configured to fetch only branch <branch>.
If you want to fetch all branches, use "git remote set-branches <remote> "*""
or something like that.

>> Even if you did so, guess_remote_head() may not find any branch when
>> the other repository's HEAD is detached, so you would need to decide
>> what to do in such a case, and "fetch and integrate their HEAD
>> without using any remote tracking branch" may be a reasonable thing
>> to do in such a case.
> --
> Duy
