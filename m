From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
Date: Fri, 27 May 2016 17:41:09 +0200
Message-ID: <87d1o7pkyy.fsf@fencepost.gnu.org>
References: <1464356141-3797-1-git-send-email-dak@gnu.org>
	<alpine.DEB.2.20.1605271633230.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 27 17:42:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6JuE-0006SF-98
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 17:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbcE0Pm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 11:42:26 -0400
Received: from eggs.gnu.org ([208.118.235.92]:47479 "EHLO eggs.gnu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755595AbcE0PmZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2016 11:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6Ju3-0003nh-N8
	for git@vger.kernel.org; Fri, 27 May 2016 11:42:24 -0400
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on eggs.gnu.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_50,RP_MATCHES_RCVD
	autolearn=disabled version=3.3.2
Received: from fencepost.gnu.org ([2001:4830:134:3::e]:55510 helo=lola.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1b6Jtx-0003lm-Ou; Fri, 27 May 2016 11:42:17 -0400
Received: by lola.localdomain (Postfix, from userid 1000)
	id DAE01E248E; Fri, 27 May 2016 17:41:09 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.20.1605271633230.4449@virtualbox> (Johannes
	Schindelin's message of "Fri, 27 May 2016 17:00:25 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4830:134:3::e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295762>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 27 May 2016, David Kastrup wrote:
>
>> pressure particularly when the history contains lots of merges from
>> long-diverged branches.  In practice, this optimization appears to
>> behave quite benignly,
>
> Why not just stop here?

Because there is a caveat.

> I say that because...
>
>> and a viable strategy for limiting the total amount of cached blobs =
in a
>> useful manner seems rather hard to implement.
>
> ... this sounds awfully handwaving.

Because it is.

> Since we already have reference counting, it sounds fishy to claim
> that simply piggybacking a global counter on top of it would be
> "rather hard".

You'll see that the patch is from 2014.  When I actively worked on it,
I=A0found no convincing/feasible way to enforce a reasonable hard limit=
=2E
I am not picking up work on this again but am merely flushing my queue
so that the patch going to waste is not on my conscience.

>> In addition, calling git-blame with -C leads to similar memory reten=
tion
>> patterns.
>
> This is a red herring. Just delete it. I, for one, being a heavy user=
 of
> `git blame`, could count the number of times I used blame's -C option
> without any remaining hands. Zero times.
>
> Besides, -C is *supposed* to look harder.

We are not talking about "looking harder" but "taking more memory than
the set limit".

> Also: is there an easy way to reproduce your claims of better I/O
> characteristics? Something like a command-line, ideally with a file i=
n
> git.git's own history, that demonstrates the I/O before and after the
> patch, would be an excellent addition to the commit message.

I've used it on the wortliste repository and system time goes down from
about 70 seconds to 50 seconds (this is a flash drive).  User time from
about 4:20 to 4:00.  It is a rather degenerate repository (predominantl=
y
small changes in one humongous text file) so savings for more typical
cases might end up less than that.  But then it is degenerate
repositories that are most costly to blame.

> Further: I would have at least expected some rudimentary discussion
> why this patch -- which seems to at least partially contradict 7c3c79=
6
> (blame: drop blob data after passing blame to the parent, 2007-12-11)
> -- is not regressing on the intent of said commit.

It is regressing on the intent of said commit by _retaining_ blob data
that it is _sure_ to look at again because of already having this data
asked for again in the priority queue.  That's the point.  It only drop=
s
the blob data for which it has no request queued yet.  But there is no
handle on when the request is going to pop up until it actually leaves
the priority queue: the priority queue is a heap IIRC and thus only
provides partial orderings.

>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 21f42b0..2596fbc 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -1556,7 +1556,8 @@ finish:
>>  	}
>>  	for (i =3D 0; i < num_sg; i++) {
>>  		if (sg_origin[i]) {
>> -			drop_origin_blob(sg_origin[i]);
>> +			if (!sg_origin[i]->suspects)
>> +				drop_origin_blob(sg_origin[i]);
>>  			origin_decref(sg_origin[i]);
>>  		}
>
> It would be good to mention in the commit message that this patch doe=
s not
> change anything for blobs with only one remaining reference (the curr=
ent
> one) because origin_decref() would do the same job as drop_origin_blo=
b
> when decrementing the reference counter to 0.

A sizable number of references but not blobs are retained and needed fo=
r
producing the information in the final printed output (at least when
using the default sequential output instead of --incremental or
--porcelaine or similar).

> In fact, I suspect that simply removing the drop_origin_blob() call
> might result in the exact same I/O pattern.

It's been years since I actually worked on the code but I'm still prett=
y
sure you are wrong.

--=20
David Kastrup
