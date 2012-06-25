From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4 v8] Let core.attributesfile default to $XDG_CONFIG_HOME/git/ignore
Date: Mon, 25 Jun 2012 08:32:28 +0200
Message-ID: <vpqehp3j403.fsf@bauges.imag.fr>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
	<1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
	<1340355806-6894-4-git-send-email-Matthieu.Moy@imag.fr>
	<7v4nq3niwc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 08:32:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj2qq-00077W-1s
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 08:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab2FYGck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 02:32:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58604 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab2FYGcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 02:32:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5P6VqSD020019
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2012 08:31:52 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sj2qb-0005GP-Nd; Mon, 25 Jun 2012 08:32:29 +0200
In-Reply-To: <7v4nq3niwc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 Jun 2012 14:20:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 25 Jun 2012 08:31:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5P6VqSD020019
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1341210717.84937@8KXK23/I/OEShXykt/oo9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200551>

Junio C Hamano <gitster@pobox.com> writes:

> The patch text may be OK but look at the Subject: line and notice
> something funny ;-)

Nice catch.

> Given the root cause of that "something funny", I'll reduce the log
> message of this one down to:
>
>     Let core.attributesfile default to $XDG_CONFIG_HOME/git/attributes
>     
>     This gives the default value for the core.attributesfile variable
>     following the exact same logic of the previous change for the
>     core.excludesfile setting.
>     
>     Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
>     ...
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Good (I see you did the change yourself in pu).

> I am not sure about use of git/ignore in [2/2], though.
>
> Shouldn't the default value for core.excludesfile be git/exclude,
> not git/ignore?

Both are valid options, and unfortunately, Git currently use both
"ignore" and "exclude" to mean the same thing. 

I have a slight preference for "ignore", because this file is the
user-wide version of the .gitignore file. I think most non-advanced
users have already been exposed to the wording "ignore" with this file,
but much less have been exposed to "exclude" (for example, I don't
remember having ever used the per-directory .git/info/exclude). So,
going for "ignore" means that the wording used for the most common
operations will be consistant, and only relatively advanced users (who
use .git/info/exclude, or "git ls-files --exclude-standard", or need to
set core.excludesfile to some value other than the default) will need to
learn that "exclude" is synonym for "ignore" in the Git world.

Actually, it would even make sense to reduce the number of occurences of
"excludes" in the UI, e.g. support something like core.ignoresfile as an
alias for core.excludesfile, along the lines of:

--- a/config.c
+++ b/config.c
@@ -723,7 +723,7 @@ static int git_default_core_config(const char *var, const char *value)
        if (!strcmp(var, "core.askpass"))
                return git_config_string(&askpass_program, var, value);
 
-       if (!strcmp(var, "core.excludesfile"))
+       if (!strcmp(var, "core.excludesfile") || !strcmp(var, "core.ignoresfile"))
                return git_config_pathname(&excludes_file, var, value);
 
        if (!strcmp(var, "core.whitespace")) {

(which would off course require some documentation)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
