From: Junio C Hamano <gitster@pobox.com>
Subject: Re: {bug} warning: unable to access 'RelNotes/.gitattributes'
Date: Thu, 13 Sep 2012 12:40:39 -0700
Message-ID: <7vy5kd7lu0.fsf@alter.siamese.dyndns.org>
References: <7vpq5qa0w9.fsf@alter.siamese.dyndns.org>
 <20120913123740.GB4287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 21:41:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCFHR-00066K-KP
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 21:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab2IMTko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 15:40:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab2IMTkm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 15:40:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C332989E8;
	Thu, 13 Sep 2012 15:40:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=colsB7cMzDvAUa79/goPXwVhS78=; b=xft+C1
	ulbsMI+1u5ntCyBSkR6K6N60SrreB84NnPltjEiXTG/fJN7iBh5O/qrLMs0or3Iz
	ZLZ+28Nr2HMgI5AHIwnS8gycLOoJcGwx0WqrYuIQTUNDyXk33Ju6m3trSNBo0QOJ
	wyo3+f1/1DSTLHpJckdKbxkqdniZMWzFObv/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tlUpVPeuqFp/AiEjh8Den5k/ZH1vyNOT
	V/KfK/BZ/m0PG6ciC3N2+2Y/JRrvzGnwDYaPwWGRQROadFsr9Fm7Nz8gI2wvHRPK
	H7ZMh795Abjp16Cye83QRQfNAr4mjQS8TaurU8ZRpwKXH/U8Gef1ozdk77Xa/Uqa
	8qCaHVbRrjA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF6D289E7;
	Thu, 13 Sep 2012 15:40:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F09B89E3; Thu, 13 Sep 2012
 15:40:40 -0400 (EDT)
In-Reply-To: <20120913123740.GB4287@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Sep 2012 08:37:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E68F8552-FDDA-11E1-A67A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205416>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 12, 2012 at 11:32:22PM -0700, Junio C Hamano wrote:
>
>> "git repack" started giving the above warning, and I am guessing
>> that the recent 11e50b2 (attr: warn on inaccessible attribute files,
>> 2012-08-21) exposed a bug where we ask stat(2) not lstat(2) by
>> mistake before deciding to append .gitattributes to see if that
>> directory has a per-directory attributes file.
>
> Interesting. I don't get any such warning on repack. And RelNotes points
> to a file, so I'm not sure why stat() would make us think it was a dir.

Interesting.  The command in question is

 git-pack-objects --keep-true-parents --honor-pack-keep --non-empty \
    --all --reflog --delta-base-offset </dev/null .junk-pack

And pack-objects.c::no_try_delta() is given "RelNotes/1.7.4.txt" as
a path (which is very strange), and is trying to see if "-delta" is
set for the path.

Three problems:

 - "rev-list --object --all" does not produce "Relnotes/1.7.4.txt"
   (it does have "Documentation/RelNotes/1.7.4.txt", of course).
   Somebody in this callchain is screwing the name up.

 - Even if the name were correct, we are looking at the path that
   existed in the past.  The value of checking the attributes file
   in the working tree for "delta" attribute is dubious.

 - This is done while traversing the commit list and enumerating
   objects, so even if we have many incarnations of the same path in
   different commits, the attr stack mechanism would only help
   objects in the same directory in the same commit.  Perhaps we
   could do this after collecting all the blobs, check attributes
   for each path only once (in a sorted order so that we can take
   advantage of the attr stack), to reduce the cost of "delta"
   attribute check.

In any case, because the directory that used to exist to house the
blob in it may no longer exist, giving the warning on ENOTDIR that
your 11e50b2 (attr: warn on inaccessible attribute files,
2012-08-21) is a wrong thing to do (assuming that checking the
current attribute setting for historical tree is a sensible thing to
do, that is).

I could check for ENOTDIR to squelch the warning, but I think your
patch uncovered a lot deeper issues.


diff --git i/attr.c w/attr.c
index f12c83f..056d702 100644
--- i/attr.c
+++ w/attr.c
@@ -353,7 +353,7 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	int lineno = 0;
 
 	if (!fp) {
-		if (errno != ENOENT)
+		if (errno != ENOENT && errno != ENOTDIR)
 			warn_on_inaccessible(path);
 		return NULL;
 	}
