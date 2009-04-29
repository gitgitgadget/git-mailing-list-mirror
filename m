From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git config: error when editing a repo config and not
 being in one
Date: Wed, 29 Apr 2009 16:01:27 -0700
Message-ID: <7vws935ak8.fsf@gitster.siamese.dyndns.org>
References: <1241043939-29013-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:01:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIme-0001ci-Jw
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZD2XBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 19:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZD2XBi
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:01:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbZD2XBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 19:01:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FC06AE8CE;
	Wed, 29 Apr 2009 19:01:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 948C7AE8C9; Wed,
 29 Apr 2009 19:01:29 -0400 (EDT)
In-Reply-To: <1241043939-29013-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 30 Apr 2009 01:25:39 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0DC5894-3511-11DE-828F-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117973>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Let's throw an error on this specific case. If the user specifies the
> config file, he must know what he is doing.
>
> Teemu Likonen pointed this out.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin-config.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-config.c b/builtin-config.c
> index d8da72c..6e936e1 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -390,6 +390,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
>  	}
>  	else if (actions == ACTION_EDIT) {
>  		check_argc(argc, 0, 0);
> +		if (!config_exclusive_filename && !is_inside_git_dir())
> +			die("not in a git directory");
>  		git_config(git_default_config, NULL);
>  		launch_editor(config_exclusive_filename ?
>  			      config_exclusive_filename : git_path("config"),

How could this be correct?

When you are inside a work tree controlled by a git repository, and you
want to edit the configuration file that belongs to the repository, I do
not think is_inside_git_dir() is true.

What you are trying to catch is if $GIT_DIR exists (not in the sense that
"is it a non-empty string?", but in the sense that "does it point at an
existing directory?"), I think.

So perhaps you want to say something like this instead?

No, I did not test it.

 builtin-config.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index d8da72c..a4bd516 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -390,6 +390,12 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 	else if (actions == ACTION_EDIT) {
 		check_argc(argc, 0, 0);
+		if (!config_exclusive_filename) {
+			const char *git = get_git_dir();
+			struct stat sb;
+			if (!git || stat(git, &sb) || !S_ISDIR(sb.st_mode))
+				die("not in a git directory");
+		}
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
 			      config_exclusive_filename : git_path("config"),
