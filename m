From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v8 4/4] git-rebase: add keep_empty flag
Date: Wed, 18 Jul 2012 00:16:47 -0700
Message-ID: <CAOeW2eHvDMkX++L386aXaUsMPVbmL-9GvioiUAPGX8PjJ8TNTA@mail.gmail.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
	<1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
	<1334932577-31232-5-git-send-email-nhorman@tuxdriver.com>
	<CAOeW2eEchYzRYYUBySKg5xYY3vBDy8GVcAd=ay-HoAGDLZtORw@mail.gmail.com>
	<5006614E.8090601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:16:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOVC-0007g9-21
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab2GRHQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:16:50 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42250 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab2GRHQs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:16:48 -0400
Received: by lbbgm6 with SMTP id gm6so1703505lbb.19
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZoPcoF0RoE9w6shirDmkDcKzmr0kTSkusvBt9n9jJT0=;
        b=GhquGKKYqbC+zsYuocaA9oRJMUnAphE6DB2zyrPrm2sbJB/Z451WUqw2k4p+7eZ55O
         GMhOQuzMIYeLBn4grSoRuoTvrc7WeerRnQ/u2gwgJSivxRzGfol3XHXKi7AYmpgJgGqW
         ze4Mwykw1wGSMrDGcQhs7RpPyWnA46hfdsszEk2X6NLNd+Cr5poXO3gnxdMcbnTphNqF
         t9JWbtxpWUeoKlFm0RojUTpC6bcSIMlbhIq+zSlAcvRPqVfCW/jQ9bqylq3dOI92xBIg
         uxC1WvwCv3Kg8M2to2p0R7PyowcYr6B8JHmg/e8duAIwojhBO1S+WWbYMTm3ZeoMOrVm
         izeQ==
Received: by 10.112.98.40 with SMTP id ef8mr1199608lbb.72.1342595807185; Wed,
 18 Jul 2012 00:16:47 -0700 (PDT)
Received: by 10.112.39.169 with HTTP; Wed, 18 Jul 2012 00:16:47 -0700 (PDT)
In-Reply-To: <5006614E.8090601@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201655>

On Wed, Jul 18, 2012 at 12:10 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 7/18/2012 8:20, schrieb Martin von Zweigbergk:
>> On Fri, Apr 20, 2012 at 7:36 AM, Neil Horman <nhorman@tuxdriver.com> wrote:
>>>  pick_one () {
>>>         ff=--ff
>>> +
>>>         case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
>>>         case "$force_rebase" in '') ;; ?*) ff= ;; esac
>>>         output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
>>> +
>>> +       if is_empty_commit "$sha1"
>>> +       then
>>> +               empty_args="--allow-empty"
>>> +       fi
>>> +
>>>         test -d "$rewritten" &&
>>>                 pick_one_preserving_merges "$@" && return
>>> -       output git cherry-pick $ff "$@"
>>> +       output git cherry-pick $empty_args $ff "$@"
>>
>> The is_empty_commit check seems to mean that if $sha1 is an "empty"
>> commit, we pass the --allow-empty option to cherry-pick. If it's not
>> empty, we don't. The word "allow" in "allow-empty" suggests that even
>> if the commit is not empty, cherry-pick would not mind. So, can we
>> always pass "allow-empty" to cherry-pick (i.e. even if the commit to
>> pick is not empty)?
>
> I don't think so. If the commit is not empty, but all its changes are
> already in HEAD, then it will become "empty" when cherry-picked to HEAD.
> In such a case, we usually do not want to record an empty commit, but stop
> rebase to give to user a chance to deal with the situation.

Ah, makes sense. Thanks!
