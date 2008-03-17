From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On fetch refspecs and wildcards
Date: Sun, 16 Mar 2008 17:14:01 -0700
Message-ID: <7v8x0idx6e.fsf@gitster.siamese.dyndns.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se>
 <1205604534.7589.20.camel@gentoo-jocke.transmode.se>
 <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
 <200803161921.49274.tlikonen@iki.fi>
 <7v8x0igvdp.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161831330.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 01:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb30c-0006Jq-2x
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 01:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbYCQAOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 20:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbYCQAOR
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 20:14:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbYCQAOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 20:14:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 552D81A0B;
	Sun, 16 Mar 2008 20:14:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3C4AE1A0A; Sun, 16 Mar 2008 20:14:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77404>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sun, 16 Mar 2008, Junio C Hamano wrote:
> ...
>> Fortunately or unfortunately, Documentation/pull-fetch-param.txt does not
>> talk about wildcard refspecs (not even the syntax, let alone the
>> semantics), so we can define whatever we want right now, and I think both
>> 
>>     (1) allow duplicated destinations, including wildcard matches; and
>> 
>>     (2) refuse duplicated destinations for explicit ones, and more than
>>         one wildcard patterns that match the same ref, but omit explicitly
>>         specified ones from wildcard matches;
>> 
>> are viable options.  I suspect the current code does not do either.  We
>> should pick one semantics, make sure the implementation matches that, and
>> document it.
>
> Actually, I think the current code is close to (2). get_fetch_map() 
> returns everything, ref_remove_duplicates() removes any exact matches and 
> gives errors if there's the same destination for two different sources.
>
> (Upon further consideration, there's one slight issue:
>
> [remote "origin"]
> 	fetch = refs/heads/*:refs/remotes/origin/*
> 	fetch = +refs/heads/pu:refs/remotes/origin/pu
>
> is not quite the same as:
>
> [remote "origin"]
> 	fetch = +refs/heads/pu:refs/remotes/origin/pu
> 	fetch = refs/heads/*:refs/remotes/origin/*
>
> in whether pu will be forced; the forcing flag on the first matching 
> refspec is what matters.)

Ok.

As I said, I think either one is valid, and I only mentioned (1) because I
thought refusing duplicates might be more work to get it right.  So if
your code does _most of_ (2), that is good.  Please document what it is
meant to do in Documentation/pull-fetch-param.txt, so that others can
report deviation from the defined semantics, if any, in the implementation
for us to fix.

>> The issues are:
>> 
>>  (1) get_fetch_map() currently insists on refname to be check_ref_format()
>>      clean; it even rejects CHECK_REF_FORMAT_ONELEVEL, which means that
>>      refs/stash would not be considered Ok and the code will die().
>
> Yes, that's probably wrong. We probably do want to reject people whose 
> servers send us "refs/heads/../../heads/master", but not "refs/stash".

The feeler patch I sent out would be Ok, then.  Can you test it, after
updating it with the die() -> error() and message rewording we discussed
in the other message, and send the result in?

>>  (2) "git remote prune" seems to cull refs/remotes/one/HEAD if exists.
>> 
>> Currently we do not have a way to determine where HEAD at the remote
>> points at at the protocol level (I've sent a patch to the list earlier for
>> the necessary protocol extension on the upload-pack side, but receiver
>> side never got implemented in remotes.c).  So we cannot propagate
>> refs/HEAD information correctly right now, but when we accept the protocol
>> extension to do so, issue (1) will matter also for HEAD.
>
> There's the issue that "HEAD" isn't "refs/HEAD". I'm not at all sure how 
> the user should communicate the desire to update things to match the 
> remote HEAD. FWIW, I was considering moving the code to guess where the 
> remote HEAD points from builtin-clone to remotes.c, until I realized that 
> it's not clear what configuration should control this.. I think it'd be 
> necessary to have a special option to say "write HEAD here", but I may be 
> wrong.

I tend to agree.  I'd propose the semantics for refs/remotes/<name>/HEAD
symref to be like this:

 * It is under _local_ control.  That means fetch should not update it, and
   "remote prune" should not prune it, nor even mention it is prunable.

 * It is the means for the user (i.e. the owner of the local repository)
   to express which branch from the remote he is most interested in.
   I.e., it exists solely to make "<name>" => "refs/remotes/<name>/HEAD"
   ref dwimming work as expected.

 * It is set up by "git clone" to point at the branch the remote had its
   HEAD pointing at when clone happened but that is merely a convenience
   feature.

 * We would probably want an explicit convenience subcommand "git remote
   something <name> <branch>" that switches refs/remotes/<name>/HEAD to
   point at a specific remote tracking branch, although you can do that
   yourself with symbolic-ref.

 * We may want to teach "git remote add <name>" to do the same HEAD
   discovery as done by "git clone" (earlier JBF had a patch for it to the
   scripted version), to have the same convenience feature as "git clone"
   has.

 * If we teach "git remote add" to set refs/remotes/<name>/HEAD, we may
   also want to teach it an explicit way to let the user say "I want
   <name> to mean refs/remotes/<name>/this", not whatever the remote side
   currently points at with its HEAD.

 * If we teach "git remote add" to do the HEAD discovery, we may also want
   to teach "git remote update" a way to let the user request "my
   refs/remotes/<name>/HEAD may not be pointing at the branch the remote
   currently points at with its HEAD.  Please update mine to match
   theirs".

When true mirroring configuration "refs/*:refs/*" is employed, neither
"refs/HEAD" nor "refs/heads/HEAD" is needed nor desired on the local side.
