From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative paths don't work in .gitignore as would be expected.
Date: Mon, 02 Feb 2015 11:15:46 -0800
Message-ID: <xmqqsieot999.fsf@gitster.dls.corp.google.com>
References: <CAKU1PAWMh_3x9OoFmXG4+5b=7PRckC47k-MAq++SXahxAP5V7g@mail.gmail.com>
	<54CF11CA.6000308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "\/#!\/JoePea" <trusktr@gmail.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 20:15:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIMTS-0002We-EB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 20:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243AbbBBTPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 14:15:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932972AbbBBTPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 14:15:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92D4134F53;
	Mon,  2 Feb 2015 14:15:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3wU3tcvUy4X1a8M6I7p3Xgi2LFQ=; b=eQBzAp
	WFi8PCgM+8M+DCocB4WxS5mWAGqCPtjVPqmA+sAklDiHMYkT9xOnLNM1kSeBDbAT
	KL9cJrzPYFeqgQqhdIxqo3QVA/PvRkB/5vEup5Bb90bkEzTmLUsz/OzEl0f3FjIi
	moOiwPXYwiQu78dkh9TQg6gRKFeoIZ47rMdIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhAPtG7S5qXzp4aw31PG6nb/DZObG9h4
	Rl56iEuWsU5MybTX3iiapMinhkSwqEBIT3IMcLUPEBe9lORb9FCO0jR94GH5b07A
	a/UUwJZnSqHNa0c4U0QG+EvmPxkdu+QzNh6PmDGICSwsdEEByODRXgvycw8AgAjN
	guWWvNHjPpI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 781DB34F52;
	Mon,  2 Feb 2015 14:15:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E150334F4F;
	Mon,  2 Feb 2015 14:15:47 -0500 (EST)
In-Reply-To: <54CF11CA.6000308@gmail.com> (Stefan Beller's message of "Sun, 01
	Feb 2015 21:57:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4CCD6D6-AB0F-11E4-98B4-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263278>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 01.02.2015 14:51, /#!/JoePea wrote:
>> I have this in my .gitignore:
>> 
>>   ./*.js
>> 
>> I would expect that to cause git to ignore .js files in the same
>> folder as .gitignore, but it doesn't do anything. However, this works:
>> 
>>   /*.js
>> 
>> I'm not sure what this actually means because a leading slash is the
>> root of some filesystem, 

Isn't gitignore(5) documentation reasonably clear?

 - If the pattern ends with a slash, it is removed for the purpose
   of the following description, but it would only find a match with
   a directory. In other words, foo/ will match a directory foo and
   paths underneath it, but will not match a regular file or a
   symbolic link foo (this is consistent with the way how pathspec
   works in general in Git).

 - If the pattern does not contain a slash /, Git treats it as a
   shell glob pattern and checks for a match against the pathname
   relative to the location of the .gitignore file (relative to the
   toplevel of the work tree if not from a .gitignore file).

 - A leading slash matches the beginning of the pathname. For
   example, "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".

> That's true, though you'd never (barely?) git version control an entire
> file system?

When you have the entire file system under /.git, "/var/" still
would be the right way to spell a pattern to match only a directory
(because of the trailing '/') whose name matches 'var' and lives in
the root level of the filesystem (because of the leading '/' anchors
the pattern to the same level as the file the pattern appears in,
i.e. /.gitignore) and no other place.

> (from man gitignore, though reading that and not finding a './' it may
> need improvement

We do not allow relative pathname traversal with "." or "..", do we?

I would be very hesitant to special case "./*.js" to mean "*.js
files in the same directory as .gitignore appears", as I think it
risks intelligent readers to infer "../foo/*.js" or "../*.js" would
take effect, when placed in "bar/.gitignore".  A design that spreads
an incorrect assumption/expectation is not a good one, I would have
to say.
