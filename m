From: Pierre Habouzit <madcoder@debian.org>
Subject: Use more strbufs series [on top of next]
Date: Sun,  9 Sep 2007 02:04:30 +0200
Message-ID: <11892962763548-git-send-email-madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 10:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOa-0003oI-O3
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:56 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMV-0006SO-37
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:15 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMN-0003zs-Hg
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbXIIAEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755273AbXIIAEj
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:04:39 -0400
Received: from pan.madism.org ([88.191.52.104]:46625 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbXIIAEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:04:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 873AF1EB17
	for <git@vger.kernel.org>; Sun,  9 Sep 2007 02:04:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E19C91A9; Sun,  9 Sep 2007 02:04:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.5, required=12.0, autolearn=disabled, AWL=1.500,UIO_VGER=-3)
X-UiO-Scanned: D07CA68697620B2E7DEE9DF00CEC4D04B2BB1F42
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -14 maxlevel 200 minaction 2 bait 0 mail/h: 2 total 517788 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58152>

  Here is a series of patches on top of next, which use strbufs in even
more places. Most notably, it uses it in the commit pretty printer (and
commit message formatter), and it supersedes definitely read_fd
(previously in sha1_file.c).

  The latter is not strictly speaking necessary, but strbuf_read and
read_fd do almost the same. The sole difference is that read_fd use
custom reallocation mechanisms (which is bad now that strbufs exists)
though had a different semantics when an error occurs. Though, like for
strbuf_read, read_fd callers either die() or discard the buffer, and
current strbuf_read semantics works with that.

  As a result we once again have a nice reduction of the code lines.

  $ git diff --shortstat origin/next strbuf.*
   2 files changed, 24 insertions(+), 0 deletions(-)

  $ git diff --shortstat origin/next ^strbuf.*
   16 files changed, 270 insertions(+), 466 deletions(-)

  I feel that with the current series commit.c can be simplified
further, but the patch was big enough as is already.

  If this series will be rewritten for this or this reason, please note
that I found a memory leak (not a severe one though) in
builtin-archive.c, where the "fmt" pointer is allocated and never freed.

Cheers,
