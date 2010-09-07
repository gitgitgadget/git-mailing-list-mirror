From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/7] Re: [PATCH] Several tests: cd inside subshell instead
 of around
Date: Mon, 6 Sep 2010 20:41:35 -0500
Message-ID: <20100907014135.GA1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:43:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnDs-0004lK-IR
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab0IGBnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 21:43:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61138 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab0IGBni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:43:38 -0400
Received: by ywh1 with SMTP id 1so1774774ywh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WwNQ4tINKSfSexavZPZ9M7vQtTaOguJEEU/qAaTesFI=;
        b=Cm4z3kh2um+VCo8jJwKd7tRE9ey9uDrXQa/8pXxREYyANiMta0lx2ZVQLMN3471C0J
         +H9yJjuwa+v3Soz2zIkxg6fgz1b20d0kT29Hnxs9jQXDuXYYvDY1ceSF0lvAw9z/4woD
         OofmFBUgdjCoL8a/zWl1TXMh1o6koUBI1xoag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l1bxhRY+bf6/shXvsokjBxTE1BaNXvA+Y+kkscM/z+xSnOgjk63Mmv779HJtMZloyK
         4bnSTnzSk6ctdY9aQkkR2mVtz/3wT60CoKw2J6q9McRgeY1q81WL1g7uaUs5zccJ983U
         1r1gkMtmSKmakFJXqS8EbzxqswgwQKgg6n/4w=
Received: by 10.100.134.15 with SMTP id h15mr493521and.31.1283823817435;
        Mon, 06 Sep 2010 18:43:37 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id k11sm10316762ani.30.2010.09.06.18.43.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:43:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C854B36.6010606@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155657>

Jens Lehmann wrote:

> I think that makes a lot of sense. I think you would not only end up
> changing the indentation of many subshells (not only those that I
> added), you will also have to deal with tests using spaces instead of
> tabs for indentation. But these issues have to be addressed anyway ...

Hmm, it seems there are quite a lot of strange uses of subshells in
tests.  I have only started the task you describe.  But here are
a couple of patches of that kind.

Patch 1 re-indents the subshells you introduced.  I have not checked
that those subshells are all semantically neutral (and in fact some
seem not to be, but I think for the better); in fact, the main goal of
that patch is to help other people review yours.

Patch 2 teaches the fsck tests to use test_when_finished.  This
causes some pointless subshells to be removed, and more importantly,
it fixes the cleanup to actually work, so there are no dangling
objects by the end.

Patch 3 adds a missing && in t2105 (.git file pointing to .git dir).  
The style cleanup for that file has been done locally but I do not
think it's worth sending yet.

Patch 4 teaches the "unwritable file" error handling tests to use
test_when_finished.  This causes some pointless subshells to be
removed, and more importantly, it simplifies the script a lot.

Patch 5 is a style cleanup for the core.repositoryversion tests
(mostly to do with formatting of subshells, but there are other
things).

Patch 6: likewise, for the git config tests.

Patch 7 is perhaps iffy.  I find it easier to read

	printf "%s\n" some long list of lines

than

	(echo some; echo long; echo list; echo of; echo lines)

but others might disagree; anyway, this patch change the latter
to the former (and adds a missing && while at it).

I hope such mundane patches are not too painful to read.

Jonathan Nieder (7):
  tests: subshell indentation stylefix
  t1450 (fsck): remove dangling objects
  t2105 (gitlink): add missing &&
  t0004 (core): simplify error handling
  t1302 (core.repositoryversion): style tweaks
  t1303 (config): style tweaks
  t2016 (checkout -p): use printf for multiline y/n input

 t/t0004-unwritable.sh                         |   52 +++-------
 t/t1020-subdirectory.sh                       |   13 ++-
 t/t1302-repo-version.sh                       |   75 +++++++++-----
 t/t1303-wacky-config.sh                       |   28 +++--
 t/t1450-fsck.sh                               |  138 ++++++++++++++----------
 t/t2016-checkout-patch.sh                     |   43 +++++---
 t/t2105-update-index-gitfile.sh               |    2 +-
 t/t3060-ls-files-with-tree.sh                 |   12 +-
 t/t3409-rebase-preserve-merges.sh             |   13 ++-
 t/t3903-stash.sh                              |    5 +-
 t/t4041-diff-submodule-option.sh              |    7 +-
 t/t5510-fetch.sh                              |   35 ++++---
 t/t6050-replace.sh                            |   46 +++++----
 t/t7400-submodule-basic.sh                    |   11 +-
 t/t7401-submodule-summary.sh                  |    7 +-
 t/t9100-git-svn-basic.sh                      |   21 ++--
 t/t9101-git-svn-props.sh                      |   33 ++++---
 t/t9102-git-svn-deep-rmdir.sh                 |   13 ++-
 t/t9104-git-svn-follow-parent.sh              |   56 ++++++-----
 t/t9105-git-svn-commit-diff.sh                |    7 +-
 t/t9106-git-svn-commit-diff-clobber.sh        |   30 +++---
 t/t9107-git-svn-migrate.sh                    |   16 ++--
 t/t9114-git-svn-dcommit-merge.sh              |    7 +-
 t/t9115-git-svn-dcommit-funky-renames.sh      |    7 +-
 t/t9116-git-svn-log.sh                        |   16 ++--
 t/t9119-git-svn-info.sh                       |   69 ++++++++-----
 t/t9120-git-svn-clone-with-percent-escapes.sh |    3 +-
 27 files changed, 433 insertions(+), 332 deletions(-)

-- 
1.7.2.3
