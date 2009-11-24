From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk does not show path file list
Date: Mon, 23 Nov 2009 23:22:01 -0800
Message-ID: <7v3a44l752.fsf@alter.siamese.dyndns.org>
References: <33e2b2760911170409q4cbdad8ay83ae5c941bc5ff95@mail.gmail.com>
 <loom.20091124T060334-836@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Blakeney <markb@berlios.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 08:22:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCpj9-00023R-32
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 08:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbZKXHWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 02:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbZKXHWG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 02:22:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbZKXHWF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 02:22:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B7CF82056;
	Tue, 24 Nov 2009 02:22:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Znx8WaBu0JigJz9rYYAkDMvQJ6U=; b=YAuMi3
	ZehLZENFeWmaOeiKn+Bt+c1EUbreBAGGPjiT3Y/cchFKqZznAXvPHETcMRDjJmb5
	nf7mgACpowaYTtAyQI/FVEN/CeGItgpzQ/xHcz6OmzVTJHiCAGiid0bA11Bq2nSU
	C5bJ5IZYe5Cw5/5BjpTULMVzCJOEGIYACCE/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gL9HCUKFsTMhw35aPkfuzlWfBjWs1MOm
	LHceDtNwTVc4lRoyNvGfjCailH/pLszYyF1HvlmSGip+uBW8wmIVufP9grQpUmfc
	NevIWlm16YAp3NLzCqmHO2LBTtbYcSmeSmlN6mYsXrOB73KQfyWBcDdIenVesyAn
	FcBeWIn7ymo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 102BD82054;
	Tue, 24 Nov 2009 02:22:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17CBE82053; Tue, 24 Nov
 2009 02:22:02 -0500 (EST)
In-Reply-To: <loom.20091124T060334-836@post.gmane.org> (Mark Blakeney's
 message of "Tue\, 24 Nov 2009 05\:36\:37 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 124D5144-D8CA-11DE-A91E-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133563>

Mark Blakeney <markb@berlios.de> writes:

> ... why does gitk (usually) not show the subset list of files affected
> when you give it a path?
>
> E.g. If I am in a src dir then "gitk ." does not list files. Neither does "gitk
> $PWD" nor "gitk ../src". However "cd ..; git src" does list files!?

Paul, I do not read Tcl very well, but it appears that path_filter
procedure is at fault.

The call chain involved in this seems to be:

    gettreediffs
     - arranges gettreediffline to be fed output from "diff-tree $commit ."

 ->

    gettreediffline
     - finds the path (note that diff output is _always_ relative to the
       top of the work tree) from the patch;
     - calls path_filter with $vfilelimit($curview) and each filename
       In this case, the $vfilelimit($curview) is "." (dot)

 ->

    path_filter
     - compares strings in $filter and the $name; in this case, $filter is
       a dot "." and $name begins with "src/"

I see at least two problems in path_filter used this way:

 - A dot "." never would match anything from "diff-tree" (or any "diff"
   variant) after stripping a/ and b/ prefix.  gitk should prefix the
   current directory to each of the pathspec from command line (run
   "rev-parse --show-prefix" to learn where you are).

 - There is another callsite to path_filter for filtering output from
   "ls-files -u".  But the output from "ls-files" is relative to the cwd
   by default.  gitk should probably run it with --full-name option, so
   that it would get the same semantics as "diff" output.

It _might_ be the easiest to do an equivalent of (sorry, I do not talk Tcl
so this is in shell):

	prefix=$(git rev-parse --show-prefix)
	if test -n "$prefix"
        then
        	cd $(git rev-parse --show-cdup)
	fi

and then prepend prefix to all the pathspecs you would use from the
command line before doing anything else.  This "prepending" obviously need
to be aware of the ".", ".." and friends.
