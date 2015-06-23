From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/19] initial_ref_transaction_commit(): check for duplicate refs
Date: Tue, 23 Jun 2015 10:44:45 -0700
Message-ID: <xmqqd20me2uq.fsf@gitster.dls.corp.google.com>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
	<63ae59139a3a7b5c85f6d44864eade79a93965fb.1434980615.git.mhagger@alum.mit.edu>
	<xmqqtwtzfo79.fsf@gitster.dls.corp.google.com>
	<558906A4.8060106@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:44:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7SFh-000165-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbFWRou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:44:50 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35406 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbFWRos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 13:44:48 -0400
Received: by iebrt9 with SMTP id rt9so16878990ieb.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UjZUGu5EWgNcSVSvgvqpCBwKi0NuvaoqzEo+S5TyJ4o=;
        b=xg+BeTEJjHGFOOkPWmZ+ZahVvMPzWBDFecu4rvy3gXnClU74dUqRRrVVqs1oJd8ZFF
         6JlCVLtKJMCehhWGce88M9qXkST5N7xOTrrps9gPG5vb9+vE8//ucWOOoWDAqKbusm0Y
         XbPSKglnyUp8PqYG9B64qUZ0nwztmDQaCJX8c7lwFG5mAobqOctEIy1y6uZDDlJrc1Zy
         oVg8d9ZA4E+BtKh59ZVKoa688IvkDq9ieXJWZJ5lbWtqwWgg0gmcjxg7A9hQch/nmBVb
         RBANI3zFellLXohQqujqcrdv3CC9YILuYJdyiU/S9/tjkOBwu70Ca8dKZDi+pHIZfYC7
         S9pg==
X-Received: by 10.107.18.92 with SMTP id a89mr49166225ioj.14.1435081487478;
        Tue, 23 Jun 2015 10:44:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id s5sm183725igh.6.2015.06.23.10.44.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 10:44:46 -0700 (PDT)
In-Reply-To: <558906A4.8060106@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 23 Jun 2015 09:11:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272472>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/22/2015 11:06 PM, Junio C Hamano wrote:
> ...
>> What I am wondering is if we could turn the safety logic that appear
>> here (i.e. no existing refs must be assumed by the set of updates,
>> etc.)  into an optimization cue and implement this as a special case
>> helper to ref_transaction_commit(), i.e.
>> 
>> 	ref_transaction_commit(...)
>>         {
>> 		if (updates are all initial creation &&
>>                     no existing refs in repository)
>> 			return initial_ref_transaction_commit(...);
>> 		/* otherwise we do the usual thing */
>> 		...
>> 	}
>> 
>> and have "clone" call ref_transaction_commit() as usual.
>
> The safety logic in this function is (approximately) necessary, but not
> sufficient, to guarantee safety.

Oh, no question about it, and you do not even have to bring up an
insane "user runs random commands while Git is hard working on it"
non use-case ;-)

> One of the shortcuts that it takes is
> not locking the references while they are being created. Therefore, it
> would be unsafe for one process to call ref_transaction_commit() while
> another is calling initial_ref_transaction_commit(). So the caller has
> to "know" somehow that no other processes are working in the repository
> for this optimization to be safe. It conveys that knowledge by calling
> initial_ref_transaction_commit() rather than ref_transaction_commit().

OK.  So the answer to my first question "is the initial creation
logic too fragile" is a resounding "yes"; the caller should know
that it is too crazy for the user to be competing with what it is
doing before deciding to call initial_ref_transaction_commit(),
hence we cannot automatically detect if it is safe from within
ref_transaction_commit() to use this logic as an optimization.

> But I think if anything it would make more sense to go the other direction:
>
> * Teach ref_transaction_commit() an option that asks it to write
>   references updates to packed-refs instead of loose refs (but
>   locking the references as usual).
>
> * Change clone to use ref_transaction_commit() like everybody
>   else, passing it the new REFS_WRITE_TO_PACKED_REFS option.
>
> Then clone would participate in the normal locking protocol, and it
> wouldn't *matter* if another process runs before the clone is finished.

Yeah, I thought that was actually I was driving at, and doing so
without that write-to-packed-refs option, which I'd prefer to leave
it as an optimization inside ref_transaction_commit().

Except that I missed that the initial_* variant is even more
aggressive (i.e. not locking), so no such optimization is safe.

> There would also be some consistency benefits. For example, if
> core.logallrefupdates is set globally or on the command line, the
> initial reference creations would be reflogged. And other operations
> that write references in bulk could use the new
> REFS_WRITE_TO_PACKED_REFS option to prevent loose reference proliferation.
>
> But I don't think any of this is a problem in practice, and I think we
> can live with using the optimized-but-not-100%-safe
> initial_ref_transaction_commit() for cloning.

OK.
