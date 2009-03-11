From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Removed unnecessary use of global variables.
Date: Tue, 10 Mar 2009 18:52:40 -0700
Message-ID: <7vab7s966v.fsf@gitster.siamese.dyndns.org>
References: <1236733524-8892-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 02:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhDeT-000752-Sf
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 02:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbZCKBww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 21:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbZCKBww
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 21:52:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbZCKBwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 21:52:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D1DC5DE2;
	Tue, 10 Mar 2009 21:52:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 14B4B5DE1; Tue,
 10 Mar 2009 21:52:41 -0400 (EDT)
In-Reply-To: <1236733524-8892-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Wed, 11 Mar 2009 01:05:24 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 531A8158-0DDF-11DE-B79A-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112867>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Subject: Re: [PATCH] Removed unnecessary use of global variables.

Please review "git log" and "git shortlog" output for the past dozen or so
commits to learn the style used in the project.

The first paragraph is a single line that goes to "Subject: ".  It
typically:

   - mentions what area, file, or function is affected;

   - a colon;

   - command the person who applies the patch to do something, iow,
     phrased in imperative mood; and

   - lacks the terminating full-stop.

   That is:

   Subject: connect.c: remove a few globals by using git_config callback data

> git_config() now takes a third data-parameter that is passed back
> to the callback-function. At the time this code was written, that
> parameter did not exist, so a somewhat nasty (but by all means
> correct) use of global variables was introduced. In commit
> ef90d6d4208a5130185b04f06e5f90a5f9959fe3 Johannes Schindelin
> <Johannes.Schindelin@gmx.de> introduced a parameter for similar
> purposes.

Perfect, even though I would have abbreviated the commit object name and
said:

    Since ef90d6d (Provide git_config with a callback-data parameter,
    2008-05-14), git_config() takes a callback data pointer that can be
    used to pass extra parameters to the parsing function.  The codepath
    to parse configuration variables related to git proxy predates this
    facility and used a pair of file scope static variables instead.

> I've changed the code to utilize this parameter to pass the
> string. In addition, I've made the function calculate the string
> length on usage instead, to reduce the parameters needed to what
> the callback-interface supplies.

We tend to avoid saying "I did this", i.e.

    This patch removes the need for these global variables by passing the
    name of the host we are trying to access as the callback data.

> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  connect.c |   16 ++++++----------
>  1 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 2f23ab3..98fbaea 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -371,14 +371,13 @@ static void git_tcp_connect(int fd[2], char *host, int flags)
>  	fd[1] = dup(sockfd);
>  }
>  
> -
>  static char *git_proxy_command;
> -static const char *rhost_name;
> -static int rhost_len;
> -
>  static int git_proxy_command_options(const char *var, const char *value,
> -		void *cb)
> +		void *data)
>  {
> +	const char *rhost_name = data;
> +	const size_t rhost_len = strlen(rhost_name);
> +

This is bad for two and half reasons.

 - The original said "cb" and we use that to denote "callback"
   everywhere.  Renaming it to "data" adds noise to the patch without
   adding any extra value.

 - The original used "int" but you made it to an unsigned "size_t"; a
   type-change like this could change the semantics.

   I've read the codepath and it does not seem to introduce a bug, but if
   you are changing it to size_t, then you should change the other two
   variables (host_len and match_len) that are compared with (and are
   involved in subtraction with) rhost_len to the same type at the same
   time to avoid confusion and potential for a bug.

 - Parser functions given to git_config(), such as this one, are called
   for each and every configuration datum encountered in the config files
   (/etc/gitconfig, $HOME/.gitconfig, and .git/config).  Because you
   decided not to precompute rhost_len at the calling site, you are
   recomputing it every time this function is called.  Worse yet, you
   compute it even before deciding if the call is about "core.gitproxy"
   variable.

   Moving these two variables down one scope would be a reasonable
   compromise.  You could introduce a structure with two members (name,
   len) and pass it as a call-back data, but for this particular case,
   counting the length of the name every time you see "core.gitproxy" in
   the configuration file is acceptable.

Thanks.
