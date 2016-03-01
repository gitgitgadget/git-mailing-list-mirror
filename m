From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 01/33] setup: call setup_git_directory_gently before
 accessing refs
Date: Tue, 1 Mar 2016 16:53:30 +0700
Message-ID: <CACsJy8AiT0=juU0pqBfraCZyk-g9MgEuybOw-0JQyqm9VveUWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:54:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aah0b-0000cn-2y
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 10:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbcCAJyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 04:54:14 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35748 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbcCAJyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 04:54:01 -0500
Received: by mail-lf0-f50.google.com with SMTP id j186so35208481lfg.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 01:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3GslOBPmyKr1hi7NOk9TH0ozC+LNfMJRebjIfp7Gcqo=;
        b=GZtHswgH9M5UUJCkaXwDlWuolgic5jes6lrbTxJ+3LcQMp1HciE47e1K9jR0Kxp46V
         YEt/yEXwfWz0upzgMkvffkfPj6UUioHRoXMEhvw3W1s8FSxg06aQjvgaV7le8BzEFhyq
         S7PWYEDVAdzb9oZoOirbSdY2J/G0TED6U9/Mqqsgbuci06sTLThx+tO2s9cPg1bE9JSU
         i8W1lHjhrCG6O5WySdPd/SXxnWcEjwdFJaV68NAL41vM/5SETZiPSxq6yVY5+C5hdeV0
         Rk+V/usGVucbvD09P4d2vFCIr/GKMfp5OYOy4UCvbWnJgHw7BFAeCxlT8J2ZOoEVC8Px
         mo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3GslOBPmyKr1hi7NOk9TH0ozC+LNfMJRebjIfp7Gcqo=;
        b=Wykl1JJyQZeQXC7MSPhYteKaeeKe7irGnvXtbEqQa4PilU2UQBjk5TtVt0PY/z+Z/S
         ikfvZnO+wt4jgAxH+GS/+KdAApx/n2gfl81bAJDW2ubXRKeGfxNE2D+h2X1bwuBQq2Q4
         H99FvJxC5AG6A4ZZuxiAnmugxEkbnOjzUyZgVy+Sph+jwPNlJCnMlG95OHmOurjLT9s3
         yfzl/eKtKxqLeNqxx+fWl4biBpOG7X4bLCMqUiWAuviH6PRzj/MSxsMnYF58kiW81X2V
         /5Gj51BGmY/swZF6/xlbd5lYPve++UDr7E+MU21S7rSqMNo9KWMndqf4R5ZCZlZQA4im
         dzrQ==
X-Gm-Message-State: AD7BkJJtDqmbCcagnvBkT+3cxM0cMsGCyZkCng3+nNcSQRr2PkrqpB7hH6k9pDjGfla7YeW3xBK86It4EUnr7Q==
X-Received: by 10.25.212.213 with SMTP id l204mr2779998lfg.118.1456826039717;
 Tue, 01 Mar 2016 01:53:59 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Tue, 1 Mar 2016 01:53:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288003>

On Tue, Mar 1, 2016 at 3:35 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 29, 2016 at 07:52:34PM -0500, David Turner wrote:
>
>> Usually, git calls some form of setup_git_directory at startup.  But
>> sometimes, it doesn't.  Usually, that's OK because it's not really
>> using the repository.  But in some cases, it is using the repo.  In
>> those cases, either setup_git_directory_gently must be called, or the
>> repository (e.g. the refs) must not be accessed.
>
> It's actually not just setup_git_directory(). We can also use
> check_repository_format(), which is used by enter_repo() (and hence by
> things like upload-pack). I think the rule really ought to be: if we
> didn't have check_repository_format_gently() tell us we have a valid
> repo, we should not access any repo elements (refs, objects, etc).

Agreed.

There's also a lighter version of check_repo.. which is
is_git_directory(). Most of the time we just want to answer the
question "is it a valid repository? support or not does not matter".
We probably need more eyes on submodule case when this functino is
used. For example in 25/33 [1] we check if a repo is non-bare (a
variant of is_git_directory) then we peek the config file inside.
Should check_repository_format() be done in this case?

You know what, forget my question. The answer is yes. After writing
all that, I remember that part of the config file may be moved away in
the next version of multiple worktrees [2]. We need proper repo
validation before reading anything inside.

[1] http://article.gmane.org/gmane.comp.version-control.git/287959
[2] http://article.gmane.org/gmane.comp.version-control.git/284803

> I started earlier today on a patch series to identify and fix these
> cases independent of your series.

Yes this sounds like a separate problem, even though it's raised by lmdb topic.

> The basic strategy was to adapt the
> existing "struct startup_info" to be available everywhere, and have
> relevant bits of code assert() on it, or even behave differently (e.g.,
> if some library code should do different things in a repo versus not).

startup_info is NULL for external programs if I remember correctly, or
do you make it available to all of them too?
-- 
Duy
