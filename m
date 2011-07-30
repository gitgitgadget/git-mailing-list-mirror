From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: gitignore design
Date: Sat, 30 Jul 2011 08:45:21 +0200
Message-ID: <CAA01Cspv4yShnKBKFFrf8K1tbARahyYf7KZPqbiDFrvFsX9hwg@mail.gmail.com>
References: <1311934832699-6632987.post@n2.nabble.com>
	<m3pqktql6s.fsf@localhost.localdomain>
	<4E32B637.1030201@viscovery.net>
	<201107292339.51753.jnareb@gmail.com>
	<CACsJy8CurvKd_=hdRQyjjzWLvKF0jbWOQhbLSsmk1BqB_dK3og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	llucianf <llucianf@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ferry Huberts <mailings@hupie.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 08:45:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn3If-0000Wg-My
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 08:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab1G3GpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 02:45:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50056 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab1G3GpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 02:45:24 -0400
Received: by ywn13 with SMTP id 13so167481ywn.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/9p+zhKjrcMYCfD8uemCNVgvrdoa53QbXqLXNg9LOSI=;
        b=Hd3m5Qu5pKpAyJX0idqwdESZBMTa0yeGTIULXys5q2wunsodl6aBrly1vI96dzJm0y
         t8jhJwlTa2i+DPAqg/wxKvU8GV2s6UhKcbQ2bRkLEUu5QLwDG/i3gfrsz+1k9wCCccr4
         hdHzZaqCacHPlKsmaEYA8R9aFHvhKdkIiqcF8=
Received: by 10.150.74.17 with SMTP id w17mr184752yba.274.1312008321582; Fri,
 29 Jul 2011 23:45:21 -0700 (PDT)
Received: by 10.151.147.1 with HTTP; Fri, 29 Jul 2011 23:45:21 -0700 (PDT)
In-Reply-To: <CACsJy8CurvKd_=hdRQyjjzWLvKF0jbWOQhbLSsmk1BqB_dK3og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178176>

On Sat, Jul 30, 2011 at 5:10 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> 2011/7/30 Jakub Narebski <jnareb@gmail.com>
>> True, it is *assume-unchanged*, not ignore-changes bit; though the latter
>> would be also possible to implement, I think... but having some file not
>> changing and marking it as such for better performance is saner use case
>> than tracking some file but not really tracking it.
>
> If you just want to ignore some files (or paths), then adding
> --exclude option to diff machinery may be a better option.
> --assume-unchanged is too low-level, and not really convenient to use.

I want to have "exclude tracked" feature too, for the same reason as
llucianf wrote. I have project files which are
tracked but when I use them locally they might get changed (if I
modify some options).

The template project files are some solution, but they need changes to
the build process, which might not always be possible. Also, with
templates you won't have updates (like new project options) in your
local copy automatically.

The project files are updated very rarely so handling updates should
not be a big problem.

I think the "exclude tracked" option might work like this (all of this
with "unless asked explicitly" assumption):
- diff, stat do not show differences
- add, commit do not add changes
- stash do not stash changes
- merge tries to merge changes from upstream. If there's a conflict
you'll have to resolve it. OR
- merge does not touch your locally unchanged files if they have
changes - if upstream have changes you'll have to make your local
changes disappear (copy file, checkout orig file, merge, analyze what
changed, copy your local changed file back)
- checkout (different branch) - probably same as merge


>> > No code reference, sorry, because I'm just parrotting what I've read
>> > elsewhere on the list, for example,
>> > http://thread.gmane.org/gmane.comp.version-control.git/146082/focus=146353
>>
>> Well, there is hint that there might be problems, but not really says
>> that they are, and where (if one is lying about assume unchanged by changing
>> assume-unchanged file).
>
> There were problems in the past. See aecda37 (do not overwrite files
> marked "assume unchanged" - 2010-05-01)
>
> The only place that relies on checking files uptodate (which can be
> faked by assume-unchanged bit) before overwriting them is
> unpack-trees.c, verify_update_1(). With that fix in place, I think
> assume-unchanged bit is safe now. However, as long as we don't
> explicitly state that we will not carelessly overwrite
> assume-unchanged files, there are still chances that some
> optimizations in future may make it dangerous again.

I was using assume-unchanged for some time but stopped after some
weird problems during updates. I'm not sure if this was caused by this
or by sparse-checkout (and I use git-svn too). Anyway, after stopping
using assume-unchanged and sparse-checkout mysterious problems
disappeared.


-- 
Piotr Krukowiecki
