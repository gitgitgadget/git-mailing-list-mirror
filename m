From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Splitting gitweb and build-time configuration variables
Date: Tue, 17 Aug 2010 20:15:36 +0200
Message-ID: <201008172015.37353.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	John Hawley <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 20:15:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlQhV-00048X-93
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 20:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096Ab0HQSPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 14:15:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55161 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab0HQSPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 14:15:46 -0400
Received: by bwz3 with SMTP id 3so3761142bwz.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=yy2NPPvSvoIww2HI+Ld5YIAdJNRCY3rK0c2ZBZbwKo0=;
        b=fImZ+OpwvjMblBpwHnqAZkG1O0a/wTm1AOQhOTNM6RBL+8GYr7oS5MF/nbmBiMy/Or
         s09UGColte2StZjThUZrBFWKShIDfOB3LkWid5HN/gNaLDEKS8LWVutosizLf1EgqKi3
         aFdC0YI3jthJmU9o0lNPy2ctTeyO7FnCWnECw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=Z+b4y+pyWNWJJK5YYeq0qVDIp25yPpIk+GiqHh9zZr47gMLw6WztCTepCe1tKA/XsI
         Pt2JMVjj02e2Vv3pKx5/00hyIIh7gJ/jsAgUpPb/PlrBkqH5TgnnqDb8531LR9732qOL
         HtpIm53OAZKKQ615jmti4WSL6cXlNpYFejRhE=
Received: by 10.204.131.132 with SMTP id x4mr4688024bks.50.1282068945344;
        Tue, 17 Aug 2010 11:15:45 -0700 (PDT)
Received: from [192.168.1.13] (abve74.neoplus.adsl.tpnet.pl [83.8.202.74])
        by mx.google.com with ESMTPS id f10sm5433149bkl.17.2010.08.17.11.15.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 11:15:44 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153772>

I am planning on picking up and resubmitting "splitting gitweb" series,
which was created by Pavan as a prerequisite for adding write and admin
support to gitweb ("Splitting gitweb and developing write 
functionalities (Integrated web client for git)" GSoC 2010 project).

There is a question what to do about gitweb configuration variables 
which are set during build time, like e.g.:

  # URI of stylesheets
  our @stylesheets = ("++GITWEB_CSS++");

or

  # core git executable to use
  # this can just be "git" if your webserver has a sensible PATH
  our $GIT = "++GIT_BINDIR++/git";


I think it was agreed that _setting_ these variables would be left in 
gitweb.perl, to have one single place which gathers all such variables, 
and to have gitweb/Makefile to munge (transform) only a single file.

So those variables would be _declared_ in appropriate gitweb module 
(Gitweb::Git aka Gitweb::Command, Gitweb::Config, Gitweb::Util etc.)
but would be _defined_ (set to value) in gitweb.perl.  The final goal is 
to have gitweb.perl consist only of loading modules, build-time 
configuration, and starting gitweb (calling run() or similarly named 
subroutine or method).

The question is where *description* of those build time configuration 
variables should be (see the above examples).  Should it be:

1. Description of build-time configuration variable is in the module
   that defines it, and each block of variables coming from the same
   module would have notice where one can find description of those
   variables, like in original patches by Pavan, e.g.:

     # Only configuration variables with build-time overridable
     # defaults are listed below. The complete set of variables
     # with their descriptions is listed in Gitweb::Config.

or

2. Description of build-time configuration variables is in gitweb.perl,
   and in each module there is comment that full description of those
   variables can be found there, e.g. (proposal):

     # Values of those variables are set during build time in 
     # gitweb/gitweb.perl (main script).  You can find their description
     # there.

or perhaps

3. Duplicate description of those variables, to have it both in
   appropriate module and in gitweb.perl


What do you think about it?

-- 
Jakub Narebski
Poland
