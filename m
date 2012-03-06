From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv3 0/2] gitweb: Beginnings of splitting gitweb into modules
Date: Tue,  6 Mar 2012 23:41:40 +0100
Message-ID: <1331073702-9071-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 23:41:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S534t-0007Fx-Fr
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 23:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759333Ab2CFWlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 17:41:50 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52136 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759081Ab2CFWlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 17:41:49 -0500
Received: by eaaq12 with SMTP id q12so2014017eaa.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 14:41:48 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.99.1 as permitted sender) client-ip=10.14.99.1;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.99.1 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.99.1])
        by 10.14.99.1 with SMTP id w1mr14509636eef.49.1331073708147 (num_hops = 1);
        Tue, 06 Mar 2012 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=52Vmrl091ptYux7R7lKtqC6RM8hGHqKs8jpY7vYcNtg=;
        b=jU3ISN/1VHl8zzUEaYiaJDkHdP1uR9yPO/oMcJcB5Gv5FF42UpjXKpy8Bx7gIagPJ6
         Zg1+0+rsKAF+6q1zGHJLSes6N3MvCyfROG99yzbwgWQmVTbXVuUlQJVw3Vw4GQmwVVu8
         huQiCBrMj1NkVUj4fWVELZnF6hfvH3AuaqVfUeXDHbJVpvxSAZdK8pl8XFUuHSA2UzoU
         hZDHujXlloXCVznf7dFQsmRIb9xX8HLY4tQeatb7NGRzYzNxYvTbrOwQjI4Pa+PLwBo8
         f8CEdOffMb08tlZQYEhi1UoEgJxwJ8oqmIelW5DHla/FUWxGJN+IU6XEXASvaRTEYb2k
         rfZA==
Received: by 10.14.99.1 with SMTP id w1mr10995662eef.49.1331073708021;
        Tue, 06 Mar 2012 14:41:48 -0800 (PST)
Received: from localhost.localdomain (abwo250.neoplus.adsl.tpnet.pl. [83.8.238.250])
        by mx.google.com with ESMTPS id o49sm79596627eeb.7.2012.03.06.14.41.45
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 14:41:47 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192408>

Gitweb is currently next to largest file (after gitk) in git sources,
having more than 235KB, with more than 7,500 lines.

Therefore adding any large feature, like gitweb caching by J.H. and my
rewrite of it, or "gitweb admin/write" [failed] GSoC 2010 project by
Pavan Kumar Sunkara, would require for the new code to be added as a
separate module.  Otherwise gitweb would fast become unmaintainable.

Not in all cases splitting gitweb upfront would be required.  If a new
feature is clearly separate from the rest of gitweb we can add this
new feature as a new module to be used by gitweb.  This is for example
the case for adding output caching support to gitweb.

What must be done however is preparing the infrastructure for modular
gitweb sources; to properly test such infrastructure we need at least
one gitweb module split off gitweb itself and used by it.  This patch
series implements this initial step.

Note that JavaScript side of gitweb is already split into many smaller
files for better maintability (and concatenated on build for better
performance) since 9a86dd5 (gitweb: Split JavaScript for maintability,
combining on build, 2011-04-28).


The major problem with splitting gitweb code into modules (similar to
SVN::Web or Gitalist) is its error handling.  

Currently die_error() subroutine uses non-local jump out of subroutine
to end of request.  This means however that die_error() must be in the
same file as run_request() subroutine, and therefore any module which
must use die_error() must include module with run_request()... and one
of most natural places for run_request() is a main script.

To be able to decouple die_error() and run_request() we have to change
the way error handling is done.  

One approach is to go back to using 'exit' (which ModPerl::Registry
redefines to not quit Perl interpreter) in die_error().  But this has
serious disadvantages for other persistent environments: FastCGI (with
CGI::Fast) and PSGI (emulated via CGI::Emulate::PSGI).  It wouldn't
either solve problems with handling errors in capturing and caching
layer in the future gitweb output caching support.

Another solution, used e.g. by SVN::Web, is to handle errors and
generate error pages using exceptions.  For handling exceptions we
would need something like Try::Tiny, for throwing them something like
HTTP::Exception (which in turn uses Exception::Class), or
HTTP::Throwable... though the latter is probably not so suitable for
non-ersistent environments like pure CGI (requires Moose and PSGI).

We should probably implement the latter solution... but this patch
series doesn't do that.


The previous version of this patch series was sent to git mailing list
as

  [PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into modules
  http://thread.gmane.org/gmane.comp.version-control.git/172659


Shortlog:
~~~~~~~~~
Jakub Narebski (1):
  gitweb: Prepare for splitting gitweb

Pavan Kumar Sunkara (1):
  gitweb: Create Gitweb::Util module

Diffstat:
~~~~~~~~~
 gitweb/Makefile           |   22 ++-
 gitweb/gitweb.perl        |  401 ++---------------------------------------
 gitweb/lib/Gitweb/Util.pm |  438 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 472 insertions(+), 389 deletions(-)
 create mode 100755 gitweb/lib/Gitweb/Util.pm

-- 
1.7.9
