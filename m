From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Draft of API for git-vcs-*, transport.c code to use
 it.
Date: Wed, 25 Mar 2009 00:11:18 -0700
Message-ID: <7vskl284bt.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303410.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 08:12:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmNIG-0006KD-NP
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 08:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbZCYHL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 03:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbZCYHL1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 03:11:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbZCYHL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 03:11:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C39EDA4F1B;
	Wed, 25 Mar 2009 03:11:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 963B0A4F1A; Wed,
 25 Mar 2009 03:11:20 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0903242303410.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 24 Mar 2009 23:04:15 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2621C0C0-190C-11DE-930F-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114572>

Daniel Barkalow <barkalow@iabervon.org> writes:

> +'capabilities'::
> +	Prints the capabilities of the helper, one per line. These are:
> +	 - import: the basic import command
> +	 - marks: import should be done with a saved marks file
> +	 - find-new-branches: detect new branches
> +	 - export: the general export command
> +	 - fork: create a new branch and export to it
> +	 - anonymous-fork: make commits on a branch without an inherent name
> +	 - merge: merge branches (of whatever type the system supports)
> +
> +	If the helper doesn't support "merge", the default for pull is
> +	to rebase instead of merging.
> +
> +'list'::
> +	Takes the remote name, and outputs the names of refs. These
> +	may be followed, after a single space, by "changed" or
> +	"unchanged", indicating whether the foreign repository has
> +	changed from the state in the ref. If the helper doesn't know,
> +	it doesn't have to provide a value. (In particular, it
> +	shouldn't do expensive operations, such as importing the
> +	content, to see whether it matches.)

Does this roughly corresponds to get_remote_refs(), with "unchanged"
return turned into the current value of the ref while "changed" returned
as 0{40} in old_sha1 value?

For a vcs backend that lacks find-new-branches capability, when does the
set of refnames returned by this operation change?  Can the end user
request an expensive operation to make the list up-to-date?  Does the end
user need to?

> +'import'::
> +	Takes the remote name and a list of names of refs, and imports
> +	whatever it describes, by outputting it in git-fast-import
> +	format.
> +
> +'export'::
> +	Sends the branch to the foreign system and reimports it in
> +	fast-import format.

The above two description is inconsistent; say "git-fast-import" for both.

This seems to follow the model of git-svn in that we treat our history as
throw-away, export the history and give the authority to the other system
by discarding and replacing our history with whatever the other end gives
back to us by re-importing.  Because git is more flexible than anything
else, we could afford to do so, but I wonder if it is the right model and
mentality.

One downside is that you end up rebasing the git side by operating this
way, and a topology where multiple developers use one git repository as a
synchronization point and use that git repository to interface with the
foreign system becomes impossible.  Instead, these multiple developers
need to treat the foreign system as the central repository, and interface
with it individually.
