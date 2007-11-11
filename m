From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/5] git-fetch: Always fetch tags if the object they reference exists
Date: Sun, 11 Nov 2007 02:29:30 -0500
Message-ID: <20071111072930.GB19146@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 08:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir7GS-0003H1-0C
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 08:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbXKKH3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 02:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbXKKH3f
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 02:29:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41449 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbXKKH3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 02:29:34 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ir7G8-0000za-LW; Sun, 11 Nov 2007 02:29:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D2A9420FBAE; Sun, 11 Nov 2007 02:29:30 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64416>

Previously git-fetch.sh used `git cat-file -t` to determine if an
object referenced by a tag exists, and if so fetch that tag locally.
This was subtly broken during the port to C based builtin-fetch as
lookup_object() only works to locate an object if it was previously
accessed by the transport.  Not all transports will access all
objects in this way, so tags were not always being fetched.

The rsync transport never loads objects into the internal object
table so automated tag following didn't work if rsync was used.
Automated tag following also didn't work on the native transport
if the new tag was behind the common point(s) negotiated between
the two ends of the connection as the tag's referrant would not
be loaded into the internal object table.  Further the automated
tag following was broken with the HTTP commit walker if the new
tag's referrant was behind an existing ref, as the walker would
stop before loading the tag's referrant into the object table.

Switching to has_sha1_file() restores the original behavior from
the shell script by checking if the object exists in the ODB,
without relying on the state left behind by a transport.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 847db73..a935b5a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -389,7 +389,7 @@ static struct ref *find_non_local_tags(struct transport *transport,
 
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
-		    lookup_object(ref->old_sha1)) {
+		    has_sha1_file(ref->old_sha1)) {
 			path_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);
-- 
1.5.3.5.1661.gcbf0
