From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
Date: Fri, 19 Feb 2010 18:29:23 +1100
Message-ID: <2cfc40321002182329q7b8c5b90nbd77a4e0678cd9c8@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com>
	 <20100218051129.GD10970@coredump.intra.peff.net>
	 <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com>
	 <32541b131002181913t24989addr84b612787a2f8c48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:35:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiNOK-0007If-UG
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab0BSHfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 02:35:06 -0500
Received: from mail-pz0-f192.google.com ([209.85.222.192]:47515 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660Ab0BSHfE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 02:35:04 -0500
Received: by pzk30 with SMTP id 30so1039987pzk.22
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QSMzKeQM4fOeO1X31XW8638KATLTK9Viuz1A6/WB2fw=;
        b=xRZLA/Kiflw3pA51iahCz6uX8Bq2tAlZPiBgPZZ24LfaXUtloqByL/zK2B4C6yNKEh
         A9vJHGuTkN9MduwbXfpS7PPxLWtQxTdoXwpkbKzwbekVTfbM5x3BM6J/dyKHUESkWUQg
         Crpr+GdS0zgKKbsJrKzgOs8FFrwcbpWzg/8hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Cn9OZ6jlJQj1kxyGuLFCg44n21qRj5n+lOPOdnq9/YR1cGm3gQK6YTHvfpTEcR2ZVN
         tXPQu5ze80F5sOK/fwplkjSApSGNlzVHkywfsM1YZHtp2WwfJ7f1YkadEfZ/CNCys1av
         DKet7HLMNsxTNkLVFD7W2vlaPD8PkNiBKnSJk=
Received: by 10.114.119.3 with SMTP id r3mr1273431wac.16.1266564563702; Thu, 
	18 Feb 2010 23:29:23 -0800 (PST)
In-Reply-To: <32541b131002181913t24989addr84b612787a2f8c48@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140426>

On Fri, Feb 19, 2010 at 2:13 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Thu, Feb 18, 2010 at 8:04 PM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>
> Using the linearization mechanism you propose, you end up producing a
> false history: one in which, other than at certain checkpoints, the
> code doesn't even work. =A0What's the point of such a history? =A0It
> neither reflects the true development history (ie. pre-linearization)
> nor a more useful, idealized version of history (ie. one that compile=
s
> at every point and adds features in a rational order and is useful fo=
r
> git bisect).

If there are no merge conflicts in the original history, then there
will be no merge conflicts in the rewritten history, and therefore no
error deltas.

The point of creating the linearization of this kind is that if there
are no merge conflicts, it flattens the hierarchy in a form that is
immediately rebaseable and will faithfully represent the work the
developer would have done if they had decided to rebase at each merge
instead of merging.

If there are merge conflicts, then it produces a history that
indicates the extent the merge conflict rectification that will be
needed which then allows you to decide whether you want to attempt the
rebase.  If you decide to rebase, then it should just be a question of
deleting the delta commits and fixing the merge conflicts as they crop
up.

My contention is that most of the text diffs in the rewritten history
(with the exception of the error deltas) will actually represent the
intent of the developers original changes although until the
rectification work is done the commit sequences bounded by error
deltas would not be usable for git bisect, compiles or any other
purpose that requires an intact tree.

In the no  conflict case, it is not clear to me that the history
resulting from your script is immediately rebaseable, precisely
because of the presence of the merge commits [ feel free to correct me
if I am wrong about that ] . With my approach, the merge commits
dissolve away - there is nothing to edit.

>
> It doesn't even provide something useful for patch review, since half
> your patches will have randomly-selected conflict resolutions (ie.
> changes to unrelated code that never should have changed) thrown in.
> You'd be better off reviewing patches from the original history, and
> just ignoring merge commits, which is what 'git format-patch' or just
> 'git log -p' would do automatically.

The conflict resolutions are far from random. They are precisely
chosen to reconstruct the blob in such a way that all subsequent picks
in the same path segment apply cleanly.  This is  a deliberate choice
because we know that conflict will be resolved eventually. We are
temporarily deferring correctness to allow us to automatically proceed
with a speculative rewrite of the merge history as a rebase history.
The extent of incorrectness in the history is well delimited and well
understood.

>
> The result is also still not suitable for submission upstream: the
> sync points (where the files actually match what the developer had in
> his tree) are the only places where the code is even likely to
> compile, and yet they *also* include all the code brought in by prior
> merges, which you already said include code that shouldn't go
> upstream.

I agree it is not suitable for many purposes. I contend that what it
allows one to do is rewrite the merge history as a rebase history in a
form that allows the merge conflict resolutions to be deferred. In the
no conflict case, the linearisation is immediately usable (with no
further edits) as a rebase source.

>
> The linearization script I gave you at least has these interesting
> characteristics:
>
> - If the original history compiled at every point, then the linearize=
d
> history does too.
>
> - It is an accurate representation of the successive states of the
> tree experienced by the original developer.
>
> - You can use 'git rebase' to incrementally rearrange and combine
> patches until they make enough sense to submit upstream.
>
> - It is easy to separate out merges (which usually don't need patch
> review) from individual patches (which do).
>
> - If some merges added useless code, you can remove them completely
> with rebase by just removing a single patch from the list.
>
> Of course, even with this script, it will still take work (rebasing)
> to produce code that's polished and ready to go upstream. =A0But I'm =
not
> sure there's a way to automate that without producing interim version=
s
> that are much, much worse.
>
> Have fun,
>
> Avery
>
