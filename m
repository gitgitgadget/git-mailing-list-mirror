From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] diffcore-rename: don't consider unmerged path as
 source
Date: Fri, 18 Mar 2011 10:00:44 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1103180717230.7736@debian>
References: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vmxkszzw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 15:01:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0aEt-0008Nz-2T
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678Ab1CROA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:00:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62476 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab1CROA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 10:00:56 -0400
Received: by vws1 with SMTP id 1so3651716vws.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=WKRxOyvQqpTvcHSWwh4gAkVgvz67SjolypihiWmSJSo=;
        b=wCHz8ImtALnrTEx0gNIa+/vlaA4Gfj0oXMGkHzivTeZONYEQduvPo4fCqg2d4vZ/bm
         6WOtX+cTOwh3yEYnKpzsFbYk8h//SOUK8RCWASYS2d54NijLTXMT8MyN1yYSVGM9bumh
         RHO3wMPonDlUdqHnP2j8CPrOggsxtB/XtWgSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=opIKrj0lbdxuUbiTQ3fc9S4/EwCBkISCDkgw5IcKouXvOmgAW2HfCl6dFynsnMn3gZ
         lxfzKjhZPw6q6tkK1H76B3eqKc5tlP//7I5JCa9+ifAirarXP2e425ClxtCugZ/fTRk+
         IULL5nA1EzJUlMye+COiaT6Q5OCvZht5AoAQ8=
Received: by 10.52.71.148 with SMTP id v20mr1556433vdu.266.1300456855040;
        Fri, 18 Mar 2011 07:00:55 -0700 (PDT)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id a11sm917855vdu.1.2011.03.18.07.00.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 07:00:54 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7vmxkszzw5.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169318>

On Thu, 17 Mar 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > The output from 'git status' and 'git diff-index --cached -M' is
> > broken when there are unmerged files as well as new files similar to
> > the unmerged file (in stage 1).
> >
> > When two copies have been created the output is:
> >
> > $ git status -s
> > C  original -> exact-copy
> > R  original -> modified-copy
> >  U original
> 
> The first column of
> status output is about comparing the HEAD and the index, and the second
> column is about comparing the index and the working tree

According to git-status's man page, that is true for paths without
merge conflicts only. For paths with merge conflicts, the two letters
represent each side of the merge. That is why I thought " U" (note the
SP) was invalid. Reading the documentation again, I see that ' '
actually means 'unmodified'. I'm still not sure it is correct
though. First, "original" was modified on both sides in this case,
which is of course the reason it had a merge conflict. Second, the
meaning of " U" is not described in the table in the man page. I have
always assumed that the table is supposed to be complete.

Either way, the fact that "original" is completetly missing from the
verbose 'git status' output must surely be incorrect.

> When comparing an unmerged index with the working tree, the comparison
> itself does not make much sense.  When producing textual diff,
> "diff-index" tends to give the difference between stage #2 and the working
> tree in order to show the difference from "our" version and the result of
> the incomplete merge, but when we need to show the result concisely in the
> "status -s" output, the fact that the index is unmerged is more important
> than the incomplete merge result in the working tree is different from the
> original, so we show "U".
> 
> So I think "U" is perfectly good there.

For completeness, I should say that I think the output from 'git
diff-files' is correct (and unchanged by this patch); only 'git
status' and 'git diff-index' showed incorrect (as far as I can see)
output.

$ git diff-files --name-status
U	original
M	original

Same output with '-M' or '-C'.

> About the comparison between HEAD and index, "original" in HEAD is copied
> to "exact-copy" in the index, and "modified-copy" in the index has a very
> similar contents as "original" in HEAD. It may be a bug that the latter is
> shown as "R" and I suspect that is because the code mistook the unmerged
> entry in the index as missing.  Turning that "R" to "C" may be worth
> doing. Change the code that says "ah, the index is unmerged at this path,
> so treat it as if it is not there" to "if the unmerged path does not have
> stage #2 entry, it is missing".

Exactly. That is what this patch tries to do (although not for 'git
status', but for 'git diff-index --cached -C', see later answers).

Speaking of stage #2, I think my references to stage #1 in the commit
message should have been referring to stage #2.

> > There are several errors here: 1) "original" has invalid status " U",
> > 2) "modified-copy" is listed as a rename, even though its source
> > ("original") still exists, and 3) "exact-copy" is detected as a copy,
> > even though 'git status' is only supposed to show renames
> 
> The prose is good but if you illustrated a bug with a command output,
> please follow it up with another command output that you think is the
> right output.

Makes sense. This is the output after this patch:

$ git status -s
A  exact-copy
A  modified-copy
UU original

> I don't think anybody said "only supposed to show renames", but I suspect
> that the recent lt/diff-rename topic may affect this part of the output.

wt-status.c sets rev.diffopt.detect_rename = 1 (==
DIFF_DETECT_RENAME). I think that means that it should only detect
rename, not copies. With the patch applies, the files show up as added
(as show in above). I tried changing it to DIFF_DETECT_COPY and then,
not surprisingly, 'git status' showed them as copies instead (even
with the patch applied).

While on the subject, I almost asked why 'git status' does not detect
copies, but I never did. I kind of suspected that it might be too
slow. Could there be some other reason?

> > Fix these problems by making diffcore-rename not consider unmerged
> > paths as source for rename detection. For simplicty, don't consider
> > the path independent of the type of merge conflict, even if the path
> > is deleted on at least one side. Still consider unmerged paths as
> > source for copy detection.
> 
> I don't think the part after "Still..." is justified enough.
> 
> For that matter, everything after "For simplicity..." is not justified
> enough. What are you sacrificing in return for that simplicity?  "Ideally
> we should show X but because we don't consider these we end up getting Y
> but that still is better than what we get today which is Z" is missing.

I wasn't really sure how it should work, so I just punted and said
"For simplicity" :-). What I was not sure about was what stage to
compare to. For example, for "deleted by us" conflicts, the most
likely outcome is that the file will be deleted, so it could make some
sense to make it eligible for rename detection. This would mean that
if a similar file was added by "them", it would be described as a
rename in the git-status output. The same applies to "deleted by us",
but if I understand correctly, we don't have the stage #3 content
available to compare to at this point in the code, and even if we did,
it would be inconsistent with how the diff is done with stage #2
everywhere else.

I don't have time to think more about this right now, but I hope the
above explains what I simplfied from. I'll think a bit more about this
later and might get back with another mail.

> > Also not sure about the "while at it" stuff...
> 
> Because "while at it" is by definition stuff that is not essential, don't
> do "white at it" if you are not sure, if it adds unnecessary noise and
> burden on reviewers.

I changed it because I thought it is slightly more clear that
DIFF_DETECT_RENAME, as opposed to 1, does not detect renames. I could
either explain that reason in the commit message, do it in a separate
patch, or just drop it completely. I don't have a strong
opinion. Which would you prefer?

Thanks for reviewing. I will try to include much of the above in the
commit message in a re-roll.


/Martin
