From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Mon, 03 Sep 2012 13:16:52 -0700
Message-ID: <7voblmeua3.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org>
 <5041BC94.7000304@gmail.com> <504214AA.9080706@kdbg.org>
 <50425F8B.5020406@gmail.com> <7voblognny.fsf@alter.siamese.dyndns.org>
 <5044D162.1010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 22:17:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8d4z-0003yF-5d
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 22:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584Ab2ICUQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 16:16:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34849 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371Ab2ICUQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 16:16:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD4BD9BED;
	Mon,  3 Sep 2012 16:16:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GfJQnuZphjzDIfvBeLoikVl9t5A=; b=CI7nPb
	2glMNmvIu1I07ULf2HRNlWGpJxD3Ldg7v6n6/vL5LCVMuvMbuOnqWdH7JQ0vZrdd
	6aBez/8PgmnPZWvssd56yU8P7BBA364nAm3UqhEqL72/92DpnrOHoEXol+jcLCyy
	uFo5uviU+YkmZsIr3I5d6zgE4qREDeyrKZ2e4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayM76EXN9IZZhNprLhzJiCY+6y19wG7z
	16IQaYSnEaQydNcR8ARBvbR6MYjltyxBNbVMV9vRFj7x2Y30rAEFNsuqnS8GBL97
	ffG4gpxj/mC4Dsk8fwdnb0Ayv+0gSygdE/NRs7F9Ohy2GkVdhx0wBjJYIsyXT1FR
	tmjd2sT2z40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB5EF9BEB;
	Mon,  3 Sep 2012 16:16:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E7239BE9; Mon,  3 Sep 2012
 16:16:54 -0400 (EDT)
In-Reply-To: <5044D162.1010608@gmail.com> (Marco Stornelli's message of "Mon,
 03 Sep 2012 17:48:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DAD3614-F604-11E1-8C17-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204710>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> I tried the Johannes's script, but it seems it doesn't work well with
> the pattern of format-patch (To: <mail1>,\n   <mail2>,\n
> <mailN>). The multilines are not well managed.

I am guessing that the reason why Jonahhes's "copy our headers out
with continuation lines intact" approach does not work is because
Thunderbird does not want to see its own header part (i.e. that
which comes before that $SEP) contain RFC-2822 style continuation
lines.

Can you grab a typical input (i.e. the contents of what is passed as
$1 to the appp.sh script) and show us how it looks like here so that
we can take a look?  It would be fine to paste the contents, but we
might want to protect it from MUA by doing an attachment or a
pastebin URL.

It appears that the original script tries very hard to keep the
Subject: line at the beginning, but I am not sure if that is because
Thunderbird wants to read its "$1" that way, or it is just that
original appp.sh script happened to be written that way without real
reason.  If I were updating this script, what I would do would be
more like:

    0. Open a temporary output file $OUT, input filehandle $IN from
       ${PATCH}, and another input filehandle $TEMPLATE from "$1"

    1. Read from $IN starting from the second line (i.e. skip the
       first line "From [0-9a-f] Mon Sep 17 00:00:00 2001" magic
       marker) upto the empty line, coalescing the RFC-2822 style
       continuation lines into one long line each.

    2. Output the above into $OUT, while applying your "header field
       name translation" (e.g. "Oggetto") and remembering what
       header you wrote out.

    3. Read from $TEMPLATE up to a line that matches the following
       pattern:

	/^-=-=-=-=-=-=-=-=-=#.*#=-=-=-=-=-=-=-=-=-$/

       reject headers that step 2. already emitted, and emit other
       headers to $OUT.  Also emit that line that matched the above
       SEP pattern to $OUT (by doing so, you do not have to care how
       "Don't remove this line" is spelled in the user's language).

    4. Resume reading from $IN and copy to $OUT, including the patch
       separator "---", and stop copying.

    5. Read the remainder of $TEMPLATE and copy to $OUT.

    6. Read the remainder of $IN and copy to $OUT.

    7. Rename the temporary file that was connected to $OUT to "$1".


       
