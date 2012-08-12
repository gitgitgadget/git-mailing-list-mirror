From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Sun, 12 Aug 2012 12:49:56 -0700
Message-ID: <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 <7vtxw8exii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:50:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0eBb-0004jI-CO
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 21:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2HLTuC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Aug 2012 15:50:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab2HLTuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2012 15:50:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB80E651F;
	Sun, 12 Aug 2012 15:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WAQ3y3thQUwT
	+Cosg1m8X+V3SAU=; b=l/U9SxL7jGrUoNaFzjxGrynRPKwDV5Xk0i+x+H89sc0E
	rPuiMy4WpkFXYDWGb3ijBCtZksTBcVibw/LUFxqiD3HSrs8Ehk+/eoOxTPoGxiJs
	1I2bdQ7HdAESGlsmRbwP4btTokv07ACtSYSXuZQKf+LkG3L6xEufu888dzeGLeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wStIim
	zuvlRktnJBzH03n9BgXb0wxAIROy1AejzYciaf4XJbHMrQwlZl1SLwo2HeBlRl4Q
	T63tAEha+wGdbtCY//u9MIE13U/2ZeKFrNLRN6ACPKgXXFXDLds9X1QfqwiLrWwL
	43NxbA2gx/5bDZeqYWJqox9FFfjcNx2e28uKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA2B6651E;
	Sun, 12 Aug 2012 15:49:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EAD7651C; Sun, 12 Aug 2012
 15:49:57 -0400 (EDT)
In-Reply-To: <7vtxw8exii.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 12 Aug 2012 12:11:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5182658-E4B6-11E1-A385-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203317>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> The main reason to group objects by type is to make it possible to
>> create another sha1->something mapping for a particular object type,
>> without wasting space for storing sha-1 keys again. For example, we
>> can store commit caches, tree caches... at the end of the index as
>> extensions.
>
> Why can't you do the same with a single "sorted by SHA-1" table?
>
> Not impressed yet.

The above should be "Not impressed yet, as it lacks sufficient
explanation of possible future benefits, but the idea is
interesting."

=46or example, the reachability bitmap would want to say something
like "Traversing from commit A, these objects in this pack are
reachable."  The bitmap for one commit A would logically consist of
N bits for a packfile that stores N objects (the resulting bitmap
needs to be compressed before going to disk, perhaps with RLE or
something).  With the single "sorted by SHA-1" table, we can use the
index in that single table to enumerate all reachable objects of any
type in one go.  With four separate tables, on the other hand, we
would need four bitmaps per commit.

Either way is _possible_, but I think the former is simpler, and the
latter makes it harder to introduce new types of objects in the
future, which I do not think we have examined possible use cases
well enough to make that decision to say "four types is enough
forever".

In either way, we would have such bitmap (or a set of four bitmaps
in your case) for more than one commit (it is not necessary or
desirable to add the reachability bitmap to all commits), and such a
"reachability extension" would need to store a sequence of "the
commit object name the bitmap (or a set of four bitmaps) is about,
and the bitmap (or set of four bitmaps)".  That object name does not
have to be 20-byte but would be a varint representation of the
offset into the "sorted by SHA-1" table.  That varint representation
would be smaller by about 3.5 bits if you have a separate "commit
only, sorted by SHA-1" table (as the number of all objects tend to
be 10x larger than the number of all commits that need them).  For
the particular case of "we want to only annotate the commits, never
other kinds of objects" use case, it would be a win.  But without
knowing what other use cases we will want to use the "object
annotation in the pack index file" mechanism for, it feels like a
premature optimization to me to have four tables to shave 3.5 bits
per object.
