From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On "interpret-trailers" standalone tool
Date: Mon, 14 Apr 2014 14:41:15 -0700
Message-ID: <xmqqy4z7lhc4.fsf@gitster.dls.corp.google.com>
References: <xmqq61mi1djt.fsf@gitster.dls.corp.google.com>
	<20140412.213003.73509455950485398.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 23:41:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZod9-0005GN-Of
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 23:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbaDNVlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 17:41:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567AbaDNVlS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 17:41:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD327D564;
	Mon, 14 Apr 2014 17:41:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O69xsDaHCWgwxY8qqNnZ7dZijW8=; b=o7S6ke
	L8CjrO3SyezP9wobEm6LbO3X5b5Bb2SLJwxGwuSNmlfRT2foiGMC1739HcEvTW7n
	JXfPgn1vrx5rwRcSM0G0bhH0xJocoqrjKSgo61/DzQqbiPZap4W5ExOGZ7+Y9HoG
	l6/3r/Up01EB1I8xfzpFR8FUSdyIf7Nlk2qe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdQBkHf74AMY7OVpaCUDh8IpDFQFdsEi
	3G1BSIdiGcRHW+fSAFu7DqMlDPG4jA78u/q178t1iAHBgX8Gp3ZwHijxhvfMUrDd
	g6k6LcaL8qxBXwnw7093U4deh8OxtGPZQuHo1YOrkdXO10E7XXH5O8jcHpA2LhFZ
	abrDSion6x8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D48C47D563;
	Mon, 14 Apr 2014 17:41:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BFB27D562;
	Mon, 14 Apr 2014 17:41:16 -0400 (EDT)
In-Reply-To: <20140412.213003.73509455950485398.chriscool@tuxfamily.org>
	(Christian Couder's message of "Sat, 12 Apr 2014 21:30:03 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 820809FA-C41D-11E3-BBB3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246269>

Christian Couder <chriscool@tuxfamily.org> writes:

>> However, I am wondering if the current "everything on the command
>> line is instruction to the command" is too limiting to allow the use
>> of the tool both as a filter and as a tool that can work on one or
>> more files named on the command line.  If we start from there, the
>> only way to later add "these arguments are names of the files to be
>> operated on" is to add "--file <file1> --file <file2>..." options,
>> which feels quite backwards as a UNIX tool.
>
> Yeah, except that we could add for example a '-o' option that would
> take a directory as argument and that would mean that the command
> should operate on all the files in this directory. It would be like
> the -o option of the format-patch command.

For output for which users do not know offhand what files are to be
produced, giving a single directory with -o makes tons of sense, but
for input, naming each individual file (and with help with shell
globs *) is a lot more natural UNIX tool way, I would think.  "Take
everything from this directory" cannot be substitute for that, even
though the reverse (i.e. by naming the input files with "dir/*") is
true.  It is not a viable replacement.

> First, if you think that the command might often be used along with
> format-patch,

... I am not singling out format-patch output.  Any text file/stream
that has the commit log message may benefit from the "trailers" filter,
and format-patch output is merely one very obvious example.  As to
the detection of the end of commit log message, the current "EOF is
where the log message ends (but we would remote trailing blank line)"
can easily be updated to "EOF or the first three-dash line".

> Third, if trailers arguments are passed to the command using an
> option like "-z token=value" or "-z token:value", it would be nice
> to the user for consistency if the same option could be used when
> passing the same arguments to "git commit" and perhaps other
> commands like "git rebase", "git cherry-pick" and so on. This
> means that we now have to choose carefully the name of this
> option. Perhaps we can just give it a long name now like --trailer
> and care later about a short name,...

Absolutely.  That is a very sensible way to go.

> Fourth, some users might want the command to be passed some files as
> input, but they might not want the command to modify these input
> files. They might prefer the command to write its ouput into another
> set of output files. Maybe a syntax like cat or sed is not very well
> suited for this kind of use, while having a -o option for the output
> directory and a -i option for the input directory (if different from
> the output dir) would be nicer.

Sure.  I would expect we would require something like Perl's '-i'
(in-place rewrite) option for this sequence to really work:

	git format-patch -o there -5
	git that-command --options -i there/*

and without, I would expect the output to come to its standard
output.

Thanks.
