From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v2 15/22] i18n: rebase-interactive: mark here-doc strings
 for translation
Date: Wed, 25 May 2016 13:13:37 +0000
Message-ID: <5745A501.2040605@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
 <1464031661-18988-16-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 15:14:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5YdL-0002cy-K9
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 15:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbcEYNNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 09:13:46 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:42133 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753960AbcEYNNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 09:13:45 -0400
Received: (qmail 27558 invoked from network); 25 May 2016 13:13:43 -0000
Received: (qmail 5851 invoked from network); 25 May 2016 13:13:43 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 25 May 2016 13:13:37 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <1464031661-18988-16-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295573>

=C0s 19:27 de 23-05-2016, Vasco Almeida escreveu:
> Add eval_ngettext dummy function to be called by tests when running
> under GETTEXT_POISON. Otherwise, tests would fail under gettext poiso=
n
> because that function could not be found.
>=20
> [...]
>
> diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
> index e6c3116..c14c303 100644
> --- a/git-sh-i18n.sh
> +++ b/git-sh-i18n.sh
> @@ -64,6 +64,10 @@ poison)
>  	eval_gettext () {
>  		printf "%s" "# GETTEXT POISON #"
>  	}
> +
> +	eval_ngettext () {
> +		printf "%s" "# GETTEXT POISON #"
> +	}
>  	;;
>  *)
>  	gettext () {

Perhaps, I should have added more eval_ngettext dummy functions in othe=
r
places in this file. Not exclusively to the poison part of the switch c=
ase.

I see Solaris is a special case (gettext_without_eval_gettext), does it
have eval_ngettext? Probably not, since it does not have
eval_gettext(1). In such case, we would call ngettext like it's done fo=
r
eval_gettext, assuming Solaris has ngettext.

The relevant part of git-sh-i18n.sh updated with this patch:

# ... and then follow that decision.
case "$GIT_INTERNAL_GETTEXT_SH_SCHEME" in
gnu)
	# Use libintl's gettext.sh, or fall back to English if we can't.
	. gettext.sh
	;;
gettext_without_eval_gettext)
	# Solaris has a gettext(1) but no eval_gettext(1)
	eval_gettext () {
		gettext "$1" | (
			export PATH $(git sh-i18n--envsubst --variables "$1");
			git sh-i18n--envsubst "$1"
		)
	}
	;;
poison)
	# Emit garbage so that tests that incorrectly rely on translatable
	# strings will fail.
	gettext () {
		printf "%s" "# GETTEXT POISON #"
	}

	eval_gettext () {
		printf "%s" "# GETTEXT POISON #"
	}

	eval_ngettext () {
		printf "%s" "# GETTEXT POISON #"
	}
	;;
*)
	gettext () {
		printf "%s" "$1"
	}

	eval_gettext () {
		printf "%s" "$1" | (
			export PATH $(git sh-i18n--envsubst --variables "$1");
			git sh-i18n--envsubst "$1"
		)
	}
	;;
esac
