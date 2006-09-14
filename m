From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Notes on supporting Git operations in/on partial Working Directories
Date: Thu, 14 Sep 2006 12:05:16 -0700
Message-ID: <4509A7EC.9090805@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 14 21:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNwWa-0001wb-63
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 21:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWINTFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 15:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWINTFU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 15:05:20 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:28208 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751034AbWINTFT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 15:05:19 -0400
Received: by py-out-1112.google.com with SMTP id n25so3721306pyg
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 12:05:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=nlX970zvoGiFc4muwfXLh0d62DV37pN2ycM017cQzfXKwBiV2aLiw6X9wSg8Ly+ibtQDbchDUd5rJ+gB2uwcXg4xaUkQLPViInWDx9fmY/dtwvxudzqK3Lrx2HWN7Km0qKm8x1ramY7A337+F6Fk03LqwBQ1zw0R0vC4LsZDsA8=
Received: by 10.35.125.16 with SMTP id c16mr15603767pyn;
        Thu, 14 Sep 2006 12:05:19 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id i72sm6571358pye.2006.09.14.12.05.18;
        Thu, 14 Sep 2006 12:05:18 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27026>

Notes on supporting Git operations in/on partial Working Directories
====================================================================

Motivation
----------
Be able to checkout only part of a tree, do some work, and commit the
changes. Support for partial working directories is also (almost) a
requirement for supporting partial repositories.


Expectations
------------
All Git commands that currently work with the index or the working
directory will work with indexes or working directories that are partial
checkouts.

Leading directories common to all objects of a partial checkout are not
present in the working directory.

The contents of a partial working directory can be determined on an path
by path basis; entire directories are not required.


Implementation Sketch
---------------------
The minimum required changes[*1*][*2*][*3*] to the index file to support
partial checkouts are:

1) the addition of WD_Prefix string to hold the common path prefix of
all objects in the working directory. For a full checkout, the WD_Prefix
string would be empty.

2) A (new) flag for each entry in the index indicating whether or not
the object is in the partial checkout.

The contents of the index file still reflect the full tree but flag each
object (file or symlink) separately as part of the checkout or not. The
WD_Prefix string is so that a partial checkout consisting of only
objects somewhere in the a/b/c/d/ tree can be found in the working
directory without the a/b/c/d/ prefix to the path of the object.

All the Git commands that use the index file will need to be changed to
support this but the transfer protocols do not need to change.


Notes
-----
[*1*] As long as the index file structure is being changed, it may be
worth while also including the ideas in:
	http://www.gelato.unsw.edu.au/archives/git/0601/15471.html
	http://www.gelato.unsw.edu.au/archives/git/0601/15483.html
	http://www.gelato.unsw.edu.au/archives/git/0601/15484.html
Except for the "bind" parts since I still think that is a bad idea.

[*2*] The index "TREE" (cache-tree) extension should also become a
required part of the index.

[*3*] Possibly split the index up by directory and store the parts in
the working directory. An index "distributed" in this way would have
a "natural" cache-tree built in and (finally) be able support empty
directories.
