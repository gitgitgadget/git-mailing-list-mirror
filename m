From: Phil Hord <phil.hord@gmail.com>
Subject: Re: MERGE_RR droppings
Date: Mon, 2 Jul 2012 15:36:32 -0400
Message-ID: <CABURp0rY6SMiP8NKO4RMGvkta_nYubwt4bq3DL7-UEJJPK56cA@mail.gmail.com>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
 <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
 <7v395ic5kq.fsf@alter.siamese.dyndns.org> <CABURp0qr7dZfEJZ7oDfG4ftm+cvQO1A9OG4Cv0wid3Mz8j7-iA@mail.gmail.com>
 <CAJDDKr5w2Q6aJcF48WbVyS=q54+iq=RAu9njJ18Wv8=OEbSrnQ@mail.gmail.com> <7vmx3i3agg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com, tytso@mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 21:37:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlmQd-0002xx-AC
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 21:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab2GBTgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 15:36:54 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53648 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2GBTgx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 15:36:53 -0400
Received: by ghrr11 with SMTP id r11so4491096ghr.19
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AeamPw3BBgIgv0v9bH92ZOHkA0XJf89IedhnWtaZlqg=;
        b=N6xBKbqOprrE4wVwSG8dGQrljMgvQI4/khtdVLuJ4jA7Elm8tbKDf+5L11ijWs0nUN
         PlNJ8Q65Hi5oCzwu+Y2IlwecXFr/GDm4xFBSitYuzKevsGgUsTSQXQ7Rt2IMVEC9s2f0
         fPwHe307AeK6WtAiaQR/uRsQnXjYI54NeUDROINketzQLowGDbCL3ISdTvW4xjPg7P2v
         VBdv67mJUC/uJ2fzMxFhi7TJoe3cpEz6v4A/cbrhheqzQGxh4BZiYumUPowQXLSYWEeJ
         EiusvoN3wd4ou6RbGyhr1XK5y885vr/K0dZFZq1U7BMAOtGARTxY1Vh6/OKRSZM4rqsW
         lfjA==
Received: by 10.236.75.163 with SMTP id z23mr17742034yhd.3.1341257812588; Mon,
 02 Jul 2012 12:36:52 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Mon, 2 Jul 2012 12:36:32 -0700 (PDT)
In-Reply-To: <7vmx3i3agg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200856>

