From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: No one understands diff3 "Temporary merge branch" conflict markers
Date: Tue, 07 Jul 2015 18:16:36 +0200
Message-ID: <vpqbnfondsr.fsf@anie.imag.fr>
References: <CAOMsSXQVJsd0h1fnNMEJ5+cKpxbeF9mHraXva-wr6Y2zBCADbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Edward Anderson <nilbus@nilbus.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:16:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVY8-0007a6-N6
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516AbbGGQQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:16:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56422 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747AbbGGQQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:16:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t67GGYw4018336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Jul 2015 18:16:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t67GGa1l008917;
	Tue, 7 Jul 2015 18:16:36 +0200
In-Reply-To: <CAOMsSXQVJsd0h1fnNMEJ5+cKpxbeF9mHraXva-wr6Y2zBCADbg@mail.gmail.com>
	(Edward Anderson's message of "Tue, 7 Jul 2015 10:55:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 07 Jul 2015 18:16:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t67GGYw4018336
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436890597.61604@Xy8SqSyW8T/OHZKn7lj4IA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273584>

Edward Anderson <nilbus@nilbus.com> writes:

> I have the diff3 conflictstyle enabled and want to be able to
> understand how to understand its output when there are criss-cross
> merges requiring temporary merge branches.  Eg:
>
>     <<<<<<< HEAD
>       print(A);
>     ||||||| merged common ancestors
>     <<<<<<< Temporary merge branch 1
>       print(B);
>     =======
>       print(C);
>     >>>>>>> feature

I guess you are seeing the result of the recursive-merge.

>> The details are too advanced for this discussion, but the default
>> "recursive" merge strategy that git uses solves the answer by
>> merging a and b into a temporary commit and using *that* as the
>> merge base.

That is the point. We don't have a good common ancestor, so Git builds
one by merging the common ancestors. Then, two things can happen:

* The merge of the common ancestors is conflict-free. Then, we get a
  "sane" common ancestor.

* The merge has conflicts. In this case, the common ancestor that Git
  built has conflict markers. It is not a big issue, since when merging
  A, B, and ancestor(A, B), the result of the merge is either A or B,
  but never comes from ancestor(A, B). So, you never get to see the
  temporary ancestor(A, B), *except* when you request the common
  ancestor in the merge conflict.

It gets nasty since you get recursive merge conflicts, but you don't see
the recursivity. Let me try to indent your conflict:

 1 <<<<<<< HEAD
 2     unless admin
 3       fail Unauthorized.new("Admin only")
 4     end
 5 ||||||| merged common ancestors
 6         <<<<<<< Temporary merge branch 1
 7             unless admin
 8               fail Unauthorized.new("Admin only")
 9             end
10         ||||||| merged common ancestors
11             unless admin
12               fail Unauthorized.new
13             end
14         =======
15             fail Unauthorized.new unless admin
16         >>>>>>> Temporary merge branch 2
17 =======
18     unless admin
19         fail Unauthorized.new("Admin only")
20       fail Unauthorized.new
21     end
22 >>>>>>> feature

> It seems lines 6-16 are a conflict that occurred when merging the
> merge-bases.

Yes.

> That conflict could be resolved by merging the change in Temporary
> merge branch 1 (add "Admin only") with Temporary merge branch 2
> (convert multi-line unless to single-line) as this:
>
>            fail Unauthorized.new("Admin only") unless admin

That is probably what you would do if you resolved the conflict
manually, but while merging the common ancestors, Git found an ancestor
of an ancestor that was different from both ancestors being merged, and
there was a conflict. Asking you to resolve this conflict would be
essentially a loss of time since Git knows that the result won't appear
in the final merge, but only in the merge base.

 1 <<<<<<< HEAD
 2     unless feature.enabled_for_user?(UserIdLookup.new(params).user_id)
 3       fail Unauthorized.new("Requires setting #{label}.")
 4 ||||||| merged common ancestors
 5         <<<<<<< Temporary merge branch 1
 6             unless feature.enabled_for_user?(params[:user_id])
 7               fail Unauthorized.new("Requires setting #{label}.")
 8 =======
 9     unless feature.enabled_for_user?(params[:user_id])
10       fail Unauthorized.new("Requires setting #{label}.")
11 >>>>>>> feature

> This is the full conflict, and it doesn't seem to balance.

Right: I guess the merge-base was stg like

<<<<<<< Temporary merge branch 1
    unless feature.enabled_for_user?(params[:user_id])
      fail Unauthorized.new("Requires setting #{label}.")
|||||||
blabla 1
=======
blabla 2
>>>>>>> Temporary merge branch 2

But then, the actual merge happens, using this as merge-base. A conflict
occurs when the commits being merged and the merge-base are all
different. In your case, I guess the commits being merged were identical
on the next different hunks (the line "blablabla 1" probably was in both
commits being merged, which allowed the merge algorithm to move to the
next hunk), and there were no conflict in this hunk, hence you don't see
the merge base.

I hope this helps on the "light and understanding" part of your
question. Now, as of "what to do when I get this?", I would say: the
recursive merge-base was computed internally, but not really meant to be
shown to the user. You should probably ignore it and resolve the merge
by looking only at the 2 sides of the conflict ("ours" and "theirs").
Sorry, this is probably not the answer you expected, but it's the best I
can give ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
