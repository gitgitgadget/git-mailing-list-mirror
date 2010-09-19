From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 0/2] fix problems with recursive submodule fetching
Date: Sat, 18 Sep 2010 20:54:39 -0700
Message-ID: <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 19 05:55:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxAzW-0005nM-Ln
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 05:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab0ISDyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 23:54:43 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:62542 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab0ISDym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 23:54:42 -0400
Received: by pxi10 with SMTP id 10so894843pxi.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 20:54:42 -0700 (PDT)
Received: by 10.142.136.9 with SMTP id j9mr6106651wfd.43.1284868482422;
        Sat, 18 Sep 2010 20:54:42 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id 9sm7253152wfd.12.2010.09.18.20.54.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Sep 2010 20:54:41 -0700 (PDT)
In-Reply-To: <4C953DE5.6020900@web.de>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156484>

On Sep 18, 2010, at 3:32 PM, Jens Lehmann wrote:

>> And of course the performance issue is still relevant.
> 
> Hmm, I think it still the right thing to do to a full fetch of all
> submodule changes, as you can't possibly know at fetch time what you'll
> need later. But I have to admit that "git submodule update" does some
> kind of optimization, as it only fetches submodules where the commit
> recorded in the superproject has changed. But IMO this aims a bit too
> short, as it still can lead to commits missing in submodules (which are
> on branches you didn't check out and ran "git submodule update" on).
> 
> The aim of these changes is to make you able to do a fetch before you go
> onto a plane and then check out every branch of the superproject without
> having a commit missing from a submodule. And even more, you should be
> able to use all new submodule commits not yet committed inside the
> superproject without being able to forget to fetch them before you leave.
> 
> But maybe we can reduce this performance impact by running the submodule
> fetches in threads. Dunno yet, I'll look into that as soon as I have the
> other two patches ready.

In a situation like mine, with 17 nested submodules, you're still going to significantly increase the time for a fetch. I understand the desire to be able to run something like `git fetch` and have everything be there, but I don't agree it should be the default behavior. Perhaps it should be a flag, like `git fetch --update-submodules` (or `git fetch --recursive`). That's friendly enough to let people know about (much friendlier than `git submodule update --recursive`), but wouldn't cause any changes to the common case. And a config variable to control whether recursive is the default would not be amiss (though I would make that config variable default to false).

I should also note that fetching all submodules may be not desired in the slightest. If I use submodules to pull in specific tagged builds of another project, I really have no desire at all to regularly update the branches in that repository. Similarly, if I pull in another project that's out of my control, I have no desire to update any submodules it may have unless the project itself changes. That's certainly the case in my project. Here's the submodule layout:


 .--Root-.
/ / /|\ \ \  
A B C D E F G
    |
    H
   /|\
  I J K
   /|\
  L M N
   /|\
  O P Q

I control the root, and I control most of the first-level of submodules. I would also not mind seeing updates to other submodules at that level, though that doesn't generally concern me. However, I don't control submodule H, and I have absolutely no desire whatsoever to see updates to I-Q unless needed by submodule H. In this layout, regularly running `git submodule update --init --recursive` works perfectly. Having `git fetch` fetch submodules I-Q on every invocation is a complete waste of my time.

-Kevin Ballard