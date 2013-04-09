From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Tue, 9 Apr 2013 14:49:24 +0530
Message-ID: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
 <1365416809-4396-1-git-send-email-artagnon@gmail.com> <20130408213006.GD9649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 11:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPUit-00030g-8a
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 11:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175Ab3DIJUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 05:20:07 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49794 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935294Ab3DIJUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 05:20:05 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so8198714iec.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=t0fHphH22t9jYOknLcoWKwyGN+MAGmMmomTsIot4Pyo=;
        b=mDThfYcJDDi8k5Qy22GUT8yCm0HePwxK7CpO+4ssSP2s4YpizHquET6DZh4flVZJY7
         fAZ5UWG+gU5boYF84Lr/lrxG36ci6F0h2bTPciCRxlxl29Oyq1r4qUSqoG8eNMBQyz0M
         kehy3oAJcfaBhoU/2lmbkuS4NTW/u7b3HdvSINFev2F6rkHMFF3u69mEDmcYwtsg8C4+
         iOpdBM12JllXWp2VrxkInn7/9V6LCX49rNhavIo5USGdxAqKauoG4SCNcOvDTanc8Z19
         GRbgvMnHFCujcQ5lnNY39RqKTeo4ChfxhER/8IKFBgC5Nm34ALnwDXnQMp1ilK11lc8x
         5ngw==
X-Received: by 10.50.117.3 with SMTP id ka3mr9151093igb.107.1365499204580;
 Tue, 09 Apr 2013 02:20:04 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 9 Apr 2013 02:19:24 -0700 (PDT)
In-Reply-To: <20130408213006.GD9649@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220555>

Jeff King wrote:
> That is not actually a submodule, but rather just a repo that happens to
> be inside our working tree. I know the distinction is subtle, but
> according to the thread I linked to above, we may actually treat paths
> with gitlinked index entries separately already (I did not try it,
> though).

Agreed.  treat_gitlink() dies if there is a gitlink cache_entry
matching any of the pathspecs; it does one thing well, and promises
what it does: however, its core logic in check_path_for_gitlink() can
easily be moved into lstat_cache_matchlen() as that is more generic
(checks index and worktree).  die_if_path_beyond_symlink() is the
perfect example to replicate.  Today, there is one more caller of
die_if_path_beyond_symlink(): check-ignore, so we must patch that too.

On a slightly related note treat_path() also contains the logic for
checking for a git repository in the worktree.  Unfortunately, the
code cannot be reused because it checks for a '.git' in a dirent.

On the wording issue, a submodule is a submodule whether in-index or
otherwise.  I would write two different tests: one for in-worktree
submodule and another for in-index submodule, and name them
appropriately.  Does that make sense?
