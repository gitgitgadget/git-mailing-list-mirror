From: lists@haller-berlin.de (Stefan Haller)
Subject: --find-copies-harder finds fewer copies/renames than -C does
Date: Wed, 5 Jan 2011 18:46:13 +0100
Message-ID: <1jukub7.uehx43wxtij7M%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 18:46:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaXRW-0000NI-G7
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 18:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209Ab1AERqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 12:46:19 -0500
Received: from mail.ableton.net ([62.96.12.117]:37738 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab1AERqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 12:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:To; bh=+6Qu+GEKUTIDZstI3uRvfHURykvZ9FOqdIolqjVeTMA=;
	b=Jxw2af9ndlb7PEmRP+7X4a3br4+LgJ1CqkBLs0YThVZYqJPAbUQBX2xkzc4VoyJHcSHXRBgn/P0cCbr7rOXCP87JD+g7tU7KHGaw7k4yuwq6F3x8aZq4gTiUg8CAkiLGstFdzTEWn8GZAA8Ia4rephdSiHoI9n6V6+GZHtfPT1c=;
Received: from macbook-stk.office.ableton.com ([10.1.12.10])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PaXOy-0001c4-Kj
	for git@vger.kernel.org; Wed, 05 Jan 2011 18:44:00 +0100
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.5 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164576>

I was surprised to find out that --find-copies-harder can, under certain
circumstances, detect fewer renames than -C does for a given commit.
After some digging I think I understand now why this is so, but I find
it extremely unintuitive, and would like to know what other people think
about it.  I had expected --find-copies-harder to always detect at least
as many copies/renames as -C, and possibly more, but never less.

The case I had is this: I have a repo with about 10.000 files, and a
commit with 14 files being moved to a different folder; half of them
where unmodified moves, the other half had one-line modifications
(similarity index 97% or so).

"git show -C --name-status <commit>" detects all 14 files as renames;
"git show --find-copies-harder --name-status <commit>" only shows the
unmodified moves as renames, the ones with modifications are shown as
delete plus add.

The reason for this seems to be the condition
"num_create * num_src > rename_limit * rename_limit" in diffcore_rename;
--find-copies-harder exeeds the limit, so it turns off inexact rename
dectection *completely*, while -C stays well below the limit.

I had expected --find-copies-harder to still do inexact rename detection
among the changed files in the commit in this case, and turn it off only
for the unmodified files; I'm not familiar enough with the code to tell
whether that would be easy to implement though.

Any thoughts?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
