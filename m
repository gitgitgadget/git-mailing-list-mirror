From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] instaweb: if no httpd is specified and lighttpd doesn't
 exist, fall back on apache2.
Date: Sat, 10 May 2008 23:44:51 -0700
Message-ID: <7vlk2h7318.fsf@gitster.siamese.dyndns.org>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: nathan spindel <nathans@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 08:46:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv5KF-0003DO-RZ
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 08:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbYEKGpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 02:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbYEKGpH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 02:45:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYEKGpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 02:45:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B9340105E;
	Sun, 11 May 2008 02:45:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 052D1105D; Sun, 11 May 2008 02:44:59 -0400 (EDT)
In-Reply-To: <1210483565-12415-1-git-send-email-nathans@gmail.com> (nathan
 spindel's message of "Sat, 10 May 2008 22:26:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C9001ABC-1F25-11DD-8E4F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81742>

nathan spindel <nathans@gmail.com> writes:

> Signed-off-by: nathan spindel <nathans@gmail.com>
> ---
>  git-instaweb.sh |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 6f91c8f..b744133 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -31,8 +31,16 @@ conf="$GIT_DIR/gitweb/httpd.conf"
>  
>  # Defaults:
>  
> -# if installed, it doesn't need further configuration (module_path)
> -test -z "$httpd" && httpd='lighttpd -f'
> +# use lighttpd if it exists, otherwise use apache2
> +if test -z "$httpd"
> +then
> +	if type "lighttpd" > /dev/null 2>&1;

The exit code from "type" is very loosely defined by POSIX which just says
it exits >0 to signal that "an error occured".  Presumably it means there
is no such command that is executable on the $PATH, and it may be more
portable and reliable than using "which", but this still worries me.

Doesn't "lighttpd" have an option that reports "I am here" and exit 0,
e.g. "--version"?  Then we could instead say:

	if lighttpd --version >/dev/null
        then
        	... use it ...

and that would be much nicer...
