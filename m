From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Thu, 6 Oct 2011 09:44:45 -0400
Message-ID: <CAG+J_DyJri1iTMWbeab9Dm15=p2wDUw_vt7TXEYSyGXAK6zWkg@mail.gmail.com>
References: <4E8C6F2F.1070306@6wind.com>
	<CAG+J_DynqAK8uXDPtHwWpGhfA5qFZifucs91qL79Pu_DmCxG3g@mail.gmail.com>
	<4E8D5AD0.2040509@6wind.com>
	<CAG+J_DzY6oW3CgCPDhD81Eue1Ygh+3pR7Q_NZEhauH_qkyUwqQ@mail.gmail.com>
	<4E8DABB0.4090206@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: nicolas.dichtel@6wind.com
X-From: git-owner@vger.kernel.org Thu Oct 06 15:44:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBoFo-0000mC-I1
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407Ab1JFNoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 09:44:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38941 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758293Ab1JFNoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 09:44:46 -0400
Received: by gyg10 with SMTP id 10so2571813gyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G9+CXI8kAHoodaLvwBrZFPpYrsJ5EKfNMnpDgpjf74Y=;
        b=nRGuiwEx00OzdLoG+n1TYgYtsXLI4rmtQrOaLPJ07OnjZMD3Aazu4T0TnP06s3gPY9
         be3nm5eCx1ULyOl/8bYwJlKAd7ykhrFCiaupY43WNWMknRSYNOHVCcG8qtOI1jJHGzW6
         onN5G6InD5ppDAaSLVnqDIUHwVNNyru4xHyHY=
Received: by 10.236.190.200 with SMTP id e48mr3239004yhn.59.1317908685455;
 Thu, 06 Oct 2011 06:44:45 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 6 Oct 2011 06:44:45 -0700 (PDT)
In-Reply-To: <4E8DABB0.4090206@6wind.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182951>

On Thu, Oct 6, 2011 at 9:22 AM, Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> Here is the output:
> # GIT_TRACE=1 git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
> trace: built-in: git 'cherry-pick'
> '3f78d1f210ff89af77f042ab7f4a8fee39feb1c9'
> trace: run_command: 'commit' '-n' '-F' '.git/MERGE_MSG'
> trace: exec: 'git' 'commit' '-n' '-F' '.git/MERGE_MSG'
> setup: git_dir: .git
> setup: worktree: /home/dichtel/DEV/linux-2.6
> setup: cwd: /home/dichtel/DEV/linux-2.6
> setup: prefix: (null)
> trace: built-in: git 'commit' '-n' '-F' '.git/MERGE_MSG'

I have a theory that determine_whence() inside commit.c isn't finding
.git/CHERRY_PICK_HEAD:

	else if (file_exists(git_path("CHERRY_PICK_HEAD")))
		whence = FROM_CHERRY_PICK;

That would cause the mis-attributed cherry-picked commit. commit.c is
also responsible for removing CHERRY_PICK_HEAD, which is not happening
correctly:

	unlink(git_path("CHERRY_PICK_HEAD"));

Maybe git_path("CHERRY_PICK_HEAD") is returning something unexpected.
But the trace output looks fine.

Aside, I'm a little confused by the "setup:" output appearing above.
In 1.7.5 and later, it requires setting GIT_TRACE_SETUP=1 to appear,
but you reported you're having this problem with 1.7.6.4.

j.
