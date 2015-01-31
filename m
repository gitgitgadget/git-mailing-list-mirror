From: Junio C Hamano <gitster@pobox.com>
Subject: [Git BUG] Please do not use "-B -M" in "diff" family for now
Date: Sat, 31 Jan 2015 11:12:34 -0800
Message-ID: <xmqqegqaahnh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Jan 31 20:12:50 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHdTN-00079u-71
	for glk-linux-kernel-3@plane.gmane.org; Sat, 31 Jan 2015 20:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639AbbAaTMo (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 31 Jan 2015 14:12:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753395AbbAaTMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2015 14:12:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76AA933249;
	Sat, 31 Jan 2015 14:12:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	xO9TMU/pxYqFWufxdkdG9XuHhQ=; b=b4KOvt71k/qH6+z1NsL3US9G2/8pdvbpc
	yXlzzZtxeyUebospy44Xfx1S5WiEIF+mhcO4wZZUNCAeh8lBhzGnvGynruJ/TY94
	kEdhI+t4gCMq7lp9tr9BsUwPiZ9Uu3+22pnuXDQaAynTP4m2bUvpLgDf2o6hj7gM
	//IN/Br4dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Nuez0lNzTYeqeP1NwdBqJ6q36yKkmQBzfnM0Obv/KwwyL83ir+YofMA/
	/mlAZs/plTPDiTDD5GjEqa4mdCAWy17XS4Y7/I3CYZib2wDF5l+sToOKubsq188p
	Zo3dYifTXu0QtJlLCi6qRjDyjQITO21fCptQf1gx/MwLafz8NIc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C3F433247;
	Sat, 31 Jan 2015 14:12:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6BC133246;
	Sat, 31 Jan 2015 14:12:35 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D8000E6-A97D-11E4-9B6C-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263208>

Please avoid the combination "-B -M" when running "diff" family of
commands, as it can produce incorrect results [*1*] in corner cases.
Use of either "-B" or "-M" by itself is fine, but not both at the
same time.

This problem exists even in Git v1.7.12, and I have no reason to
suspect that it worked correctly in any earlier versions, so I do
not consider it an urgent issue to fix during the pre-release for
upcoming Git v2.3 release.

End of TL;DR.

For a simple reproduction, go to your copy of the kernel tree and do
this:

    $ git diff -B -M v2.6.13 v2.6.12 -- \
        arch/ppc64/kernel/rtas_pci.c arch/ppc64/kernel/pSeries_pci.c >:patch

    $ git reset --hard
    $ git checkout v2.6.13

    $ git apply --cached --whitespace=nowarn :patch
    error: arch/ppc64/kernel/pSeries_pci.c: already exists in index

This is not a bug in "apply", but in "diff".  The resulting patch
looks like this:

    $ git apply --whitespace=nowarn --numstat --summary :patch
    112     5       arch/ppc64/kernel/pSeries_pci.c
     rename arch/ppc64/kernel/{rtas_pci.c => pSeries_pci.c} (81%)

That is, it wants to rename rtas_pci.c to pSeries_pci.c with a bit
of editing.

However, what really happens when going from 2.6.13 to 2.6.12 is
this:

    $ git diff v2.6.13 v2.6.12 -- \
        arch/ppc64/kernel/rtas_pci.c arch/ppc64/kernel/pSeries_pci.c |
        git apply --whitespace=nowarn --numstat --summary
    478     19      arch/ppc64/kernel/pSeries_pci.c
    0       495     arch/ppc64/kernel/rtas_pci.c
     delete mode 100644 arch/ppc64/kernel/rtas_pci.c

That is:

    #1 rtas_pci.c exists in 2.6.13 but not 2.6.12.

    #2 pSeries_pci.c exists in both 2.6.12 and 2.6.13 but is majorly
       rewritten; in fact, the difference between rtas_pci.c in
       2.6.13 and pSeries_pci.c in 2.6.12 is much smaller than the
       difference between pSeries_pci.c from 2.6.13 and 2.6.12.

What seems to happen is that "diff -B" splits the above #2 into
"removal of pSeries_pci.c with contents from 2.6.13" and "creation
of pSeries_pci.c with contents from 2.6.12" and these gets further
combined with the "removal of rtas_pci.c" [*2*].  In the end result,
we incorrectly get "rename rtas_pci.c to create pSeries_pci.c with
some changes".  We shouldn't do this because pSeries_pci.c is not
created and is not a new file.

[Footnotes]

*1* "git apply" refuses to apply the output affected by the bug, so
    at least this will not lead to silent corruption.

*2* The "-B" option was introduced solely to find a possible
    rename/copy source to express this sequence:

    $ cp A B
    $ edit B slightly ;# optional
    $ edit A heavily

as if it was done like this instead:

    $ mv A B
    $ edit B slightly ;# optional
    $ create B from scratch

Without "-B", the change would be expressed as "Heavily edit A,
create B from scratch", and with "-B", we would say "Create B by
copying from A and then edit, and edit A heavily", which would
result in more readable patch (in fact, we would see in the output
of "diff -B -M v2.6.12 v2.6.13" exactly that).
