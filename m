From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Wed, 14 Mar 2012 09:59:04 +0100
Message-ID: <4F605DD8.9040504@alum.mit.edu>
References: <vpqobs65gfc.fsf@bauges.imag.fr> <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk> <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu> <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr> <20120312183725.GA2187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 09:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7k3d-0005rL-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 09:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436Ab2CNI7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 04:59:40 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47800 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760088Ab2CNI7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 04:59:36 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q2E8x4RF008302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Mar 2012 09:59:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
In-Reply-To: <20120312183725.GA2187@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193088>

On 03/12/2012 07:37 PM, Jeff King wrote:
> On Mon, Mar 12, 2012 at 05:37:32PM +0100, Matthieu Moy wrote:
>> * For newbies, the sequence "create an empty repository, clone it,
>>   commit and push" works like a charm with either 'upstream' or
>>   'current'. Today, the first push to an empty repository requires
>>   either saying "git push origin master" or "git push --all", both of
>>   which sound like black magic to the poor user who did not yet learn
>>   what 'origin' is and what a branch is.
> 
> Ending that confusion is one of the best reasons to switch the default,
> IMHO, but I don't think it argues for "current" versus "upstream", as
> they both fix it (but Michael's matching-current hybrid would not, so I
> agree it is less appealing).

In the case of my proposed matching-current hybrid, the error message
for the failing push would make it pretty obvious what went wrong and
how to fix it; something like:

    $ git push
    The remote repository "git.example.com:myproject" does not yet
    contain a branch called "master".  If you would like to create one
    now, type

        git push origin master

    For other alternatives, please see gitworkflows(7).

This error message would appear *whenever* the matching-current hybrid
policy caused the push to fail.  Since this problem occurs only if (1)
the upstream repository is empty and (2) the user hasn't configured a
more liberal global push.default, and since it is blindingly obvious
what to do to fix the problem, it doesn't seem especially onerous.

(One could even create a special-case to allow such a push when the
upstream repository is empty, but I don't think the gain in convenience
is worth the loss of consistency.)

> So far a lot of the discussion has focused on "what is the most sensible
> default for the most number of people". But I wonder if a better
> question is "what is the default that is the least likely to do
> something dangerous and embarrassing". People who use git enough to say
> "wow, I don't like this default for my workflow" are probably at the
> point that they can configure push.default themselves.

I agree entirely.  And here is an algorithm for deciding what the
default should be:

1. Make a list of branch configurations that can be distinguished by
   git, which would be something like all combinations of

   * remote has a branch with the same name as the current branch?
     * no
     * yes, and remote branch could be fast-forwarded to local state
     * yes, but remote branch cannot be fast-forwarded to local state

   * local branch has known upstream branch on remote?
     * no
     * yes, and remote upstream branch could be fast-forwarded to
       the state of the current local branch
     * yes, but remote upstream branch cannot be fast-forwarded to
       the state of the current local branch

2. In each of these situations, decide what "git push" should do in
   each of the common workflows.

3. In the branching configurations for which all workflows agree about
   what "git push" should do, then that is what "git push" should do by
   default.  When they do not agree, then "git push" should do nothing,
   give an informative error message, and leave it to the user to
   decide.  If all workflows agree on a safe subset of what "git push"
   should do (for example, "matching" and "current" agree that the
   current branch should be pushed even though they disagree whether
   other branches should be pushed), then it might be OK to carry out
   the safe subset.

The most common workflows, along with the configuration settings that
are recommended for that workflow, should be given standard names and
documented in gitworkflows(7).  The warning message for a failed "git
push" invocations (especially if push.default is unset) should direct
the user to this manpage.


Isn't it obvious?: The fact that we cannot even agree among ourselves
what "git push" should do in all cases *proves* that we are trying to be
too ambitious with DWIM.  "git push" must therefore become more
deferential when the obvious thing to do is unclear, especially given
that mistakes (due to the very nature of "git push") often have
embarrassing and publicly visible effects.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
