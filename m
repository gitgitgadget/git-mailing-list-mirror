Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77041C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 19:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E9324695
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 19:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgARTGY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 18 Jan 2020 14:06:24 -0500
Received: from mail6.webfaction.com ([31.170.123.134]:43908 "EHLO
        smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgARTGY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 14:06:24 -0500
X-Greylist: delayed 68925 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jan 2020 14:06:24 EST
Received: from localhost (82-64-139-178.subs.proxad.net [82.64.139.178])
        by smtp.webfaction.com (Postfix) with ESMTPSA id 355FE6002B562;
        Sat, 18 Jan 2020 19:06:16 +0000 (UTC)
From:   Christoph Groth <christoph@grothesque.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Stat cache in .git/index hinders syncing of repositories
References: <87v9p9skjz.fsf@drac> <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 18 Jan 2020 20:06:21 +0100
In-Reply-To: <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 18 Jan 2020 10:15:22 -0800")
Message-ID: <87pnfgshxu.fsf@drac>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Christoph Groth <christoph@grothesque.org> writes:
>
> > However, there is one problem with syncing git repositories, that
> > has been noticed by multiple people [1]: The file .git/index
> > contains not only the “git index”, but also a cache of stat-data of
> > the files in the working directory.  Some file synchronizers are
> > able to sync mtimes, but syncing ctimes would be bizarre (if it is
> > even possible).
>
> The stat-data in the index file is meant to be a mere optimization,
> and after copying .git/index and the working tree files to a new box,
> running "git update-index --refresh" would make them in sync, no?

Let’s assume that one somehow manages to teach the synchronizer to run
"git update-index --refresh" immediately after copying the index file
and to consider the resulting modified .git/index file as identical to
the version on the other side.  (That would be already really difficult,
because it’s against the design of synchronizers to consider differing
files to be identical.)

Even then, .git/index will change again whenever the mtime of any
tracked file changes.  That can easily happen through "touch" or
modifying a file and then reverting the change.  There’s no way for the
synchronizer to tell the difference between relevant and irrelevant
changes to .git/index.  (Short of writing a specialized tool for
comparing git index files and embedding it.)

Would it be feasible to move this optimization data to a separate file
without breaking backwards and forwards compatibility?  I guess it
would: the data format of .git/index could remain identical, but newer
versions of git could ignore the stat data in the index file and use
a separate file for that.  If an older version of git is used with the
repository, it would simply notice that the stat data in .git/index is
not up-to-date.

But if the above is not feasible for some reason, would it be possible
to provide a switch for disabling stat caching optimization?

I believe that synchronizing files between machines is something that
will become ever more important with new tools like syncthing.  So it
would be really cool if git were to support such usage.  It *almost*
does!
