From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Problem with contrib/hooks/post-receive-email
Date: Fri, 19 Mar 2010 13:44:13 -0500
Message-ID: <pT1haZZsyBxOUoBofAkY_SnkAbeYO1Pm-blvjUr1xIzpQgSbduiE4w@cipher.nrlssc.navy.mil>
References: <m3vdcsq0hl.fsf@winooski.ccs.neu.edu> <ho09bh$hdh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 19:44:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NshBF-0002go-T3
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 19:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab0CSSoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 14:44:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55390 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab0CSSoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 14:44:16 -0400
Received: by mail.nrlssc.navy.mil id o2JIiDEC021299; Fri, 19 Mar 2010 13:44:13 -0500
In-Reply-To: <ho09bh$hdh$1@dough.gmane.org>
X-OriginalArrivalTime: 19 Mar 2010 18:44:13.0334 (UTC) FILETIME=[2B8EB360:01CAC794]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142631>

On 03/19/2010 11:39 AM, Andy Parkins wrote:
> Eli Barzilay wrote:
> 
>> The post-receive-email script goes out of its way to avoid sending
>> commits twice by filtering out commits that are included in existing
>> refs, but if more than one branch changes then some commits can end up
>> not being reported.  For example, I made two commits A and B, made one
>> branch point at A and another at B, and pushed both -- neither of the
>> resulting two emails had A.
> 
> <Andy starts crying>
> 
> I can't see any way to deal with this case easily with post-receive-email as 
> it is.  It inherently processes ref-by-ref.  The relevant bit of script is 
> in generate_update_branch_email().  The comments explain how the same 
> problem is addressed for another developer changing the same branch before 
> post-receive-email runs, but after the update is performed.  I think the 
> same method could be applied.
> 
>   git rev-parse --not --all | grep -v $(git rev-parse $refname)
> 
> This line is where the particular branches are being included and excluded.  
> The problem you have is that "--all" means "--all-at-the-moment", and you 
> want "--all-as-they-were-before-the-update".
> 
> So, --all will have to go, and a manual list built instead.  The supplied 
> change list includes all the information necessary:
> 
>  ref1_oldrev ref1_newrev ref1
>  ref2_oldrev ref2_newrev ref2
>  ref3_oldrev ref3_newrev ref3
>  ref4_oldrev ref4_newrev ref4
> 
> Let's say there is also a ref5 and ref6 in the repository.  The revision 
> list we want for (say) the ref1 call to generate_email would be:
> 
>  ref1_newrev
>  ^ref2_oldrev
>  ^ref3_oldrev
>  ^ref4_oldrev
>  ^ref5
>  ^ref6
> 
> And similarly for ref2, ref3 and ref4.  It seems to me that it needs a hash 
> table keyed on the refname, but I have no idea how to do that in bash.
> 
>  %originalreftable{"ref1"} = "^ref1_oldrev"
>  %originalreftable{"ref2"} = "^ref2_oldrev"
>  %originalreftable{"ref3"} = "^ref3_oldrev"
>  %originalreftable{"ref4"} = "^ref4_oldrev"
>  %originalreftable{"ref5"} = "^ref5"
>  %originalreftable{"ref6"} = "^ref6"
> 
> This table would be sufficient to create the revision list for every 
> generate_email(), because each generate_email() knows which ref it's being 
> updated for, so could easily do:
> 
>  %originalreftable{$myref} = "$mynewrev"
> 
> Before using the table (and restore it afterwards).
> 
> In short: yuck.  It feels an awful lot like its pushing the boundaries of 
> what is sensible to do in shell script.

Here's how I did it.  I did this so quickly and so long ago that I
forgot about giving it a final think-through and submitting it.  Now
that I look at it again, and the fact that it has been working for a
good long while, it doesn't look as ugly as I remember it.

What do you think? Sane enough?

Warning: copy/pasted so beware white space corruption

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 58a35c8..42dc4e7 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -619,9 +619,8 @@ show_new_revisions()
                revspec=$oldrev..$newrev
        fi

-       other_branches=$(git for-each-ref --format='%(refname)' refs/heads/ |
-           grep -F -v $refname)
-       git rev-parse --not $other_branches |
+       git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
+               sed $sed_rev_script |
        if [ -z "$custom_showrev" ]
        then
                git rev-list --pretty --stdin $revspec
@@ -680,10 +679,22 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
        # Output to the terminal in command line mode - if someone wanted to
        # resend an email; they could redirect the output to sendmail
        # themselves
+       sed_rev_script="-e s/$3/$2/"
        PAGER= generate_email $2 $3 $1
 else
+       numrevs=0
        while read oldrev newrev refname
        do
-               generate_email $oldrev $newrev $refname | send_mail
+               sed_rev_script="$sed_rev_script -e s/$newrev/$oldrev/"
+               oldrevs[$numrevs]=$oldrev
+               newrevs[$numrevs]=$newrev
+               refnames[$numrevs]=$refname
+               numrevs=$(($numrevs + 1))
+       done
+       i=0
+       while [ $i -lt $numrevs ]; do
+               generate_email ${oldrevs[$i]} ${newrevs[$i]} ${refnames[$i]} |
+                       send_mail
+               i=$(($i + 1))
        done
 fi
