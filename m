From: Junio C Hamano <gitster@pobox.com>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Tue, 16 Oct 2012 13:09:07 -0700
Message-ID: <7v391erxgc.fsf@alter.siamese.dyndns.org>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
 <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
 <20121015183438.GB31658@sigill.intra.peff.net>
 <507D4651.6080207@lsrfire.ath.cx>
 <20121016173254.GD27243@sigill.intra.peff.net>
 <20121016175806.GB26650@thunk.org>
 <20121016182751.GA30010@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 22:09:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TODS9-0008SZ-Ch
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 22:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab2JPUJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 16:09:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab2JPUJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 16:09:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C762B9BFC;
	Tue, 16 Oct 2012 16:09:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Et2AewJtqeok4fUYFWBhKmR2SxQ=; b=GQfycv
	t8r8AA/J0xnFlDBZeSpJ7wQ9ClZjSatDdUoE5Ok6se5WpI+9gSzDIBQbxHLwUCgZ
	mr3uh8o3l0fA6qT97pbSRzGN010wgTNxW0cn35FBW3TrcQU4VUd+kDYV3FmwR6iH
	618BlK5paARfn7QC5BHloG+e7Gjuj7RkI0aog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSYO0R3lhB8gQuhEc4mey/ppN0agHwBL
	RguBQBhVbzQGYXuucESbXPUx6e+Fg7jV/ZPAdB3Snvjat1eVLnIppbMcPMFjcphj
	C05K+BE/+AY3u6FOluHedNDr31gq5zdxy8dwMWIPPvxcRFYk68zghS+tQcmWqnlI
	NjDT84Zqa54=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B25A29BFB;
	Tue, 16 Oct 2012 16:09:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8E699BF7; Tue, 16 Oct 2012
 16:09:08 -0400 (EDT)
In-Reply-To: <20121016182751.GA30010@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 16 Oct 2012 14:27:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58339B92-17CD-11E2-9AD7-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207878>

Jeff King <peff@peff.net> writes:

> A much bigger problem is the other places we reference sha1s. The
> obvious place is trees, which have no room for backup pointers (either
> in headers, or with a NUL trick).

This is a tangent (as I do not have anything particularly worth
adding on top of what have already been said around the exact
SHA-[123] topic), but we probably would want to start thinking about
the tree object format "v2" at some point.

Some random thoughts:

 - It is OK if existing versions of Git barfed when asked to read a
   tree object in the "v2" format.  The repository format version
   may need to be bumped up when writing such an object, and
   transfer protocols need to pay attention to it, to avoid
   transferring history with objects in newer representation to
   repositories with older repository format version.

 - We do not need a new "tree v2" object type.  Existing versions of
   Git will barf upon seeing such an object, but that won't be the
   only way to prevent existing versions of Git from misinterpreting
   a tree object recorded in the "v2" format as if it were in the
   current format (e.g. a non-octal in the mode field of the first
   entry causes tree-walk.c::get_mode() to barf).

 - We do not mind two tree objects that encodes the same tree in the
   current and the enhanced formats to have different object names.
   In fact, we care more about the object names derived purely from
   the content of the object as an uninterpreted bytestream, so it
   is expected that they have different object names.

   This will make the path-limited traversal and diff to open more
   trees unnecessarily at the "version bump" boundary in the
   history, but that is normal (think of a project that used to
   record its text files with CRLF and one day decides to convert
   everything to LF; the trees before and after the conversion will
   record logically the same contents "git show" should give an
   emptyness, but the diff machinery needs to go into contents at
   the flag day boundary).

   As long as we do not let random "extension of the day" into the
   new format willy-nilly, the resulting history will still be
   useful and usable.  From that point of view, no parts of the
   additional information we would record in the updated format that
   is not present in the current format should be optional (iow,
   once you decide to use the "v2" format to record a certain tree,
   you will produce an identical and reproducible representation in
   "v2", regardless of your implementation).

All of the above are issues for Git 3.0 and beyond, though ;-).
