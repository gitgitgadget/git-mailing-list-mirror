From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [PATCH] repack: allow simultaneous packing and pruning
Date: Wed, 11 Oct 2006 01:45:22 +0200
Message-ID: <452C3092.7090003@tromer.org>
References: <20061010102210.568341380D6@magnus.utsl.gen.nz> <Pine.LNX.4.64.0610100800490.3952@g5.osdl.org> <452BF8B3.5090305@tromer.org> <Pine.LNX.4.64.0610101423561.3952@g5.osdl.org> <452C19FC.7030001@tromer.org> <Pine.LNX.4.64.0610101524050.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 01:52:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXRON-0007DU-QX
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 01:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWJJXwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 19:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWJJXwG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 19:52:06 -0400
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:430 "EHLO
	lucian.tromer.org") by vger.kernel.org with ESMTP id S932278AbWJJXwE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 19:52:04 -0400
Received: from [192.168.4.6] ([192.168.4.6])
	by lucian.tromer.org (8.13.7/8.12.11) with ESMTP id k9ANpsTi012065;
	Wed, 11 Oct 2006 01:51:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610101524050.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28684>

On 2006-10-11 00:27, Linus Torvalds wrote:
> Those unreferenced objects are old history that won't be part of any new 
> history.
> 
> If you create new history, they won't be in the pack.

... because git-repack moves only already-referenced objects to packs
(and once they're referenced a subsequent "git-repack -a -d" won't lose
them). Curiously, this critically depends on Documentation/git-repack
being wrong:

  This script is used to combine all objects that do not currently
  reside in a "pack", into a pack.

However, this means there is no safe way to create a new pack without
adding all its content as loose objects first.

For example, the following is racy because there's a point where the new
pack is on disk but not yet referenced:

$ git-fetch --keep foo &  git-repack -a -d


>> But "git prune" does not GC packs, only loose objects.
> 
> Right. And you'd want to repack _and_ prune, but they should be kept 
> separate, because one is safe, the other is not.

Ah, semantics.

The request was for removing unreferenced objects ("pruning") in *packs*
while doing the repacking. This turns out to be already implemented
(contrary to the docs) and, as you explained, safe.

Pruning both packed and loose objects while repacking is neither safe
nor requested (and is indeed roughly equivalent to just
"git-repack -a -d; git-prune").


  Eran
