From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: show usage of branch description
Date: Mon, 14 Sep 2015 10:00:15 -0700
Message-ID: <xmqqh9mxx7fk.fsf@gitster.mtv.corp.google.com>
References: <74514591d4cd502eee06cde3e099e656@dscho.org>
	<1442098288-3316-1-git-send-email-philipoakley@iee.org>
	<CA+P7+xqh0e+2aMZf8i-1hBc0fMgaz0UjVdboLv+L9+rBYBR85w@mail.gmail.com>
	<DDA818BA5B3749C8953193DEC3682293@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jacob Keller" <jacob.keller@gmail.com>,
	"GitList" <git@vger.kernel.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:00:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbX7B-0004by-SS
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbbINRAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:00:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36682 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbbINRAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:00:18 -0400
Received: by padhk3 with SMTP id hk3so148790450pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XE68pI0ZF3ATjFCtbK2iyGvOCxVsfSM2AEOKlfP4/g8=;
        b=A4JPX8r93uYl2x1P9xvSxuQk8zKJ08Ln0ZRcw3me3AaTG+Zrb32qqJcJIRND8wb6ZV
         4uEWCwx8UDJqCLE1neR/jR0hBkJ1wLGG6nFMN1b606GKr6TLlXv1IzDUwWaRV3v2Uuxe
         frIp35uEl10pVgmlVjpuMjHIdoqFLUCLOZ+OWIP95l9WV1VN7UpIix6I0fY6E+dZvs7A
         o4MwNLfOJmSnUdUmiZcd+jAMP4AYL5td1pd08timUkN8YFWVHquAxrIJkWTA2TB1UExe
         IHOrlKdTlg7rz/rpwHs0w9wklD8Em4sG06hibLmGBzudvi5AlUxqr/oVpJ34G1trSmhI
         qkrA==
X-Received: by 10.66.193.162 with SMTP id hp2mr36598009pac.108.1442250017282;
        Mon, 14 Sep 2015 10:00:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id yp9sm12361460pab.1.2015.09.14.10.00.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 10:00:16 -0700 (PDT)
In-Reply-To: <DDA818BA5B3749C8953193DEC3682293@PhilipOakley> (Philip Oakley's
	message of "Mon, 14 Sep 2015 13:01:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277839>

"Philip Oakley" <philipoakley@iee.org> writes:

> It still means that my patch is incomplete in its aim to bring out
> these possible broader usages.
>
> I haven't yet looked at the mail archives to see if there is more
> around the time of those introductions.

I guess this is largely my fault, but I think "git grep" is an
easier source of truth to work with than the list archive.

It eventually boils down to branch.*.description configuration and
all users of that would call read_branch_desc(), so if you check
callers of that helper function and see which commit introduced that
call for what purpose ("blame" is your friend), you would know how
they use the information under what condition.


$ git grep -n read_branch_desc -- \*.c
branch.c:143:int read_branch_desc(struct strbuf *buf, const char *branch_name)
builtin/branch.c:771:   read_branch_desc(&buf, branch_name);
builtin/fmt-merge-msg.c:211:    if (!read_branch_desc(&desc, name)) {
builtin/log.c:888:      read_branch_desc(&desc, branch_name);

$ git blame -L210,212 -s builtin/fmt-merge-msg.c
898eacd8 210) 
898eacd8 211)   if (!read_branch_desc(&desc, name)) {
898eacd8 212)           const char *bp = desc.buf;

$ git show -s 898eacd8
commit 898eacd8ada2d012f977948350ed60845e238037
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Oct 6 23:12:09 2011 -0700

    fmt-merge-msg: use branch.$name.description
    
    This teaches "merge --log" and fmt-merge-msg to use branch description
    information when merging a local topic branch into the mainline. The
    description goes between the branch name label and the list of commit
    titles.
    
    The refactoring to share the common configuration parsing between
    merge and fmt-merge-msg needs to be made into a separate patch.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

etc. etc.
