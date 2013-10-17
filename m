From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [git-users] Problem using detached worktrees with commands
 implemented in scripts
Date: Thu, 17 Oct 2013 15:48:35 -0700
Message-ID: <20131017224834.GW9464@google.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
 <xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
 <29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley>
 <xmqqk3hc3jbw.fsf@gitster.dls.corp.google.com>
 <3401D1F36F134CDDB0881B196F79CB3A@PhilipOakley>
 <xmqqr4bjy63y.fsf@gitster.dls.corp.google.com>
 <5A09FF55D37146E7A02DF2F640A46406@PhilipOakley>
 <1390B0AFBE7F4C4A875987C7469B0791@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Dale R. Worley" <worley@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Oct 18 00:48:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWwNE-0007Gu-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 00:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890Ab3JQWsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 18:48:39 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60419 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab3JQWsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 18:48:38 -0400
Received: by mail-pa0-f42.google.com with SMTP id kx10so3565872pab.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=v9eUnfedkch0JUejRRVM/D6e/DSq88fB76z32bikqzw=;
        b=Z/W+ONbVHdCfrLGW9QT3vHxTFegUQYwFV3wda/szhvPGiZcDQU2884mupCtbl7Y36e
         zGeFa+Yt1tRqPDOZZnkWJ4/t6XUJSkSziw7jYsKZS55A9bv0g46c/5q6Ounmilf2RXaa
         e8dcuD3bXxssKAK7INOjZihPX7JSyLEf568fdKXrvJE1KhO9ivP0hxR1bpTBApePrUCo
         o+24mpQuf6NFU8Mo+9sKbVEehE24Vap8UXfWsWvDOzBKtmsDznMfL7N/YXPr4AqVfUQ1
         NjVGI/h+ZX6LMNglNzYh7wituFsxWizGy3vcWPqTH7h9VRUW9GDcvgl3sOd8pPLJNdT7
         /usw==
X-Received: by 10.66.121.68 with SMTP id li4mr284065pab.33.1382050118268;
        Thu, 17 Oct 2013 15:48:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bt1sm100231911pbb.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 15:48:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1390B0AFBE7F4C4A875987C7469B0791@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236332>

Philip Oakley wrote:

> A bit more looking gave that the cd_to_toplevel () in git-sh-setup.sh
> directly uses `git rev-parse --show-toplevel`, which simply returns
> work_tree (static char *work_tree; in environment.c, with comment /*
> This is set by setup_git_dir_gently() and/or git_default_config()
> */), apparently without a check for the GIT_WORK_TREE.

Getting closer. :)

The usual way to use GIT_WORK_TREE is along with GIT_DIR.  That takes
you into the setup_explicit_git_dir() codepath, which does respect
GIT_WORK_TREE as it should.  (setup_discovered_git_dir does, too.)

The strange behavior you ran into is that unlike, say, git-pull.sh and
git-am.sh, filter-branch does not set SUBDIRECTORY_OK, store the
prefix from 'git rev-parse --show-prefix', and then cd_to_toplevel at
the top of the script.  In other words, nobody bothered to make it
work from anywhere other than the toplevel of the worktree to begin
with, and nobody wanted it enough to fix it later.

Hope that helps,
Jonathan
