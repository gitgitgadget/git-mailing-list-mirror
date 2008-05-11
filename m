From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] instaweb: make it compatible with Mac OS X 10.5's apache
 installation.
Date: Sat, 10 May 2008 23:58:44 -0700
Message-ID: <7vhcd572e3.fsf@gitster.siamese.dyndns.org>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com>
 <1210483565-12415-2-git-send-email-nathans@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: nathan spindel <nathans@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 09:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv5XW-0005nZ-Cp
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 09:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbYEKG65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 02:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbYEKG64
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 02:58:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYEKG64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 02:58:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D729636A1;
	Sun, 11 May 2008 02:58:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1481A36A0; Sun, 11 May 2008 02:58:51 -0400 (EDT)
In-Reply-To: <1210483565-12415-2-git-send-email-nathans@gmail.com> (nathan
 spindel's message of "Sat, 10 May 2008 22:26:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B863666C-1F27-11DD-8852-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81743>

nathan spindel <nathans@gmail.com> writes:

> When in apache2 mode if there isn't an apache2 binary on the system but
> there is a httpd command in /usr/sbin/ (like there is on Mac OS X)
> use that instead.

How would you ensure that httpd is actually Apache and not something else?

> When in apache2 mode and there isn't a module_path specified, look for
> module paths in /usr/lib/apache2/modules _and_ /usr/libexec/apache2,
> in that order.

This one sounds Ok.

>  apache2_conf () {
> -	test -z "$module_path" && module_path=/usr/lib/apache2/modules
> +	# if there isn't an apache2 command on the system but there is a httpd
> +	# command in /usr/sbin/ use that instead for Mac OS X compatibility.


> +	httpd_only="`echo $httpd | cut -f1 -d' '`"
> +	type $httpd_only > /dev/null 2>&1;
> +	test $? != 0 && test -x /usr/sbin/httpd && httpd=${httpd/apache2/httpd}

I see the same "type" issue as I mentioned, but I see that we use them in
mergetool and web--browse and we haven't heard breakages so perhaps this
is portable enough ;-)

Please avoid ${parameter/pattern/string} expansion, which is not even in
POSIX.  It is bashism and unportable.

> +	if test -z "$module_path"
> +	then
> +		for path in /usr/lib/apache2/modules /usr/libexec/apache2; do

Hmm.  If you do discovery like this, maybe you would want to do discovery
for "httpd" the same way?  After all, why look for it only in /usr/sbin?

> @@ -190,6 +206,7 @@ ServerName "git-instaweb"
>  ServerRoot "$fqgitdir/gitweb"
>  DocumentRoot "$fqgitdir/gitweb"
>  PidFile "$fqgitdir/pid"
> +LockFile "$fqgitdir/gitweb/logs/accept.lock"
>  Listen $bind$port

We've seen this elsewhere and this part should be Ok.
