From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file" DWIM better.
Date: Mon, 16 Mar 2015 10:14:15 -0700
Message-ID: <xmqq61a0sw48.fsf@gitster.dls.corp.google.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	<vpq1tkq5fsw.fsf@anie.imag.fr>
	<xmqqr3spsir2.fsf@gitster.dls.corp.google.com>
	<CAHLaBNJxRx9jkNHCM+djq7KEZBV2n5PFZN0-UUtzhO=ikR+Kuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 18:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXYb6-0008KB-C2
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 18:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167AbbCPROc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 13:14:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932398AbbCPROa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 13:14:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A427D40BB7;
	Mon, 16 Mar 2015 13:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4PPOvxQrwRnz+dwosMdlBvLGDDc=; b=Rx/8Qu
	W8/ff9ppukyF8prMU5MtHDz2x+Rla+dOvoV1x9O9iE2O2LOo2roFZ98+RscBleEg
	d7kWIjzOmkre+JTkCPF3hWRII4I4REmiX/mDDcDOxrGRnFcMZ4XUdRojNAn+AkU5
	hoqqb/AXrAJ07nF4Sgc2w/aFytFPy8uTOhI6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=grxHA4bW74CQcVDHoT8C2t0kkW6lKfM7
	RHKQy6O3uDYKIdbOhqPhZ6G24u7W3s75XVon1lVdOHV6FTMFC1qZC13Mb6u9TZ3d
	JiV6m1AClggdLmxhcoJj4dP5pXN+b335PW8qJvC5wHCZtbKIIJ6ZCF87BC7YRfFO
	s4ziX9OUnnc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CDFD40BB6;
	Mon, 16 Mar 2015 13:14:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B413D40BAC;
	Mon, 16 Mar 2015 13:14:16 -0400 (EDT)
In-Reply-To: <CAHLaBNJxRx9jkNHCM+djq7KEZBV2n5PFZN0-UUtzhO=ikR+Kuw@mail.gmail.com>
	(Yurii Shevtsov's message of "Mon, 16 Mar 2015 18:23:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0424892-CBFF-11E4-BEB3-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265577>

Yurii Shevtsov <ungetch@gmail.com> writes:

>> ...  As it stands now, even before we think about dwimming
>> "diff D/ F" into "diff D/F F", a simple formulation like this will
>> error out.
>>
>>     $ mkdir -p a/sub b
>>     $ touch a/file b/file b/sub a/sub/file
>>     $ git diff --no-index a b
>>     error: file/directory conflict: a/sub, b/sub
>>
>> Admittedly, that is how ordinary "diff -r" works, but I am not sure
>> if we want to emulate that aspect of GNU diff.  If the old tree a
>> has a directory 'sub' with 'file' under it (i.e. a/sub/file) where
>> the new tree has a file at 'sub', then the recursive diff can show
>> the removal of sub/file and creation of sub, no?  That is what we
>> show for normal "git diff".
>>
>> But I _think_ fixing that is way outside the scope of GSoC Micro.
> 
> So you want me to convert args ("diff D/ F" into "diff D/F F") before
> calling queue_diff()? But why?

Because it is wrong to do this inside queue_diff()?

Have you actually read what I wrote, tried the above sample
scenario, and thought what is happening in the codepath?

When the user asks to compare directory a/ and b/, the top-level
diff_no_index() would have paths[0]=="a" and paths[1]=="b", and
queue_diff() is called with these in name1 and name2.  Once it
learns that both of these are directories, it _recurses_ into itself
by appending the paths in these directories after these two names.
It finds that both of these directories have "sub" underneath, so it
makes a recursive call to itself to compare "a/sub" and "b/sub".

That call would notice that one is a directory and the other is
not.  That is where you are getting the "f/d conflict" error.

At that point, do you think it is sensible to rewrite that recursed
part of the diff into a comparison between "a/sub/sub" (which does
not exist, and which the user did not mean to compare with b/sub)
and "b/sub" (which is a file)?  I hope not.

> queue_diff() already check args' types and decides which
> comparison to do.

Yes, and I already hinted that that is an independent issue we may
want to fix, which I suspect is larger than GSoC Micro.  Also the
fix would be different.  Right now, it checks the types of paths and
then refuses to compare a directory and a file.  If we wanted to
change it to closer to what the rest of Git does, we would want it
to report that the directory and everything under it are removed and
then a new file is created (if the directory is on the left hand
side of the comparision and the file is on the right hand side) or
the other way around.  That will not involve "append the name of the
file at the end of the directory".

In short, "append the name of the file at the end of the directory"
logic has no place to live inside queue_diff() which handles the
recursion part of the operation.
