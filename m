From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: introduce GIT_GLOBAL_CONFIG to override ~/.gitconfig
Date: Thu, 27 Sep 2012 18:57:35 +0200
Message-ID: <vpq626zjtds.fsf@grenoble-inp.fr>
References: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
	<1348757171-3223-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Anurag Priyam <anurag08priyam@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 18:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHPV-0003Ae-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 18:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab2I0Q5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 12:57:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37910 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab2I0Q5v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 12:57:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q8RGpcZA013711
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 18:51:38 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1THHP6-0005tz-72; Thu, 27 Sep 2012 18:57:36 +0200
In-Reply-To: <1348757171-3223-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 27 Sep 2012 20:16:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Sep 2012 18:51:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8RGpcZA013711
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349369501.37144@/E4XlPzmghB0rQp/w5DgDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206488>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index eaea079..c8db03f 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -205,6 +205,9 @@ $GIT_DIR/config::
>  	User-specific configuration file. Also called "global"
>  	configuration file.
>  
> +$GIT_GLOBAL_CONFIG::
> +	Overrides the path of the global configuration file.
> +

I'm not particularly in favor of introducing another environment
variable, but if you are to introduce it, why just override the
configuration file, and not $HOME completely (e.g. to override
$HOME/.git-credentials too).

There was a patch proposing that here ($GIT_HOME to override $HOME):

  http://thread.gmane.org/gmane.comp.version-control.git/135447/focus=135494

I don't remember exactly what happened to the patch, I can't find an
explicit reason to reject it in the thread, but it seems it didn't make
its way to git.git.

> index cbbdf7d..9b09cee 100644
> --- a/path.c
> +++ b/path.c
> @@ -131,10 +131,15 @@ char *git_path(const char *fmt, ...)
>  
>  void home_config_paths(char **global, char **xdg, char *file)
>  {
> +	char *global_config = getenv("GIT_GLOBAL_CONFIG");
>  	char *xdg_home = getenv("XDG_CONFIG_HOME");
>  	char *home = getenv("HOME");
>  	char *to_free = NULL;
>  
> +	if (global_config) {
> +		*global = mkpathdup("%s", global_config);
> +		return;
> +	}

If you return here, haven't you completely broken the XDG stuff, since
*xdg is set a few lines below in the function?

Also, I guess home_config_paths(..., "ignore") will return the path to
the configuration file instead of the ignore file?

> --- a/t/t1306-xdg-files.sh
> +++ b/t/t1306-xdg-files.sh
> @@ -28,6 +28,14 @@ test_expect_success 'read config: xdg file exists and ~/.gitconfig exists' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'read config: $GIT_GLOBAL_CONFIG is set and ~/.gitconfig exists' '
> +	>.gitconfig &&
> +	echo "[alias]" >.gittestconfig &&
> +	echo "	myalias = !echo in_gitconfig" >>.gittestconfig &&
> +	echo in_gitconfig >expected &&
> +	GIT_GLOBAL_CONFIG=~/.gittestconfig git myalias >actual &&
> +	test_cmp expected actual
> +'

You should check that "git config --set" works too, as the codepath for
writing to configuration is relatively different from the one to read.
For example, I *think* that "git config --global" will write to
$GIT_GLOBAL_CONFIG and "git config" without --global will ignore it, but
a test would be welcome.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
