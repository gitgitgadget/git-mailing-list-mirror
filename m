From: Phil Hord <phil.hord@gmail.com>
Subject: Re: files deleted with no record?
Date: Thu, 26 Jun 2014 12:47:43 -0400
Message-ID: <CABURp0p6amKmhMhOUzdKy0a8TY7bmPoSLM0sUnZfGErhyfLsEQ@mail.gmail.com>
References: <CAFDwLfyXrUZUUuaciAjamn-cXJ6mAv_D41zLwT4AZE=cmAX7rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeremy Scott <jeremy@great-scotts.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0CqI-0001SK-BB
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 18:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbaFZQsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 12:48:05 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:33199 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085AbaFZQsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 12:48:04 -0400
Received: by mail-ve0-f181.google.com with SMTP id db11so3951786veb.40
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WwoMjUkbXNj6hUHk81VDfP0/FNS15uXlpG1yu5Yilho=;
        b=1IN+Be2mUTtF3kITnm3qgyUj2Oc7tVNosHbFuQSB9TgfSVC9kreFYuVXSBz/ah1fwP
         2de3E16qC4jwnIbAc9xTTQfKeCvu3IszuTky9OJ8A4PttckrcSV74MFrOWNdJj9I+Dsr
         Nm54tcSJ4HrBr9ILkix3I0ptYUNRtDeSMJNUuVt+SGCbDKc8CXCXNWjMCJ1Z7K4GspBe
         MVtmNm3fUFtkoC4yzn+czMj0bsR82y0Rh0rmogZAaOvNZuR6MnNA2yw3bP40IHGtGnXd
         VMCRQ0lSi9th3rsHSmpeWSLkqOuBaaW4n1LnOH46GhzMrBOV/s8RxnsDcInrL4WXAEuX
         mB0A==
X-Received: by 10.52.17.129 with SMTP id o1mr12406792vdd.0.1403801283184; Thu,
 26 Jun 2014 09:48:03 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Thu, 26 Jun 2014 09:47:43 -0700 (PDT)
In-Reply-To: <CAFDwLfyXrUZUUuaciAjamn-cXJ6mAv_D41zLwT4AZE=cmAX7rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252508>

On Mon, Jun 23, 2014 at 9:15 PM, Jeremy Scott <jeremy@great-scotts.org> wrote:
> I just encountered a situation where a merge was made, with no
> apparent changes in files (ie no log), but the result was that some
> files were deleted.
>
> person A adds some files
> person B adds some files from the same point

You mean from the same point in history, right?  Not files with the
same filename or path?

> person B commits and pushes.
> person A commits -- now merge is required
> a few more commits on top of person B's commit

I don't understand this step.  Who adds a few more commits on top of B and why?

> person A merges - this removes the files that B added. There is no log
> of the files being deleted

This sounds like an "evil merge" (see man gitglossary, and google),
but it's not clear to me how you arrived here.

When I tried to reproduce your issue with this script, it did not
remove any files unexpectedly:
------------------->8-----------------------
#!/bin/sh

set -e
mkdir foo && cd foo && git init
echo foo > foo && git add foo && git commit -mfoo

git checkout -b PersonA master
echo bar > bar && git add bar
git commit -m"PersonA: bar"

git checkout -b PersonB master
echo baz > baz && git add baz
git commit -m"PersonB: baz"

echo foo-conflict >> foo && git add foo
git commit -m"PersonB: foo"

git checkout PersonA
echo foo-different >> foo && git add foo
git commit -m"PersonA: foo (conflicts with PersonB)"

git log --oneline --all --stat

if ! git merge PersonB ; then
  git checkout PersonA foo
  git commit --no-edit
fi
git log --oneline --graph --stat
------------------->8-----------------------

A sneaky issue with merges is that they do not have a clear way to
show patch information -- the diff between the commit and its ancestor
-- because they have multiple ancestors.  You can show diffs for a
merge relative to each of its parents, but it is not usually done for
you automatically.  This is why making changes in a merge which are
not actually required for the merge is bad ("evil").

> Clearly this is possible - was this a user error?

Probably, but we'd need to see how the user got there.
