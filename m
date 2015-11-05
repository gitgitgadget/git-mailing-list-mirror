From: Junio C Hamano <gitster@pobox.com>
Subject: Re: File owner/group and git
Date: Wed, 04 Nov 2015 18:38:40 -0800
Message-ID: <xmqqoaf9891r.fsf@gitster.mtv.corp.google.com>
References: <1446689037.4131.47.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 03:38:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuARt-0004cS-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 03:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031843AbbKECip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 21:38:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031791AbbKECin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 21:38:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2437429124;
	Wed,  4 Nov 2015 21:38:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s9Gf7n+PJDkQUFl9hm7nMRqH7PQ=; b=lhgiGA
	JfspJN/HUwaISItgMvkvQlreR+RMoRXZXwIzh/lvg7IYYs0JjXfrDNH2c9QQo+eR
	nyq0hcQhWZPOmKKT/Y8bkO1EEa5L4pR7rnj4xYRL2joyje6fdIeTW6wK+hsEeZpv
	Iymy19w0xgNJjghzXW464H/l7xoGgSX9AAfDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZKVwkc8f49br0emrBpZjUtZGIr1QrHWl
	DHQ2WIA5C7nzr5Ml+zuAo6mE44DsFgks6k+4EhkgyFRB6mDLWpAoGDUsi3EDGTcL
	CEVX9kXS7e/rJ3kkifRPoVflKjpm2SCF3/kWqORXzTeNFEnW/TMi/Ix2tG4zr+XK
	pPJWbd82faM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C18D29123;
	Wed,  4 Nov 2015 21:38:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9995A29122;
	Wed,  4 Nov 2015 21:38:41 -0500 (EST)
In-Reply-To: <1446689037.4131.47.camel@twopensource.com> (David Turner's
	message of "Wed, 04 Nov 2015 21:03:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 538E5282-8366-11E5-B834-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280895>

David Turner <dturner@twopensource.com> writes:

> In unpack-trees.c, in verify_uptodate_1, we check ie_match_stat.  This
> returns OWNER_CHANGED if a file has changed ownership since the index
> was updated.  Do we actually care about that particular case?  Or really
> anything other than DATA_CHANGED?

That's a 10-year old code and there aren't that many people left
who can answer the original rationale, I am afraid ;-)

In general, "Do we actually care?" is not the question we ask in
this area of the code.  "Does it help us to catch real changes, or
does it change spuriously to make it too unreliable a signal to be
useful?" is the question that drives the design of this part of the
system.

DATA_CHANGED is "we know the contents are different without even
looking at the data".  If the size is different from the last time
we hashed the data, the contents must have changed.  The inverse is
not true (and that is half of the "racy git" issue).

Other *_CHANGED are finely classified only because originally we
didn't really know which are useful to treat as notable change
event, and "changed" variable had sufficient number of bits to hold
different classification, so that we could pick and choose which
ones we truly care.  We knew MTIME was useful in the sense that even
if the size is the same, updated mtime is good enough indication
that the stuff has changed, even to "make" utility.

INODE and CTIME are not so stable on some filesystems (e.g. inum may
not be stable on a network share across remount) and in some
environments (e.g. some virus scanners touch ctime to mark scanned
files, cf. 1ce4790b), and would trigger false positives too often to
be useful.  We always paid attention to them initially, but there
are configurations to tell Git not raise them these days.

OWNER probably falls into a category that is stable enough to be
useful, as the most likely way for it to change is not by running
"chown" on the file in-place (which does not change the contents),
but by running "mv" to drop another file owned by somebody else to
the original location (which likely does change the contents).  At
the same time, "mv" a different file into the path would likely
trigger changes to INODE and MTIME as well, so it cannot be more
than belt-and-suspenders measure to catch modification.  In that
sense ignoring OWNER would not hurt too much.

If it changes spuriously to make it too unreliable a signal to be
useful, it certainly is OK to introduce a knob to ignore it.  It
might even make sense to ignore it unconditionally if the false hit
happens too frequently, but offhand my gut reaction is that there
may be something wrong in the environment (i.e. system outside Git
in which Git runs) if owner/group changes spuriously to cause
issues.
