From: Geert Bosch <bosch@adacore.com>
Subject: Re: Multiblobs
Date: Wed, 28 Apr 2010 14:34:02 -0400
Message-ID: <AAA4B50E-9539-450D-9B6C-E67856D3D5BC@adacore.com>
References: <loom.20100428T164432-954@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 20:34:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7C5L-0003BW-RC
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 20:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab0D1SeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 14:34:06 -0400
Received: from rock.gnat.com ([205.232.38.15]:45550 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016Ab0D1SeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 14:34:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 7A42F2BAB6A;
	Wed, 28 Apr 2010 14:34:02 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6aLbYTdztCh3; Wed, 28 Apr 2010 14:34:02 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.115])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 625BC2BAB66;
	Wed, 28 Apr 2010 14:34:02 -0400 (EDT)
In-Reply-To: <loom.20100428T164432-954@post.gmane.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146003>


On Apr 28, 2010, at 11:12, Sergio Callegari wrote:

> Hi,
> 
> it happened to me to read an older post by Jeff King about "multiblobs"
> (http://kerneltrap.org/mailarchive/git/2008/4/6/1360014) and I was wandering
> whether the idea has been abandoned for some reason or just put on hold.
> 
> Apparently, this would marvellously help on
> - storing large binary blobs (the split could happen with a rolling checksum
> approach)
> - storing "structured files", such as the many zip-based file formats
> (Opendocument, Docx, Jar files, zip files themselves), tars (including
> compressed tars), pdfs, etc, whose number is rising day after day...
> - storing binary files with textual tags, where the tags could go on a separate
> blob, greatly simplifying their readout without any need for caching them on a
> note tree.
> - etc...

In the early days of GIT I once implemented a "git pipe" command that would
allow an unbounded stream of data to be stored in GIT. The stream would be
broken up in small segments using context-sensitive break points (essentially
points in the code where a hash H of the last N bytes modulo P is equal to some Q).
The average segment length will then be about P bytes long.
Multiple segments would be put in a tree with each tree entry's name being the
cumulative length of the segment or subtree it references, with enough leading
zeros to accomodate for the largest length in the tree.

This works well and allows efficient diff operations or updates of arbitrarily
large files. In particular, all operations take a time proportional to the
size of the change rather than the size of the file.

The draw backs are:

  - All of the variables H, N, P and Q above influence the final hash
    that is computed for an object, so the values picked must work well.
  - You'd only want to use this method for largish files, but because
    this threshold influences final hashes, it again should be picked with care.
  - more complex than having just simple straight blobs.

One of the nice aspects of this representation is that extracting the tree
into the local filesystem and concatenating all files in the directory
tree in alphabetical order does yield the original file.

  -Geert