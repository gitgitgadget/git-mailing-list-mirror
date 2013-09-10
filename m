From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re-Transmission of blobs?
Date: Tue, 10 Sep 2013 10:51:02 -0700
Message-ID: <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
References: <20130910130837.GA14259@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJS5p-0005X8-8E
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab3IJRvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:51:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab3IJRvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:51:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FAC840E04;
	Tue, 10 Sep 2013 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=46nwm/91IaGY0J7ONiYwSAFwgas=; b=jpS7TN
	Ni2XQECDVTsrNnuxx0JHzJVKZ6miHxe8UO+3mL/32bkVkhztWTFvJdJ1NzSch5V+
	C5rqCIA0TBTApEz7BjpqRwErWTqe7ICjK93Bkv9zThujlQg2NygcC2pcf0NZKRgN
	60PqeAFTlFLb+//nQ9cmosiynb/aW4t2gjihM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cRKH3pSX4XbXnVhP1A8EG10d+pBvEkoJ
	/pIptUCe8glFvfiGVL+Jcj4onYgeBZ+kqTS+4dg6jxIMKiM5DGNoCeFsSxCEmR6G
	m6BDrTklyNS3xA5kPhbL25mKcLK7JDmGIKnOS1VK5r0M7e7iDesgu3JJaMkeks9/
	48C5m9s1IAU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F91340E03;
	Tue, 10 Sep 2013 17:51:06 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E70340DFF;
	Tue, 10 Sep 2013 17:51:05 +0000 (UTC)
In-Reply-To: <20130910130837.GA14259@raven.wolf.lan> (Josef Wolf's message of
	"Tue, 10 Sep 2013 15:08:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 90935A64-1A41-11E3-9328-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234464>

Josef Wolf <jw@raven.inka.de> writes:

> as we all know, files are identified by their SHA. Thus I had the impression
> that when transfering files, git would know by the SHA whether a given file is
> already available in the destination repository and the transfer would be of
> no use.

That is unfortunately not how things work.  It is not like the
receiving end sends the names of all objects it has, and the sending
end excludes these objects from what it is going to send.

Consider this simple history with only a handful of commits (as
usual, time flows from left to right):

              E
             /   
    A---B---C---D

where D is at the tip of the sending side, E is at the tip of the
receiving side.  The exchange goes roughly like this:

    (receiving side): what do you have?

    (sending side): my tip is at D.

    (receiving side): D?  I've never heard of it --- please give it
                      to me.  I have E.

    (sending side): E?  I don't know about it; must be something you
                    created since you forked from me.  Tell me about
                    its ancestors.

    (receiving side): OK, I have C.

    (sending side): Oh, C I know about. You do not have to tell me
                    anything more.  A packfile to bring you up to
                    date will follow.

At this point, the sender knows that the receiver needs the commit
D, and trees and blobs in D.  It does also know it has the commit C
and trees and blobs in C.  It does the best thing it can do using
these (and only these) information, namely, to send the commit D,
and send trees and blobs in D that are not in the commit C.

You may happen to have something in E that match what is in D but
not in C.  Because the sender does not know anything about E at all
in the first place, that information cannot be used to reduce the
transfer.

The sender theoretically _could_ also exploit the fact that any
receiver that has C must have B and A and all trees and blobs
associated with these ancestor commits [*1*], but that information
is not currently discovered nor used during the object transfer.

There may happen to be a tree or a blob in A that matches a tree or
a blob in D.  But because the common ancestor discovery exchange
above stops at C, the sender does not bother enumerating all the
objects that are in the ancestor commits of C when figuring out what
objects to send to ensure that the receiving end has all the objects
necessary to complete D.  If you modified a blob at B (or C) and
then resurrected the old version of the blob at D, it is likely that
the blob is going to be sent again when the receiving end asks for
D.

There are some work being done to optimize this further using
various techniques, but they are not ready yet.


[Footnote]

*1* only down to the shallow boundary, if the receiving end is a
shallow clone.
