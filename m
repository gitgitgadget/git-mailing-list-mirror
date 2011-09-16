From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch --set-upstream regression in master
Date: Fri, 16 Sep 2011 15:58:11 -0700
Message-ID: <7v7h58dri4.fsf@alter.siamese.dyndns.org>
References: <CAG+J_DyxNpPevwfrJVkv3GBmv0tEXgW2LZtdHgarFoXb9Qqghw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, conrad.irwin@gmail.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 17 00:58:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4hMV-0001Sn-IM
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 00:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab1IPW6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 18:58:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932454Ab1IPW6S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 18:58:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D24A5FCD;
	Fri, 16 Sep 2011 18:58:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yjFhguZH51roa0Sc1LXjCoOH4FY=; b=xRup5X
	4lTFSm0Lfv8tB30+JOP+8l7PlrsNs3L2l8uetgKQAnZdwlQBAd5tiChqEgFxWIfh
	SaF82KmTGzqSj6kB1c4xBwvvT2syMgwxweIsjY7q3RY6hlCuahcCBzo1ESa8nTI6
	yUgySGTzWuVVdezCdtzn+PGcSJD6HU+j2Lj2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VriPtJ7iHJ2Tg8rxwkZA6f90VMHm3Hpy
	iHJfYD7aOyIOTWqmtnXHvW6Jb441CcdjsunLE6z9HGsCIMqYjGxPRA/TuESFIOW5
	pTKMPpV4t3xB2ZWOFqpXGojUTsdcsz6RfplRXB30cyythvHGTaXbI2sgAraagYtN
	UqmbGIdE8m4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2512D5FCC;
	Fri, 16 Sep 2011 18:58:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F60A5FCB; Fri, 16 Sep 2011
 18:58:13 -0400 (EDT)
In-Reply-To: <CAG+J_DyxNpPevwfrJVkv3GBmv0tEXgW2LZtdHgarFoXb9Qqghw@mail.gmail.com> (Jay
 Soffian's message of "Fri, 16 Sep 2011 17:43:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B30B83C-E0B7-11E0-8E4D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181565>

Jay Soffian <jaysoffian@gmail.com> writes:

> This used to be possible on the checked out branch:
>
>   $ git branch master --set-upstream origin/master
>
> Now it gives "fatal: Cannot force update the current branch." which is
> broken. You should be able to setup/change the tracking information on
> the checked out branch.
>
> It's apparently due to ci/forbid-unwanted-current-branch-update.

Does

	git branch --set-upstream master origin/master

work? If so then I wouldn't worry too much about it (your "arg then
option" should be forbidden in the longer term anyway). If not, we would
need to patch it.

> (BTW, --set-upstream still needs to be fixed so that these mean the same
> thing:
>
>   $ git branch master --set-upstream origin/master
>   $ git branch --set-upstream origin/master master

If we are doing anythning, I think it needs to be fixed not to allow the
former, period.

> .. to just allow:
>
>   $ git branch --set-upstream origin/master
>
> w/o having to specify the checked-out branch.

That may be a nice feature enhancement, post 1.7.7 release.

I took a brief look at --set-upstream codepath, and I have to say that the
implementation is totally broken with respect to an existing branch.

Given

	$ git branch master --set-upstream origin/master

it passes the exact same codepath as

	$ git branch master origin/master

uses, only with a different "track" flag, no?  That is, it calls a
function that is meant to _create_ branch "master" from given branch point
"origin/master", namely create_branch().  And then create_branch(),
contrary to its name, is littered with "dont_change_ref" special case to
work it around, depending on the value of "track".
