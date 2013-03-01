From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 01 Mar 2013 14:27:32 -0800
Message-ID: <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
References: <20130301222018.GA839@WST420>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 23:28:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBYQr-0006wX-0j
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 23:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab3CAW1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 17:27:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225Ab3CAW1f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 17:27:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7219DAED9;
	Fri,  1 Mar 2013 17:27:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dY51/XjY5WUc3rXNE3eDPQMeYzU=; b=bgHZ2h
	IStzH7OsgqeP4RoMCNP3BLtfQLFnYDKVLSsHJsWfuuZYrwCDfmUW52QsuF6lko8t
	AwItJ5VwUuPoXZBsMdcXnSDT1IOv9IGedoiYZuXLuAH8ki5DmbqXo0HzT0ix88TU
	1Xz4HhfdbpW+ER9+khCSQInti0ztjwsRlqFlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l+Q2AJHdqWPnbOfr6NN0jlSh2Z4luqwA
	15IRMBEARZLWo9aJACn3osnpMmbILrGzD0t48SECCSe1ritr2uQPpVFrV5AZcHTl
	tbek4g8AghOQM+lmP8+VIgmxH5IKNcehp+wTrw1eLxmo4kAZYjgn3pQnkG6IZCwE
	OPabCTpk8CU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6172AAED8;
	Fri,  1 Mar 2013 17:27:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B14F1AED2; Fri,  1 Mar 2013
 17:27:33 -0500 (EST)
In-Reply-To: <20130301222018.GA839@WST420> (William Giokas's message of "Fri,
 1 Mar 2013 16:20:18 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3662A730-82BF-11E2-A4E1-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217299>

William Giokas <1007380@gmail.com> writes:

> All,
>
> I've been using git for a while and this is the first time I've had to
> use `git am` and I've got a 16 patch patchset that I'm looking to apply.
> The files were copied to a separate maildir by mutt to keep things
> clean, and then I ran `git am -i /path/to/maildir/` expecting things to
> start from the patch with the subject 
>
>     [PATCH 01/16] refactor common code in query_search/sync_search
>
> But instead, it starts with the 16/16 patch and works backwards, which,
> obviously, breaks the application process as the patches depend on each
> other. I looked in the maildir directory just to see if the file names
> were backwards, and that's not the issue. I talked to `gitster` on IRC
> and he said to send in a bug report on this issue here. The patchset I'm
> trying to apply can be found here[0]. 
>
> Process to reproduce:
> * find a multi-patch set with interdependent patches
> * run `git am` on the maildir containing these patches
>
> Expected result:
> * Apply patches in [01..N] order
>
> Actual result:
> * Patches applied in [N N-1..01] order

Note to bystanders.  This is coming from populate_maildir_list() in
builtin/mailsplit.c; the function claims to know what "maildir"
should look like, so it should be enforcing the ordering as
necessary by sorting the list, _if_ the implicit ordering given by
string_list_insert() is insufficient.

It also is likely that it is a user error to expect that patch
e-mails are received and stored in the maildir in the order they
were sent, or it could be "mutt" copying the mails in the order the
messages were originally received, or something silly like that.

>
> [0]: https://mailman.archlinux.org/pipermail/pacman-dev/2013-March/016541.html
>
> Thank you,
