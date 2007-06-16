From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix up ugly open-coded "alloc_nr()" user in object.c
Date: Sat, 16 Jun 2007 10:30:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706161024220.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 16 19:31:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzc7I-0003Lw-HW
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 19:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbXFPRbJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 13:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXFPRbI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 13:31:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56936 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913AbXFPRbH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jun 2007 13:31:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5GHURSq006637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 Jun 2007 10:30:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5GHUMOc019862;
	Sat, 16 Jun 2007 10:30:22 -0700
X-Spam-Status: No, hits=-2.521 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50291>


When adding objects to the object/mode array, we used to have our own 
alloc_nr() implementation, rather than use the normal one.

And since the normal one is arguably a bit nicer (still grows the 
allocation exponentially, just not by more-than-doubling it every time), 
why not just use it?

That array of objects ends up being really quite big when you force a 
while repack of a big project, and while we might end up doing a few more 
xreallocs in the process, we also hopefully don't end up with a final 
allocation that is quite as wastefully big.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

  That was an overkill of a situation for a trivial patch that I don't 
  think is in the least interesting or even important. I really don't care 
  if you take this, Junio, but it seemed the obvious one-liner to do, so 
  I'm sending it in anyway.

 object.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/object.c b/object.c
index 16793d9..fdd6ceb 100644
--- a/object.c
+++ b/object.c
@@ -245,7 +245,7 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
 	struct object_array_entry *objects = array->objects;
 
 	if (nr >= alloc) {
-		alloc = (alloc + 32) * 2;
+		alloc = alloc_nr(alloc);
 		objects = xrealloc(objects, alloc * sizeof(*objects));
 		array->alloc = alloc;
 		array->objects = objects;
