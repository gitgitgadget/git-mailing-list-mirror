From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Sun, 09 Apr 2006 23:29:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604092305000.2215@localhost.localdomain>
References: <20060409143117.GA23908@erlang.gbar.dtu.dk>
 <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain>
 <20060409173409.GB23908@erlang.gbar.dtu.dk>
 <Pine.LNX.4.64.0604091340540.2215@localhost.localdomain>
 <20060409224548.GB21455@erlang.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_m13tkXu99mbN5CZD1nMcpQ)"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 05:29:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSn5y-0005NV-IF
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 05:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWDJD3j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 23:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWDJD3j
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 23:29:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8485 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750900AbWDJD3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 23:29:39 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXH00IJWLP9YZ20@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 09 Apr 2006 23:29:34 -0400 (EDT)
In-reply-to: <20060409224548.GB21455@erlang.gbar.dtu.dk>
X-X-Sender: nico@localhost.localdomain
To: Peter Eriksen <s022018@student.dtu.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18575>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_m13tkXu99mbN5CZD1nMcpQ)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

On Mon, 10 Apr 2006, Peter Eriksen wrote:

> On Sun, Apr 09, 2006 at 01:45:00PM -0400, Nicolas Pitre wrote:
> ...
> > Try this with the README file from the git source tree:
> > 
> > 	sed s/git/GIT/g < ./README > /tmp/README.mod
> > 	test-delta -d ./README /tmp/README.mod /tmp/README.delta
> > 	[BOOM!]
> 
> I found the bug.  The code still has some limitations, but now
> it passes the test suite.  Thanks for your help, Nicolas.

OK here's some more meat for you:

Copy the same README file from the git source tree, then edit the copied 
version so the "Blob Object" section and the "Tree Object" section are 
swapped around like shown in the attached patch.

The best delta that can be achieved is 24 bytes.

With the current code the produced delta is 42 bytes.

With your code the resulting delta is 4978 bytes, about twice as large 
as the attached patch.

One major limitation of your algorithm appears to not have a global view 
of the base buffer before starting to find matches.


Nicolas

--Boundary_(ID_m13tkXu99mbN5CZD1nMcpQ)
Content-id: <Pine.LNX.4.64.0604092329330.2215@localhost.localdomain>
Content-type: TEXT/PLAIN; charset=US-ASCII; name=README.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=README.diff
Content-description:

--- f1	2006-04-09 13:31:26.000000000 -0400
+++ f2	2006-04-09 23:04:10.000000000 -0400
@@ -87,26 +87,6 @@
 
 The object types in some more detail:
 
-Blob Object
-~~~~~~~~~~~
-A "blob" object is nothing but a binary blob of data, and doesn't
-refer to anything else.  There is no signature or any other
-verification of the data, so while the object is consistent (it 'is'
-indexed by its sha1 hash, so the data itself is certainly correct), it
-has absolutely no other attributes.  No name associations, no
-permissions.  It is purely a blob of data (i.e. normally "file
-contents").
-
-In particular, since the blob is entirely defined by its data, if two
-files in a directory tree (or in multiple different versions of the
-repository) have the same contents, they will share the same blob
-object. The object is totally independent of its location in the
-directory tree, and renaming a file does not change the object that
-file is associated with in any way.
-
-A blob is typically created when gitlink:git-update-index[1]
-is run, and its data can be accessed by gitlink:git-cat-file[1].
-
 Tree Object
 ~~~~~~~~~~~
 The next hierarchical object type is the "tree" object.  A tree object
@@ -147,6 +127,26 @@
 its data can be accessed by gitlink:git-ls-tree[1].
 Two trees can be compared with gitlink:git-diff-tree[1].
 
+Blob Object
+~~~~~~~~~~~
+A "blob" object is nothing but a binary blob of data, and doesn't
+refer to anything else.  There is no signature or any other
+verification of the data, so while the object is consistent (it 'is'
+indexed by its sha1 hash, so the data itself is certainly correct), it
+has absolutely no other attributes.  No name associations, no
+permissions.  It is purely a blob of data (i.e. normally "file
+contents").
+
+In particular, since the blob is entirely defined by its data, if two
+files in a directory tree (or in multiple different versions of the
+repository) have the same contents, they will share the same blob
+object. The object is totally independent of its location in the
+directory tree, and renaming a file does not change the object that
+file is associated with in any way.
+
+A blob is typically created when gitlink:git-update-index[1]
+is run, and its data can be accessed by gitlink:git-cat-file[1].
+
 Commit Object
 ~~~~~~~~~~~~~
 The "commit" object is an object that introduces the notion of

--Boundary_(ID_m13tkXu99mbN5CZD1nMcpQ)--
