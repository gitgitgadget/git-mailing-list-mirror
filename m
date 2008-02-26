From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: add regression tests
Date: Tue, 26 Feb 2008 20:32:06 +0100
Organization: glandium.org
Message-ID: <20080226193206.GC16889@glandium.org>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org> <20080225232820.GA18254@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:29:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU5Ux-0000tV-0t
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 20:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761562AbYBZT3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 14:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760442AbYBZT3R
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 14:29:17 -0500
Received: from vuizook.err.no ([85.19.215.103]:60698 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757889AbYBZT3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 14:29:16 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JU5UB-00043A-3M; Tue, 26 Feb 2008 20:29:13 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JU5X4-0005In-PA; Tue, 26 Feb 2008 20:32:06 +0100
Content-Disposition: inline
In-Reply-To: <20080225232820.GA18254@localhost>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75164>

On Tue, Feb 26, 2008 at 12:28:20AM +0100, Clemens Buchacher wrote:
> http-push tests require a web server with WebDAV support.
> 
> This commit introduces a HTTPD test library, which can be configured using
> the following environment variables.
> 
> LIB_HTTPD_PATH		web server path
> LIB_HTTPD_MODULE_PATH	web server modules path
> LIB_HTTPD_PORT		listening port
> LIB_HTTPD_DAV		enable DAV
> LIB_HTTPD_SVN		enable SVN
> LIB_HTTPD_SSL		enable SSL

Overall, this looks fine to me, though I haven't taken a deep look at
what the test itself does. I was more interested in the "library".

Just a few nitpicks.

> +HTTPD_ROOT_PATH="$PWD"/httpd
> +HTTPD_DOCUMENT_ROOT_PATH="$PWD"/httpd/www

Why not just use $HTTPD_ROOT_PATH/www and don't use the
$HTTPD_DOCUMENT_ROOT_PATH variable ?

> +	mkdir $HTTPD_ROOT_PATH
> +	mkdir $HTTPD_DOCUMENT_ROOT_PATH

This could become mkdir -p $HTTPD_ROOT_PATH/www

> +	if test -n "$LIB_HTTPD_SSL"
> +	if test "$LIB_HTTPD_SSL" != ""

Why use different tests?

> +		openssl req \
> +			-config $TEST_PATH/ssl.cnf \
> +			-new -x509 -nodes \
> +			-out $HTTPD_ROOT_PATH/httpd.pem \
> +			-keyout $HTTPD_ROOT_PATH/httpd.pem
> +		export GIT_SSL_NO_VERIFY=t
> +		HTTPD_PARA="$HTTPD_PARA -DSSL"

For future improvement (that could be another patch), it would probably
be nice to generate a CAcert and a certificate signed by it, so we can
also test without GIT_SSL_NO_VERIFY.

By the way, why not just include the .pem ?

> +stop_httpd() {
> +	"$LIB_HTTPD_PATH" $HTTPD_PARA -k stop
> +}

As Junio said, it might be good to add a trap.

> +RANDFILE                = $ENV::HOME/.rnd

Wouldn't it be better elsewhere ?

Mike
