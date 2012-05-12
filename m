From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] notes: preserve object type given by "add -C"
Date: Fri, 11 May 2012 23:12:27 -0700
Message-ID: <7vzk9ehqr8.fsf@alter.siamese.dyndns.org>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
 <1336699506-28388-2-git-send-email-pclouds@gmail.com>
 <7vzk9eju4m.fsf@alter.siamese.dyndns.org>
 <CACsJy8Avusvu9LJeg1L=OZ9=qW+FaqbNWfA_rrZJUY_3WqfhOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 08:12:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST5ZM-0001ho-M8
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 08:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab2ELGMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 02:12:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab2ELGMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 02:12:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7161F3CCF;
	Sat, 12 May 2012 02:12:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mtCiMrf45GgLY8fncpXw7kazs+Y=; b=rJoPxN
	HAlNj0ftOveFv4f0txBeKTS/YNOQm1nILjnO91iaHPvQu1bdSU47L/h4oRGV258j
	KF2cd49JA0w8ITy4V4Brty6yBuFLQTXjgLRJX98R0p4+vkPhukYf3TMYlFx/RKwz
	um4vWWY+0HX8aYJK9CZUlYKwtNw2ZxdXmvXmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=upM0C1m+yWO16c7/dO6bIpaNkLUdDJDZ
	maxJVuI0tk4QVIH8lpYt5NH0i7UycZd/tSiMWgtwxi8VftxfyRuF+B5r+9Aud+XL
	aO6mc497w7ibMs7YuBo9wjbh2doFY58VZ5K5OYSKXvPq3OuDraWdw05Z+3kI4jXY
	2KkLG6wGGQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 688343CCE;
	Sat, 12 May 2012 02:12:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A15983CCD; Sat, 12 May 2012
 02:12:28 -0400 (EDT)
In-Reply-To: <CACsJy8Avusvu9LJeg1L=OZ9=qW+FaqbNWfA_rrZJUY_3WqfhOg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 12 May 2012 12:20:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 739DE784-9BF9-11E1-B6E5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197712>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, May 12, 2012 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> It is not automatically "converting"; as far as the notes subsystem is
>> concerned, the data you throw at it to be associated with an object the
>> note annotates has always been uninterpreted stream of bytes. If an
>> application wants to store the raw representation of a commit object
>> including the log message and its header, it has every right to expect
>> that it can use "git cat-file commit $argument_to_the_C_option" as the
>> source of that uninterpreted stream of bytes, doesn't it?
>
> Some part of git-notes expects this stream of bytes to be textual,
> human readable. In that case, "git notes add -C commit/tag"'s stuffing
> a blob with the given commit/tag content to notes tree may make sense.
> Personally I'd rather stuff the commit/tag object instead so no new
> blobs are created. The end result is the same: read_sha1_file() always
> return correct text, so does "git notes show".

No, the end result is definitely not the same.

There are two important characteristics of "uninterpreted byte stream" the
above thinking is not taking into consideration:

 (1) we do not interpret what the application stores; and
 (2) the application is *not* limited by our type system.

Suppose the application happens to want to stuff the contents it took from
a commit object, and "add -C $objecname" is a convenient way to do so.  We
have recorded it as "blob" because it is uninterpreted stream of bytes. If
you record that as a leaf note in the note tree, does that mean the note
tree now suddenly have a submodule?  Hell, no.

What if the application wanted to record the contents of a tree object
instead?  How would that affect the fan-out mechanism the note subsystem
uses to hash the 40-hexadecimal object names?  After descending the notes
tree to consume the object name to reach the leaf node, it still finds
even more level hanging below.  Not very careful "list all object names
that have notes attached in this note tree" implementation may end up
descending into the tree object, because of this patch.  Another bad
implication of such a change is that suddenly we would start including all
the subobjects in that tree object when computing the reachability of the
notes tree.

The application needs to have a way to tell what is in the data it stores
anyway, because it is not necessarily "enhancing git" kind of application
that talks about relationships between git objects.  And it may do so
either by convention (e.g. my "notes/amlog" notes tree only records a
single-line text that is a Message-Id header of the original patch e-mail
commits came from) or by having its own way to identify the application
specific data type (e.g. json, pickle, protobuf, etc.).  It is pointless
to say "Git object types can be stored natively, but there is only one
type of blob so the application needs to find a way to coax the types of
data it wants to store itself."  It needs to do so anyway, and having
native and standardized way only for git object types does not improve the
system.  It only ties our hands going forward because we need to define
what it _means_ to store non-blob types in the notes tree, and support
that forever.

So this 1/4 patch is _not_ a bugfix at all.  It breaks perfectly good
current storage semantics without no good reason.

For that matter, as long as $EDITOR is set to something appropriate for
the application specific data, there is no reason to forbid editing,
either.

The only sensible safety against "oops, I forgot that this notes tree
stores binary gunk" I can think of offhand that won't cripple sensible use
case is to sample the data to see if it is binary and ask confirmation,
similar to how "less" asks "frotz may be a binary file. See it anyway?",
and do so only when we are spewing it to the terminal.
