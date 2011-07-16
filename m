From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] remote-curl: Add a format check to parsing of info/refs
Date: Sat, 16 Jul 2011 19:23:51 +0100
Message-ID: <20110716182352.85371.18215.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 21:05:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiAAy-0000yk-IT
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 21:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab1GPTFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 15:05:13 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:41030 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751794Ab1GPTFM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2011 15:05:12 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jul 2011 15:05:12 EDT
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 478B0C0612
	for <git@vger.kernel.org>; Sat, 16 Jul 2011 19:58:39 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 277DF329B66
	for <git@vger.kernel.org>; Sat, 16 Jul 2011 19:58:34 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZAEWVBVDNKcQ for <git@vger.kernel.org>;
	Sat, 16 Jul 2011 19:58:33 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [IPv6:2001:470:96a1:2:e2f8:47ff:fe26:e1cc])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 847ED228457
	for <git@vger.kernel.org>; Sat, 16 Jul 2011 19:58:33 +0100 (BST)
X-git-sha1: fdf3131a10854a41e34cad112d12136bf0ff1fa0 
X-Mailer: git-mail-commits v0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177282>

When parsing info/refs, no checks were applied that the file was in
the requried format.  Since the file is read from a remote webserver,
this isn't guarenteed to be true.  Add a check that the file at least
only contains lines that consist of 40 characters followed by a tab
and then the ref name.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

If you happen to try, for example, git ls-remote http://example.com/foo, when
http://example.com/foo/info/refs exists - but isn't part of a git repository you
get a very strange response as remote-curl.c attempts to parse refs out of the
file.  This may be an unlikely situtation, but that doesn't mean it can't be
hanlded a little better.

Julian

 remote-curl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index b5be25c..8ac5028 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -227,6 +227,8 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		if (data[i] == '\t')
 			mid = &data[i];
 		if (data[i] == '\n') {
+			if (mid - start != 40)
+				die("%sinfo/refs not valid: is this a git repository?", url);
 			data[i] = 0;
 			ref_name = mid + 1;
 			ref = xmalloc(sizeof(struct ref) +
-- 
1.7.6
