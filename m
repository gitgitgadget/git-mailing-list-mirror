From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: in-page errors don't work with mod_perl
Date: Sun, 27 Nov 2011 14:43:20 -0800 (PST)
Message-ID: <m339d9mbiu.fsf@localhost.localdomain>
References: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?J=FCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Sun Nov 27 23:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUnRZ-00065D-13
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 23:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab1K0WnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 17:43:24 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34605 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab1K0WnX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2011 17:43:23 -0500
Received: by bke11 with SMTP id 11so7627116bke.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=qKQkK0DuKDSJG0o/U0LBAWan0Xqc67dGxUN3UFtfkxg=;
        b=T0jWq5LsIYMkICteK3fbqoZvHRemHiHG9q9AAherkwZMxJBz+0y0r7aCzvkm+H1F2o
         5B1rpRL+g+VbHLKlMY967KcRcyi66u3ZEjloYfUXLRGBCJsWOHv9TZwX7bAjSDF2WWMZ
         5UUyJ7owip4BL/H4IEZo8bxhP5/5fsWTHRJcI=
Received: by 10.204.36.8 with SMTP id r8mr36692767bkd.129.1322433801839;
        Sun, 27 Nov 2011 14:43:21 -0800 (PST)
Received: from localhost.localdomain (abwo176.neoplus.adsl.tpnet.pl. [83.8.238.176])
        by mx.google.com with ESMTPS id v7sm1838600fah.5.2011.11.27.14.43.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Nov 2011 14:43:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pARMhsq4001763;
	Sun, 27 Nov 2011 23:43:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pARMhr0f001760;
	Sun, 27 Nov 2011 23:43:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185993>

Hello!

J=FCrgen Kreileder <jk@blackdown.de> writes:

> when gitweb.perl (208a1cc3d3) is run with mod_perl2 (2.0.5-2ubuntu1 o=
n
> Ubuntu 11.10) custom error pages don't work: Any page with status !=3D
> 200 shows the plain Apache error document instead of a gitweb's error
> page.

Thanks for reporting it.  I wonder if it worked at all anytime...

Anyway, does the following patch fixes this issue for you?

-- >8 --
Subject: [PATCH] gitweb: Fix error handling for mod_perl

When gitweb was run with mod_perl2 (using ModPerl::Registry), the
custom error pages don't work: Any page with status !=3D 200 had the
plain Apache error document appended to a gitweb's error page, e.g.

  <?xml version=3D"1.0" encoding=3D"utf-8"?>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  ...
  </html><!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
  <html><head>
  <title>404 Not Found</title>
  </head><body>
  <h1>Not Found</h1>
  <p>The requested URL ... was not found on this server.</p>
  <hr>
  <address>Apache/2.0.54 (Fedora) Server at localhost Port 80</address>
  </body></html>

When serving gitweb with application/xhtml+xml mimetype this results
in malformed XML and some browsers do not showing output at all.


The solution used by this commit is to tell mod_perl that it is O.K.,
and we handled all errors by ourselves.

This make us not depend in whether there is or not

  PerlOptions +ParseHeaders

in Apache configuration section for mod_perl.

Reported-by: J=FCrgen Kreileder <jk@blackdown.de>
Signed-off-by: Jakub Nar=EAbski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..f51cce1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1239,6 +1239,11 @@ sub run {
=20
 run();
=20
+if ($ENV{'MOD_PERL'}) {
+	# mod_perl needs to be told that error page was already created
+	my $r =3D $cgi->r;
+	$r->status(200);
+}
 if (defined caller) {
 	# wrapped in a subroutine processing requests,
 	# e.g. mod_perl with ModPerl::Registry, or PSGI with Plack::App::Wrap=
CGI
--=20
1.7.6
