From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Mon, 13 Aug 2012 00:40:55 -0700
Message-ID: <7v8vdjfddk.fsf@alter.siamese.dyndns.org>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 <7vtxw8exii.fsf@alter.siamese.dyndns.org>
 <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
 <CACsJy8CNp2w6PsMSrQ4aFBwHKbOGid4pVHUhE4xgmTatrnEepQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 09:41:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0pGr-0003Ts-Fe
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 09:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab2HMHk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 03:40:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab2HMHk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 03:40:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A4C87E6D;
	Mon, 13 Aug 2012 03:40:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JcEKThvwIkKj0qs1KEaBhCFg3zM=; b=X4uMDy
	5jOVdK++OBkyIzfq7KDFdDu/nhl4E464Lnd/ijnTk08q4dFcH9XmZ0cmcDPNDM74
	CKUZOIdlFsfMVL5GSqKyQ4E1aLO7WvLy6SYsDUoOBVFUF1bolnSw7ZqV4ASyG52a
	RZDGx/5wBXYUG0NGMhkwjIqiO9n/+4NhecNCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DzkKYpkM7VfNozyWZRUjnY1Qft16niDj
	cwuj6/aZQeOKndJ1+ShC6iY04Wpw9Frf++Ik9Q/kXBg98/JsZt6Spj8P9mh+BlHZ
	7qE2MwyCZ+lebjzDXe+qYu+nAfwt4jjzhk5TU820vcXx+2tck8Y0GKxxHkCUOAAV
	yV2doQWOuO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 870F07E63;
	Mon, 13 Aug 2012 03:40:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3FFD7E62; Mon, 13 Aug 2012
 03:40:56 -0400 (EDT)
In-Reply-To: <CACsJy8CNp2w6PsMSrQ4aFBwHKbOGid4pVHUhE4xgmTatrnEepQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 13 Aug 2012 07:57:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37E45452-E51A-11E1-AD37-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203331>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Aug 13, 2012 at 2:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> For example, the reachability bitmap would want to say something
>> like "Traversing from commit A, these objects in this pack are
>> reachable."  The bitmap for one commit A would logically consist of
>> N bits for a packfile that stores N objects (the resulting bitmap
>> needs to be compressed before going to disk, perhaps with RLE or
>> something).  With the single "sorted by SHA-1" table, we can use the
>> index in that single table to enumerate all reachable objects of any
>> type in one go.  With four separate tables, on the other hand, we
>> would need four bitmaps per commit.
>
> No we still need one per commit. The n-th bit is in the order of the
> object in the pack, not the index. How sha-1 is sorted does not
> matter.

Then what is the problem of using that same "N" that counts the
object using the order of the objects in the pack as a short-hand to
the object name instead, if your objective is to avoid having to
repeat the full 20-byte object name in your secondary tables?  That
does not call for any split in the list of SHA-1s, no?

>> Either way is _possible_, but I think the former is simpler, and the
>> latter makes it harder to introduce new types of objects in the
>> future, which I do not think we have examined possible use cases
>> well enough to make that decision to say "four types is enough
>> forever".
>
> New types can be put in one of those four tables, depending on its
> purpose. The reason I split because I care particularly about commits
> and trees. If the new type serves the same purpose as tree, for
> example, then it's better put in tree table...

And when there are multiple uses, one that wants to treat trees and
commits more or less the same way, and another that wants to treat
them in a distinct way, even without considering a new type, how
would your "we have four separate tables" help?  The former user
wants three "commits+trees", "tags" and "blobs" table while the
latter wants four, no?

>> In either way, we would have such bitmap (or a set of four bitmaps
>> in your case) for more than one commit (it is not necessary or
>> desirable to add the reachability bitmap to all commits), and such a
>> "reachability extension" would need to store a sequence of "the
>> commit object name the bitmap (or a set of four bitmaps) is about,
>> and the bitmap (or set of four bitmaps)".  That object name does not
>> have to be 20-byte but would be a varint representation of the
>> offset into the "sorted by SHA-1" table.
>
> How do you reach the bitmap, given its commit sha-1?

Look at the ordered list of SHA-1 in the pack idx file as an array
of 20-byte entries, and find the commit SHA-1 in that array by
Newton-Raphson/bisection.  You have an index into the array that
holds the object name.  You can use it as the local object number
in the packfile.  Then you can find that object number (that is
shorter than 20-byte object name) in your secondary table, no?
