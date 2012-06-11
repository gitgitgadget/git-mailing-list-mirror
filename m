From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 15:45:45 -0700
Message-ID: <7vfwa15uxy.fsf@alter.siamese.dyndns.org>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
 <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr> <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com> <7vaa097k3q.fsf@alter.siamese.dyndns.org> <CAMUXYmUg12z8LUcFKwjH0Utrvxx0fa5Sne0u9adgoZ=oooBbig@mail.gmail.com> <7vobop5zmp.fsf@alter.siamese.dyndns.org> <7vk3zd5y8d.fsf@alter.siamese.dyndns.org> <20120611214705.GC32061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Cl=C3=A1udio_Louren=C3=A7o?= <pt.smooke@gmail.com>,
	Leila <muhtasib@gmail.com>, konglu@minatec.inpg.fr,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:45:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeDMu-0002hx-JV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 00:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab2FKWps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 18:45:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab2FKWpr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 18:45:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2773B8358;
	Mon, 11 Jun 2012 18:45:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V5DtppEQBpoP4lUdqp20lGpC6aI=; b=egsdd9
	csl8KCtNIJrRb86UA7U6by+tkd7oR0U2WrTmJybPgyxzIWqbOLmnDx4I2vzZhHKP
	vfO8KFzLCp5YshFviV1JwsERnrnou4UARUkObjg9i7pVbJjFDTdTwwrIZV6GQ+R4
	s5Z9KitBQyFDENL6qjItoe5tPcfm3uJVjegpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OyaDelgXIyb2ldj1Azeog6hVQuGL1yy4
	QI9BQetb3ZejjQMzuI0WmowU8+lEzAMKKC37R2+OVJhDI4+piC8fu+g9XzpflaYj
	dyuIdI2HydfkuNo7Z4AUGiNUNAQX/nOFFVdLNgNb5e8/eWjEyQRBCrZCS4Ni6zQt
	jZZvtfxAn5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E5968357;
	Mon, 11 Jun 2012 18:45:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 816B68356; Mon, 11 Jun 2012
 18:45:46 -0400 (EDT)
In-Reply-To: <20120611214705.GC32061@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Jun 2012 17:47:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F1BD072-B417-11E1-8F28-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199749>

Jeff King <peff@peff.net> writes:

> I think the problem is in verify_clean_subdirectory, which checks that
> we do not have untracked files in the subdirectory, nor modifications
> between the index and working tree. But I do not see it checking whether
> we have modifications from the HEAD.

I actually think "comparison with HEAD" is a red herring.  As long
as the version in the index matches the version in the other branch
we are checking out, it does not matter if the version in the index
is different from the version in HEAD (case 4).  Also if the version
in the index is new and neither HEAD nor the other branch has it, we
should keep it (case 2).  And we should error out if these are not
possible.

I did a bit more digging on this; even though I am not going to
continue it further today, here is a snapshot of my current
thinking.

After replacing "something" with "something/f1" in the index,
attempting to "read-tree -m -u master b" (which is what checkout is
about) decides that the regular file "something" should not exist,
because it is in "master" but not in "b", so it calls

	deleted_entry(ce = master's version, old = NULL)

where "old" is the version of "something" in the index, i.e. "does
not exist".  This in turn calls verify_absent(ce) to make sure that
it is OK to remove regular file "something".  verify_absent() checks
the path "something" with lstat(), and it would be happy if there
weren't "something", as there won't be anything necessary to do in
that case.

But it finds a directory.  It calls check_ok_to_remove() on it.
This is where things go wrong.  This function is to see if it is ok
to nuke the entire directory "something", for the more common case
where we are about to create a different "something" there. It is an
appropriate check if we were trying to create a version of regular
file "something" from the branch we are trying to check out, but it
is a wrong thing to do when we are not interested in touching
"something" in any way.  We do not have regular file "something"
now, and after checking out the branch, we do not want to have
regular file "something" there, either ---so all we have to do is to
do nothing!

Instead, it says "Ah, something/f1 is clean", sets o->cache_bottom
to skip it, and the machinery loses sight of that path.

Probably we need to vet the caller of verify_absent() to see why
each caller wants to call it.  Some may be about to create a new
thing there, and really want to make sure there is nothing there
after they are done.  But this caller, when it _knows_ the path is
already removed (it can tell in check_ok_to_remove() after lstat()
says there is a directory "something" there---at that point we know
the regular file "something" cannot be there), should just be happy
and let the later callers to look at the remaining cache entries
without marking everything under something/* has been processed.

Or something like that.
