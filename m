From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: Compression speed for large files
Date: Mon, 3 Jul 2006 11:13:34 +0000 (UTC)
Message-ID: <loom.20060703T124601-969@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 03 13:14:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxMNK-0007EW-Ga
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 13:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWGCLNz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 07:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWGCLNz
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 07:13:55 -0400
Received: from main.gmane.org ([80.91.229.2]:17806 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750702AbWGCLNy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 07:13:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxMN4-0007CF-1L
	for git@vger.kernel.org; Mon, 03 Jul 2006 13:13:42 +0200
Received: from fnasa.simula.no ([129.240.228.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 13:13:42 +0200
Received: from cjhaga by fnasa.simula.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 13:13:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 129.240.228.53 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060608 Ubuntu/dapper-security Firefox/1.5.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23170>

I'm looking at doing version control of data files, potentially very large,
often binary. In git, committing of large files is very slow; I have tested with
a 45MB file, which takes about 1 minute to check in (on an intel core-duo 2GHz).

Now, most of the time is spent in compressing the file. Would it be a good idea
to change the Z_BEST_COMPRESSION flag to zlib, at least for large files? I have
measured the time spent by git-commit with different flags in sha1_file.c:

  method                 time (s)  object size (kB)
  Z_BEST_COMPRESSION     62.0      17136
  Z_DEFAULT_COMPRESSION  10.4      16536
  Z_BEST_SPEED            4.8      17071

In this case Z_BEST_COMPRESSION also compresses worse, but that's not the major
issue: the time is. Here's a couple of other data points, measured with gzip -9,
-6 and -1 (comparable to the Z_ flags above):

129MB ascii data file
  method    time (s)  object size (kB)
  gzip -9   158       23066
  gzip -6    18       23619
  gzip -1     6       32304

3MB ascii data file
  gzip -9   2.2        887
  gzip -6   0.7        912
  gzip -1   0.3       1134

So: is it a good idea to change to faster compression, at least for larger
files? From my (limited) testing I would suggest using Z_BEST_COMPRESSION only
for small files (perhaps <1MB?) and Z_DEFAULT_COMPRESSION/Z_BEST_SPEED for
larger ones.


-j.
