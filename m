From: Junio C Hamano <gitster@pobox.com>
Subject: [BUG] "git merge-file" mismerge
Date: Tue, 22 Jul 2014 12:19:21 -0700
Message-ID: <xmqqzjg1fbgm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 21:19:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9fb4-0006w7-2y
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 21:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572AbaGVTTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 15:19:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64474 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbaGVTT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 15:19:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BAE12BE73;
	Tue, 22 Jul 2014 15:19:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=O
	0ymnqUaOyPzxW3vXOWarXHqnf4=; b=Dcf09kVIWlaxnacPeIu1hAzlHeKwDI6Sv
	pL0ToZurbdbDFgRo4fQTEFlNmz9GvfoIJpzl1zprWd/J9zsJ319LWrfoUe8KJLmL
	6RfFJX00Y565DKPg2mldj459BcDwXau9FBBJozafcTXEvX/K4x/WAsaOcO7FmaSV
	6f8NFGIMLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=s79
	R0nNM7exw7gToKRA+DdIpypl4SZ9C6tbElMJJ+kjmRLdq4IrGxiF3FQmHcbjob3n
	jkvRXjQkcWhGHqN+98wS1kaOl8dl9KwX1nhPcoVhYTM5Zp9J+E9MIX61A1OWNX+u
	HStINX/pm5tzy0Zqb0pThxz54D6mTXWVlEeuDxlw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01A262BE72;
	Tue, 22 Jul 2014 15:19:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5BE92BE68;
	Tue, 22 Jul 2014 15:19:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 166713E8-11D5-11E4-8F81-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254031>

Consider these three files:

    $ printf "%s\n" A B C D >ours
    $ printf "%s\n" A C B D >common
    $ printf "%s\n" A B D >theirs

Starting from A C B D, our side flips the order of the second (C)
and the third (B), while their side removes the second (C).

The correct three-way content level merge should notice conflict
during this merge, but "git merge-file" that uses xdiff/xmerge.c,
which is meant to be equivalent to "merge" from the RCS suite,
declares that our version is already the correct merge result:

    $ merge ours common theirs
    merge: warning: conflicts during merge
    $ cat ours
    A
    <<<<<<< ours
    B
    C
    =======
    B
    >>>>>>> theirs
    D
    $ printf "%s\n" A B C D >ours ;# revert it back
    $ git merge-file ours common theirs ; echo $?
    0
    $ cat ours
    A
    B
    C
    D


    
    
