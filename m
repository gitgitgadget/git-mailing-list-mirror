From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] clone: fix refspec on "--single-branch" option
Date: Fri, 14 Sep 2012 20:10:16 +0700
Message-ID: <CACsJy8BLwd=XeHFqg5jb=yx3p6xdKuzvG+KvfotfLf0vfSZdRQ@mail.gmail.com>
References: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
 <1347599357-15533-1-git-send-email-ralf.thielow@gmail.com>
 <7vr4q56uae.fsf@alter.siamese.dyndns.org> <7vipbh6qxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 15:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCVfd-0007Il-Os
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 15:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab2INNKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 09:10:48 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54509 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab2INNKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 09:10:47 -0400
Received: by ieje11 with SMTP id e11so6747504iej.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uVde+5Ydt99VZ8Aufv10bnAVVAIn5VHv3V3+ZWkq4Tg=;
        b=ojck+htQce2PoFaZcZatEv8AYbzO2fUFx2NBtEXuFM9oQPi9emTA7x4T5x0I/JwsO7
         AVcmmCJjbskABbf22SwYdLXPNdxw+yIMisf8Ou2j0yp8a78lr9VhnTXTSvLM2CVWKlan
         F93MSL+o4tNV/Ku59NXChAJNTX1l5HdtBKrSWZGnqD2dlLR3qZLbUjTjn5+qtBwjOxwV
         TVYPSRv6IR8B19idWCSt6Lugm6p6WthNwnScNPXGJI0x8cNFDcm7Q5zR/uBzSNjAw5Fb
         wX+0IUw9HkM59eaL9brhmoW6tiCmendQkaZWue3eC7fEx6RABhnbls6uNgVwjRzQbGr/
         TcRw==
Received: by 10.50.13.133 with SMTP id h5mr691199igc.2.1347628246861; Fri, 14
 Sep 2012 06:10:46 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Fri, 14 Sep 2012 06:10:16 -0700 (PDT)
In-Reply-To: <7vipbh6qxa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205489>

On Fri, Sep 14, 2012 at 1:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Who guarantees at this point in the codepath that option_branch is
>> set when option_single_branch is non-zero?  Until we talk with the
>> remote, "clone --single-branch" without an explicit "--branch" will
>> not learn which branch at the remote we are going to fetch (it will
>> be their HEAD).
>>
>> I wonder if this should be more like this:
>>
>>       if (option_single_branch) {
>>               if (option_branch)
>>                       Your patch "+refs/heads/foo:refs/remotes/origin/foo";
>>               else
>>                       "HEAD";
>>         } else {
>>               Original "+refs/heads/*:refs/remotes/origin/*";
>>       }
>>
>> That is, "clone --single-branch" will continue fetching from and
>> integrating with their HEAD without storing any remote tracking
>> branch.
>
> Alternatively, if you can move the logic to set up this
> configuration further down so that it happens after we talked to the
> other side and figured out remote_head_points_at, you could instead
> set it up to keep a single remote tracking branch.

That sounds reasonable. I have a question though, what should a user
do when he/she want to fetch all branches again? Messing up with
refspec in config file is not something I would like to do.

Perhaps a heuristic in git-fetch to detect "single branch" situation
and ignore refspec? We could hint people that refspecs are not
followed when remote has more than one branch. They could either fetch
the another branch explicitly, which turns off the heuristic, or turn
off the advice.

> Even if you did so, guess_remote_head() may not find any branch when
> the other repository's HEAD is detached, so you would need to decide
> what to do in such a case, and "fetch and integrate their HEAD
> without using any remote tracking branch" may be a reasonable thing
> to do in such a case.
-- 
Duy
