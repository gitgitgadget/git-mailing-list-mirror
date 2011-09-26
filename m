From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply/am whitespace errors
Date: Mon, 26 Sep 2011 12:44:28 -0700
Message-ID: <7vzkhr142r.fsf@alter.siamese.dyndns.org>
References: <CALFxCvxxbsgZnhqK9nN7h=1ASJzfDJ7aVF+rM-8RUyKhpv8FzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: neubyr <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 21:44:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8H6R-0001kB-QA
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 21:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab1IZTob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 15:44:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab1IZToa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 15:44:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F19B45C9;
	Mon, 26 Sep 2011 15:44:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ck0NZO6L77fbtKhhypfjU2vAFLw=; b=ldtNs/
	unQVpG6zI3EFeblR2mAVc4BdOxIa/WG1aV+sqkNQhOBU/zrOgyhu9Xldi09mngmo
	Jix/HT3MTwpvG0FveflJNikQkChrywdUkaut4Rd5J85+iJC1BzhqSB6QG805XFag
	mTOhsDPLtOAHKR+O9KO69GDQy0qw5XyODqSIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJbyIBZSjicss4a/pqIXnquSHtm60YZy
	l5UVMHpLJMrzvueb5lQzTlhuMeLY/o7liomt0OcnsMBB6zDAlX5QEVIuwogZ1gfG
	/a9QE1UASm/1PVtAAqA6DoIOL4b9qFoYx8An60aXQ1mBrnuUDPPn9blxFFEbP2bG
	bOYUY8PPEak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 151AD45C8;
	Mon, 26 Sep 2011 15:44:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9943E45C6; Mon, 26 Sep 2011
 15:44:29 -0400 (EDT)
In-Reply-To: <CALFxCvxxbsgZnhqK9nN7h=1ASJzfDJ7aVF+rM-8RUyKhpv8FzQ@mail.gmail.com>
 (neubyr@gmail.com's message of "Mon, 26 Sep 2011 14:03:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2FAB51A-E877-11E0-B8EC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182156>

neubyr <neubyr@gmail.com> writes:

> I am getting  following error while applying a patch using git-apply.
>
> {{{
> /tmp/patches/ticket11/0002-Commit-for-ticket-11.patch:51: new blank line at EOF.
> }}}
>
> What does number '51' after colon ':' indicate?

Looks like "apply --whitespace=error" is not reporting the optimal line
number for the blank at EOF case.

It ideally should point at the line number of the offending patch in the
input patch file (i.e. "cat -n .git/apply-rebase/patch" would show the "+"
line that adds a blank line on 51th line), but it seems that it instead
points at the beginning of the hunk that introduces the issue.

E.g. if we add an empty line at the end of COPYING (which is 360 lines
long), we would get a patch file that looks like this:

     1	diff --git a/COPYING b/COPYING$
     2	index 536e555..ccf4c7f 100644$
     3	--- a/COPYING$
     4	+++ b/COPYING$
     5	@@ -358,3 +358,4 @@ proprietary programs.  If your program is a subroutine library, you may$
     6	 consider it more useful to permit linking proprietary applications with the$
     7	 library.  If this is what you want to do, use the GNU Lesser General$
     8	 Public License instead of this License.$
     9	+$

and "git apply --whitespace=error P.diff" would report the hunk that
begins at line 5 is wrong:

     P.diff:5: new blank line at EOF.
     +
     fatal: 1 line adds whitespace errors.

when the true offending line is at line #9.
