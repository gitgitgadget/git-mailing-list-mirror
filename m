From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Store refreshed stat info in a separate file?
Date: Fri, 25 Apr 2014 12:18:08 +0700
Message-ID: <CACsJy8AV0yQNWnxu+J09UNEEsd6nSad90ZcOzB4GbfZtpYzZaA@mail.gmail.com>
References: <CACsJy8CzZ7H4pffNccBBpvpn5oT5tud-Tx=Nu1c=q2SB7Zi8eg@mail.gmail.com>
 <xmqq4n1qcz3d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 07:18:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdYX8-0006UV-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 07:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbaDYFSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 01:18:40 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:48484 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaDYFSj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 01:18:39 -0400
Received: by mail-qg0-f54.google.com with SMTP id q107so2919011qgd.27
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vzPHpG8cFyxLvSBuD8d2QISuhyOU+aL/2/roBG3VIEc=;
        b=Zysi3fp5Z/OMBkHUHCVaSIaylLEWjc14Pf3i7lNOuNfSId5jNGrh8ul/04hWvXqPxJ
         VOEK5V34gQyxBk4jlZy6xl70SQiiWjx9fDTNIZcV3DRP335pBxF13lE6YzLnQg+lX53I
         xEonGEUf6b3Ph//4/SdSqQ3MrQ7DLy2yoLIADR/qglCiTbMdtUx1Cr4XJ0n88v1PhR8M
         oGKmsQWxeEt2kbyuO73lSOINyFNv8tmm3OyOmdMuoDZ4cF9iNz6bOGVXn+dV1Qpedbd1
         0DByre9uQLUsvVs8A0sJULzrhjMmGbahC09UZooBL04fZpiyMTuWD70CnbR2nsZmlU97
         N4pw==
X-Received: by 10.140.107.229 with SMTP id h92mr8163073qgf.30.1398403118761;
 Thu, 24 Apr 2014 22:18:38 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Thu, 24 Apr 2014 22:18:08 -0700 (PDT)
In-Reply-To: <xmqq4n1qcz3d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247031>

On Sat, Apr 19, 2014 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Having said that, I do not think there is a fundamental reason why
> the stat data has to live inside the same index file.  A separate
> file is just fine, as long as you can reliably detect that they went
> out of sync for whatever reason (e.g. "the index proper updated, a
> stale stat file left beind"), and storing the trailer checksum from
> the corresponding index in this new file is an obvious and good
> solution.

I've gone further and store index updates (including entry removals
and additions) to the second index file so that index I/O cost is now
proportional to the number of changed entries, not the work tree size
(sort of). Which makes it scale much better when the work tree is
huge. There is one flaw though. I'm expecting many "yuck" responses
from people. So let's try to settle it now, or drop the idea.

The idea is we can support another mode, where index content is stored
in two files, the small $GIT_DIR/index and large $GIT_DIR/index.base.
"index" contains changes that should be applied to "index.base".
Whenever you do something to the index, "index" records those actions.
Git reads both index.base and index, then replay the action to have
the final index in memory. "index.base" contains full worktree data
and remains unchanged until "index" becomes too big/slow that changes
should be merged back to "index.base". This works great (my prototype
passed the test suite), and even greater than index v5 because v5
still rewrites the whole index file when an entry is added or removed.

But there is a problem with atomic update. The good old rename() does
not work well with 2 files. This is not a problem with the C part, I
can still make atomic update work. Scripts, on the other hand, may
rely on "mv" or similar commands/functions to prepare a temp index and
move it to $GIT_DIR/index. The workaround is merge back two files into
a single index file so that scripts can "mv $temp_index" as before and
pay the whole-index I/O penalty. An alternative is store two files in
one, the one index file actually consists two subfiles. We avoid the
atomic update problem, but we pay I/O cost for writing 10MB every time
an index is updated (but not hashing 10MB file) and introduce a new
index format. This is even yuckier in my opinion.

Should I continue, or drop it?
-- 
Duy
