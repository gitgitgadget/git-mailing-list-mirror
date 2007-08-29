From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify how repository service parameters are used
Date: Wed, 29 Aug 2007 02:34:17 -0700
Message-ID: <7vr6lmr8fa.fsf@gitster.siamese.dyndns.org>
References: <absa3doz.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 11:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQJwP-0006Ip-Vv
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbXH2JeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 05:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbXH2JeW
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:34:22 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbXH2JeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 05:34:21 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D11FC12A5EB;
	Wed, 29 Aug 2007 05:34:40 -0400 (EDT)
In-Reply-To: <absa3doz.fsf@cante.net> (Jari Aalto's message of "Wed, 29 Aug
	2007 12:14:20 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56917>

Jari Aalto <jari.aalto@cante.net> writes:

> At upload-archive service, mention repository option
> daemon.uploadarchive. Add a paragrah and example to show how the
> service parameters are added to the repository's config file.
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-daemon.txt |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index f902161..0aeff70 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -164,7 +164,21 @@ upload-pack::
>  	item to `false`.
>  
>  upload-archive::
> -	This serves `git-archive --remote`.
> +	This serves `git-archive --remote`. This is the
> +        repository setting `daemon.uploadarchive`.
> +
> +Instead of globally using `--enable=service`, it might be more
> +advisable to configure these items by repository basis. The
> +configuration file is ./config, supposing that the repository
> +was created with `git --bare init [--share]`. The services would
> +be listed as:

"This is the repository setting"?  The service is not repository
setting.  It can be controlled by the configuration variable.

"It might be more advisable"?  If you advise, indicate what
considerations there are when picking between the two.
Otherwise you would confuse users.

The filename is ./config only because it is $GIT_DIR/config;
there is nothing new here, and not worth mentioning.  If you are
running git-daemon, you should be at least familiar enough to
know that per-repository configuration file is always there.

Saying the configuration file is ./config (and not .git/config),
and the part "supposing that ..." both imply that use of bare
repository is recommended.  While I like the idea of strongly
encouraging the use of bare repositories for the purpose of
git-daemon, I do not think SERVICES section is the place to do
so.  These implications are not strong enough either, so if we
want to have something to encourage bare repositories, we should
dedicate a separate paragraph to do so.

I think the last item might be controvercial, so I'd rather omit
the "bare" part.  Here is a suggested rewrite.

---
 Documentation/git-daemon.txt |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index f902161..5dbf016 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -157,6 +157,12 @@ the facility of inet daemon to achieve the same before spawning
 SERVICES
 --------
 
+These services can be globally enabled/disabled using the command
+line options of this command.  If a finer-grained control is
+desired (e.g. to allow `git-archive` to be run against only a
+selected repositories the daemon serves), per-repository
+configuration file can be used to enable/disable them.
+
 upload-pack::
 	This serves `git-fetch-pack` and `git-peek-remote`
 	clients.  It is enabled by default, but a repository can
@@ -164,7 +170,18 @@ upload-pack::
 	item to `false`.
 
 upload-archive::
-	This serves `git-archive --remote`.
+	This serves `git-archive --remote`.  It is disabled by
+	default, but a repository can enable it by setting
+	`daemon.uploadarchive` configuration item to `true`.
+
+receive-pack::
+	This serves `git-send-pack` clients, allowing anonymous
+	push.  It is disabled by default, as there is _no_
+	authentication in the protocol (for that, use the
+	"git over ssh" protocol, not `git-daemon`).  It can be
+	enabled by `daemon.receivepack` configuration item to
+	`true`.
+
 
 EXAMPLES
 --------
@@ -229,6 +246,18 @@ Repositories can still be accessed by hostname though, assuming
 they correspond to these IP addresses.
 
 
+To enable `git-archive --remote` and disable `git-fetch` against
+a repository, have this in the configuration file in the
+repository (that is the file 'config' next to 'HEAD', 'refs' and
+'objects').
++
+----------------------------------------------------------------
+[daemon]
+	uploadpack = false
+	uploadarchive = true
+----------------------------------------------------------------
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>, YOSHIFUJI Hideaki
