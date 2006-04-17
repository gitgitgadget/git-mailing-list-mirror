From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/7] cleanups: Remove unused variable from sha1_file.c
Date: Mon, 17 Apr 2006 14:42:19 -0700
Message-ID: <7v64l7lw04.fsf@assigned-by-dhcp.cox.net>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
	<20060417151448.1D99C19B912@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 23:42:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVbUH-0004NI-9H
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 23:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWDQVmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWDQVmV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 17:42:21 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64131 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751326AbWDQVmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 17:42:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417214220.VUPO24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 17:42:20 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18837>

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Left is assigned to, but never used in sha1_file.c

True, but in this case I suspect it should be used to make sure
we have the 20-byte base_sha1 that follows the header in
deltified case, perhaps like this:

diff --git a/sha1_file.c b/sha1_file.c
index e3d0113..929f481 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -874,17 +874,19 @@ void packed_object_info_detail(struct pa
 			       unsigned char *base_sha1)
 {
 	struct packed_git *p = e->p;
-	unsigned long offset, left;
+	unsigned long offset;
 	unsigned char *pack;
 	enum object_type kind;
 
 	offset = unpack_object_header(p, e->offset, &kind, size);
 	pack = p->pack_base + offset;
-	left = p->pack_size - offset;
 	if (kind != OBJ_DELTA)
 		*delta_chain_length = 0;
 	else {
 		unsigned int chain_length = 0;
+		if (p->pack_size - 20 < offset)
+			die("pack file %s records an incomplete delta base",
+			    p->pack_name);
 		memcpy(base_sha1, pack, 20);
 		do {
 			struct pack_entry base_ent;
