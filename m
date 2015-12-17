From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 10/10] dir: do not use untracked cache ident anymore
Date: Thu, 17 Dec 2015 17:54:34 +0100
Message-ID: <CAP8UFD0Y252vmqxziy4Y8Bp3cw6fS0iOVFzZG+=wGt7K25V8Yg@mail.gmail.com>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
	<1450196907-17805-11-git-send-email-chriscool@tuxfamily.org>
	<xmqqd1u7fq5r.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Thu Dec 17 17:54:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9bpB-0002jN-JI
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 17:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbbLQQyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 11:54:37 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36051 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbbLQQyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 11:54:36 -0500
Received: by mail-lf0-f54.google.com with SMTP id z124so51078017lfa.3
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KvUuOj0A8EQ+2QrDQ3LqteBy7xe6gSJxU9fkwbjCu8U=;
        b=PQSeCCRZzTqCeqRIz58oOBU50xUemB9SM3eQkDRycETAZOlvoRnAbg4pfNb0HOGrin
         kBnhA8p32AJGVJe7UbnfA378rFodcBf9e8bmtR5Qpqc2DsrlsL/1R0ho+wj6QhHfbrGo
         fd4ypBMIv+/hXeYD03IAP46v8JVlB7YSt/IvtmzbIpLn2o1nT1uNXG8FaEmLbTLADI8K
         oydpleCGKy8xO3GowOIFFDQeNX9pKDHCbTbZy+lbehCb7vdxC5wECxaGoitv50wW/8+b
         IeVuFtPlHr0bXkrf+T04GJS49phDrd9iWtaFVxu3YJsPPAKXOSjCetfIrtCDiEh1ohrN
         mdOg==
X-Received: by 10.25.86.9 with SMTP id k9mr22490284lfb.36.1450371274423; Thu,
 17 Dec 2015 08:54:34 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Thu, 17 Dec 2015 08:54:34 -0800 (PST)
In-Reply-To: <xmqqd1u7fq5r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282658>

On Tue, Dec 15, 2015 at 8:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +/*
>> + * We used to save the location of the work tree and the kernel version,
>> + * but it was not a good idea, so we now just save an empty string.
>> + */
>
> I do agree that storing the kernel version (or hostname or whatever
> specific to the machine) was not a good idea.  I however suspect
> that you must save and check the location of the working tree,
> though, for correctness.  If you use one GIT_DIR and GIT_WORK_TREE
> to do "git add" or whatever, and then use the same GIT_DIR but a
> different GIT_WORK_TREE, you should be able to notice that a
> directory D in the old GIT_WORK_TREE whose modification time you
> recorded is different from the directory D with the same name but in
> the new GIT_WORK_TREE, no?

Yeah, if people use many worktrees made using "git worktree", the code
above should be fine because there is one index per worktree, but if
they just use one GIT_DIR with many GIT_WORK_TREE then there will be
only one index used.

I am wondering about the case when the worktree is moved and then
GIT_WORK_TREE is changed to reflect the new path were the worktree has
been moved.

In the "git worktree" documentation there is:

"If you move a linked working tree to another file system, or within a
file system that does not support hard links, you need to run at least
one git command inside the linked working tree (e.g. git status) in
order to update its administrative files in the repository so that
they do not get automatically pruned."

It looks like git can detect when a worktree created with "git
worktree" has been moved and I wonder if it would be possible to
detect if the main worktree pointed to by GIT_WORK_TREE as moved.
