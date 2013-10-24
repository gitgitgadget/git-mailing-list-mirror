From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Finding the repository
Date: Thu, 24 Oct 2013 20:46:33 +0700
Message-ID: <CACsJy8AVdV8nPXFVdj37O1dgvcWh=tQ5C7iUE134Wk2yTD42Ug@mail.gmail.com>
References: <5267804b.JaxQnlQ5Cx+By4RS%perryh@pluto.rain.com>
 <CACsJy8DgxpjasroZv4iqTn9JhQ_3r2DD9uEf-xL-uyyPOtWh+A@mail.gmail.com> <5268d0ff.HMSQf8rpwyXtEYEA%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Perry Hutchison <perryh@pluto.rain.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 15:47:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZLFp-0001lB-3L
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 15:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab3JXNrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 09:47:09 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:36660 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab3JXNrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 09:47:07 -0400
Received: by mail-qe0-f50.google.com with SMTP id 1so1401264qee.23
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0aLOZALBMil/z6qfkhEScnG8BcdRwXpwfSMu9cXZ3VE=;
        b=ZUAIFDpEaT8K2/kUC3H3zgEKBG0IXInypup2DSqMMSWtiZ60B4R0waXanBw07cwYV/
         V62U1jg0ejpZ5JoWE+TxNn5Z7tTjrz9yX2WCsSE3nJMeHOL1s0HySmol/qjbsKDtepBx
         xbxxpN1m7GLYlI19k5Uqp0rLcNaLPgKqkSOCH0GAe03hyk5clsMhM4wWqYaoVaCsT4sv
         BZZnrM9Q21CqEOwLxx6Hl72EUXdTm/xghql89J/Z+vt3BkDUDGxT1wYN8jtlkZtH+Hh2
         QNy9eAMztBOQGcMtjQ7JmPDOKMJfkTNVcugcMj6ONSK1Rg86sooHHlqSyGj72Udm9RP0
         TRnQ==
X-Received: by 10.224.160.83 with SMTP id m19mr2546948qax.108.1382622424646;
 Thu, 24 Oct 2013 06:47:04 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 06:46:33 -0700 (PDT)
In-Reply-To: <5268d0ff.HMSQf8rpwyXtEYEA%perryh@pluto.rain.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236586>

On Thu, Oct 24, 2013 at 2:49 PM, Perry Hutchison <perryh@pluto.rain.com> wrote:
> Duy Nguyen <pclouds@gmail.com> wrote:
>
>> ... it's not easy to determine ambiguity here, especially when the
>> repo finding code does not know anything about "bar/barz.c" (is it
>> a pathname or an argument to an option?).
>
> IOW, the code that finds the repository is called "too early"?

Yes. First it tries to find and setup the repository. Read per-config
repo file and add aliases to the database if any. Resolve alias. Run
the actual command. Then the command parses the command line.

> One way to solve that to that would be to proceed, even if the
> repository has to be left as "unknown" until it actually needs to
> be consulted -- by which time the subcommand would presumably have
> parsed all of the options and pathnames and so would know which is
> which.  Then, use the pathname(s) to identify the repository(ies).
> Yes, if there's more than one repository involved, the subcommand
> has to do a "for each repository" loop.  The code to do all this
> could go in a module shared among the subcommands.

That breaks the normal process I described above (i.e. lots of code
changes). People would scream at the code changes for a minor
convenience. We could refactor the parsing code so that the startup
code could do a "dry-run" command line parsing pass first. May work
for the majority of commands that do not need special parsing
callbacks.

Even then we still need more changes because git does not work well if
cwd is outside the worktree. Paths like 'bar/baz.c" need to cut "bar/"
out. Then if "baz.c" is to printed out again, "bar/" needs to be
prepended back..

>> There are more cases to consider, like what if you do
>> "git rm bar/baz.c and rab/zab.c" where bar and rab are
>> two different repositories..
>
> So we remove baz.c from bar and zab.c from rab.  It's not clear
> to me that there's anything wrong with that -- it's exactly what
> I would expect to have happen (and also what the hackish script
> I posted will do).

For "git rm", maybe. Many other commands need repo information and it
would not make sense to have paths from two different repositories.
For example, commit, rev-list or log. And it may break more things as
most of current commands are designed to work on one repo from a to z.
Some may support multi-repo operations if they're part of submodule
support.
-- 
Duy
