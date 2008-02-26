From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: add regression tests
Date: Mon, 25 Feb 2008 16:24:30 -0800
Message-ID: <7vprukfttt.fsf@gitster.siamese.dyndns.org>
References: <20080218130726.GA26854@localhost>
 <alpine.LSU.1.00.0802181339470.30505@racer.site>
 <20080218155546.GA8934@localhost>
 <alpine.LSU.1.00.0802181733400.30505@racer.site>
 <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org>
 <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org>
 <20080225232820.GA18254@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Feb 26 01:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTndO-0007BW-Iy
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 01:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805AbYBZAYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 19:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757122AbYBZAYt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 19:24:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754AbYBZAYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 19:24:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 93B8A1848;
	Mon, 25 Feb 2008 19:24:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5EB0A1846; Mon, 25 Feb 2008 19:24:38 -0500 (EST)
In-Reply-To: <20080225232820.GA18254@localhost> (Clemens Buchacher's message
 of "Tue, 26 Feb 2008 00:28:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75095>

Clemens Buchacher <drizzd@aon.at> writes:

> http-push tests require a web server with WebDAV support.

I'd rather see these tests that are heavyweight and (more
importantly) open a listened network ports kept strictly
optional.  IOW, please enable them only when the user asks for
them, like some of the heavier GIT_SVN tests already do with
"make full-svn-test" target.

>  create mode 100644 t/lib-httpd.sh
>  create mode 100644 t/lib-httpd/apache.conf
>  create mode 100644 t/lib-httpd/ssl.cnf
>  create mode 100644 t/t5540-http-push.sh

Others are Ok but the last one should be 100755 per convention.

> +TEST_PATH="$PWD"/../lib-httpd
> +HTTPD_ROOT_PATH="$PWD"/httpd
> +HTTPD_DOCUMENT_ROOT_PATH="$PWD"/httpd/www
> +
> +if ! test -x "$LIB_HTTPD_PATH"
> +then
> +        say_color "" "skipping test, no web server found at $LIB_HTTPD_PATH"

Just use "say" to let "say" function pick the color.

> +	if test "$LIB_HTTPD_DAV" != "" -o "$LIB_HTTPD_SVN" != ""
> +	then
> +		HTTPD_PARA="$HTTPD_PARA -DDAV"
> +
> +		if test "$LIB_HTTPD_SVN" != ""
> +		then
> +			HTTPD_PARA="$HTTPD_PARA -DSVN"
> +			rawsvnrepo="$HTTPD_ROOT_PATH/svnrepo"
> +			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/svn"

Subversion???  Ah, you are preparing for enhancement of t91XX series?

> +		fi
> +	fi
> +}
> +
> +start_httpd() {
> +	prepare_httpd
> +
> +	"$LIB_HTTPD_PATH" $HTTPD_PARA \
> +		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start
> +}
> +
> +stop_httpd() {
> +	"$LIB_HTTPD_PATH" $HTTPD_PARA -k stop
> +}

I have to wonder where it is arranged so that a test failure
(including ^C out of it, or losing SSH connection to the
terminal) would cause the server to be killed off.
