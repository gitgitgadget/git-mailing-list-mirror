From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bringing a bit more sanity to $GIT_DIR/objects/info/alternates?
Date: Mon, 06 Aug 2012 14:55:35 -0700
Message-ID: <7vboiny9bc.fsf@alter.siamese.dyndns.org>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 23:56:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyVHh-0000tH-LI
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 23:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab2HFVzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 17:55:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617Ab2HFVzi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 17:55:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E385874B;
	Mon,  6 Aug 2012 17:55:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bgAQN3NEVIJSI4T88lT4kiErFPM=; b=VqKyts
	20Ufr0iPinbmUJbzREoeyPQiOoaiWngJLJK9HWAPsSoRniBFRjDw7ZDRZZdamsw3
	McQvHk1Usx7JS8JeKbFP0x+1jkwTokpqAwjB/gDw9x1E3u1am2dc8KZWnhy3Ge4z
	tr3QHwEvgi1j6P8vunpOtyJ8lex+Ra1kpb6AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o9nmj+7iHqz3CaAMa9TsPaSrfRJnysDL
	1CXmW3K605rsbXY40zSNz5lVN6XWvz6JnCOfgXXd+E9oS/caMTRFHoDEXNpxZxwi
	iTztB/ru2fOW1o0CdUfAZoN0y8p6TJO1iYGPZl+nU4sFwZ1LYyWJn+it9xn0nkcz
	dj3LUmOsuyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BADE874A;
	Mon,  6 Aug 2012 17:55:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA1648749; Mon,  6 Aug 2012
 17:55:36 -0400 (EDT)
In-Reply-To: <7vmx2a3pif.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 04 Aug 2012 21:56:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 743CE224-E011-11E1-91A1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202992>

Junio C Hamano <gitster@pobox.com> writes:

>  - When you have one object store and a repository that does not yet
>    borrow from it, you may want to make the repository borrow from
>    the object store.  Obviously you can run "echo" like the sample
>    script in the previous item above, but it is not obvious how to
>    perform the logical next step of shrinking $GIT_DIR/objects of
>    the repository that now borrows the objects.
>
>    I think "git repack -a -d" is the way to do this, but if you
>    compare this command to "git repack -a -d -f" we saw previously
>    in this message, it is not surprising that the users would be
>    confused---it is not obvious at all.
>
>    Some ideas:
>
>    - (obvious: give a canned subcommand to do this)

The analysis of this item is wrong, I think.  "git repack -a -d -l"
should be the way to do so.

The message looks wrong when it turns out that there is no need to
have any object in the borrowing repository, though.  We only see
"Nothing new to pack" (which technically is correct), and the
command exits successfully.  You can peek .git/objects/ to find out
that all the objects the borrower used to have its own copy are now
gone (because they are available at the alternate), but the message
gives a false impression that we thought about doing something,
found nothing new to be packed, and gave up without doing anything.

But that is not what is happening.  We traversed the connectivity,
found that all the objects necessary for our history are housed in
our alternates, gave "Nothing new to pack" (because we do not have
to have any object on our own), and then removed all the object
files and packs in our repository.
