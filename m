From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Problem with contrib/hooks/post-receive-email
Date: Fri, 19 Mar 2010 23:21:37 -0400
Message-ID: <m3r5nfptj2.fsf@winooski.ccs.neu.edu>
References: <m3vdcsq0hl.fsf@winooski.ccs.neu.edu>
	<ho09bh$hdh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 04:21:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NspG9-0006yg-EN
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 04:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab0CTDVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 23:21:53 -0400
Received: from lo.gmane.org ([80.91.229.12]:52749 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600Ab0CTDVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 23:21:52 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NspG1-0006wp-Vy
	for git@vger.kernel.org; Sat, 20 Mar 2010 04:21:49 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 04:21:49 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 04:21:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:KJaQ0zHMIS8htEi6GeZQT42nmbY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142679>

Andy Parkins <andyparkins@gmail.com> writes:

> Eli Barzilay wrote:
>
>> The post-receive-email script goes out of its way to avoid sending
>> commits twice by filtering out commits that are included in
>> existing refs, but if more than one branch changes then some
>> commits can end up not being reported.  For example, I made two
>> commits A and B, made one branch point at A and another at B, and
>> pushed both -- neither of the resulting two emails had A.
>
> <Andy starts crying>
>
> I can't see any way to deal with this case easily with
> post-receive-email as it is.  It inherently processes ref-by-ref.

Well, one thing that sounded obvious to me is to expicitly say
something about it.  The "danger" that I see in this is a central
repository setup and people relying on knowing everything that happens
by reading through these emails -- then get a bad surprise when
something sneaks in past those emails.

As for a proper solution, I first thought along the lines of what
Brandon suggested -- but I considered doing that with a hash table
instead of accumulating a sed script.


> And similarly for ref2, ref3 and ref4.  It seems to me that it needs
> a hash table keyed on the refname, but I have no idea how to do that
> in bash.
> [...]

(Isn't that just associative arrays?)


> In short: yuck.  It feels an awful lot like its pushing the
> boundaries of what is sensible to do in shell script.

Yeah, my conclusion was similar...  But after considering it for a
while, I think that a saner approach is to choose a main branch (eg,
`master' or `devel') where all commits are always reported, then for
branches show only commits that are not on this main branch.  This
means that if you only read the emails on this branch you know
practically everything that happens, and if you're interested in what
happens on a branch you will see some commits again in the future when
they're added to the main branch -- but that seems even better to me:
even I read some commit when it happened on a branch, I'd still want
to know when it's added to the main branch.

This seems to me both more predictable in the sense of the
notifications and the code.  But I'm in the process of converting a
project to git so I might not be experienced enough...

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
