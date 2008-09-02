From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Mon, 01 Sep 2008 19:07:51 -0700
Message-ID: <7vk5dvs3k8.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
 <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
 <7v63pftqmk.fsf@gitster.siamese.dyndns.org>
 <94a0d4530809011625n772fdc58h3ce1c04e79fb116f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 04:09:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaLKM-0001TG-UP
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 04:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYIBCIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 22:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbYIBCH7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 22:07:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYIBCH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 22:07:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 125E55EB8D;
	Mon,  1 Sep 2008 22:07:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1FFEE5EB87; Mon,  1 Sep 2008 22:07:53 -0400 (EDT)
In-Reply-To: <94a0d4530809011625n772fdc58h3ce1c04e79fb116f@mail.gmail.com>
 (Felipe Contreras's message of "Tue, 2 Sep 2008 02:25:14 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F669A794-7893-11DD-80B8-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94641>

"Felipe Contreras" <felipe.contreras@gmail.com> writes:

> On Tue, Sep 2, 2008 at 2:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> This is useful for SCMs that don't have proper changesets in each
>>> revision (monotone).
>>
>> I am still not convinced this is a proper workaround for the issue.  Why
>> shouldn't the feeder of fast-import be able to do this?
>
> If I could get a list of the files that changed on each revision from
> monotone I would, but that's not possible (I've asked in their mailing
> list). Apparently there's a way to feed the right data, but it's
> complicated.

Ok, I did not realize that you are not keeping track of what the parents'
trees look like when processing a merge commit.

But it raises a bigger question.  You earlier said:

    In monotone you can have something like:

     A
    / \
    B D
    | |
    C E
    \ /
     F

    If you do a 'delete foo' in B, and a 'delete bar' in F, you will get
    this stored in the merge revision (F):

    old_revision [C]
    delete "foo"
    delete "bar"

    old_revision [E]
    delete "bar"

    All the changes of the merged branches are stored again in the merge revision.

Now, does it talk about C and E because they are immediate parents of B
and D, or because they are immediate child of the common ancestor F?  I am
guessing it is the latter (what I mean is if it still talks aobut C and E
if you had more intermediate commits between B and C).  What the merge at
A records is not relative to B/D but relative to immediate child of the
fork point.

If that is the case, ignoring a delete that deletes already deleted path
is fine; I think it is the least of your problem.  The above description
makes me wonder what they say about modification.  Do they talk about the
same modification that happened between B and C when talking about A?  If
that is the case, it would be a far larger problem.  You cannot just say
"ignore any modification recorded in a merge, because they have been
already done on the branches being merged (i.e. up to B and up to D)", as
A may have to be an evil merge.

I have to wonder if you can "mark" the tree object of C, and when you
process merge A, represent A's tree by starting from that marked tree,
applying only the description to bring the state of "old_revision [C]"
to that of A (delete "foo" and delete "bar" in your illustration), and
recording that tree with parents B and D.

>>> @@ -1993,8 +1994,15 @@ static void file_change_cr(struct branch *b, int rename)
>>> ...
>>
>> Also what happened to the missing warning() for 'D'elete codepath?
>
> I'm not interested in it.

If I were asking for an unrelated "feature" when you are developing some
other feature, it would have been different, but I do not think that is a
good answer in this particular case.

Your --tolerant (or --ignore-errors) is about customizing strictness of
the error handling, and you know of a case where the error handling is not
strict enough in the existing code.  In other words, your "not interested"
is _not_ saying "It is an unrelated feature that I am not interested in";
it is saying "I am not interested in making my patch self consistent; a
half-baked hack that happens to solve my case is good enough for me."
