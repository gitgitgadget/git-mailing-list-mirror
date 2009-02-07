From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] give exclude mechanism a debug option
Date: Fri, 06 Feb 2009 23:38:38 -0800
Message-ID: <7vljsizog1.fsf@gitster.siamese.dyndns.org>
References: <20090207064221.GA14856@coredump.intra.peff.net>
 <20090207064454.GB14906@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVhoM-0005Vm-KA
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbZBGHiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbZBGHiw
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:38:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbZBGHiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:38:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CBEDF971E1;
	Sat,  7 Feb 2009 02:38:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 52FB8971CD; Sat,
  7 Feb 2009 02:38:40 -0500 (EST)
In-Reply-To: <20090207064454.GB14906@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 7 Feb 2009 01:44:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C3E6FD2-F4EA-11DD-9B0F-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108822>

Jeff King <peff@peff.net> writes:

> Users can set GIT_DEBUG_IGNORE in the environment to get the
> exclusion mechanism to dump to stderr files mentioned in
> .gitignore along with the pattern that matched. The output
> looks something like:
>
>   foo.c: exclude: *.c
>
> This implementation has several shortcomings that make it
> unsuitable for inclusion:
>
>   1. Doing it as a debug environment variable is hack-ish.
>      A nicer interface would be a .gitignore equivalent of
>      "git check-attr".

Correct.

>   2. If you ask for "foo/bar", and "foo/" is ignored, the
>      output will show only "foo: exclude: foo". This is an
>      artifact of the calling interface: you don't ask "is
>      foo/bar excluded", but rather while recursing through
>      "foo/" you ask "should I bother even recursing into
>      foo?". So the exclusion code never even knows that you
>      might have cared about foo/bar in the first place.

I do not see why it is a problem.  It exactly is what you want to know,
isn't it?

>   3. There is no indication of where patterns came from. We
>      could specify whether it came from the command-line,
>      from per-directory files, or from another file. But what
>      is most interesting is the actual _filename_ that it
>      came from. I.e., something like:
>
>        sub/foo.c: exclude: sub/.gitignore: *.c
>
>      But that information seems to have been forgotten by
>      the time we are actually doing excludes.

For this, you would need to add an element to exclude_stack structure to
record the human readable name of the exclude source in prep_exclude().
Once you find the matched element using your new excluded_1() mechanism
introduced by patch 1/2, you can find which stack in dir->exclude_stack
the match element belongs to, and map it back the human readable source
name recorded in the exclude_stack.
.
