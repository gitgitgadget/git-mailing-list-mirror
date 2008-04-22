From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Mon, 21 Apr 2008 22:32:17 -0700
Message-ID: <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 07:33:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoB83-0006zX-1t
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 07:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYDVFcd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 01:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYDVFcd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 01:32:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbYDVFcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 01:32:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FD4E2A38;
	Tue, 22 Apr 2008 01:32:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 243342A37; Tue, 22 Apr 2008 01:32:25 -0400 (EDT)
In-Reply-To: <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 (=?utf-8?Q?J=C3=B6rg?= Sommer's message of "Mon, 14 Apr 2008 02:21:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80060>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> This new command can be used to set symbolic marks for an commit whil=
e
> doing a rebase. This symbolic name can later be used for merges or
> resets.
>
> The decision to use references for the marks and not files like done =
with
> the rewritten commits for preserve merges was made to ensure no commi=
t
> objects get lost if prune is started while (a long term) rebase is
> running. This also unifies the checking of the validity of marks and
> references by using rev-parse for it.
>
> The usage of : as the sign for marks conforms with the tag sign of
> fast-export and fast-import.
>
> Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
> ---
>  git-rebase--interactive.sh    |   37 +++++++++++++++++++++++++++++++=
+++++-
>  t/t3404-rebase-interactive.sh |   17 +++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 531ee94..6ac316a 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -35,6 +35,8 @@ mark the corrected paths with 'git add <paths>', an=
d
>  run 'git rebase --continue'"
>  export GIT_CHERRY_PICK_HELP
> =20
> +mark_prefix=3Drefs/rebase-marks/
> +
>  warn () {
>  	echo "$*" >&2
>  }
> @@ -105,7 +107,13 @@ die_with_patch () {
>  }
> =20
>  cleanup_before_quit () {
> -	rm -rf "$DOTEST"
> +	rm -rf "$DOTEST" &&
> +	for ref in "$GIT_DIR/$mark_prefix"*
> +	do
> +		test "$ref" =3D "$GIT_DIR/$mark_prefix*" && continue
> +		git update-ref -d "${ref#$GIT_DIR/}" "${ref#$GIT_DIR/}" || \
> +			return 1
> +	done

In practice nobody would "run" pack-refs during the rebase session, but=
 I
have to wonder if it can be triggered to run as part of automated gc or
something, in which case this loop does not work as intended. It needs =
to
be rewritten using for-each-ref.

> @@ -244,6 +252,19 @@ peek_next_command () {
>  	sed -n "1s/ .*$//p" < "$TODO"
>  }
> =20
> +mark_to_ref () {
> +	case "$1" in
> +	:[!/]*)
> +		# :/SOMETHING is a reference for the last commit whose
> +                # message starts with SOMETHING
> +		echo "$mark_prefix${1#:}"
> +		;;

What was the conclusion of the mark-syntax discussion?

While I know the bang in ":[!negated]" is POSIX, I wonder if everybody'=
s
shell we care about groks it.

Could people run this with the shell they care about being supported
(Solaris /bin/sh does not count) try this and yell loudly if you get
"matches" please?  I know bash and dash are Ok, but I do not have easy
access to various flabours of BSDs (OSX included).

	case ":/foo" in
        :[!/]*)	echo matches ;;
	*)	echo does not ;;
	esac
