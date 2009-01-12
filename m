From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] Add specification of git-vcs helpers
Date: Sun, 11 Jan 2009 17:29:00 -0800
Message-ID: <7vk591mhwj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0901110334350.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 02:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBdW-0006T3-CW
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbZALB3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbZALB3O
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:29:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZALB3N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:29:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B1091C481;
	Sun, 11 Jan 2009 20:29:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7C8961C480; Sun,
 11 Jan 2009 20:29:02 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0901110334350.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 11 Jan 2009 15:12:08 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69A355D6-E048-11DD-A1F2-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105269>

Daniel Barkalow <barkalow@iabervon.org> writes:

> So far, I've actually used list and import; I've also implemented an 
> export, but haven't figured out exactly how the user should cause it to be 
> used.
> ...
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

Have you tried formatting this to both html and man?  I think you need to
dedent the second paragraph, and have '+' as the sole character on a line
immediately before, without any blank lines.  The formatted output of the
description of 'export' is probably more troublesome as it is much longer.

This list feels like overengineered yet without enough thinking behind it.

Your 'list' allows to list what can become branches on the git end, so as
long as you have tracking information on the git side, find-new-branches
seems unnecessary, for examle.  Worse, find-new-branches needs its own
tracking mechansim anyway, but that means how the namespace for remote
tracking branches is managed is left to the vcs backends, even though that
namespace is directly visiblt to git --- my gut feeling is that it would
probably better to arrange things similar to what git native transport
does already.  'list' would say "The remote has what can become refs on
the git end and calls them A, B, C", and the built-in code, using ref
mapping specification, maps them to refs/remotes/somename/{A,B,C}.  You do
it again and if you see the remote has D but does not have B anymore, you
know D is a new branch and B was deleted.

What does 'merge' mean?  It cannot mean to fetch their changes from
foreign vcs and create a merge locally (you only need import from the
backend, and merge will be a usual git merge).  Perhaps you meant if you
can export a merge back?  Some foreign systems may support importing
merges but not octopus, so it may not be just a black-or-white boolean.

Also "the default is to rebase instead of merge" is probably too weak.
You would want to error out if the user tried to merge, wouldn't you?

> +'list'::
> +	Takes the remote name, and outputs the names of refs. These
> +	may be followed, after a single space, by "changed" or
> +	"unchanged", indicating whether the foreign repository has
> +	changed from the state in the ref. If the helper doesn't know,
> +	it doesn't have to provide a value. (In particular, it
> +	shouldn't do expensive operations, such as importing the
> +	content, to see whether it matches.)

I am guessing by 'a value' you mean 'changed/unchanged', iow you are not
saying if the helper does not know it can omit such refs from the list,
but it is unclear.
