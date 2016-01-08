From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should notes handle replace commits?
Date: Fri, 08 Jan 2016 15:51:39 -0800
Message-ID: <xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com>
References: <20160108012830.GA2110@glandium.org>
	<xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
	<20160108214939.GA22801@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:52:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHgpR-0007LV-9l
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 00:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbcAHXvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 18:51:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752162AbcAHXvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 18:51:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E33E3A0E0;
	Fri,  8 Jan 2016 18:51:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N72c3r5gLkQ64fqY/IGMGTBfsrc=; b=MYGglA
	gtJVAx4vb0zL/1W0J+VtT2Dv8wY76Qpix9Ei7b3ADJaJbJ8TnD1zMTxpj6CgnjR+
	ayFZRjxQI+NmVmRRe/izGtZiqRhGQ9cZZstK3z8j5FxYwf9VOPZD4lvX6s/w6EWH
	/2Kp51FOcZxfjo8HiqKAhNTw6y4u3mLx9+Qsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rTueX0rwXjCYm8+G0+owt/jXV8dn/A9a
	Y4kef+mEZjsF2w7kBhlpix32jOVWndusB/2HPQv5B4mUCZA0wcedIT6GJ6wmh68c
	4TGksslsHRZtycHY6cueux9PeE66lPmIg65ZJvIYUQmhVphYVnkX+I1CIOHJImLA
	oEh4bqlUkOg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A0B23A0DF;
	Fri,  8 Jan 2016 18:51:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BFA803A0DE;
	Fri,  8 Jan 2016 18:51:40 -0500 (EST)
In-Reply-To: <20160108214939.GA22801@glandium.org> (Mike Hommey's message of
	"Sat, 9 Jan 2016 06:49:39 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3849A54-B662-11E5-A699-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283589>

Mike Hommey <mh@glandium.org> writes:

> On Fri, Jan 08, 2016 at 12:09:45PM -0800, Junio C Hamano wrote:
>> > So the question is, is this the behavior this should have?
>> 
>> The behaviour is a natural consequence of what graft and replace are
>> about (i.e. "telling Git what the parents of a commit are" vs
>> "telling Git what the contents of a commit are"), so the answer to
>> the "should" question is a resounding "yes".
>
> It's not only about contents, except for a very broad definition of
> contents that includes ancestry.

That is not broad at all.  A Git commit knows about its parents in
exactly the same way as it knows about its tree and its own log
message.  Hashing all of them together, without considering which
part is "broad", gives us the content-addressible filesystem, which
is "stupid content tracker", aka Git.

Perhaps you would see what is going on more clearly if you replace
your "git log" with "git rev-list".

If your pre-graft/pre-replace histories were

	A (first)  <--- B (second)  <--- C (third)	master
	X (rFirst) <--- Y (rSecond) <--- Z (rThird)	old

then your "graft" tells Git "B's parent is Z, not A.  If you run
"rev-list master", it will give you "C B Z Y X".  The discrepancy
(relative to the true history) brought in by "grafting" is that
nowhere in "cat-file commit B" you would find Z, even though "log"
and "rev-list" pretends as if Z is a (and the) parent of B.

Your "replace" tells Git "A records what Z records".  If you run
"rev-list master", it will give you "C B A Y X".

A fake history made by "replace" does not have the same discrepancy
as "grafting"; "cat-file commit B" names A as its parent, and asking
what A is gives what actually is in Z, i.e. "cat-file commit A"
shows what "cat-file commit Z" would give you.  The discrepancy with
the reality "replacing" gives you is that hashing what you got from
"cat-file commit A" does not hash to A (it obviously has to hash to
Z).

> From my POV, replace is more about
> "telling Git that this commit (and its parents) is really that one (and
> its parents)".

Your "POV" does not match reality; replace is about telling Git to
give contents recorded for object Z when anybody asks the contents
recorded for object A.
