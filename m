From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule - Allow adding a submodule in-place
Date: Mon, 03 Mar 2008 23:09:20 -0800
Message-ID: <7vod9v9d9b.fsf@gitster.siamese.dyndns.org>
References: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pkufranky@gmail.com,
	Sven Verdoolaege <skimo@kotnet.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWRI0-000456-E8
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 08:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbYCDHJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 02:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbYCDHJj
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 02:09:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbYCDHJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 02:09:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 28D2633BE;
	Tue,  4 Mar 2008 02:09:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 19DAC33BD; Tue,  4 Mar 2008 02:09:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76039>

Mark Levedahl <mlevedahl@gmail.com> writes:

> When working in top-level project, it is useful to create a new submodule
> as a git repo in a subdirectory, then add that submodule to top-level in
> place.  This allows "git submodule add <intended url> subdir" to add the
> existing subdir to the current project.  The presumption is the user will
> later push / clone the subdir to the <intended url> so that future
> submodule init / updates will work.
>
> Absent this patch, "git submodule add" insists upon cloning the subdir
> from a repository at the given url, which is fine for adding an existing
> project in but less useful when adding a new submodule from scratch to an
> existing project.  The former functionality remains, and the clone is
> attempted if the subdir does not already exist as a valid git repo.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

This is a very well written commit log message with an appropriate title,
and a convincing justification why this is a good idea.  Even I (who does
not heavily use submodules himself) can look at the patch and tell that
the existing check and die was too limiting to the users after reading
these two paragraphs.

I wish everybody wrote his commit log message like this.

> +-r remote::
> +	Name of remote to use or define when working with relative submodules
> +	(i.e., submodules whose url is given relative to the top-level
> +	project). If this value is undefined, the top-level project's
> +	branch.<name>.remote is used, and if that is undefined the default
> +	"origin" is used. The remote will be defined in each relative
> +	submodule as needed by appending the relative url to the top level
> +	project's url. This option has no effect upon submodules defined
> +	using an absolute url: such project's are cloned using the default
> +	"origin," and are updated using the submodule's branch.<name>.remote
> +	machinery and defaulting to "origin."
> +

However, this part is not mentioned in the commit log message at all.

Is the enhancement advertised on the title line be useful _without_ this?

If so, this is a commit with two unrelated changes, and needs to be split
into two patches.  Also the other change that adds "-r remote" needs to be
explained and defended separately.

If not, the additional option should be described (what it does) justified
(why it is needed), and also there needs an explanation why this is an
integral part of the addition of this "add existing subdirectory" feature.

Yes, I _can_ guess that this option is related to your earlier f31a522
(git-submodule - allow a relative path as the subproject url).  Because
"submodule add" is used for setting up the initial .gitmodules entry for
the new submodule, you would need to give a clue to the command if you
want to set it up as a relative thing or an absolute thing, and you use
the relativeness of the URL parameter for that.  If you give a relative
path to the URL, however, you would need a way to pass in another piece of
information to let the command determine what it is relative to, and that
is the reason why this parameter exists.

But you _shouldn't_ be making me (or others, for that matter) wonder why
and justify it for you.  It should be explained in the commit log message.


