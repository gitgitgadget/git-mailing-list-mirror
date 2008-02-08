From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Abort early if not being sourced under bash.
Date: Fri, 08 Feb 2008 13:31:08 -0800
Message-ID: <7vprv7i19f.fsf@gitster.siamese.dyndns.org>
References: <200802082310.34398.ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:32:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNapY-0007m1-1c
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbYBHVbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 16:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754463AbYBHVbV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:31:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbYBHVbT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2008 16:31:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D6BA4409;
	Fri,  8 Feb 2008 16:31:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EDF64408;
	Fri,  8 Feb 2008 16:31:11 -0500 (EST)
In-Reply-To: <200802082310.34398.ville.skytta@iki.fi> (Ville =?utf-8?Q?Sky?=
 =?utf-8?Q?tt=C3=A4's?= message
	of "Fri, 8 Feb 2008 23:10:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73152>

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> Subject: [PATCH] Abort early if not being sourced under bash.
>
> This way, the file can be safely sourced from profile files shared wi=
th
> non-bash shells, eg. dropped into /etc/profile.d like directories.
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  contrib/completion/git-completion.bash |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 4ea727b..3cde9f4 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -45,6 +45,8 @@
>  #       git@vger.kernel.org
>  #
> =20
> +[ -z "$BASH_VERSION" ] && return
> +
>  __gitdir ()
>  {
>  	if [ -z "$1" ]; then

I do not particularly sympathize with the /etc/profile.d/
argument.  Ditros can and should put a small script in there
that checks what /bin/sh it really is running and source the
real thing from elsewhere, perhaps /usr/share/git-core/,
appropriately.

However, even if you did so, there is another issue.  One of my
hosts have a bash that does not know the "complete" command, and
logging into the host I get twenty-or-so "bash: complete:
command not found".

So

	if bash "complete" would not work for this shell
        then
        	__git_ps1 () { : dummy; }
		return
	fi

at the beginning may be needed even if you know we are running
bash.

Then people can safely say:

	PS1=3D': \h \W$(__git_ps1 "/%s"); '

(or whatever git-completion.bash suggests these days) in their
start-up script.
