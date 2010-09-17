From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] git-rebase--interactive.sh: LF terminate line sent to
 cut
Date: Fri, 17 Sep 2010 10:10:31 -0500
Message-ID: <XhMLJaG8mUbh4rzLnU3IrGDXbMd9-p7UFO6kn9Uke7n_H4NNOG6glg@cipher.nrlssc.navy.mil>
References: <60d13fc6a7d5b1b08f35f91b2d90eb7c13922390.1284733059.git.chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 17:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwccU-0002OB-11
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 17:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab0IQPMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 11:12:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48015 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab0IQPMv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 11:12:51 -0400
Received: by mail.nrlssc.navy.mil id o8HFBdFV031660; Fri, 17 Sep 2010 10:11:39 -0500
In-Reply-To: <60d13fc6a7d5b1b08f35f91b2d90eb7c13922390.1284733059.git.chris_johnsen@pobox.com>
X-OriginalArrivalTime: 17 Sep 2010 15:11:38.0981 (UTC) FILETIME=[A08D6150:01CB567A]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156387>

On 09/17/2010 09:17 AM, Chris Johnsen wrote:
> Some versions of cut do not cope well with lines that do not end in
> an LF. Add '\n' to the printf format string to ensure that the
> generated output ends in a LF.
> 
> I found this problem when t3404's "avoid unnecessary reset" failed
> due to the "rebase -i" not avoiding updating the tested timestamp.
> 
> On a Mac OS X 10.4.11 system:
> 
>     % printf '%s' 'foo bar' | /usr/bin/cut -d ' ' -f 1
>     cut: stdin: Illegal byte sequence
>     % printf '%s\n' 'foo bar' | /usr/bin/cut -d ' ' -f 1
>     foo


Or we could write it like:

   sha1=${rest%% *}

which I wish I had changed it to in the first place when I made some
recent modifications.  The '%%' notation avoids the whole newline issue
by not even spawning 'cut'.  We are already using this construct in
git-filter-branch.sh and git-instaweb.sh, though those are not the
most visible scripts in git.

Does the above work on your FreeBSD system?

-Brandon


> Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>
> 
> ---
> It looks like the cut on my system is derived from FreeBSD. It is
> probably an old version though (possibly too old to care about).
> 
> The cut from GNU coreutils does not to have this problem, so using
> it serves as a workaround.
> ---
>  git-rebase--interactive.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index eb2dff5..834460a 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -626,7 +626,7 @@ skip_unnecessary_picks () {
>  		case "$fd,$command" in
>  		3,pick|3,p)
>  			# pick a commit whose parent is current $ONTO -> skip
> -			sha1=$(printf '%s' "$rest" | cut -d ' ' -f 1)
> +			sha1=$(printf '%s\n' "$rest" | cut -d ' ' -f 1)
>  			case "$(git rev-parse --verify --quiet "$sha1"^)" in
>  			"$ONTO"*)
>  				ONTO=$sha1
