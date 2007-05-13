From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] Make git compile with SUNs forte12 compiler
Date: Sun, 13 May 2007 14:52:53 +0200
Message-ID: <46470A25.70703@free.fr>
References: <11790057101792-git-send-email-sithglan@stud.uni-erlangen.de> <pan.2007.05.13.09.47.32@free.fr> <20070513103038.GC18546@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090909090807080706060203"
Cc: git@vger.kernel.org, junkio@cox.net
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun May 13 14:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnDZR-0007R8-3R
	for gcvg-git@gmane.org; Sun, 13 May 2007 14:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbXEMMw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 08:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbXEMMw5
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 08:52:57 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:58088 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932753AbXEMMw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 08:52:56 -0400
Received: from [192.168.0.3] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 73C1C96AE6;
	Sun, 13 May 2007 14:52:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20070217 Iceape/1.1.1 (Debian-1.1.1-2)
In-Reply-To: <20070513103038.GC18546@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47145>

This is a multi-part message in MIME format.
--------------090909090807080706060203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas,

Thomas Glanzmann wrote:
> Hello,
> 
> [ Junio please drop the patch, if you thought about putting it upstream ]
> 
>> Did you understand what you did ?
> 
> I do. But my objective wasn't get that function inline but get git to compile
> under forte12. However. After you pushed me in the right direction I read the
> compiler documentation and found a compiler option called "-features=no%extinl"
> which makes it possible to compile git as is using forte12.
What's strange with your compiler is that it seems to not take care of 
the "static" keyword and thinks about an "extern inline".
Now it could be interesting to understand why.

Let's look at your error [1].
First it only complain about tree_entry_extract not tree_entry_len.

Let's see why ?
If you look in tree-walk.h and search for tree_entry_extract, you will see :

static inline const unsigned char *tree_entry_extract(struct tree_desc 
*desc, const char **pathp, unsigned int *modep)
[...]
const unsigned char *tree_entry_extract(struct tree_desc *, const char 
**, unsigned int *);

This is bad, tree_entry_extract is declared as static inline and as extern.

If you remove the "const unsigned char *tree_entry_extract(struct 
tree_desc *, const char **, unsigned int *);", I bet everybody will be 
happy and no need to extra option for the sun compiler. [2]


Matthieu

[1]
LINK git-convert-objects
ld: fatal: symbol `tree_entry_extract' is multiply-defined:
         (file libgit.a(sha1_name.o) type=FUNC; file libgit.a(tree.o) 
type=FUNC);
ld: fatal: symbol `tree_entry_extract' is multiply-defined:
         (file libgit.a(sha1_name.o) type=FUNC; file 
libgit.a(tree-walk.o) type=FUNC);
ld: fatal: File processing errors. No output written to git-convert-objects

[2] see attached patch


--------------090909090807080706060203
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- a/tree-walk.h	2007-05-13 14:51:01.451827585 +0200
+++ b/tree-walk.h	2007-05-13 14:51:07.450235889 +0200
@@ -27,7 +27,6 @@
 
 void update_tree_entry(struct tree_desc *);
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
-const unsigned char *tree_entry_extract(struct tree_desc *, const char **, unsigned int *);
 
 /* Helper function that does both of the above and returns true for success */
 int tree_entry(struct tree_desc *, struct name_entry *);

--------------090909090807080706060203--
