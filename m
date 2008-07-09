From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule - make "submodule add" more strict, and
 document it
Date: Tue, 08 Jul 2008 23:04:19 -0700
Message-ID: <7vwsjvlhjw.fsf@gitster.siamese.dyndns.org>
References: <7vhcb0x6ak.fsf@gitster.siamese.dyndns.org>
 <1215575965-3588-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, <sylvain.joyeux@dfki.de>, <hjemli@gmail.com>,
	<pkufranky@gmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 08:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGSnx-0001Fr-TW
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 08:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYGIGEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 02:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbYGIGEc
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 02:04:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYGIGEb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 02:04:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5EBD18BF0;
	Wed,  9 Jul 2008 02:04:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6EB2818BEF; Wed,  9 Jul 2008 02:04:24 -0400 (EDT)
In-Reply-To: <1215575965-3588-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Tue, 8 Jul 2008 23:59:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E52502EA-4D7C-11DD-A60D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87851>

Mark Levedahl <mlevedahl@gmail.com> writes:

> This change makes "submodule add" much more strict in the arguments it
> takes, and is intended to address confusion as recently noted on the
> git-list. With this change, the required syntax is:
> 	$ git submodule add URL path
>

Please have an extra blank line on both sides of examples.

> Specifically, this eliminates the form
> 	$git submodule add URL
> which was confused by more than one person as
> 	$git submodule add path

s/\$/& /;

> The change eliminates one form of URL: a path relative to the current
> working directory....
> ...
> Following this change, there are exactly four variants of
> submodule-add, as both arguments have two flavors:
>
> URL can be absolute, or can begin with ./|../ and thus name the origin
> relative to the top-level origin.

Now this _is_ confusing.  Examples of a path relative to the current
working directory would be ./foo or ../../foo but the previous paragraph
says the form is eliminated.  I think I know what you want to say, but it
still is confusing.

>  add::
>  	Add the given repository as a submodule at the given path
> +	to the changeset to be committed next. This requires two arguments,
> +	<repository> and <path>. <repository> is the URL of the new
> +	submodule's origin repository. This may be either an absolute URL,
> +	or (if it begins with ./ or ../), the location relative
> +	to the parent repository's origin.

This is much better than the part I found confusing above.  Here, "parent
repository" actually means "this repository", right?  It is the one that
owns the index you are adding the gitlink to and tracks the .gitmodules
file you are adding an entry for this submodule to.

> +	<path> is the relative location for the cloned submodule to
> +	exist in the current tree. If <path> does not exist, then the
> +	module is created by cloning from the named URL. If <path> does
> +	exist and is already a valid git repository, then this is added
> +	to the changeset without cloning. This second form is provided
> +	to ease adding a submodule to a project the first time, and presumes
> +	the user will later push the new submodule to the given URL.
> +
> +	In either case, the given URL is recorded into .gitmodules for
> +	use by subsequent users cloning the project. If the URL is given
> +	relative to the parent, the presumption is the main and sub-modules

We seem to say "superproject" and "submodule" elsewhere, including Linus's
talk.

> +	will be kept together in the same relative location, and only the
> +	top-level URL need be provided: git-submodule will correctly
> +	locat the submodules using the hint in .gitmodules.

s/locat/&e/;

> @@ -150,16 +138,27 @@ cmd_add()
> ...
> +	# assure repo is absolute or relative to parent
> +	case "$repo" in
> +		./*|../*)
> +			# dereference source url relative to parent's url
> +			realrepo=$(resolve_relative_url "$repo") || exit
> +			;;
> +	    *:*|/*)

Funny indentation; "case/esac" and its arms align, like so:

	case "$repo" in
        ./* | ../*)
        	...
		;;
	esac
