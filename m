From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Thu, 23 Jul 2015 10:06:28 -0700
Message-ID: <xmqq615aregb.fsf@gitster.dls.corp.google.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	<xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
	<xmqqegjyrfrq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:06:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIJx9-0006vk-1p
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbbGWRGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:06:36 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34581 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbbGWRGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:06:32 -0400
Received: by pdbbh15 with SMTP id bh15so114428149pdb.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n7jqaSA6gYrkIbWRINBZXG3mRtuOjadcGmWk7nOtJpc=;
        b=ArMGuZ/81vIBjED8DFgb6YuG6Qstx7+7tKRmSk3xgW/atbSk+zA2h3tesfZtb81mTt
         22EQl5uQS7Y629n8o/eq0q/i4eh8bpxwGvvUkemCmDXpIWMc6snQ9ZGVtAQ18JLxfh0c
         CncA+1tT8fVeOqex4RNLc6B6dwBDiYlbwNcfwSHiiPBp+a4Yx1DjH9J/JeVNAgb0HFRL
         /QD0XdX8mU+p8SUFsB3QEqJCcrKLzQ+wQcYlT6xgai32xSpHQq8KtlSaoDL9pkuidMW3
         mLAXH1HQ4Uu6+oPtGRNUlGwOZwZaKzhdUtyByenY3EaUtS3pdkrHqPjJmRQ8OymB3hv0
         KLzw==
X-Received: by 10.70.43.72 with SMTP id u8mr20396364pdl.33.1437671190983;
        Thu, 23 Jul 2015 10:06:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id dd3sm10031114pad.45.2015.07.23.10.06.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 10:06:30 -0700 (PDT)
In-Reply-To: <xmqqegjyrfrq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 23 Jul 2015 09:38:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274506>

Junio C Hamano <gitster@pobox.com> writes:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> Well, from a user's perspective it does not matter which part of the
>> internal implementation of diff-tree is responsible for printing that
>> single line,...
>
> That is not "internal implementation", but "logically separate
> parts".  View it more like "'git show -s' does squelch the diff part
> but does not squelch the log output".  After all, a single commit form
> of 'diff-tree' is a degenerate use case of feeding a single commit
> to 'diff-tree --stdin' from its standard input, which is a rough
> plumbing-level equivalent of 'show'.
>
> Documenting the behaviour correctly is the best thing you could do
> at this point, as this is one of the oldest part of the system that
> existing scripts would rely on.

Having said that.

Existing scripts by definition would not be using a new option you
will invent that used not to be a valid one.  So that would be one
way that you can shorten your script without breaking other people.

If we were living in an ideal world equipped with a time machine, I
would redesign "git diff-tree $commit" so that it does not show the
commit object name in its output at all, with or without "--quiet".

In "git rev-list ... | git diff-tree --stdin" output, the commit
object name is absolutely necessary, with or without --quiet, as it
serves as the sign that the output switched to talk about a
different commit.  But the case that feeds a single commit to the
command, used as a poor-man's "git show $commit", does not need
one---the caller knows exactly which commit the output is about.  It
is an unfortunate historical accident that a single commit usage is
defined to be a degenerate case of feeding a sequence of commits to
the command and the length of the sequence happens to be one.

But we do not live in an ideal world.
