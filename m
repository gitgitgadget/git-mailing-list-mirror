From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/18] git notes merge: Initial implementation handling
 trivial merges only
Date: Sat, 9 Oct 2010 12:29:55 -0500
Message-ID: <20101009172955.GB17799@burratino>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-9-git-send-email-johan@herland.net>
 <20101007062433.GF2285@burratino>
 <201010090155.20858.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Oct 09 19:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4dII-0000ub-Vg
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 19:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759948Ab0JIRdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 13:33:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64219 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab0JIRdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 13:33:07 -0400
Received: by gyg13 with SMTP id 13so402382gyg.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vc5VP94N7wuaALaDatrfrYxjrfRswcjCagJIRKfCS+E=;
        b=CMgGxQceNsziaF3pmk0YAWDKW0t4PiyFZQ6kEvl3gp4Kt35Pn+vguYq+L1/0pkoPon
         ahnxOCWz3RPNwNlhkMY2E7AM2IRHbfG7jYP22hzHSkOIw6Eqoal8zvAw88LXjFzFbfDt
         1lpv5CXfO8NE0lFzdk2hRSYe6jecNguRMB7KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XJgrelhL1cp/ad6sclfd4IoFQC/gnujGwqKc+O4VVmUUpu/R1tNMbKpP+/SaSZMnR5
         xj3+CzUOcgOCAyrIWdj2qjismEByLd5pDo2aJKB0ETxTpbunJSvGL+XudJjN1yQSdPqB
         CXVG6Y06aD2NUEUqQU7vmc35Cjc4HNdDjljHw=
Received: by 10.150.69.24 with SMTP id r24mr4925415yba.168.1286645585936;
        Sat, 09 Oct 2010 10:33:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v37sm1111625yba.20.2010.10.09.10.33.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 10:33:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010090155.20858.johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158593>

Johan Herland wrote:

> I agree, but I'd like to name it 'git notes get-ref' instead, to stay
> consistent with the current subcommand (instead of option) design.

Sounds good. :)

> Jonathan Nieder wrote:

>> I would find it easier to read
>>
>> 	if (o->verbosity >= DEFAULT_VERBOSITY)
>> 		fprintf(stderr, ...)
>>
>> unless there are going to be a huge number of messages.
>
> The current version is modeled on the show() and output() functions in
> merge-recursive.c. I think that works better in this situation.
> Or maybe you have a better solution for merge-recursive.c as well?

Hmm --- isn't the point of output() that it indents to the appropriate
level to portray a recursive merge?

Similarly, show() prevents those confusing messages from the internal
merge between ancestors from being printed when the user is not
interested.

But if you think they are important abstractions to maintain, I won't
stop you. :)

>>> +
>>> +	if (!o->local_ref || get_sha1(o->local_ref, local_sha1)) {
>>> +		/* empty notes ref => assume empty notes tree */
[...]
> I'm not sure when you think we should (or shouldn't) error out.

get_sha1() can return -1 in the following cases:

 - starts with :/, regex does not match.
 - starts with :, entry not present in index
 - in form <rev>:<path>, <path> does not exist in <rev>
 - in form <rev>^, <rev> does not exist or that parent does not
   exist
 - tag being used as commit points to a tree instead
 - et c.

Especially if the caller tries

	git notes merge 'afjkdlsa^{gobbledeegook'

I would not like the merge to succeed.

So as I see it, there are four cases:

 - get_sha1() succeeds and returns a commit ==> merge that rev
 - get_sha1() succeeds and returns a non-commit ==> fail
 - get_sha1() fails, but resolve_ref() indicates a ref valid
   for writing ==> merge empty tree
 - get_sha1() fails, invalid refname ==> fail

The current code does not notice case 4, does it?

> I guess this becomes a discussion of whether we should model notes
> merges on the 'resolve' merge strategy or the 'recursive' merge
> strategy. Without having studied each strategy in-depth, I don't know
> how much "better" 'recursive' is than 'resolve', especially not from
> the POV of notes merges.

I think 'resolve' should be good enough for now.  We can always add
'recursive' later.

The cases where 'recursive' might help are those in which both sides
made a lot of changes to the same notes.  It helps in two ways:
signaling conflicts that might have been otherwise missed and merging
cleanly in cases that might otherwise produce spurious conflicts.
In theory, it makes the result less "arbitrary"; in practice, it seems
to help avoid some conflicts in ugly cases like merging one week's pu
with the next week's pu.

[...]
> Almost. If you look at the notes_merge() docs in notes-merge.h by the
> end of this series, you'll see the following return values:
> 
> 0: Merge trivially succeeded in an existing commit (e.g. fast-forward).
> 
> 1: Merge successfully completes a merge commit (i.e. no conflicts).
> 
> -1: Merge results is conflicts.

What kind of caller would care about the distinction between 1 and -1
here (just curious)?

Jonathan
