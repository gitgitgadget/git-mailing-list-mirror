From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Return or exit after done serving request
Date: Mon, 14 Jun 2010 10:28:58 +0200
Message-ID: <201006141029.00310.jnareb@gmail.com>
References: <20100613100800.28221.77529.stgit@localhost.localdomain> <7v1vcach4x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 10:29:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO52k-0007gq-JD
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 10:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab0FNI3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 04:29:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58089 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689Ab0FNI3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 04:29:12 -0400
Received: by bwz7 with SMTP id 7so1899698bwz.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6UikIm0Nn4UK++cLMt65VaPuGWkbcuZnSrx6fSjbhJ4=;
        b=oGDnurenrOtQNp5aExY6F1Jo3/0zQAdu3nSp0G7GsgzZ+1wD7Ge4zriTrplf2ygLSj
         tS9bKq9nM6aph2YHhZvgaU8xMdq4PUiHyIOfx7DJos4g0nA6IfHATEG7Ql0ju/Q5L0B2
         BuWv0zx369Pn6WpTf3HZQJUmyj9U+7MHIBzw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AymTZjQ1MmC/kwcjG4QpxZPFdZPdqjSobhVlHeMgEwZFN1Lmrm+sShQWJlK5wCHWE5
         rEbgf4qvKhG6kzE+S2JRf74g8PAlv7xOVXmH0nPfG94v4T18vwW5FP65kx3u/FFd6i6D
         wUAiwlEujucPh4d78p1K2SQcd3bPfggVnSAMw=
Received: by 10.204.74.2 with SMTP id s2mr4068936bkj.28.1276504150579;
        Mon, 14 Jun 2010 01:29:10 -0700 (PDT)
Received: from [192.168.1.15] (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id v3sm18496965bkz.22.2010.06.14.01.29.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 01:29:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1vcach4x.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149086>

On Mon, 14 June 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index e108bbc..02f366d 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -987,7 +987,16 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
> >  	die_error(400, "Project needed");
> >  }
> >  $actions{$action}->();
> > +
> >  DONE_GITWEB:
> > +if (defined caller) {
> > +	# wrapped in a subroutine processing requests,
> > +	# e.g. mod_perl with ModPerl::Registry, or PSGI with Plack::App::WrapCGI
> > +	return;
> > +} else {
> > +	# pure CGI script, serving single request
> > +	exit;
> > +}
> >  1;
> 
> Is the last "1;" still needed if we did this?

Probably not, and probably we never need this.

> 
> I am guessing that this new codeblock will go inside "sub run" when
> merging with your c2394fe (gitweb: Put all per-connection code in run()
> subroutine, 2010-05-07) and Sam's a0446e7 (gitweb: Add support for
> FastCGI, using CGI::Fast, 2010-05-07).  If I am mistaken, please advise.

No, the code is meant to be after last code to be run in gitweb, 
in *top level* scope, otherwise it would always return.

So the patch merged with commits mentioned above ('jn/gitweb-fastcgi',
old or new) would look like the following... but I am not sure if it
is needed, as I tried to reproduce error / warning that I got to ensure
that the patch really fixes it (as in new post "sub run" code there
are subroutine definitions before end of 'main' code, i.e. run(); in
new post "sub run" code, $actions{$action}->(); in pre "sub run" code)
and I couldn't get again this:

  /var/log/httpd/error_log:
  ...
  [Sun Jun 13 11:58:02 2010] gitweb.cgi: Subroutine git_atom redefined at /var/www/perl/gitweb/gitweb.cgi line 6804.
  [Sun Jun 13 11:58:02 2010] gitweb.cgi: Subroutine git_opml redefined at /var/www/perl/gitweb/gitweb.cgi line 6808.
  ...gi-bin

Lets table it now.

-- >8 --
Subject: [RFC/PATCH] gitweb: Return or exit after done serving request

Check if there is a caller in top frame of gitweb, and either 'return'
if gitweb code is wrapped in subroutine, or 'exit' if it is not.

This should avoid

  gitweb.cgi: Subroutine git_SOMETHING redefined at gitweb.cgi line NNN

warnings in error_log when running gitweb with mod_perl (using
ModPerl::Registry handler)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 14ef50c..43589b5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1111,6 +1111,16 @@ sub run {
 
 run();
 
+if (defined caller) {
+	# wrapped in a subroutine processing requests,
+	# e.g. mod_perl with ModPerl::Registry, or PSGI with Plack::App::WrapCGI
+	return;
+} else {
+	# pure CGI script, serving single request
+	# or 'exit' hijacked appropriately
+	exit;
+}
+
 ## ======================================================================
 ## action links
 
-- 
1.7.0.1
