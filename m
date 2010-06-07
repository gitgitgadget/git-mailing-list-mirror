From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Explanation for dropping write-back in mmap
Date: Mon, 07 Jun 2010 08:55:56 -0700
Message-ID: <7vbpbmx2er.fsf@alter.siamese.dyndns.org>
References: <AANLkTilrinkNo9awJ9Wso4tXzQKghWEd2bfDRhPHPOga@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 17:56:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLegV-000672-Ip
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 17:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab0FGP4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 11:56:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab0FGP4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 11:56:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1ACBA9D1;
	Mon,  7 Jun 2010 11:56:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NEGBxdP2oFgZS7linI6AfUQ7Muk=; b=n77KND
	ybjlvauDF2A3apyhWBeL8/ubNY51SLteUil6yzjEJPEii5/f64eeteY1FrtBHlYU
	Zmiwnc5QQknqVEWFSgaiWrujg/kuFK1V6mHkn8fCKyYPIprbS7eNKv0Cn8CP2e/v
	TLj9qt2nhiWOoByeocKRzROyOLGMcGJ8WU4Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FOIYqhb2wGJfxLaPjURWoTeTxQLXY5ks
	OHnVQvzI5Vx1aUK5SmDaan4PHwBikKFqzmRwfcVutBXv7iLkvLC/N0rbA3NaIlDb
	R9etcKOa7mkEmVzXwQJpqkLbiMHBvaAZT9tvVIk4n6eeBhrKRu7kiOKGllFri42y
	gldResSwCpg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8E1FBA9CF;
	Mon,  7 Jun 2010 11:56:05 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD5B6BA9CC; Mon,  7 Jun
 2010 11:55:58 -0400 (EDT)
In-Reply-To: <AANLkTilrinkNo9awJ9Wso4tXzQKghWEd2bfDRhPHPOga@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon\, 7 Jun 2010 17\:16\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2E4D0908-724D-11DF-A8AE-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148611>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In the commit f48000fcbe100, you've forced the caller to use
> MAP_PRIVATE in the alternative mmap implementation dropping write-back
> support.
> ...
> commit f48000fcbe1009c18f1cc46e56cde2cb632071fa
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Sat Oct 8 15:54:36 2005 -0700
>
>     Yank writing-back support from gitfakemmap.
>
>     We do not write through our use of mmap(), so make sure callers pass
>     MAP_PRIVATE and remove support for writing changes back.

That's a 

I don't think we _dropped_ a _working_ support that allowed shared
mapping.  IIRC the implementation emulated only private mapping well
enough to support the use of mmap() in our codebase (iow, instead of
allocating a buffer and reading into it and possibly mucking with it
without affecting outside world, map it to read and then possibly mucking
with it), but lacked input validation to make sure that no caller
mistakenly thinks the implementation could satisfy non private mapping.

Also I don't think I did this without telling other people---it would be a
lot more likely that somebody else noticed it and the issue was discussed
on the list and resulted in this commit.  I would check the commit date
and see the discussion around that time if I were you to learn the
backstory.
