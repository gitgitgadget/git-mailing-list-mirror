From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Marking commits as transitory for git bisect?
Date: Wed, 02 Dec 2009 11:44:17 +0100
Message-ID: <4B164501.7010902@drmicha.warpmail.net>
References: <871vjdyb59.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFmiO-0003DJ-6K
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbZLBKp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 05:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZLBKp0
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:45:26 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33857 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753618AbZLBKpY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 05:45:24 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83300C5FBE;
	Wed,  2 Dec 2009 05:45:30 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 02 Dec 2009 05:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=COTTLTHCk+GBPrnAoCKb/LYC3Nw=; b=MKzDURxSbru6CSzNKXt7Dz/pQM19cXFXHGzuzfmThJoOJMU/bxNcV/KxIdhlR2EqgZAcUwZtpaRj2chu/K1L+HnBqZQGd+ByFP5Veth6y28KFulf6QgyJlvT+hGjwAQ3HIOIkhTQiaaA9WLHhAWKk3CDY6ShIo/8uW1W1K95Eig=
X-Sasl-enc: ZkoiPwcgkgZPPle+6KqgeZGiBZY341rYFiAu807WFqch 1259750730
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D289F49FB5F;
	Wed,  2 Dec 2009 05:45:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <871vjdyb59.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134329>

David Kastrup venit, vidit, dixit 02.12.2009 10:32:
> 
> Hi,
> 
> sometimes there are changes which would seem better to restructure into
> more than one commit, with a non-operative intermediate state.
> 
> What I am thinking of is something like
> 
> a) change an API (small but highly intricate patch warranting thorough
>    line-by-line review to make sure it's fine)
> b) adapt all existing callers (really large but utterly trivial patch)
> 
> Substructuring this change into two commits may be quite nicer for
> reviewing and following it.
> 
> Except that it breaks git bisect.  If there was a way to mark a commit
> as non-interesting, something which does not necessarily need any new
> repo features but just a convention like automatically skipping commits
> that contain the literal string [skip bisect] in the commit message,
> that would be one way to implement basic functionality like that.
> 
> A more thorough approach might also warn against partial cherrypicks or
> rebases or merges applying just part of one such a combined change.
> 
> But the main point is the ability to keep git bisect working on commit
> combinations with deliberately non-operative transitory stage.
> 

A quick solution with current git would be "replace": Say, in
A-B-C-D
you want B and C to be considered an "atom" for bisection. So, "git
replace" C by a commit C' which is B+C squashed and has A as its parent:
A-C'-D.

Alternatively, if you want this to be distributed more easily and think
of it at the time of committing, producing a DAG like

A--C'--D
 \    /
  B--C

with C' as the first parent of D may help during bisection. I.e., you
keep the detailed history on the side branch and squash it together on
the --first-parent-line, with C,C' being tree-same.

Cheers,
Michael
