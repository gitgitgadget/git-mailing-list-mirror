From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] clone --single: limit the fetch refspec to fetched
 branch
Date: Mon, 17 Sep 2012 13:18:42 -0700
Message-ID: <7v8vc8v1wd.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
 <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:19:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhmR-0000sn-7e
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab2IQUSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:18:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757271Ab2IQUSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:18:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DD579C82;
	Mon, 17 Sep 2012 16:18:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cg1O1tSYwxEi8LdR3AOHtRTkhCM=; b=rmFvXb
	RNC2ke5PX2dhXk69zzKhztKKBghzqqMbl1YIxSJp91gt4uweuG0s+j6Jo28ztdre
	z3mo2CP3b/V0TRWNUW6VQXV0p1eJI+eWpskGswy9caSUwy5ISGoRnwrZZJZzypuu
	Y0q2ke7lA//JU0JgQnbg4hEnZ0vEjooS5Dxj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I098XYy7ylkwnEyd23CX0KMRO/AQJbsQ
	aKARI4NfO/CVzHDnVrWNJzInbExYPgZjCelzneFrGEiJ+6J/Q2sKwuHMS86IKn/C
	pzJd/exWl/IcaHVfTR0fOnVP0Q3O/EpA5FFUuCvqOAfa8YmhVbYniHsE9JHsjaYz
	zbRNxJ8H06o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BBBB9C81;
	Mon, 17 Sep 2012 16:18:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96D879C7F; Mon, 17 Sep 2012
 16:18:43 -0400 (EDT)
In-Reply-To: <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Mon, 17 Sep 2012 21:21:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0B8FF3C-0104-11E2-8625-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205736>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> - handle --mirror option (test added)

Handle how?  I personally think erroring out is the right way to
handle it, but if we care about people who have been misusing the
combination of single and mirror, the second best way would be to
imply "mirror" and "single" combination as "bare" and "single"
without "mirror".

> - install correct refspec if the value of --branch is a tag (test added)

What is the definition of "correct"?  I see the documentation says
"--branch can also take tags and treat them like detached HEAD", and
even though I _think_ allowing tags was a huge mistake, if we claim
we treat it like detached HEAD, we should do the same when coming up
with the refspec used for the follow-up "fetch".

Whatever we decide to do, the semantics we decided to use at least
need to be described in the commit log message, not just in the
"changes from the previous iteration".  Updating the
"Documentation/git-clone.txt" would also be necessary.

> +test_expect_success 'refspec contains all branches by default' '
> +	echo "+refs/heads/*:refs/remotes/origin/*" > expect &&
> +	git --git-dir=dir_all/.git config --get remote.origin.fetch > actual &&
> +	test_cmp expect actual
> +'

I still think these checks that know the current implementation
details (i.e. what exact configuration variables get what exact
values) are wrong thing to have in the longer term.  If the desired
behaviour (i.e. "later fetch do not screw up") can be tested
directly like the later parts of the test in this patch does, how
that desired behaviour is implemented should not have to be cast in
stone with these tests.
