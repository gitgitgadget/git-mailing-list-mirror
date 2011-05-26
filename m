From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/6] i18n win32: add git-am eval_gettext variable prefix
Date: Thu, 26 May 2011 08:34:43 +0200
Message-ID: <4DDDF483.70805@viscovery.net>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com> <1306365594-22061-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 08:35:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPU9o-0003e8-Pr
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 08:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab1EZGev convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 02:34:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7445 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752667Ab1EZGeu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 02:34:50 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QPU9b-0001RQ-Oy; Thu, 26 May 2011 08:34:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 777C01660F;
	Thu, 26 May 2011 08:34:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1306365594-22061-2-git-send-email-avarab@gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174499>

Am 5/26/2011 1:19, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> -		eval_gettext 'Patch failed at $msgnum $FIRSTLINE'; echo
> +		GIT_I18N_VARIABLE_msgnum=3D$msgnum
> +		GIT_I18N_VARIABLE_FIRSTLINE=3D$FIRSTLINE
> +		eval_gettext 'Patch failed at $GIT_I18N_VARIABLE_msgnum $GIT_I18N_=
VARIABLE_FIRSTLINE'; echo

That's not pretty.

I wonder whether it is possible to automate the variable prefix. Lookin=
g
at the definition of eval_gettext()

eval_gettext () {
	printf "%s" "$1" | (
		export PATH $(git sh-i18n--envsubst --variables "$1");
		git sh-i18n--envsubst "$1"
	)
}

I gather that the actual substitution of variable values is done by
sh-i18n--envsubst, and not by the shell (right?). Let's look at an exam=
ple:

	git sh-i18n--envsubst --variables '$foo and $bar'

produces

	foo
	bar

What if it produced

	GIT_I18N_VARIABLE_foo=3D$foo
	GIT_I18N_VARIABLE_bar=3D$bar
	export GIT_I18N_VARIABLE_foo GIT_I18N_VARIABLE_bar

then the definition of eval_gettext() would look like

eval_gettext () {
	printf "%s" "$1" | (
		export PATH
		eval "$(git sh-i18n--envsubst --variables "$1")"
		git sh-i18n--envsubst "$1"
	)
}

and the second call of sh-i18n--envsubst should replace $foo and $bar t=
hat
it sees on stdin by the values of GIT_I18N_VARIABLE_foo and
GIT_I18N_VARIABLE_bar from the environment.

What do you think?

BTW, if you re-roll the series, would you mind shortening the prefix to=
,
say, _I18N__ because on Windows the variables names count towards the
environment budget, which is restricted to 32k characters.

BTW2, the following patch is needed to avoid a crash of an invocation o=
f
'git sh-i18n--envsubst' without arguments.

-- Hannes

(Warning: hand-edited patch text)

diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 7125093..8104973 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -76,2 +76,3 @@ main (int argc, char *argv[])
 	  error ("we won't substitute all variables on stdin for you");
+	  break;
 	  /*
