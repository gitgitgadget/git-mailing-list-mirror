From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Handle sha1_object_info failures in ls-tree -l
Date: Fri, 2 Jan 2009 00:52:00 +0100
Message-ID: <20090101235200.GA14713@blimp.localdomain>
References: <20090101192153.GA6536@coredump.intra.peff.net> <87eizmty25.fsf_-_@jidanni.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Jan 02 00:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXM5-0005eA-3z
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 00:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbZAAXwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 18:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbZAAXwK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 18:52:10 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:57642 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275AbZAAXwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 18:52:09 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AU82pW82
Received: from tigra.home (Faacd.f.strato-dslnet.de [195.4.170.205])
	by post.strato.de (klopstock mo58) (RZmta 18.7)
	with ESMTP id p030acl01MbFNu ; Fri, 2 Jan 2009 00:52:01 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 2DA5D277DB;
	Fri,  2 Jan 2009 00:52:01 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id B02B236D27; Fri,  2 Jan 2009 00:52:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87eizmty25.fsf_-_@jidanni.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104344>

Printing 0 as the size of the blob seem to be the safest. The error
message is already printed by sha1_object_info itself.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
jidanni@jidanni.org, Fri, Jan 02, 2009 00:18:42 +0100:
> git ls-tree prints wacko file sizes if it can't find the blob:
> $ git ls-tree --abbrev=4 -l 76e4
> error: unable to find ae832f2245892ddde5221357466448b409775142
> 100644 blob ae83 3220821896     words

Not tested, but should print size of 0 if this happens.
I actually would prefer ls-tree finish listing and exit(1) in this case,
but ... am a little lazy (or scared of a "static int exit_code;").

 builtin-ls-tree.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index cb61717..234df50 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -96,7 +96,8 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			if (!strcmp(type, blob_type)) {
-				sha1_object_info(sha1, &size);
+				if (sha1_object_info(sha1, &size))
+					size = 0;
 				printf("%06o %s %s %7lu\t", mode, type,
 				       abbrev ? find_unique_abbrev(sha1, abbrev)
 				              : sha1_to_hex(sha1),
-- 
1.6.1.73.g7450
