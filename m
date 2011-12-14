From: Jeff King <peff@peff.net>
Subject: Re: How to run http server tests?
Date: Wed, 14 Dec 2011 16:39:52 -0500
Message-ID: <20111214213952.GA11519@sigill.intra.peff.net>
References: <4EE91307.6080504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 22:40:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RawYa-00046s-Fn
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 22:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179Ab1LNVj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 16:39:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50215
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755505Ab1LNVjy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 16:39:54 -0500
Received: (qmail 2810 invoked by uid 107); 14 Dec 2011 21:46:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 16:46:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 16:39:52 -0500
Content-Disposition: inline
In-Reply-To: <4EE91307.6080504@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187169>

On Wed, Dec 14, 2011 at 10:20:07PM +0100, Johannes Sixt wrote:

> I have a hard time running tests that use lib-httpd.sh.
> 
> I run the tests like this:
> 
>   LIB_HTTPD_MODULE_PATH=/usr/lib64/apache2 GIT_TEST_HTTPD=Yes \
>       sh -x t5541-http-push.sh -v -i
> 
> and I have to apply this patch because I do not have mod_cgi on my
> system (OpenSuse 11.4):
> 
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 0a4cdfa..e5cb3f9 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -13,4 +13,4 @@ ErrorLog error.log
>  </IfModule>
> -<IfModule !mod_cgi.c>
> -       LoadModule cgi_module modules/mod_cgi.so
> +<IfModule !mod_scgi.c>
> +       LoadModule scgi_module modules/mod_scgi.so
>  </IfModule>

Hmm. I know nothing about scgi, but a quick google indicates that it is
a separate protocol from CGI and is more like FastCGI (i.e., it wants to
spawn a long-running CGI server and contact it over a separate
protocol).

So I suspect you are not able to run http-backend, and thus you have no
smart-http support in your setup.

> I see t5541-http-push.sh #2 fail with:
> 
> ++ cd '/home/jsixt/Src/git/git/t/trash directory.t5541-http-push'
> ++ git clone http://127.0.0.1:5541/smart/test_repo.git/ test_repo_clone
> Cloning into 'test_repo_clone'...
> fatal: http://127.0.0.1:5541/smart/test_repo.git/info/refs not found:
> did you run git update-server-info on the server?

That's would I would expect if you have no smart-http support. The git
client will fall back to trying dumb http, but that should fail (because
we haven't run update-server-info).

The other errors you see probably stem from the same issue.

-Peff
