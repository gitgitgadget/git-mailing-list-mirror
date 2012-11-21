From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] fix git-config with duplicate variable entries
Date: Wed, 21 Nov 2012 11:46:33 -0800
Message-ID: <7vehjm20yu.fsf@alter.siamese.dyndns.org>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
 <20121022211505.GA3301@sigill.intra.peff.net>
 <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
 <20121023223502.GA23194@sigill.intra.peff.net>
 <7vsj84rt1g.fsf@alter.siamese.dyndns.org>
 <20121121192738.GA16280@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:47:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbGG4-0000Em-NK
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab2KUTqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:46:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818Ab2KUTqg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:46:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E561293F5;
	Wed, 21 Nov 2012 14:46:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qpm2KTDi0IBSCBxoyRXXjp7Hc4s=; b=TeyQ77
	SN8pBfCztGQeRYE1tcsUirodZZwHvC7woItj6KKpJ0nlsS3KtKrS59TH2TGN73hx
	L9p8pg2b61dmMSqC5HCcvOtoG9oCmd9fMllMsfsWhTF0BBQDQtxLTcEwcrL+QCqZ
	cVyKxGsS1dX4lfy4qfZjY5SNXF4l/NSTgA6Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pONUNNO4jRaLbHZURSE+nw4FFZQDRX+k
	jfcJWBFKjygAbfvqmJdOpuPJQK7xK+hzpx7GEd8+ECUVZe/JTzmy2vjoL7etQpyK
	bIg4zPTRNJItLKH6nucUUNFWDJvMNQYvUH3/oomaNr4seB82Iptw22c+L0kd4Dqj
	G6LsClp3vlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D302C93F4;
	Wed, 21 Nov 2012 14:46:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27A6493F1; Wed, 21 Nov 2012
 14:46:35 -0500 (EST)
In-Reply-To: <20121121192738.GA16280@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 21 Nov 2012 14:27:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 281FEE5C-3414-11E2-A392-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210169>

Jeff King <peff@peff.net> writes:

>> The way for the Porcelain scripts to mimick the internal "last one
>> wins" has been to grab values out of --get-all and do the "last one
>> wins" themselves, and I agree that a mode that frees them from
>> having to worry about it is a good *addition*.  I would even say
>> that if we were designing "git config" plumbing without existing
>> users, it would be the only sensible behaviour for "--get".
>> 
>> But "git config --get" users have been promised to get errors on
>> duplicate values so far, so I have to say this needs to come with a
>> big red sign about API breakage.
>
> The problem is that scripts currently using "--get" are broken by
> duplicate entries in include files, whereas internal git handles them
> just fine.  Introducing a new switch means that everybody also has to
> start using it.

Not exactly.  There are three classes of people:

 - wrote scripts using --get; found out that --get barfs if you feed
   two or more of the same, and have long learned to accept it as a
   limitation and adjusted their configuration files to avoid it.
   They have been doing just fine and wouldn't benefit from this
   series at all.

 - wrote scripts using --get, relying on it barfing if fed zero
   (i.e. missing) or two or more (i.e. ambiguous), perhaps a way to
   keep their configuration files (arguably unnecessarily) clean.
   They are directly harmed by this series.

 - wrote scripts using --get-all and did the last-one-wins
   themselves.  They wouldn't benefit directly from this series,
   unless they are willing to spend a bit of time to remove their
   own last-one-wins logic and replace --get-all with --get (but the
   same effort is needed to migrate to --get-one).

 - wanted to write scripts using --get, but after finding out that
   it barfs if you feed two, gave up emulating the internal, without
   realizing that they could do so with --get-all.  They can now
   write their scripts without using --get-all.

The only people who benefit are from the last class; it does not
matter if they have to write --get-one or --get.

> That is not an excuse for breakage, of course, but only a motivation for
> considering it. And here is what I think mitigates that breakage:
>
>   1. If you are a script that cares about multiple values and choosing
>      one (whether last-one-wins or otherwise), you are already using
>      --get-all and are not affected.

Correct.

>   2. If you are a script that only wants to mimic how get retrieves
>      a single value, then this is a bug fix, as it brings "--get" in
>      line with git's internal use.

But by definition, no such script exists (if it used "--get", it
didn't mimic the internal in the first place).

>   3. If you are a script that only wants a single value, but cares about
>      duplicates, you are already failing to notice them when the
>      duplicates are cross-file. That is, we already do "last one wins"
>      if an entry is found in ~/.gitconfig and .git/config.

Yeah, so the only ones that can be harmed is a config lint that uses
the --get option with --file to make sure variables they know must
be single value are indeed so, and they are not doing a thorough
job, unless they are checking across files themselves, at which
point they are better off using --get-all piped to "sort | uniq -c"
or something.  So breakages do not matter much for correctly written
scripts.

> I would argue that anybody fetching standard git config variables (and
> not using --list or --get-all) falls into case (2) and is being fixed,
> as they will not otherwise match the behavior of git itself.

As people shove random stuff that git itself does not care about in
their config files, they may not care, though.

> IOW, I do not see a legitimate use case for this, but see it as an extra
> check on broken config.

Yes, I agree with the latter half of that sentence.
