From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 06 Apr 2009 11:30:54 -0700
Message-ID: <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <200904052358.53028.markus.heidelberg@web.de>
 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
 <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
 <20090406032457.GA14758@gmail.com>
 <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
 <871vs5kjfw.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Apr 06 20:32:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqtck-0000wK-0V
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 20:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZDFSbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 14:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbZDFSbK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 14:31:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZDFSbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 14:31:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F4B3A8D22;
	Mon,  6 Apr 2009 14:31:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F3E99A8D20; Mon,
  6 Apr 2009 14:30:56 -0400 (EDT)
In-Reply-To: <871vs5kjfw.fsf@krank.kagedal.org> (David =?utf-8?Q?K=C3=A5ge?=
 =?utf-8?Q?dal's?= message of "Mon, 06 Apr 2009 15:20:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16F7B04C-22D9-11DE-9C5E-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115865>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> What do you mean? This was a suggestion for how git diff should
> work. I fail to see how you would need a WORKTREEANDTHEINDEX there.

You are talking only about "git diff".  I am talking about the whole gi=
t
suite, because you have to worry about how such a proposal would affect
other parts of the UI.

=46or example, what, if anything, should be done to "git grep --cached"=
 and
"git apply --index"?  Leave them unchanged and only change "git diff"?

> I think this is a basic usability issue for a high-level porcelain
> command such as diff.

I do not think there is any usability issue.  Why do you think saying
STAGE in all capital makes it easier to _use_ instead of saying --cache=
d
(or --index-only)?  In either way, you need to understand the underlyin=
g
concept, such as:

 - there are three distinct kinds of states: a committed state, the sta=
te
   in the index (aka "what you have staged so far to the index"), and t=
he
   state in your work tree.

 - many commands understand that you want to operate on and/or inspect
   states in one or more of these states.  They default to what is ofte=
n
   used (e.g. "git diff" compares the index and the work tree, "git gre=
p"
   looks in the work tree, "git apply" patches the work tree [*1*]), bu=
t
   you can tell them to use different entities via options and argument=
s.

How does it help understanding any of the above to introduce STAGE?

The only difference I see is that you change "via options and arguments=
"
to "via arguments of different kinds, either a real commit object name =
or
some fake token that stands for the index or the work tree state".

Spelled out more explicitly, the current "options and arguments" works
this way:

   - when you want to work with a committed state (or more in general,
     with a tree-ish), you give the name of the commit;

   - when you want to work with the index, you say --cached;

   - when you want to work with both the index and the work tree at the
     same time, you say --index.

   - for all commands, working with work tree is the default, so there =
is
     no --work-tree option (we could add one, if you really want).

and the STAGE would work something like this:

   - when you want to work with a committed state (or more in general,
     with a tree-ish), you give the name of the commit;

   - when you want to work with the index, you say STAGE; not that you
     cannot have a ref called STAGE and if you have a file in the work
     tree whose name is STAGE you need to say "git command ... -- STAGE=
"
     to name the file, or "git command ... STAGE --" to clarify that yo=
u
     do not mean the file but you mean to use the fake toekn STAGE.

   - when you want to work with both the index and the work tree at the
     same time, you say STAGEANDWORKTREE (the same disambiguation cavea=
t
     applies).

   - for all commands, working with work tree is the default, but you c=
an
     still say WORKTREE (the same disambiguation caveat applies).

If anything, I think these capitalized fake tokens spread more confusio=
n.

Sure, "git diff HEAD STAGED" and "git diff HEAD WORKTREE" may make the
command lines look as if what these fake tokens represent are "sort of"
commits, but that is only true while you are using a command that has
modes to work on the index and/or on the work tree.

These fake tokens do not work everywhere, and it is not an implementati=
on
limit.  Fundamentally they cannot work everywhere.

Think.  What does "git log STAGE" mean?  Can you explain why it does no=
t
make any sense?

The user needs to be aware that the index is NOT a commit to understand
why such a command line doesn't make sense _anyway_.

I think it is counterproductive for the learning curve of new people to
make these different concepts look as if they belong to the same family=
 by
using STAGE (that look too similar to HEAD).  You seem to think it woul=
d
make it easier for them to learn if these different concepts are not
presented as different.  But they are different, and if new people star=
t
with a false impression that these are "sort of" commits, they need to
unlearn that at some point, and that "some point" is not "advanced use"=
=2E
Even bog standard "git log" exposes why hiding the conceptual differenc=
es
between these three states does not work.

Teach that different things are different, and express that in the UI.
That would avoid the confusion down the line.


[Footnote]

*1* "git apply" was originally done to replace use of "GNU patch" in
Linus's workflow because "patch" was deliberately too lenient, and as
such, it does not look at the index by default.  In a git repository, a=
s
long as a patch does not contain creation of new files, this is a good
default, too.  You can "git apply incoming.patch && git diff -U20" to s=
ee
what the patch does in wider context, for example.  If "git apply --ind=
ex"
were the default, the same can be done with "git diff -U20 HEAD" and it
won't risk forgetting new files.  But it is a huge backward incompatibl=
e
change that won't happen without deep thought.
