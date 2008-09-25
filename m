From: Yann Dirson <ydirson@altern.org>
Subject: [RFC PATCH] detection of directory renames
Date: Thu, 25 Sep 2008 23:47:01 +0200
Message-ID: <20080925213819.27029.47944.stgit@gandelf.nowhere.earth>
References: <7vfxojtr9t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 23:46:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiyfP-0003V3-2G
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 23:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbYIYVpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 17:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbYIYVpW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 17:45:22 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:51396 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbYIYVpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 17:45:21 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 2657432A7FB
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 23:45:20 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 1286532A7EC
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 23:45:20 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 749BF1F0C1
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 23:47:02 +0200 (CEST)
In-Reply-To: <7vfxojtr9t.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96807>

This is a first very preliminar patch, mostly so people can comment
early on the big picture.  It has a number of limitations, many but
not all already listed as FIXME's in the patch itself.  If anything in
this patch seems so wrong it is not worth polishing it, it's the
perfect time to say so :)

The idea is to add a new pass to diffcore-rename, to group file renames
looking like a full directory move, and then to hide those file
renames which do not carry any additionnal information.

Here is a sample run:

$ ./git-diff-tree ee491 --factorize-renames -r 
[DBG] possible rename from arm/ to bar/
[DBG] possible rename from ppc/ to moved/
[DBG] discarding dir rename of arm/, mixing moved/ and bar/
[DBG] ppc/* -> moved/* makes ppc/sha1ppc.S -> moved/sha1ppc.S uninteresting
[DBG] ppc/* -> moved/* makes ppc/sha1.c -> moved/sha1.c uninteresting
ee491a42190ec6e716f46a55fa0a7f4e307f1629
:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100   ppc/    moved/
:100644 100644 9e3ae038e818f4e21bc50f864fc5204f6fa44daa 9e3ae038e818f4e21bc50f864fc5204f6fa44daa R100   arm/sha1.c      bar/sha1.c
:100644 100644 3952646349cf9d033177e69ba9433652a378c0e9 3952646349cf9d033177e69ba9433652a378c0e9 R100   arm/sha1.h      bar/sha1.h
:100644 100644 c3c51aa4d487f2e85c02b0257c1f0b57d6158d76 c065eeef7d68ea91863431788e20cd814c5ac52c R099   ppc/sha1.h      moved/sha1.h
:100644 100644 8c1cb99fb403875af85e4d1524d21f7eb818f59b 8c1cb99fb403875af85e4d1524d21f7eb818f59b R100   arm/sha1_arm.S  moved/sha1_arm.S

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
