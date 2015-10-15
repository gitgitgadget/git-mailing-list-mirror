From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make "git checkout" automatically update submodules?
Date: Thu, 15 Oct 2015 16:21:50 -0700
Message-ID: <xmqq7fmnhg4x.fsf@gitster.mtv.corp.google.com>
References: <loom.20151016T001449-848@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kannan Goundan <kannan@cakoose.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 01:22:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmrqY-0000zW-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 01:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbbJOXVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 19:21:55 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35340 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbbJOXVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 19:21:53 -0400
Received: by pabws5 with SMTP id ws5so3105633pab.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SCzvN0dIyEGGf9VWDBqsz1K6Aq7w7EZUIrQl1kMD1VM=;
        b=ytWWuyGm0uueoHnRnbagykSV6dc9uZqoqMic0WKapD2w0inV4Hqf7mhbrp3sUn7bVL
         0Fh1tsWSX8bUM6YFq4OVnxQ3vjoGizhR8gSQvt5ECPQSqPsg2z7FtlgF24/5352dirdj
         Dien9hcA/yuhKcxt1ITF2c1B/4fnxrrxoBTq1d79OqUAB4DyPYzXUgMasAo/qST5K6Xt
         2J3+X/lF19ZN9buFn2sSYU8BPkw9C9YG8ogofZhdXD1lPcZ4AX0+FCWh850yySy1u0Np
         FaAyZMLlRf683uH5sspflvRMt4IXJh+wFifpgyDJwGnL+Gzu50pAYJCk2VWir3szRc6Q
         7htA==
X-Received: by 10.66.139.201 with SMTP id ra9mr12743028pab.153.1444951312286;
        Thu, 15 Oct 2015 16:21:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id eg5sm17526812pac.30.2015.10.15.16.21.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 16:21:51 -0700 (PDT)
In-Reply-To: <loom.20151016T001449-848@post.gmane.org> (Kannan Goundan's
	message of "Thu, 15 Oct 2015 22:50:05 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279713>

Kannan Goundan <kannan@cakoose.com> writes:

> Git submodules seem to be a great fit for one of our repos.  The biggest
> pain point is that it's too easy to forget to update submodules.
> ...
> In the common case of the submodule content having no local edits, it would
> be nice if "git checkout" automatically updated submodules [1].  If there
> are local edits, it could error out (maybe override with
> "--ignore-modified-submodules" or something).
>
> I'm not a Git expert, though.  Is there a reason something like this isn't
> already implemented?  Maybe there's an existing write-up or mailing list
> thread I can read to get some background information?

I think it is mostly because the area has a lot of corner cases and
different workflows.  For example ...

> [1] Our post-checkout procedure is:
>
>     git submodule sync
>     git submodule update --init
>     git submodule foreach --recursive \
>       'git submodule sync ; git submodule update --init'

... this will clearly not work well for everybody, as you do not
want to instantiate _all_ the submodules _unconditionally_.  Well,
"you" (Kannan) and your project may want to, but not necessarily
other large projects (e.g. imagine Android using submodules).

So you can view the current status being "nothing is instantiated by
default", which _is_ far from satisfactory than the ideal case where
perhaps the project can specify in .gitmodules which submodules are
to be instantiated by default, add labels to modules in .gitmodules
so that "git clone" of a top-level project with submodules can be
told "git clone --init-submodules=<label>" to instantiate the modules
that match the given label after the top-level is cloned, etc. etc.

But such a way to allow these more complicated situations to be
handled nicely has not been designed by anybody, so for now "nothing
instantiated by default" stands as the safest default.
