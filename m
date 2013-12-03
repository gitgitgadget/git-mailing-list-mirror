From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ideas to speed up repacking
Date: Mon, 02 Dec 2013 16:44:09 -0800
Message-ID: <xmqqpppepxuu.fsf@gitster.dls.corp.google.com>
References: <201312021630.45767.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Dec 03 01:44:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vne66-00010M-5H
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 01:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab3LCAoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 19:44:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab3LCAoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 19:44:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9634A574DB;
	Mon,  2 Dec 2013 19:44:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p2x99q4sa/Iug2I5OMCzCSVGB9A=; b=kRZ7ri
	8G+MpF70zmthELKzZ6zKOK6p1aKAJmS+q6Hf2fSwJXkhfwiNr3DDGmSkiZXP6c5I
	E+a+sPOQORzPClSCFiERz0jwCh6HU++5SO79Cr7UwH6EaVSzc/Nquc6HZaHdHGrO
	5Ws6ucTEDpuovyWnFn6rgdB7zFoRT/Tc3c+Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UGsgjtC0Hl8uxmywYDDrjdbpvxwu6ypz
	WxdrKhVAfxpZ16UFdrsEqMUL+R55UvoUQ4Dt9vV0ri6lQcQQoL2MS5nMjUxy7uz2
	mItd3ATyYt6fMFphupqfy0CsJz7g6HO6mCVl0nOvaMrpO4lQ5M/URiRBDdbsD/jG
	jMzBQoOFidc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80712574DA;
	Mon,  2 Dec 2013 19:44:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1F9C574D9;
	Mon,  2 Dec 2013 19:44:11 -0500 (EST)
In-Reply-To: <201312021630.45767.mfick@codeaurora.org> (Martin Fick's message
	of "Mon, 2 Dec 2013 16:30:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 06D3A7DE-5BB4-11E3-A866-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238670>

Martin Fick <mfick@codeaurora.org> writes:

> I wanted to explore the idea of exploiting knowledge about 
> previous repacks to help speed up future repacks.  
>
> I had various ideas that seemed like they might be good 
> places to start, but things quickly got away from me.  
> Mainly I wanted to focus on reducing and even sometimes 
> eliminating reachability calculations since that seems to be 
> be the one major unsolved slow piece during repacking.
>
> My first line of thinking goes like this:  "After a full 
> repack, reachability of the current refs is known.  Exploit 
> that knowledge for future repacks."  There are some very 
> simple scenarios where if we could figure out how to 
> identify them reliably, I think we could simply avoid 
> reachability calculations entirely, and yet end up with the 
> same repacked files as if we had done the reachability 
> calculations.  Let me outline some to see if they make sense 
> as starting place for further discussion.
>
> -------------
>
> * Setup 1:  
>
>   Do a full repack.  All loose and packed objects are added 
> to a single pack file (assumes git config repack options do 
> not create multiple packs).
>
> * Scenario 1:
>
>   Start with Setup 1.  Nothing has changed on the repo 
> contents (no new object/packs, refs all the same), but 
> repacking config options have changed (for example 
> compression level has changed).
>
> * Scenario 2:
>
>    Starts with Setup 1.  Add one new pack file that was 
> pushed to the repo by adding a new ref to the repo (existing 
> refs did not change).
>
> * Scenario 3: 
>
>    Starts with Setup 1.  Add one new pack file that was 
> pushed to the repo by updating an existing ref with a fast 
> forward.
>
> * Scenario 4:
>
>    Starts with Setup 1.  Add some loose objects to the repo 
> via a local fast forward ref update (I am assuming this is 
> possible without adding any new unreferenced objects?)
>
>
> In all 4 scenarios, I believe we should be able to skip 
> history traversal and simply grab all objects and repack 
> them into a new file?

If nothing else has happened in the repository, perhaps, but I
suspect that the real problem is how you would prove it.  For
example, I am guessing that your Scenario 4 could be something like:

    : setup #1
    $ git repack -a -d -f
    $ git prune

    : scenario #4
    $ git commit --allow-empty -m 'new commit'

which would add a single loose object to the repository, advancing
the current branch ref by one commit, fast-forwarding relative to
the state you were in after setup #1.

But how would you efficiently prove that it was the only thing that
happened?  The user could have done this instead of a single commit:

    : scenario #4 look-alike
    $ git commit --allow-empty -m 'lost commit'
    $ git reset --hard HEAD^
    $ git commit --allow-empty -m 'new commit'

and the reflog entry for HEAD or the current branch ref for that
lost commit may be already ancient when you looked at this state.
Your object database has two loose commits, and you would want to
lose the older one 'lost commit' which is not reachable.

Also with Scenario #2, how would you prove that the new pack does
not contain any cruft that is not reachable?  When receiving a pack
and updating our refs, we only prove that we have all the objects
needed to complete updated refs---we do not reject packs with crufts
that are not necessary.

These two are only examples, and we might be able to convince
ourselves that not pruning (or ejecting cruft from packs) is OK, but
that is introducing a different mode of operation, not optimizing
the repacking without changing what "repacking" means (I am not
saying it is bad to change the meaning if we can make a good
argument between pros-and-cons; a small bloat might be acceptable
relative to a good enough performance gain, but only unless the user
is using repack && prune as a way to eradicate undesirable contents
out of the object database).