On Mon, Jul 2, 2012 at 3:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> We can have a "default" unmerged files provider that does the
>> `test -s .../MERGE_RR` check since that would probably deal with
>> this ugly edge case.
>>
>> We can then teach this default thing to be smarter and skip text files
>> with no merge markers. Junio, is this what you were thinking?
>> This sounds like a nice way to me.
>
> I am not sure what I were thinking ;-) so let me think aloud.
>
> In any case, once the user says (either via directly using "git add"
> or using the command via the mergetool) the path is resolved,
> mergetool would no longer want to touch it, until the user says
> "oops, the resolution was a mistake; pleae make it unresolved again"
> with something like "git checkout -m".  So in this message, I'll
> think only about the case where the index is still unmerged.
>
> The working tree files may be in one of these states:
>
>  1. It may still be the same as the conflicted state after the
>     three-way merge proper gave the user, perhaps with conflict
>     markers in the text.
>
>  2. rerere or some other mechanism (this includes manual editing or
>     previous run of "mergetool") may have resolved the conflict
>     fully.
>
>  3. Or such a mechanism may have only half-resolved the conflict.
>
> As far as I can see, the mergetool machinery, once it decides to
> feed a path to the mergetool backend, ignores what is in the working
> tree file, and uses the stage #2 (i.e. the state before merge
> happened) as LOCAL (and stage #1 as BASE, stage #3 as REMOTE) to
> redo the entire three-way merge from scratch.
>
> So "ask rerere what it hasn't resolved" would only safely work for
> the first kind, where the state in the working tree file is known to
> be expendable.

Yes, and specifically it would only work with 'rerere' and not the
"future enhancements and third-party mechanisms" you imagined earlier.

> If it can somehow determine paths that have been fully resolved, it
> can (and should) skip redoing the three-way merge.  And that is
> probably what the "if test -s MERGE_RR; then rerere remaining; fi"
> logic under discussion is about.
>
> But that will still risk losing any half-resolution done by external
> means (the third category), including manual editing.  Is that a
> good thing?
>
> Perhaps there were two conflicting hunks and one of them the user
> has resolved manually, and then the other one was a bit more complex
> than the user wanted to resolve in the editor and that is why the
> user is now running "mergetool" to resolve it in a GUI.  "rerere"
> will say "I didn't touch that path", and "mergetool" will happily
> ignore user's manual resolution of one hunk in the working tree, and
> the user ends up redoing the whole three-way merge for the path, no?

I think this is the case in practice, but the workdir file should
still be available to the mergetool if it is smart enough to consider
it.  It is not quite stomped on, though the machinery does expect the
merge-result to wind up in the workdir file.

Consider also that after a "successful" mergetool execution, the file
is automatically marked as resolved by being added to the index.
Therefore, it is not practical for mergetool to be used first to
partially merge the file in the hopes of using another tool to
complete the merge in a later step.  This is opposite from the default
and recommended operation mode of rerere, which does NOT add the
resulting resolution to the index.  And this results in more "states"
for a file to be in after a merge.

> Even if you switch that logic from "asking rerere" to "look for
> conflict markers", it wouldn't change the story.

No, this really calls for some meta-information storage about the
file's status, such as marking the file as "fully resolved" or
"partially resolved" in some sort of checklist, maybe even with line
numbers indicating regions in :1:file.txt and :3:file.txt which are
still TBD (though this "resolved regions" business seems useless to me
right now). Maybe some merge tool can learn to preserve the
partially-resolved file as a partial target in some kind of iterative
process.  But to do that, we need to have some way to manage this
meta-info.  The index comes to mind as a likely container, but a state
file similar to MERGE_RR is easier and safer (unless the index already
has some extensibility here).

> Perhaps "rerere
> remaining" was a useless addition, and instead we probably should
> have a way to ask "rerere" if the working tree file is different
> from what the mergy operation left before "rerere" tried to work on
> it?  If it is unchanged, then we know nobody (either the user, any
> third-party mechanism, or rerere) touched it and it is safe for a
> mergetool backend to redo the three-way merge from scratch (i.e. we
> know that is in the first category).

Yes, though technically the user could have previously recorded the
file as "resolved" with the change markers in place, so an unchanged
file might NOT mean that it still needs to be resolved.  This seems
like a silly case to consider, but I can see it extending to other
kinds of diff-markers which do not show up in the file itself, for
example, and we would be no further.

> Otherwise, you are risking to stomp on the change that may have been
> done between the time the mergy operation was done and "mergetool"
> was started.

So  'mergetool' is not useful to examine the result of a successful
rerere-merge, for example. because it will certainly ignore the
already-merged bits in the workdir.  We also do not want to ask the
user to reconsider the rerere resolved files during her mergetool
session.

There certainly are way more corner cases in this niche than I ever expected.

The normal rerere action is to apply previous resolutions in the
workdir but not in the index.  This is so the user can recognize that
the change needs closer inspection because she does not trust rerere
to always merge the project perfectly.  These files still appear in
ls-files --unmerged.  rerere-remaining allows git to recognize those
files. It allows git-mergetool to merge the files rerere did not touch
and also avoid stomping on the rerere resolutions which are waiting in
the workdir for the user's attention.

I personally do not like all these slightly-different cases.  It
causes the rebase-mergtool-continue cycle to lose all consistency for
me.    I am eager to help sort this out into something reasonable. I
hope we can decide what that should look like.

In the meantime, I will try to find a way to clean out stray MERGE_RR
files before I stash-pop.

Phil
