From: David Aguilar <davvid@gmail.com>
Subject: Re: MERGE_RR droppings
Date: Sat, 30 Jun 2012 17:19:17 -0700
Message-ID: <CAJDDKr5w2Q6aJcF48WbVyS=q54+iq=RAu9njJ18Wv8=OEbSrnQ@mail.gmail.com>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
	<CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
	<7v395ic5kq.fsf@alter.siamese.dyndns.org>
	<CABURp0qr7dZfEJZ7oDfG4ftm+cvQO1A9OG4Cv0wid3Mz8j7-iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 02:20:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sl7tQ-0002tB-9n
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jul 2012 02:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab2GAATS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jun 2012 20:19:18 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:62808 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab2GAATR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2012 20:19:17 -0400
Received: by ghrr11 with SMTP id r11so3559374ghr.19
        for <git@vger.kernel.org>; Sat, 30 Jun 2012 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V+gL/0S8En/K5LGFY5S7uaD64FYGfP8ZmDJfCzxz/PY=;
        b=cGU1M0gKx/Z2QCBoe8H/qPFk54geB61S/bGRsMGEPcsygb28msWGisoC8GG7EKeGDE
         VrgydQSVknX2IKdvxxoq18qC9fFjayY1dvZ8Y1HyKd8QiyQQIf4rLK0rrLlqR6UJ30KO
         VHeBalLfvaN4Uh6PWOSwHqrjjt4/9bU7IYuUnC3O/4IjBXeJjFHRnuDUBxlANHyIiCxP
         rogt0wcBRjCkISw4WSKNB0ksGYaltjKymNTFXPatQLURwBuM3EnA2L7Lo8I4mez9P2l6
         KPVd/wOcJXleKYk8KBcjr8+BGq9/fCLXbOs/ml9v422n0xNBlibAOyOyPgcglEOuR4Qb
         xARw==
Received: by 10.236.191.131 with SMTP id g3mr9615449yhn.59.1341101957188; Sat,
 30 Jun 2012 17:19:17 -0700 (PDT)
Received: by 10.147.41.5 with HTTP; Sat, 30 Jun 2012 17:19:17 -0700 (PDT)
In-Reply-To: <CABURp0qr7dZfEJZ7oDfG4ftm+cvQO1A9OG4Cv0wid3Mz8j7-iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200837>

On Tue, Jun 26, 2012 at 12:00 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Tue, Jun 26, 2012 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Phil Hord <phil.hord@gmail.com> writes:
>>
>>> git mergetool decides to use rerere-remaining based on the existence
>>> of the .git/MERGE_RR file:
>>>
>>>     if test -e "$GIT_DIR/MERGE_RR"
>>>     then
>>>         files=$(git rerere remaining)
>>>     else
>>>         files=$(git ls-files -u | sed -e 's/^[^ ]*      //' | sort -u)
>>>     fi
>>>
>>> But when I disabled rerere, I still had MERGE_RR files left over in my
>>> .git directory.   This causes git-mergetool to do the wrong thing.
>>>
>>> I do not know if the correct fix for this is to check rerere.enabled instead.
>>
>> I do not think basing the decision to use "ls-files -u" output upon
>> the use of "rerere" is a good thing for this script to do in the
>> first place.  Doesn't it close the door to future enhancements and
>> third-party mechanisms that do better job than rerere to help the
>> users auto-resolve conflicted merges?  They certainly do not have to
>> use GIT_DIR/MERGE_RR nor GIT_DIR/rr-cache, and "rerere remaining"
>> would not know which paths they handled already.
>>
>> After all, the user may have resolved the conflicts in his editor
>> but hasn't recorded the resolution to the index yet when he runs
>> mergetool, and the tool should handle such a path exactly like how
>> it currently handles the paths resolved by rerere in the working
>> tree.  But the above code will include such paths in the $files list
>> and throw them at the mergetool backends when rerere is not in use.
>>
>> This part of the code probably should be _inspecting_ the files and
>> the index to find out what still needs to be fed to the mergetools
>> itself.  Asking "rerere remaining" about things that it may not have
>> done (either the user edited the paths in the editor, or some
>> third-party mechanism resolved the conflicts already) does not make
>> much sense, methinks.
>
>
> I'll buy that.  But what should we be inspecting the files for?  What
> indicates the conflicts are resolved if not 'git add/rm'?
>
> Meanwhile, I run into this trouble when I get a conflicted
> git-stash-pop.  The first thing I do is invoke git-mergetool.  This
> fails with "No files need merging" in the case of a GIT_DIR/MERGE_RR
> leave-behind from some previous activity.  This is quite itchy, and so
> I am looking for the correct thing to do.
>
> [1]Does the MERGE_RR file need to be deleted more often?
> [2]Do we need some extensible way to indicate currently-unresolved files?
> Or something in-between these two?
>
> P

>From a mergetool perspective, just doing #2 would be nice.
We can have a "default" unmerged files provider that does the
`test -s .../MERGE_RR` check since that would probably deal with
this ugly edge case.

We can then teach this default thing to be smarter and skip text files
with no merge markers. Junio, is this what you were thinking?
This sounds like a nice way to me.
-- 
David
