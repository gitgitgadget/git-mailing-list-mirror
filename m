From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Fri, 07 Jul 2006 18:33:13 +0200
Message-ID: <87k66p8jee.fsf@mid.deneb.enyo.de>
References: <20060706055729.GA12512@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 07 19:36:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyuFV-0005ax-JM
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 19:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWGGRgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 13:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWGGRgO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 13:36:14 -0400
Received: from mail.enyo.de ([212.9.189.167]:58267 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932224AbWGGRgN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 13:36:13 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1FyuFQ-0003qF-6u
	for git@vger.kernel.org; Fri, 07 Jul 2006 19:36:12 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.62)
	(envelope-from <fw@deneb.enyo.de>)
	id 1FytGT-0003rF-3p
	for git@vger.kernel.org; Fri, 07 Jul 2006 18:33:13 +0200
To: git@vger.kernel.org
In-Reply-To: <20060706055729.GA12512@admingilde.org> (Martin Waitz's message
	of "Thu, 6 Jul 2006 07:57:29 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23450>

* Martin Waitz:

> I created a git repository for my photo collection and then renamed
> some photos (about 600).  Now git status and commit get hit by
> the OOM killer.
>
> The reason for that is that is_exact_match (in diffcore-rename.c) maps
> both the source and destination file into memory and then compares them
> byte for byte.  This is a little bit too much for my little machine.

Uhm, this shouldn't trigger the OOM killer, really.  You already have
physical backing storage for both files, so this shouldn't count
towards the OOM limit.  Ah, diff_populate_filespec has the following:

   s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);

Perhaps the following patch is in order?  On some systems, MAP_PRIVATE
might guarantee some form of repeatable reads, but I don't think GIT
needs this to guard against concurrent modification.

-- >8 --
diff_populate_filespec: use shared mapping

It seems that on some systems, PROT_READ + MAP_PRIVATE counts towards
the OOM limit, even though no additional backing store is required.
Requesting MAP_SHARED mapping should fix this.

Signed-off-by: Florian Weimer <fw@deneb.enyo.de>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 428ff78..2b4367e 100644
--- a/diff.c
+++ b/diff.c
@@ -1007,7 +1007,7 @@ int diff_populate_filespec(struct diff_f
                fd = open(s->path, O_RDONLY);
                if (fd < 0)
                        goto err_empty;
-               s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+               s->data = mmap(NULL, s->size, PROT_READ, MAP_SHARED, fd, 0);
                close(fd);
                if (s->data == MAP_FAILED)
                        goto err_empty;
--
1.4.0
