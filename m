From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Why is it bad to rewind a branch that has already been pushed out?
Date: Sat, 3 Feb 2007 10:40:54 +0000
Message-ID: <200702031041.13437.andyparkins@gmail.com>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 11:44:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDINW-0008Ka-KM
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 11:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946433AbXBCKoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 05:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946434AbXBCKoM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 05:44:12 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:27913 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946433AbXBCKoL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 05:44:11 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1122329nze
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 02:44:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MABqajauL0Od61M62E+s9CNHrg0PwfxgUpDrPUKptGEFCfCZtSUFeM+wcXg/W0zgrp2LcK/2VfZX9mB0ymPlAG0dTdvwd/v5cHtR48OMIv/RVPpdce5DY8Etd3xTB37BcsvYyQgYOuuOFS5Z5lwhSpXR8kXw6t9/6UGu+Zk/mEo=
Received: by 10.65.176.7 with SMTP id d7mr7590650qbp.1170499450447;
        Sat, 03 Feb 2007 02:44:10 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id q15sm7532547qbq.2007.02.03.02.44.06;
        Sat, 03 Feb 2007 02:44:07 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38562>

On Saturday 2007, February 03 06:40, Junio C Hamano wrote:

>     Also, don't use "git reset" on a publicly-visible branch that
>     other developers pull from, as git will be confused by history
>     that disappears in this way.
>
> I do not think this is a good explanation.  For example, if we
> do this:

I agree it's not a good explanation, I think it is good policy though.  
I love an oppourtunity to blather on and your post has given it to 
me :-)  I'm sure I'll be preaching to the converted though.

In the following I've assumed that both "h" and "a" commits are 
independent work, neither of which works on "j" (which isn't quite what 
you described).  It's not really appropriate for the tutorial, so I 
haven't really helped you.

-----------------
git's easy manipulation of branches encourages one to try to make 
history really tell the story of development.  It's more than just 
recording snapshots, there is information in the history itself - 
reasons for decisions can be recorded - separating and collecting 
commits into appropriate branches instead of one giant linear block.

As you say git is perfectly okay with the rewound branch and will do the 
Right Thing to preserve the changes.  However, it won't get the spirit 
of the changes right.

> (4) Alice pulls from me again:
>
> 	---o---o---o---j---a---a---*
>                   \             /
>                    h---h---h---h
>
> Contrary to the description, git will happily have Alice merge
> between the two branches, and never gets confused.

The problem is not that the working tree is wrong, it is that the 
history is wrong.  This sequence of development isn't best represented 
by a merge.  When we look at the history later, we'll see it as two 
branches, but that isn't true.

The graph shows that "j" was committed and then probably conflicted 
in "*" and fixed.  The problem is that you can't point to any non-merge 
commit that reverted/corrected "j" and explains why that wasn't a good 
idea - so the "story" that the history tells us is incomplete.  The 
correction was done just as a conflict resolution in "*".

Any of these would be correct:

1) "h" and "a" are parallel; "j" never happens

 ---o---o---o----a-----a----*
             \             /
              h---h---h---h

2) Alice corrects "j" with a "!j" revision - "!j" would then describe 
why "j" was wrong and what the fix was.  "h" would have to have nothing 
to do with the "j" topic in this case.

 ---o---o---o---j---!j---a---a---*
             \                  /
              h-----h-----h----h

Of course, both of these require information from the developer. (1) 
can't be done after the push has been done (because "j" is already "out 
there") and (2) requires that "h" know that Alice has fixed the problem 
and the Alice knows that the "j" problem needs fixing (and probably 
doesn't belong in Alice's branch anyway).

The only solution that keeps the history integrity, is the one that all 
the git manuals reccommend.

3) Don't rebase at all, correct the problem and record the correction.

  --o---o---o---j------a------a------*
                 \                  /
                  !j---h---h---h---h

That is - once a mistaken commit has been pushed out, it's there 
forever, accept that and don't rebase to before the last push.  
Sometimes it makes the history less pretty, but it makes it more right.  
Without "!j", no one would ever know what was wrong with "j".

In short - heed the warnings - you will get much better history if you 
don't rebase branches that have already been pushed upstream.
-----------------------

How about that as the explanation for the tutorial?  What do you mean I 
haven't simplified anything and have replaced one paragraph with a page 
worth of overly wordy ravings?  HOW DARE YOU!  :-)



Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
