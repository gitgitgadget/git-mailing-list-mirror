From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update, and clear up the pack format documentation a bit
Date: Sat, 05 Apr 2008 16:58:33 -0700
Message-ID: <7vlk3rvopi.fsf@gitster.siamese.dyndns.org>
References: <20080405180759.GA29710@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Peter Eriksen" <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Sun Apr 06 01:59:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiIIV-0007EY-AV
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 01:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbYDEX6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 19:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754794AbYDEX6u
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 19:58:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbYDEX6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 19:58:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC43B8135;
	Sat,  5 Apr 2008 19:58:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EA69180F4; Sat,  5 Apr 2008 19:58:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78869>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> The current documentation does not mention the ofs_delta pack
> object type. This patch is also supposed to make the text a bit
> more readable, since it moves the object entry header
> description earlier.
>
> I fixes one error in these lines:
>
>         If it is DELTA, then
>           20-byte base object name SHA1 (the size above is the
>                 size of the delta data that follows).
>
> The size given in the object header is actually the inflated size
> of the delta data that follows,...

Your understanding is correct.  Throughout the pack-objects program,
delta_size is always expressed in uncompressed number of bytes.  The
original description you quoted above does not even say "the size of the
delta data (compressed)", so in that sense I do not think the original
description is really an error; if the update makes the description
clearer that would be good.

>     - The header is followed by number of object entries, each of
>       which looks like this:
> +     
> +     An n-byte header encoding the
> +         type of the object

Hmm.

This is just terminology, but I think calling ref-delta and ofs-delta
"type of object", is confusing.  This "type" field is about object
representation in the pack.

There are "undeltified" representations (4 object types), "ref-delta" and
"ofs-delta" representations.

> +         length of the object before compression

And this is the length of the representation specific data.

 - for undeltified representations of the four object types, this
   size is the size of the _object_;

 - for deltified representations, this is _NOT_ the size of the _object_
   (i.e. final object data after applying the delta).  This is the size of
   the delta data to be applied to the delta base, and does not include
   the base object name (for ref-delta) nor size to represent the offset
   (for ofs-delta).
> +          
> +     The format of the header:
> +	1-byte size extension bit (MSB)
> +	       type (next 3 bit)
> +	       size0 (lower 4-bit)
> +        n-byte sizeN (as long as MSB is set, each 7-bit)
> +		size0..sizeN form 4+7+7+..+7 bit integer, size0
> +		is the least significant part, and sizeN is the
> +		most significant part.
> +
>  
> +     The header is followed by:
> +
> +     (for object types: commit, tree, blob, and tag)
>       compressed data

Correct.

> +     (for object type ref_delta)
>       20-byte base object name
>       compressed delta data
> + 
> +     (for object type ofs_delta)
> +     n-byte offset (n*7-bit as above, but with size0 being 7 bit)     
> +     compressed delta data

Correct.
