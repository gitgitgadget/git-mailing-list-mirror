From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined
 at config time
Date: Sat, 16 Feb 2008 12:04:26 -0800
Message-ID: <7vzlu07jn9.fsf@gitster.siamese.dyndns.org>
References: <20080216185349.GA29177@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 21:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQTIF-0004kF-G0
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 21:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbYBPUFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 15:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbYBPUFH
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 15:05:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbYBPUFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 15:05:05 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8723A6237;
	Sat, 16 Feb 2008 15:05:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 90BD76234; Sat, 16 Feb 2008 15:04:53 -0500 (EST)
In-Reply-To: <20080216185349.GA29177@hashpling.org> (Charles Bailey's message
 of "Sat, 16 Feb 2008 18:53:49 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74072>

Charles Bailey <charles@hashpling.org> writes:

> It follows filter-branch's 'eval a user shell snippet' philosophy to
> provide the flexibility and here in lies an ugliness. It exposes
> git-mergetool.sh's private variables to the user script. The variables
> are BASE, REMOTE, LOCAL and path.
>
> My feeling is that we should give this consistent and documented
> names, perhaps GIT_BASE, GIT_REMOTE, GIT_LOCAL, GIT_MERGED or similar.

I like the general idea and you are right that the external
interface should not expose the variable names the current
implementation happens to use.  I do not think it is necessary
to rename them to GIT_BASE etc., but I do think we need to list
the repertoire of variables that can be expected to be usable by
custom script in any future version of mergetool (even after it
is rewritten in C).  Anybody who uses a variable that is not in
the documented set that the current implementation uses can be
broken ;-).

Also perhaps we would want to spawn the eval in a subprocess to
make it clear that the custom script cannot affect the caller's
variables.

> Also, does anyone know of any reason why the temporary files should
> not be cleaned up after an unsuccessful merge?

I do not use mergetool myself, but presumably it would be to
make the manual inspection easier.

> +mergetool.<tool>.keepBackup::
> +	After performing a merge, the original file with conflict markers
> +	can be saved as a file with a `.orig` extension.  If this variable
> +	is set to `false` then this file is not preserved.

I doubt this belongs to this patch, so does ...

> +		if test "$merge_tool_keep_backup" = "true"; then
> +		    save_backup
> +		else
> +		    remove_backup
> +		fi
> +	    fi

... this part and anything else that deals with the backup
files in the patch.

Shouldn't the handling of back-up files be the same across
backends?

If the answer is yes, it makes mergetool.<tool>.keepBackup
configuration a quite bogus variable, as it is not something you
would configure per backend.

In the existing code, I see kdiff3 arm calls remove_backup while
tkdiff arm and others call save_backup, which seems quite
inconsistent.  Perhaps mergetool needs a command line option
(and perhaps a single configuration variable independent from
which backend is used) to tell what to do about them after a
conflicting merge is resolved and/or resolution is aborted.
