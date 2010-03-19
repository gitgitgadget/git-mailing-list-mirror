From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Problem with contrib/hooks/post-receive-email
Date: Fri, 19 Mar 2010 16:39:12 +0000
Message-ID: <ho09bh$hdh$1@dough.gmane.org>
References: <m3vdcsq0hl.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 17:39:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsfEY-0000OI-Sq
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 17:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab0CSQjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 12:39:33 -0400
Received: from lo.gmane.org ([80.91.229.12]:40596 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab0CSQjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 12:39:32 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NsfEQ-0000Jh-UR
	for git@vger.kernel.org; Fri, 19 Mar 2010 17:39:31 +0100
Received: from 194.70.53.228 ([194.70.53.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 17:39:30 +0100
Received: from andyparkins by 194.70.53.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 17:39:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.228
User-Agent: KNode/4.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142617>

Eli Barzilay wrote:

> The post-receive-email script goes out of its way to avoid sending
> commits twice by filtering out commits that are included in existing
> refs, but if more than one branch changes then some commits can end up
> not being reported.  For example, I made two commits A and B, made one
> branch point at A and another at B, and pushed both -- neither of the
> resulting two emails had A.

<Andy starts crying>

I can't see any way to deal with this case easily with post-receive-email as 
it is.  It inherently processes ref-by-ref.  The relevant bit of script is 
in generate_update_branch_email().  The comments explain how the same 
problem is addressed for another developer changing the same branch before 
post-receive-email runs, but after the update is performed.  I think the 
same method could be applied.

  git rev-parse --not --all | grep -v $(git rev-parse $refname)

This line is where the particular branches are being included and excluded.  
The problem you have is that "--all" means "--all-at-the-moment", and you 
want "--all-as-they-were-before-the-update".

So, --all will have to go, and a manual list built instead.  The supplied 
change list includes all the information necessary:

 ref1_oldrev ref1_newrev ref1
 ref2_oldrev ref2_newrev ref2
 ref3_oldrev ref3_newrev ref3
 ref4_oldrev ref4_newrev ref4

Let's say there is also a ref5 and ref6 in the repository.  The revision 
list we want for (say) the ref1 call to generate_email would be:

 ref1_newrev
 ^ref2_oldrev
 ^ref3_oldrev
 ^ref4_oldrev
 ^ref5
 ^ref6

And similarly for ref2, ref3 and ref4.  It seems to me that it needs a hash 
table keyed on the refname, but I have no idea how to do that in bash.

 %originalreftable{"ref1"} = "^ref1_oldrev"
 %originalreftable{"ref2"} = "^ref2_oldrev"
 %originalreftable{"ref3"} = "^ref3_oldrev"
 %originalreftable{"ref4"} = "^ref4_oldrev"
 %originalreftable{"ref5"} = "^ref5"
 %originalreftable{"ref6"} = "^ref6"

This table would be sufficient to create the revision list for every 
generate_email(), because each generate_email() knows which ref it's being 
updated for, so could easily do:

 %originalreftable{$myref} = "$mynewrev"

Before using the table (and restore it afterwards).

In short: yuck.  It feels an awful lot like its pushing the boundaries of 
what is sensible to do in shell script.



Andy
-- 
Dr Andy Parkins
andyparkins@gmail.com
