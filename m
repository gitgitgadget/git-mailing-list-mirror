From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Finding the repository
Date: Thu, 24 Oct 2013 23:09:25 -0400
Message-ID: <CABURp0rFPYZEDC95+pL7bvnFuMpsiqp_YoQJ6f0DSFYWP=v4Gw@mail.gmail.com>
References: <5267804b.JaxQnlQ5Cx+By4RS%perryh@pluto.rain.com>
 <CACsJy8DgxpjasroZv4iqTn9JhQ_3r2DD9uEf-xL-uyyPOtWh+A@mail.gmail.com>
 <5268d0ff.HMSQf8rpwyXtEYEA%perryh@pluto.rain.com> <CACsJy8AVdV8nPXFVdj37O1dgvcWh=tQ5C7iUE134Wk2yTD42Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Perry Hutchison <perryh@pluto.rain.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 05:09:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZXmZ-0002QF-Gp
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 05:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432Ab3JYDJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 23:09:47 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:43635 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab3JYDJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 23:09:46 -0400
Received: by mail-wi0-f177.google.com with SMTP id h11so454492wiv.4
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 20:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j+dn06mJqgXvsEw6RrO8xqXz9csnLXccETA71N3syUo=;
        b=f86yHVYB7SqYZdT9U3JhIiutRzFUlUyezH7D26DJFtABToUkDBYreRCwfK2nm852C+
         Fa21KcNx1RFD9IjhJjwFlep6RzE4ciEPFg9khMKDF9DGkl0XSv9YL9+2zYT1js2rTfkm
         qSEJWub4h0o9KO17CbC+LtVjJs2/dVjFHuCw+ZbV5AXjB0fdGESg22QZk4AHGNaEwW3F
         MdWj7ia3ZF5jh1UBuaSdxjrpNF5vN/08VEuVBsqsB8KhfyBFYZCjGG8EuRRM40QmVOPF
         K78dmmofPUhQob5Eo3clOLBqwHdPULXpTygystgo4Zv08pN1HAAAXFnvV+l6pqEkDydz
         RjDQ==
X-Received: by 10.194.175.133 with SMTP id ca5mr5146330wjc.19.1382670585785;
 Thu, 24 Oct 2013 20:09:45 -0700 (PDT)
Received: by 10.227.145.73 with HTTP; Thu, 24 Oct 2013 20:09:25 -0700 (PDT)
In-Reply-To: <CACsJy8AVdV8nPXFVdj37O1dgvcWh=tQ5C7iUE134Wk2yTD42Ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236645>

On Thu, Oct 24, 2013 at 9:46 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Oct 24, 2013 at 2:49 PM, Perry Hutchison <perryh@pluto.rain.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> wrote:
>>
>>> ... it's not easy to determine ambiguity here, especially when the
>>> repo finding code does not know anything about "bar/barz.c" (is it
>>> a pathname or an argument to an option?).
...
>>> There are more cases to consider, like what if you do
>>> "git rm bar/baz.c and rab/zab.c" where bar and rab are
>>> two different repositories..
>>
>> So we remove baz.c from bar and zab.c from rab.  It's not clear
>> to me that there's anything wrong with that -- it's exactly what
>> I would expect to have happen (and also what the hackish script
>> I posted will do).
>
> For "git rm", maybe. Many other commands need repo information and it
> would not make sense to have paths from two different repositories.
> For example, commit, rev-list or log. And it may break more things as
> most of current commands are designed to work on one repo from a to z.
> Some may support multi-repo operations if they're part of submodule
> support.

I've done some preliminary work on extending this sort of behavior to
submodule commands.  For example,

  git grep --recurse-submodules foo

which would look in the current project path and also any submodules
encountered.  This usage also begs for this extension:

  git grep --recurse-submodules foo path/to/sub/bar.c

Where 'path/to/sub' is a submodule, and therefore a foreign git repo
to this one.  Solving this is a little bit easier than your case
because git is already running inside a repo. Extending the reach to
submodules only requires more odb's than our first one to be
considered.  Along the way, I have considered your case, but I haven't
focused on it. Lately I haven't had time to focus on my case either,
though.  :-\

Phil
