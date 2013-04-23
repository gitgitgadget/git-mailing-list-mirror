From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Premerging topics (was: [RFD] annnotating a pair of commit objects?)
Date: Tue, 23 Apr 2013 16:51:39 +0200
Message-ID: <CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUeZQ-0001YF-9p
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab3DWOvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:51:41 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:54465 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab3DWOvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:51:40 -0400
Received: by mail-qe0-f50.google.com with SMTP id a11so436947qen.9
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZEugxIhWVNkeVpFPhQyAlGyhvZDBBx4fopMXZ4ssL2Q=;
        b=OOcOO6QeUFcEXmxGdvykZsBGUl/5eMUhCRuzyq9CaXvr2BjHydd590Hc56heJNcO+G
         7BA9kJ9486owCFbqten5p4AQr6CfQ7Uy/0psoCqY7sfgTcHoHlqbKDsl1SxP71ZCu7/p
         uknupFU45o38fxn9TaGt7Vl+0euO4CfW+26/bXBwRMftX0aXHweiY6Com5hQ0CEQFMfl
         kv/2XY8hQzjZqzlKPovrdLxDhZS0FVz1Nfw1GuejpSfmMNipR9CBhGPx4qZQ4FnT0Vt0
         ugSlvNHJgrrR47WY2AmR2CHJkWYjZH0MFIKZ/s0/UPZfhVxcYQCXWeH3afsn/+K/VDh7
         zyyw==
X-Received: by 10.229.180.2 with SMTP id bs2mr6486830qcb.52.1366728699326;
 Tue, 23 Apr 2013 07:51:39 -0700 (PDT)
Received: by 10.49.30.9 with HTTP; Tue, 23 Apr 2013 07:51:39 -0700 (PDT)
In-Reply-To: <CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222168>

On Tue, Apr 23, 2013 at 8:34 AM, Johan Herland <johan@herland.net> wrote:
> On Wed, Apr 10, 2013 at 10:35 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> Data-structure
>> ==============
>> We could use a note ref to store the pre-merge information. Each commit
>> would be annotated with a blob containing the list of pre-merges (one
>> sha1 per line with sha1 pointing to a merge commit). The commit on the
>> other side of a merge would also be annotated.
>> The choice of the refname could be done like we do with notes:
>> - Have a default value
>> - Have a default value configured in config
>> - Use a specific value when merging/creating the pre-merges
>>[snipped]
>> Cons
>> ----
>> 4. Checking connectivity means opening the blob and parsing it
>
> Can you solve this problem with a tree object, instead of inventing a
> specially-formatted blob?

That looks like a good idea.

> I.e. given pre-merge info P for a merge between commits A and B: A is
> annotated by a tree object that contains all pre-merges where A is
> involved. Each entry in the tree object has a filename and a blob
> SHA1; we store other commit involved in this pre-merge (B) in the
> filename, and the pre-merge data (P) in the blob SHA1.

But P is a commit(/merge with two parents), not a blob. Can we have trees
pointing to commits instead of blobs ?

> A nice side-effect of using tree objects to store pre-merge entries,
> is that you can do a tree-level merge of them, and it'll do the Right
> Thing (assuming two-way merge with no common history), i.e. perform a
> union merge, and leave you to handle conflicts of individual
> pre-merges (i.e. you'll only get conflicts when both sides offer
> different pre-merge data for A + B).

I'm definitely not sure what you mean here, especially with "tree-level
merge". Also I think we could be doing three-way merges. But I'm
no merge-strategies expert, so I'm kind of confused.

>> 5. Regular notes and pre-merge notes have to be handled separately
>> because of 4.
>
> Sort of, but you get that for any automated usage of notes for a
> specific purpose. Just look at the notes-cache mechanism in
> notes-cache.{h,c}. That's another example of functionality layered on
> top of notes that makes assumptions on how its notes trees are
> structured.

Thanks, I will have a look at it.

>> The goal is to merge branches J and B using existing pre-merges.
>>
>> E0. Create an empty stack S
>> E1. Create set of commits 'J..B' and 'B..J' (that is probably already done)
>> E2. For each commit C in smallest(J..B, B..J), execute E3
>> E3. For each premerge P in notes-premerge(C), execute E4
>> E4. If one of both parents of P belongs to biggest(J..B, B..J), stack P in S
>
> I don't think _both_ parents of P can belong to biggest(J..B, B..J).
> AFAICS J..B and B..J must always be completely disjoint sets of
> commits (this is easier to see when you consider that "A..B" is
> equivalent to "B ^A" for any commits A and B), and in E2/E3, you have
> already made sure that P has a parent in one of them. There is then no
> way that the same parent can occur in the other set, so you have at
> most _one_ parent in the other set.

I agree with that. After step E3, one of the parent belongs to one of
the two branches. Step E4 makes sure the other parent belongs to the other
branch (and not another unrelated branch).

>> E5. Merge J and B using all pre-merges from S
>
> This is where things get complicated... :)
>
> First there is one important thing that I have not seen a decision on
> yet (maybe this was discussed in an earlier thread?):
>
> Given pre-merge data P for commit A and B, does P encode the merge of
> the entire history up to A with the entire history up to B, or does it
> only encode the merging of the changes introduced in A with the
> changes introduced in B? In other words, are we merging snapshots or
> diffs?
>
> In the former case, we only need to find the most recent commits A and
> B on their respective branches - for which P exists - and then execute
> that one P (or at most two Ps, if there is a criss-cross pre-merge
> situation). In the other case, however, we need to enumerate all Ps
> that apply to the two branches, and find a way to execute them
> chronologically, dealing with missing Ps and conflicting Ps along the
> way. IMHO, only the former approach seems practically solvable.
>
> So you do not need to enumerate all Ps in J..B vs. B..J, you only need
> to find the _most_ _recent_ P, and execute that one.

Indeed, we only need to know the most recent. That's a good point.

       B1   B2    B3
    O---o---o-----o
    |      / \      \
    |    P1  P2     M
    |    /    |     /
     \__o_____o___o
       J1   J2  J3

In this use-case, we can use P1 to compute P2, and then we only need P2
to compute the real merge M. The idea would be to use P1 as an implicit
third parent to the pre-merge P2, and then P2 as an implicit third
parent to the real merge M.

>>     $ git pre-merge topicA topicB topicC
>>
>> to find, resolve and store all interactions between the topics.
>
> Let's leave out octopus merges for now, and only concentrate on two
> branches at a time.

I was not thinking about octopus merge here, but an easy way to
pre-merge many topic in a "single step", so it could be used like this:

    $ git pre-merge $(git for-each-ref refs/heads/??/*)

And that would pre-merge each pair of branches between each other. That
is: "n choose 2" (with n the number of branches given)

> Hope this helps,

It does, thanks !

> PS: Could you also use this mechanism to store rerere information?

That's one of the primary goal. The problem it would solves are:
- You could apply pre-merges even on clean merges, while rerere focuses
on conflict resolution. (typical use case is: somebody renames a
function in one topic, somebody decides to use that function in another
topic. You won't have a conflict in this situation but the code no
longer compiles.)
- You could easily pull/push pre-merges while today there is not built-in
mechanism to exchange/remote-save rerere's

Cheers,
Antoine
