From: Junio C Hamano <gitster@pobox.com>
Subject: Re: blame -L questions
Date: Mon, 08 Feb 2010 19:32:50 -0800
Message-ID: <7vtytrulr1.fsf@alter.siamese.dyndns.org>
References: <76718491002081903s2e37875bs85eeb55779167ce7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 04:33:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Negqd-0008QJ-KW
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 04:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab0BIDdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 22:33:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab0BIDc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 22:32:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A11E97C2E;
	Mon,  8 Feb 2010 22:32:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e47ok/lbevxl6M8WLcL68j/fipg=; b=C38mDq
	W75ynObzO5V4stLNg62H3aUcj+vBcfPvO0E4y3nrzO0siCADoLc0d4GTHTCgjXZI
	D7ANJF9klA9tUKOCbmvYmq8yo5BcgAiNcgPtIuJNyQpE8xmFcpKa43oQPaYrCU9Y
	6nx8bdLBn1fB43dtTicTEC7tKUQFw4zAzzGik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tNvS0qYbk4X2E7/TF/gf2SFnSu+9pQlJ
	O/zz3sQcaEM1k8n+ChxztEQhMmP2whSvk1C4yraTjNXGu6OOIFe5RKyJzIFLvJhS
	npsDYGP59ipisC8wU6UlxTUVV+OHwQ2i9OvBEqmBNxCJohw3dNbfyqmNkz2ogZCt
	MZauqNaMQOM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0939D97C24;
	Mon,  8 Feb 2010 22:32:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 556AA97C1C; Mon,  8 Feb
 2010 22:32:52 -0500 (EST)
In-Reply-To: <76718491002081903s2e37875bs85eeb55779167ce7@mail.gmail.com>
 (Jay Soffian's message of "Mon\, 8 Feb 2010 22\:03\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF4CB094-152B-11DF-B356-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139352>

Jay Soffian <jaysoffian@gmail.com> writes:

> My use case is emitting blocks that are wrapped in
>
> #if defined(WHATEVER)
> ....
> #endif
>
> I was going to use the syntax -L /start/../end/ for this.
>
> I naively thought I might just be able to setup multiple blame_entry's
> linked through the next/prev pointers at the start, but that clearly
> does not work.

The current -L parser is prepared to take only one range, but the
underlying data structure should be able to support what you want to do.

The scoreboard holds one final image (final_buf, final_buf_size) that is
the whole blob in the revision being annotated.  Without -L, we start with
one blame entry in ent that covers the whole lines in this image.  With a
single -L (i.e. the current implementation), this single ent covers a bit
narrower range of lines than the whole file.

    A blame_entry records a range of lines (lno, num_lines) and which path
    from what commit is the current suspect.  We iteratively compare this
    with parents of the suspect to see if we can pass blame for some lines
    in the given range to some parents.  When we can pass blame for the
    whole range, we just update the "suspect" to parent; when we can pass
    blame for some but not for other lines in the range, we break the
    blame_entry into pieces, pass blame to parents for lines that came
    from those parents and declare the current suspect for lines that did
    not appear in any of the parents.

    But this part does not concern you very much.  The only thing you need
    to know for what you want to do is how an ent must be initialized.

You should be able to start with more than one blame entry queued in ent
member of the scoreboard, each representing one range given by an -L
option, and as long as you prime these blame entries correctly, everything
should work just fine.  sb->ent is supposed to be sorted by line number
and not have overlap, but I don't think they have to be contiguous.
