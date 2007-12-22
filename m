From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Sat, 22 Dec 2007 01:25:41 -0800
Message-ID: <7vzlw3xeqy.fsf@gitster.siamese.dyndns.org>
References: <873atvwueq.fsf@rho.meyering.net>
	<7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
	<87hcibveut.fsf@rho.meyering.net>
	<7vzlw33a1o.fsf@gitster.siamese.dyndns.org>
	<87bq8jvd1g.fsf@rho.meyering.net>
	<7vve6r39bp.fsf@gitster.siamese.dyndns.org>
	<8763yrvb3g.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 10:26:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J60cZ-0003Sc-HZ
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 10:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbXLVJZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 04:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbXLVJZv
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 04:25:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbXLVJZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 04:25:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 95A8A6D74;
	Sat, 22 Dec 2007 04:25:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C961B6D73;
	Sat, 22 Dec 2007 04:25:43 -0500 (EST)
In-Reply-To: <8763yrvb3g.fsf@rho.meyering.net> (Jim Meyering's message of
	"Sat, 22 Dec 2007 01:15:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69131>

Jim Meyering <jim@meyering.net> writes:

>>> Junio C Hamano <gitster@pobox.com> wrote:
>>> ...
>> Independent of who creates a "invalid repository", our tools
>> should be prepared to be fed bad data and not get upset.
>> Somebody in our code read a non-commit (or it did not read
>> anything) and told the object layer it is a commit.  That
>> codepath needs to be tightened up, no?
>
> Yes, of course.
> Unfortunately, I won't have time to investigate for a while.

Although I haven't seen the problematic repository, I think what
is going on is that the repository has objects with pointers to
other objects labelled with wrong types.

For example, a tag can tag any type of object.

    $ git cat-file tag v1.5.4-rc1
    object 74f6b03c5c8fceef416de9f9a18e5d64712b6d96
    type commit
    tag v1.5.4-rc1
    tagger Junio C Hamano <gitster@pobox.com> 1198114975 -0800

    GIT 1.5.4-rc1
    ...

When parsing such a tag object, it instantiates an in-core tag
object that has a pointer to an in-core commit object, because
the tag says that it points at commit 74f6b0, without reading
the tagged object itself.  This is to allow the user of that
in-core tag object to ask "what do you point at" and get an
in-core object that represents the pointee.  If (and only if)
the user choose to follow that pointer and look at the contents
of the pointee, it can then call parse_object() on that in-core
object.  In other words, the object layer is designed to work
lazily.

So if you earlier parsed such a tag but if the object 74f6b0
were an object of different type, we would hit the codepath you
identified that leads to a NULL dereference.  And "lying caller"
cannot really do much better (except perhaps actually validating
the presense and the type of the object, which would incur
additional overhead).  The situation is the same if:

 - a tree object records an entry with: 
   - mode bits 040000 pointing at an object that is not a tree; or
   - mode bits 100(644|755) pointing at an object that is not a blob; or
   - mode bits 160000 pointing at an object that is not a commit; or
 - a commit object has a "parent" line that is not a commit; or
 - a commit object has a "tree" line that is not a tree.

Also we cannot just say "then we would take safety over
overhead" and make the lying callers validate the pointee;
subproject commits pointed by gitlinks (i.e. entry with 160000
mode bits in a tree object) are not even required to be
available.

Your fix is all we can sensibly do. I however think you would
need similar fix to the same function for other object types, as
they dereference a potentially NULL pointer the same way.
