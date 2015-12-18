From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 10/10] dir: do not use untracked cache ident anymore
Date: Fri, 18 Dec 2015 09:32:03 +0100
Message-ID: <CAP8UFD2UzNW6ZsrrOjRO-+5BSpx6Ntz+7gk4FsnOZ74KbEiTJg@mail.gmail.com>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
	<1450196907-17805-11-git-send-email-chriscool@tuxfamily.org>
	<xmqqd1u7fq5r.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0Y252vmqxziy4Y8Bp3cw6fS0iOVFzZG+=wGt7K25V8Yg@mail.gmail.com>
	<xmqq1talc4co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 09:32:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9qSm-0001Cx-51
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 09:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbbLRIcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 03:32:07 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33440 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbLRIcF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 03:32:05 -0500
Received: by mail-lb0-f180.google.com with SMTP id kw15so59641853lbb.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 00:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MA6GE4YDD2UvcOyeqe1Q9G7GH5F9yZwGtnxuuY732aY=;
        b=wjpJTDXN0pVOHcmJmkYqmEyLhZ1xyJplFvbo7brNW5sBEi/Ez88CM3niDicUDEomhc
         fZUAbjpjpiNaeHb+ytgHhYtC3w2woz6tK7y19eWTguqQnrqao+dTrBnlDwHJo0FxIwXc
         s8ATAfuC23slkkGiZjVGF/7awStrF6uswi8vuZMC2oh2CyKKRAaUoTuvLkFeV73hAcoh
         mlWJGHhCdwQq41vraPResX/DwbZADWWlpaej1GHxCGj6k9Z8JEGKZY5ls7TvBie0w72j
         J91VQQ/H6QVsoGBED4yw+DRY9TkONs98I89HyV26xr/cB04kACBwZNxHX3V6ZepGi4WF
         MH/w==
X-Received: by 10.112.141.201 with SMTP id rq9mr816897lbb.4.1450427523928;
 Fri, 18 Dec 2015 00:32:03 -0800 (PST)
Received: by 10.25.23.90 with HTTP; Fri, 18 Dec 2015 00:32:03 -0800 (PST)
In-Reply-To: <xmqq1talc4co.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282702>

On Thu, Dec 17, 2015 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> In the "git worktree" documentation there is:
>>
>> "If you move a linked working tree to another file system, or within a
>> file system that does not support hard links, you need to run at least
>> one git command inside the linked working tree (e.g. git status) in
>> order to update its administrative files in the repository so that
>> they do not get automatically pruned."
>>
>> It looks like git can detect when a worktree created with "git
>> worktree" has been moved and I wonder if it would be possible to
>> detect if the main worktree pointed to by GIT_WORK_TREE as moved.
>
> As I personally do not find "moving a working tree" a very
> compelling use case, I'd be fine if cached information is not used
> when the actual worktree and the root of the cached untracked paths
> are different.

Yeah, I could just discard and recreate the UC from scratch if the
actual worktree and the root of the UC paths are different.

> If you are going to change the in-index data of untracked cache
> anyway (like you attempted with 10/10 patch), I think a lot more
> sensible simplification may be to make the mechanism _always_ keep
> track of the worktree that is rooted one level above the index, and
> not use the cache in all other cases.  That way, if you move the
> working tree in its entirety (i.e. $foo/{Makefile,.git/,untracked}
> all move to $bar/. at the same time), the untracked cache data that
> was in $foo/.git/index, which knew about $foo/untracked, will now
> know about $bar/untracked when the index is moved to $bar/.git/index
> automatically.

I am ok with that, though I worry a bit about some people having a
setup where they always use a worktree that is not one level above the
.git directory.
