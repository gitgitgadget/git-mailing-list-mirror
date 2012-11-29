From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Thu, 29 Nov 2012 11:13:07 -0800
Message-ID: <7vzk20p6ik.fsf@alter.siamese.dyndns.org>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
 <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
 <1354213975-17866-2-git-send-email-martinvonz@gmail.com>
 <7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:13:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9Y6-0000M7-Es
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab2K2TNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:13:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab2K2TNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:13:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1C3971F;
	Thu, 29 Nov 2012 14:13:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PwcpIkETkucbeUCCYvPJ1XcJeDQ=; b=g22p8a
	5sjC/4aODWJgEEXZvyX0T0jBPZK2Gi04ZNE9kLuspeBWc9f4mYhVNlZIWuEvW7u0
	147f5ePmHNj6y6Cwnc3qgA4CHUhd/2ReneYB7UX7+uh6Y5vwddRy2Cbx2KDE3n3S
	3fAZ4c282j5y42TWYRCQkXvqU1dIpQVwwYvm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzBTHBL5hKXmcLcnJ3B+PBSXvbZOT6PC
	ESpvQkf5JC/xUvMRncVGCqOs9+Qm6PdsmXObcysKqmMXPU1pkEFjV5t9YSODILkF
	biKeXmC/bZBxxUmroBLIdv1wFFV3noaQCW0xq2eS4hXJilksDh/5yNZ6XXgzvamX
	0CAdNa9ZNbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CAE2971E;
	Thu, 29 Nov 2012 14:13:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6768971A; Thu, 29 Nov 2012
 14:13:08 -0500 (EST)
In-Reply-To: <7v4nk8qmaj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 29 Nov 2012 10:47:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF792282-3A58-11E2-B3F2-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210866>

Junio C Hamano <gitster@pobox.com> writes:

> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> In cases where HEAD is not supposed to be updated, there is no reason
>> that "git reset" should require a commit, a tree should be enough. So
>> make "git reset $rev^{tree}" work just like "git reset $rev", except
>> that the former will not update HEAD (since there is no commit to
>> point it to).
>
> That is a horrible design I have to nack, unless you require
> pathspec.  You cannot tell what "git reset $sha1" would do without
> checking the type of the object $sha1 refers to.  If you do this
> only when pathspec is present, then the design is very reasonable.

The above applies to an _arbitrary_ $sha1.

Allowing "reset $tree -- $pathspec" is a very good addition in the
same sense that "git checkout $tree -- $pathspec" is useful.  These
two commands, "reset" and "checkout", share that the source we grab
the blobs out of only need to be a tree and does not have to be a
commit, and the only difference between them is where the blobs we
grabbed out of that tree go, either only to the index or to both the
index and the working tree.

But I do not think it is connected, at least at the level the end
users perceive, to the issue of "reset" issued while on an unborn
branch.

If you limit the scope of the behaviour change exposed to the end
users so that you would make

	$ git reset [HEAD]

act as a short-hand for

	$ rm -f $GIT_DIR/index

when HEAD points at an unborn branch, and similarly make

	$ git reset --hard [HEAD]

act as a short-hand for

	$ rm -f $GIT_DIR/index
        $ git clean -f -d

in such a case, I do not think it is unreasonable at all.

In such a case,

	$ git reset --soft [HEAD]

would become just a no-op.  Earlier you were on an unborn branch,
and after "reset --soft", nothing changes.

Hmm?
