From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Fri, 5 Sep 2014 20:42:32 +0700
Message-ID: <CACsJy8Ca3r9AXiyGtHx114VGH7k=wdZ_W1yvPc-uu125cRuM7w@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley>
 <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
 <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com>
 <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley> <CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com>
 <5405D983.3050707@xiplink.com> <20140905032633.GB25339@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
To: Scott Schmit <i.grok@comcast.net>
X-From: git-owner@vger.kernel.org Fri Sep 05 15:43:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPtnC-0007Pt-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 15:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbaIENnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 09:43:05 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:55353 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981AbaIENnE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 09:43:04 -0400
Received: by mail-ie0-f182.google.com with SMTP id rd18so14174115iec.13
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yfo5izVH3tNIWU5cIAzrzjr6lQVVFJGYqHpxPaVmlyU=;
        b=MuemHhK7d3l+InSrdeWIbo8DRIo9l0b/vm/yoRAKVNcJ0kAX52FrOx8LBtRkGuizHd
         QSKOhXKZSbONvq3G2S9S2EhI25wSPOi3Gn2cqmhkHSEfw6d337iTIhbQoKQCK3mGYlEo
         /AnkoJ4oxNjgQd6+KExCsUO7O3CEcicYSgZL5w21ZZa4MRp6ii7vDBCVVQTm+y2Ew17m
         yEOeX+ajcJwAr4P0SY69vqPBqOI901sAyYm2h/XuqCWwRxiyPjI0tpxylVoyKLlY12X+
         7OwqUiJzcD0gBCt7mc6/NcekVXoAc1ezzf6eqTce0UhEphL/fVdBpKigbDFUwERZ3mYI
         FDOQ==
X-Received: by 10.42.136.129 with SMTP id u1mr14793091ict.65.1409924582533;
 Fri, 05 Sep 2014 06:43:02 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Fri, 5 Sep 2014 06:42:32 -0700 (PDT)
In-Reply-To: <20140905032633.GB25339@odin.ulthar.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256508>

On Fri, Sep 5, 2014 at 10:26 AM, Scott Schmit <i.grok@comcast.net> wrote:
>> Each linked working tree has a private sub-directory in the repository's
>> $GIT_DIR/worktrees directory.  The private sub-directory's name is usually
>> the base name of the linked working tree's path, possibly appended with a
>> number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
>> command `git checkout --to /path/other/test-next next` creates the linked
>> working tree in `/path/other/test-next` and also creates a
>> `$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
>> if `test-next` is already taken).
>
> As a user, this leaves me with one other question -- what happens when
> I'm done with the test-next working tree and want to delete/rename it?

If you rename it, the link remains and you can still continue to use
test-next with its new name. If you move it, or rename on a filesystem
without hardlink support, then you may need to run something from the
linked worktree for it to fix up the link to main checkout. If you
move it on the same filesystem that supports hardlink, it's all good.

If you delete it, the part in $GIT_DIR/worktrees remains and can be
cleaned up using "git prune --repos" (which I should rename to "git
prune --worktrees" as well). At some point in future, this pruning
should be part of git-gc. See patch 25/32 [1] for detail. I know I
haven't added some user documentation about pruning. You're welcome to
write up something about this ;)

Note to self, you someone moves the _main_ checkout away, then they're
screwed. Should probably make a note about that somewhere in
documents.

> Is that cleaned up automatically, or do I need to register that I'm
> getting rid of/renaming it?  (Another use case is if I put the working
> tree on removable media for some reason.)

Removable media is covered in [1] as well. Though you'll need to
"lock" the worktree in order to stop it from being pruned. In earlier
iterations, this locking could be done automatically at "git checkout
--to" time, if it detects that the new worktree is on a different
filesystem than the main one. But that got dropped. We can add it back
when this feature matures a bit.

[1] http://article.gmane.org/gmane.comp.version-control.git/256236
-- 
Duy
