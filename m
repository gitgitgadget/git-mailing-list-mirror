From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/2] push -s: receiving end
Date: Thu, 08 Sep 2011 09:43:40 -0700
Message-ID: <7vvct3x9vn.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vehzrzm0e.fsf@alter.siamese.dyndns.org>
 <7v7h5jzj8o.fsf_-_@alter.siamese.dyndns.org>
 <201109081131.58362.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:01:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nbY-00077n-Rv
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab1IHXBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:01:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686Ab1IHXBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0454B5D56;
	Thu,  8 Sep 2011 12:43:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/wM8wg+cdOnAK+PSNZfTbAKZ/Wg=; b=REosux
	Yscl9+u4jlD/N0M9NNv8uM/aiGOdwz1m62jzJWYwD/cOta6PwiCtYJ5srPrjN8T8
	3GEowMkT1qZFxxV9V0iHC+517u2ZlC5HLorr4mOqZn7aXrmJhGpjNCSplU38MPaH
	OFfv6x1m6O4QbZoZZJwjlvW2hqpGzPEYOp0ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPBhwoU2ZN66sa0Mepb+8CZx2bMKQ8a+
	hXGxEhdSu3SpmbOawRvROkl3aFBmlNvOQsl2RBsKmkBNCBXK3EaLTcC8SZB0O2BE
	c9klDmsi5Wl5AW2oMpGOebgfCKLxQpJX8uGhqt38qWCot755OvwdxQUmVyXjGQao
	rI8LwUONt3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFB155D55;
	Thu,  8 Sep 2011 12:43:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63FC75D53; Thu,  8 Sep 2011
 12:43:42 -0400 (EDT)
In-Reply-To: <201109081131.58362.johan@herland.net> (Johan Herland's message
 of "Thu, 8 Sep 2011 11:31:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6192434-DA39-11E0-BD9A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180993>

Johan Herland <johan@herland.net> writes:

>> +static void get_note_text(struct strbuf *buf, struct notes_tree *t,
>> +			  const unsigned char *object)
>> +{
>> +	const unsigned char *sha1 = get_note(t, object);
>> +	char *text;
>> +	unsigned long len;
>> +	enum object_type type;
>> +
>> +	if (!sha1)
>> +		return;
>> +	text = read_sha1_file(sha1, &type, &len);
>> +	if (text && len && type == OBJ_BLOB)
>> +		strbuf_add(buf, text, len);
>> +	free(text);
>> +}
>> +
>
> What about adding this function to notes.h as a convenience to other 
> users of the notes API?

I actually was hoping to hear that I do not have to do this "check
existing and concatenate", and should let the add_note() function
run its default combine_notes method to do the concatenation.

I found a few things I wasn't quite sure in the notes/notes-merge API, by
the way.

 - The combine_notes callback is run when a note is inserted into the
   in-core notes tree. I felt that this is way too early if you want to
   avoid racing with another process (and the patch tries to wrap
   create-notes-commit with lock-ref/write-ref-sha1 pair), but perhaps
   this is to deal with a case where the calling program calls add_notes()
   on the same object multiple times.

 - create_notes_commit() dies under a few conditions, but some callers
   that are recording advisory/optional notes might want to get an error
   and continue.

I think ideally this patch should handle notes like the following, which
is not quite how I coded it:

 - initialize in-core notes tree;

 - add bunch of notes, without regard to the existing ones, to in-core
   notes tree by calling add_notes();

 - lock the notes ref and read the "parent"; we may want to add "wait and
   retry for a few times until we get the lock" support at lockfile API
   level, but doing it at the application level would be fine.

 - call create-notes-commit, which in turn merges the in-core
   notes with what collides with those already in "parent" by
   calling the combine-notes callback, merges and re-balances
   the notes tree, and makes a notes commit object;

 - update the notes ref with that notes commit, releasing the lock on
   the ref.
