From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Community Book
Date: Fri, 05 Sep 2008 12:41:48 -0700
Message-ID: <7vmyimv0qr.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 21:43:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbhDO-0007AT-CH
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 21:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYIETl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 15:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbYIETl7
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 15:41:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbYIETl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 15:41:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 853BB5EE83;
	Fri,  5 Sep 2008 15:41:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 889B55EE80; Fri,  5 Sep 2008 15:41:51 -0400 (EDT)
In-Reply-To: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
 (Scott Chacon's message of "Fri, 5 Sep 2008 12:08:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B1855D02-7B82-11DD-8E68-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95037>

"Scott Chacon" <schacon@gmail.com> writes:

> Also, the last section of the book is on some of the plumbing - mostly
> stuff I've found difficult to pick up with the existing documentation
> while re-implementing stuff in Ruby.  I would really appreciate it if
> someone could proofread some of these chapters for errors:
>
> http://book.git-scm.com/7_the_packfile.html

Nice pictures.  You might also want to know that code for reading pack idx
version 2 was backported to 1.4.4.5 for people who are stuck on 1.4.4
series for whatever reason.

What is the target audience of this section?  If it is written for a mere
curious type, or if it is written to give "here is the general idea, for
more details read the source", the level of detail here would be Ok.

If you are writing for people who want to (re)implement something that
produces these files, you might want to at least say that offset/sha1[]
table is sorted by sha1[] values (this is to allow binary search of this
table), and fanout[] table points at the offset/sha1[] table in a specific
way (so that part of the latter table that covers all hashes that start
with a given byte can be found to avoid 8 iterations of the binary
search).

<data> part is just zlib stream for non-delta object types; for the two
delta object representations, the <data> portion contains something that
identifies which base object this delta representation depends on, and the
delta to apply on the base object to resurrect this object.  ref-delta
uses 20-byte hash of the base object at the beginning of <data>, while
ofs-delta stores an offset within the same packfile to identify the base
object.  In either case, two important constraints a reimplementor must
adhere to are:

 * delta representation must be based on some other object within the same
   packfile;

 * the base object must be of the same underlying type (blob, tree, commit
   or tag);

> http://book.git-scm.com/7_raw_git.html

I am guessing this is for Porcelain writers who use plumbing.  Please
don't teach echoing into .git/refs/...  but DO teach using update-ref with
the -m option.  We do not want people's random Porcelains flipping the tip
of branches without leaving trail in reflog for users to use to recover
from mistakes.
