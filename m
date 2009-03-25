From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Draft of API for git-vcs-*, transport.c code to use
 it.
Date: Wed, 25 Mar 2009 11:03:19 -0700
Message-ID: <7vbprp5vko.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303410.19665@iabervon.org>
 <7vskl284bt.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903251050430.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:05:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXUA-0002oK-Dc
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758209AbZCYSD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757075AbZCYSD1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:03:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758141AbZCYSD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:03:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A70BCA5B97;
	Wed, 25 Mar 2009 14:03:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8E535A5B96; Wed,
 25 Mar 2009 14:03:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3BFF36EC-1967-11DE-AB67-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114631>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 25 Mar 2009, Junio C Hamano wrote:
>
>> This seems to follow the model of git-svn in that we treat our history as
>> throw-away, export the history and give the authority to the other system
>> by discarding and replacing our history with whatever the other end gives
>> back to us by re-importing.  Because git is more flexible than anything
>> else, we could afford to do so, but I wonder if it is the right model and
>> mentality.
> ...
> But, as a general principle, the reason a git developer would push to a
> non-git remote repository is because the remote repository is
> authoritative.  I don't think it makes sense to have an environment
> where the authoritative history is in git, but people are sharing it
> through a bzr server (even if the bzr server can accurately represent
> the git history).

Suppose a project used to use subversion, but it migrated to git (not an
unheard-of scenario these days, I hope).  The git repository now is the
authoritative one, all the development happens on this side.

But in order to help:

 - people who have established their workflow to follow the project
   (e.g. not necessarily contributing anything back, but just doing
   regular "svn update");

 - people who have leftover local changes from the subversion days; and

 - other project infrastracture (e.g. trac) that the project hasn't
   managed to interface to the new git repository yet;

the project decides to keep feeding recent updates to the subversion
repository that used to be authoritative, even though it is now declared
read-only (i.e. the only update comes from the git end).

My understanding is that the above scenario would not work if git-vcs-svn
rewrites commits when git exports to svn, and existing git-svn two-way
interface using its "dcommit" may have exactly the same issue.

The reason I brought this up was to involve people who have already faced
this issue with git-svn in the discussion to see if we can avoid it by
doing somethink similar to clever tricks they are using in their git-svn
workflow, if there are some.  Perhaps your paragraph below may be one of
those clever tricks, but there may be others.

> I think it might be possible to do something where the synchronization 
> point has a list of authoritative commit-swaps, where it can tell the 
> multiple developers: "commit Y is really the same thing as commit X; they 
> have the same tree, and their parents Y1..Yn are the same as X1..Xn 
> (either based on the same criterion applied recursively, or having 
> identical hashes)". This list of commit-swaps allows the developers to be 
> comfortable with trivial rebases (in a commit Z with X as a parent, make a 
> commit Z' with Y replacing X and no other changes, and replace Z with Z' 
> in refs and other commits). Of course, this depends on being able to get 
> the foreign system to agree on both complete content and history topology, 
> but otherwise we kind of have to throw away our history, because the 
> public history simply can't be like what we've made locally.
