From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working
 directory
Date: Tue, 02 Sep 2014 10:51:47 -0400
Message-ID: <5405D983.3050707@xiplink.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley> <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com> <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com> <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley> <CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 16:51:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOpQg-0002l1-9u
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 16:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbaIBOv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 10:51:26 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:54106 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaIBOvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 10:51:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 9DB75380142;
	Tue,  2 Sep 2014 10:51:24 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 3B6EE38010C;
	Tue,  2 Sep 2014 10:51:24 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Tue, 02 Sep 2014 14:51:24 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256323>

On 14-09-02 08:27 AM, Duy Nguyen wrote:
> After reading this "multiple checkout mode" in git-checkout.txt, I'm
> tempted to rewrite it like this. I think the example makes it clearer
> what I mean. If nobody has any comments, I'm going to send v2 with
> this (and other comments collected so far)

Overall I think focusing on the word "checkout" for this feature makes the
documentation confusing.  It's also not a "mode" but just another git
feature.  Since this is all about multiple working directories (the phrase is
actually "working tree" in the existing docs) we should just stick to that
rather than introduce new terminology.

Finally, a bit of bikeshedding, but I think "$GIT_DIR/repos" is also an
unfortunate choice and that "$GIT_DIR/worktrees" would be better.

So I suggest the following for the new section:


MULTIPLE WORKING TREES
----------------------

A git repository can support multiple working trees, allowing you to check
out more than one branch at a time.  With `git checkout --to` a new working
tree is associated with the repository.  This new working tree is called a
"linked working tree" as opposed to the "main working tree" prepared by "git
init" or "git clone".  A repository has one main working tree (if it's not a
bare repository) and zero or more linked working trees.

Each linked working tree has a private sub-directory in the repository's
$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
the base name of the linked working tree's path, possibly appended with a
number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
command `git checkout --to /path/other/test-next next` creates the linked
working tree in `/path/other/test-next` and also creates a
`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
if `test-next` is already taken).

Within a linked working tree, $GIT_DIR is set to point to this private
directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
(e.g. `/path/main/.git`). These settings are made in a `.git` file located at
the top directory of the linked working tree.

Path resolution via `git rev-parse --git-path` uses either
$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
linked working tree `git rev-parse --git-path HEAD` returns
`/path/main/.git/worktrees/test-next/HEAD` (not
`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
rev-parse --git-path refs/heads/master` uses
$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
since refs are shared across all working trees.

See linkgit:gitrepository-layout[5] for more information. The rule of
thumb is do not make any assumption about whether a path belongs to
$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.


		M.
