From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Sun, 30 Oct 2011 12:55:22 +0700
Message-ID: <CACsJy8DdQXXoYT2gB2L5z6pdCNU_vL2w7c8eJvKRGX2T9iAC3Q@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com> <7vd3dk516p.fsf@alter.siamese.dyndns.org>
 <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com>
 <7vr51z3bqx.fsf@alter.siamese.dyndns.org> <CACsJy8C2nUJkN5=E7p2u_wjHqWy7EC_BS3Sr4+_QgunWHDdtKg@mail.gmail.com>
 <7vobx2z60w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 06:57:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKOOy-0000ZB-FU
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 06:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab1J3Fzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 01:55:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54977 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab1J3Fzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 01:55:54 -0400
Received: by faan17 with SMTP id n17so4679518faa.19
        for <git@vger.kernel.org>; Sat, 29 Oct 2011 22:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JOQbQNn5zNjfvmkcMfPtxWsndiHMhqbYTjHOyeHLkq4=;
        b=b9qa7JbmW4dk+3vO7wr0sfAqHvwRAR+++J1Zazvbg/ORUJbk/RXlXKyYgTt/ZlSEaF
         lmEEq9YvdFXVlfWPA4SLi6vbbz64ih/636y9R7gxAZUGobzB1R/pKiY57uCnI2oam66s
         ZrTRSvcfkkvkaLoBpwGdvDwrF78WNxuvn+TJw=
Received: by 10.223.1.137 with SMTP id 9mr19108639faf.19.1319954153094; Sat,
 29 Oct 2011 22:55:53 -0700 (PDT)
Received: by 10.223.144.138 with HTTP; Sat, 29 Oct 2011 22:55:22 -0700 (PDT)
In-Reply-To: <7vobx2z60w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184461>

On Fri, Oct 28, 2011 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> ... Should we stick with one way only?
>
> Whatever we have been doing should not change, especially in corner cases.

I disagree. If it's not right, then we should change it even though it
may face unpleasant consequences from misusing it. And I don't think
it's sane to behave like what we're doing now:

$ GIT_DIR=clone2/.git git ls-files --stage
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       1

$ ls -l clone2/2 3
-rw-r--r-- 1 pclouds users 0 Th10 30 12:40 3
-rw-r--r-- 1 pclouds users 0 Th10 30 12:40 clone2/2

$ GIT_DIR=clone2/.git git add clone2/2 3

$ GIT_DIR=clone2/.git git ls-files --stage
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       1
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       3

$ GIT_DIR=clone2/.git git add clone2/2

$ GIT_DIR=clone2/.git git ls-files --stage
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       1
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       3
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       clone2/2

"git add" behaves inconsistently when "clone2/2" and "3" are given and
when clone2/2 is given alone. This is just bad to me.

Note that this has nothing to do with read_directory() discussion we
had in the notes-merge patch, I agree we should keep the prefix. This
is about the calculating common prefix automatically from pathspec.
But prefix and pathspec are treated differently by read_directory().
In "git add clone2/2 3", common prefix is "" while in "git add
clone2/2" common prefix is "clone2".
-- 
Duy
