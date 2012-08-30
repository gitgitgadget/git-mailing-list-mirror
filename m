From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame shows wrong "Not commited yet" entries
Date: Thu, 30 Aug 2012 14:32:47 -0700
Message-ID: <7v7gsgqd4w.fsf@alter.siamese.dyndns.org>
References: <1055159053.19198.1345536909730.JavaMail.ngmail@webmail24.arcor-online.net>
 <303882026.440710.1346315214352.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7CMD-0000ls-UH
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 23:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab2H3Vcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 17:32:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495Ab2H3Vcu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 17:32:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE5978F63;
	Thu, 30 Aug 2012 17:32:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=weA6bhFR5s2e8ouUGAYHna4QJ/M=; b=Et3Rj3
	oITXV8J5jFnRmRWEB3+Y1ThLiSqiBYt1IliUi7jdY4c+T1MuURXSsB0PWVk8RzUq
	TKvNgiMNnuwm/1Bb8TSyAA0lz3vMjaAj+gAKH9vKFKptnlOqHMHZ2OduwTxXGoR3
	mz+AFB1tE82QgDM6t6li383FHO2ZM50WeauvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CoeeRXyEqZktXsEhwAyUSfB8IlAlg1Bl
	bdYSXIjxz8UJeYuDQfpzRb+ECjOe1dAKimwfgE1kO51lIhzmxI/xuhfrC0MMSA9O
	DAx333623NmteSyalXUasXTAts9LOFBuMs3r7fAOoAwYzSPSDOdpdXmJIbsU/m9y
	vNix6qc20XA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC5DB8F62;
	Thu, 30 Aug 2012 17:32:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47E228F61; Thu, 30 Aug 2012
 17:32:49 -0400 (EDT)
In-Reply-To: <303882026.440710.1346315214352.JavaMail.ngmail@webmail08.arcor-online.net>
 (Thomas Ackermann's message of "Thu, 30 Aug 2012 10:26:54 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F1DDA30-F2EA-11E1-8725-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204567>

Thomas Ackermann <th.acker66@arcor.de> writes:

> I am using MsysGit 1.7.11 on WinXP 32 bit and experience the folllowing strange behaviour:
>  
> For a file like "File.txt" in the repo, "git blame file.txt" (note the lower case)
> shows "Not commited yet" for every single line in the file. 
> "git blame File.txt" (correct upper case spelling) gives the correct output.
> "core.ignorecase" is "true" so this behaviour is not what I expected.

What happens when you do this?

	$ echo garbage >no-such-file-tracked.txt
        $ git blame no-such-file-tracked.txt

If you see everything attributed to the working tree file, I _think_
you are seeing exactly the same thing.  As far as your repository
history is concerned, "file.txt" is never tracked ("File.txt" is),
and when Git asks the contents for "file.txt" in the working tree,
Windows case insensitive filesystem gives it the contents of
"File.txt" instead, all lines in which is initially attributed to
the working tree.  When blame tries to pass the blame around to the
commit at HEAD and down the history, it never finds "file.txt", so
all the blame is given to this phamtom contents from "File.txt"
Windows gave you as if it were stored in "file.txt", which does not
really exist.

An obvious workaround is to say "git blame File.txt".  You might be
able to patch MsysGit so that "git blame file.txt" errors out when
it does not find such a path in the HEAD commit, though.
