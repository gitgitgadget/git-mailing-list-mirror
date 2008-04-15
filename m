From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule - possibly use remote branch to describe a
 module
Date: Mon, 14 Apr 2008 17:39:44 -0700
Message-ID: <7viqyk6je7.fsf@gitster.siamese.dyndns.org>
References: <1208217154-992-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 02:40:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlZE0-0003sA-UM
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 02:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbYDOAj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 20:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757560AbYDOAj4
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 20:39:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbYDOAjz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 20:39:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EBEEF315E;
	Mon, 14 Apr 2008 20:39:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 38B1E315C; Mon, 14 Apr 2008 20:39:49 -0400 (EDT)
In-Reply-To: <1208217154-992-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Mon, 14 Apr 2008 19:52:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79547>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Absent user intervention, git-submodule will maintain submodules as
> headless checkouts of remote branches: such checkouts cannot be described
> with reference to any local branch. So, allow describing the submodule
> using remote branches before falling back on just using the commit id.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-submodule.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 28509ea..af195a7 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -389,7 +389,8 @@ set_name_rev () {
>  		cd "$1" && {
>  			git describe "$2" 2>/dev/null ||
>  			git describe --tags "$2" 2>/dev/null ||
> -			git describe --contains --tags --always "$2"
> +			git describe --contains "$2" 2>/dev/null ||
> +			git describe --all --always "$2"
>  		}
>  	) )
>  	test -z "$revname" || revname=" ($revname)"

I think the new fallback sequence makes sense, but your explanation made
sense for me only after reading it two and half times.

 - The original sequence ended with "--contains --always" which always
   succeeded but with an abbrevated object name.  You removed --always
   from it so that you can add a better last-ditch effort that uses remote
   references.

   Side note.  Removal of --tags from it is not justified in your log
   message.  It is sort of obvious if you think about it, though...

 - The new one at the end uses --all because the HEAD is likely to be
   describable with remote references, and without --all remote reference
   namespace is not searched for a match.
