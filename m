From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/4] t7800: modernize tests
Date: Thu, 21 Mar 2013 08:41:25 +0100
Message-ID: <514AB9A5.3050601@viscovery.net>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com> <1361419428-22410-2-git-send-email-davvid@gmail.com> <1361419428-22410-3-git-send-email-davvid@gmail.com> <514985FB.8080806@viscovery.net> <CAJDDKr4O-OU57j0f7F2E2_4EvtCTE1gFP5uLv+fvD6VcpPiifg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 08:42:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIa8O-0003eN-0S
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 08:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab3CUHlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 03:41:32 -0400
Received: from so.liwest.at ([212.33.55.24]:18544 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753131Ab3CUHlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 03:41:32 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIa7p-0003vw-GE; Thu, 21 Mar 2013 08:41:25 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 362AB1660F;
	Thu, 21 Mar 2013 08:41:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CAJDDKr4O-OU57j0f7F2E2_4EvtCTE1gFP5uLv+fvD6VcpPiifg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218702>

Am 3/20/2013 23:59, schrieb David Aguilar:
> I started digging in and the @worktree_files (aka @worktree above)
> is populated from the output of "git diff --raw ...".
> 
> Seeing the "output" filename in "diff --raw" implies that one of the
> tests added "output" to the index somehow.  I do not see that
> happening anywhere, though, so I do not know how it would end up in
> the @worktree array if it is not reported by "diff --raw".
> 
> 
> My current understanding of how it could possibly be open twice:
> 
> 1. via the >output redirect
> 2. via the copy() perl code which is fed by @worktree
> 
> So I'm confused.  Why would we get different results on Windows?

I tracked down the difference between Windows and Linux, and it is...

	for my $file (@worktree) {
		next if $symlinks && -l "$b/$file";

... this line in sub dir_diff. On Linux, we take the short-cut, but on
Windows we proceed through the rest of the loop, which ultimately finds a
difference here:

		my $diff = compare("$b/$file", "$workdir/$file");

and attempts to copy a file here:

			copy("$b/$file", "$workdir/$file") or

where one of the files is the locked "output" file.

I don't know how essential symlinks are for the operation of git-difftool
and whether something can be done about it. The immediate fix is
apparently to protect the tests with SYMLINKS.

-- Hannes
