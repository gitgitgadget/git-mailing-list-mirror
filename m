From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Fri, 1 Feb 2013 11:15:28 -0800
Message-ID: <CANiSa6gM1gpj0A6PC0qNVSaWvVrOBnSnjn2uKR9-cHSLAZ2OVA@mail.gmail.com>
References: <1358023561-26773-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, phil.hord@gmail.com,
	Neil Horman <nhorman@tuxdriver.com>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1M5Z-0001GR-1L
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab3BATPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:15:31 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:64577 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab3BATPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:15:30 -0500
Received: by mail-wg0-f50.google.com with SMTP id es5so3209461wgb.29
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 11:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=D9lMmnVTNrfqjPDOi1q7lIz8bmUG7mZe99WbSQxvPlM=;
        b=pgy5dMWfjtAOnXAKGj5YlKOjJWB4YPeJOlO0NPQpR8LsiPUUR88vMQ8F3oxff9RcP3
         OoVVzYxlT6kgBbFSs1Q1e1RmtLSH5SSpDKUhyq10BZ+K/uLXTyjcn3Npw5BVa/KjOZ8V
         tFfnZkUok3m7MZypDY3uiyjfvqE7YFKl02tXt23dyEfBZSN+c2SakWVx8K61lQSf2TkI
         +tiVrBaBIITNB+XQcjmfGjejWB7xC9QcrVsYesVnS/1YQtzYfDpSFJTqBCRjEU+2VnqQ
         //ixlOXLl1g9If/nr+N7h1YGOfDR+52Exp1xv1KVW4Lndl1QPaMLtymnEz7V7rFr0sIO
         2pcw==
X-Received: by 10.180.85.97 with SMTP id g1mr4717174wiz.29.1359746128842; Fri,
 01 Feb 2013 11:15:28 -0800 (PST)
Received: by 10.180.85.8 with HTTP; Fri, 1 Feb 2013 11:15:28 -0800 (PST)
In-Reply-To: <1358023561-26773-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215253>

I'm working on a re-roll of

http://thread.gmane.org/gmane.comp.version-control.git/205796

and finally got around to including test cases for what you fixed in
this patch. I want to make sure I'm testing what you fixed here. See
questions below.

On Sat, Jan 12, 2013 at 12:46 PM, Phil Hord <hordp@cisco.com> wrote:
> Since 90e1818f9a  (git-rebase: add keep_empty flag, 2012-04-20)
> 'git rebase --preserve-merges' fails to preserve empty merge commits
> unless --keep-empty is also specified.  Merge commits should be
> preserved in order to preserve the structure of the rebased graph,
> even if the merge commit does not introduce changes to the parent.
>
> Teach rebase not to drop merge commits only because they are empty.

Consider a history like

# a---b---c
#      \   \
#       d---l
#        \
#         e
#          \
#           C

where 'l' is tree-same with 'd' and 'C' introduces the same change as 'c'.

My test case runs 'git rebase -p e l' and expects the result to look like

# a---b---c
#      \   \
#       d   \
#        \   \
#         e---l

> A special case which is not handled by this change is for a merge commit
> whose parents are now the same commit because all the previous different
> parents have been dropped as a result of this rebase or some previous
> operation.

And for this case, the test case runs 'git rebase -p C l'. Is that
what you meant here?

Before your patch, git would just say "Nothing to do" and after your
patch, we get

# a---b---c
#      \   \
#       d   \
#        \   \
#         e   \
#          \   \
#           C---l

As you say, your patch doesn't try to handle this case, but at least
the new behavior seems better. I think we would ideally want the
recreated 'l' to have only 'C' as parent in this case. Does that make
sense?

Martin
