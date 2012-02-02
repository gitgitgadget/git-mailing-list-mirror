From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC (version A)] gitweb: use CGI with -utf8 to process Unicode query  parameters correctly
Date: Thu, 2 Feb 2012 21:08:50 +0100
Message-ID: <201202022108.51353.jnareb@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com> <m37h05c8c1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:08:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2x7-0006qp-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249Ab2BBUIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 15:08:13 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56826 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab2BBUIM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:08:12 -0500
Received: by eaah12 with SMTP id h12so1195844eaa.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=IoUS1xh20DwYXw4jYqnDG/9NDHu5+henJKPp4z39gwY=;
        b=CLUp5RP/8QlvhghVtB722fslf7yIqZ7hGzO4R+OgXtJTZpP8sEnDtyOd8ZB1x64kPm
         6XOs8u1mnBxzIU1dp1MjjUgbgkPOx39mZEvKxhKxZWMBFrSA9nZM9FoyxX/PvF5gQr8C
         7PNfhPEyOUggo8IUty+8IeiqPT72mXCcuC6nY=
Received: by 10.213.16.199 with SMTP id p7mr683282eba.141.1328213290546;
        Thu, 02 Feb 2012 12:08:10 -0800 (PST)
Received: from [192.168.1.13] (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id n17sm12920353eei.3.2012.02.02.12.08.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:08:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <m37h05c8c1.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189691>

Gitweb tries hard to properly process UTF-8 data, by marking output
from git commands and contents of files as UTF-8 with to_utf8()
subroutine.  This ensures that gitweb would print correctly UTF-8
e.g. in 'log' and 'commit' views.

Unfortunately it misses another source of potentially Unicode input,
namely query parameters.  The result is that one cannot search for a
string containing characters outside US-ASCII.  For example searching
for "Micha=C5=82 Kiedrowicz" (containing letter '=C5=82' - LATIN SMALL =
LETTER L
WITH STROKE, with Unicode codepoint U+0142, represented with 0xc5 0x82
bytes in UTF-8 and percent-encoded as %C5%81) result in the following
incorrect data in search field

	Micha=C3=85=C2=82 Kiedrowicz

This is caused by CGI by default treating '0xc5 0x82' bytes as two
characters in Perl legacy encoding latin-1 (iso-8859-1), because 's'
query parameter is not processed explicitly as UTF-8 encoded string.

According to "Using Unicode in a Perl CGI script" article on
http://www.lemoda.net/cgi/perl-unicode/index.html the simplest
solution is to just import '-utf8' pragma for CGI module:

	use CGI '-utf8';
	my $value =3D params('input');

According to CGI module documentation, the '-utf8' pragma may cause
problems with POST requests containing binary files... but gitweb
currently do not use POST requests at all, so this should be not a
problem now.

Alternate solution would be to explicity decode query parameters when
storing them in %input_params (and perhaps also path_info).

[jn: reworded / rewritten commit message]

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9cf7e71..a7441ef 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -10,7 +10,7 @@
 use 5.008;
 use strict;
 use warnings;
-use CGI qw(:standard :escapeHTML -nosticky);
+use CGI qw(:standard :escapeHTML -nosticky -utf8);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
 use Encode;
--=20
1.7.6
