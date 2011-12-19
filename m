From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/3] gitweb: Fix fallback mode of to_utf8 subroutine
Date: Mon, 19 Dec 2011 01:54:16 +0100
Message-ID: <201112190154.19107.jnareb@gmail.com>
References: <1324113743-21498-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 01:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcRUm-00021p-NG
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 01:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab1LSAyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 19:54:21 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51812 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab1LSAyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 19:54:20 -0500
Received: by eekc4 with SMTP id c4so4999244eek.19
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 16:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0NC+iYwYxQz+bXJbROQtSDBDeJmzZpnwTNNy/acNK0w=;
        b=Epg6RVX09/mkEztWn0LILfUCIvKkImYREOFVYXVnCBxLhMuxdDmnA+OQ0Ctvndddnk
         CdsX/cOvLQdufoL2gKsagIJIpUE9I8wv/gZkLQ3ffdDftjkiv88nCZ3bc+F8zH02tesg
         5UCiJiApg86dQ52rDhGnzmFP8l9JmbSUvmBIc=
Received: by 10.213.29.7 with SMTP id o7mr4369100ebc.102.1324256058886;
        Sun, 18 Dec 2011 16:54:18 -0800 (PST)
Received: from [192.168.1.13] (aehn116.neoplus.adsl.tpnet.pl. [79.186.195.116])
        by mx.google.com with ESMTPS id q28sm37592124eea.6.2011.12.18.16.54.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Dec 2011 16:54:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1324113743-21498-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187431>

e5d3de5 (gitweb: use Perl built-in utf8 function for UTF-8 decoding.,
2007-12-04) was meant to make gitweb faster by using Perl's internals
(see subsection "Messing with Perl's Internals" in Encode(3pm) manpage)

Simple benchmark confirms that (old = 00f429a, new = this version);
note that it is synthetic benchmark of standalone subroutines, not
of gitweb itself

        old  new
  old    -- -65%
  new  189%   --

Unfortunately it made fallback mode of to_utf8 do not work...  except
for default value 'latin1' of $fallback_encoding ('latin1' is Perl
native encoding), which is why it was not noticed for such long time.

utf8::valid(STRING) is an internal function that tests whether STRING
is in a _consistent state_ regarding UTF-8.  It returns true is
well-formed UTF-8 and has the UTF-8 flag on _*or*_ if string is held
as bytes (both these states are 'consistent').  For gitweb the second
option was true, as output from git commands is opened without ':utf8'
layer.

What made it work at all for STRING in 'latin1' encoding is the fact
that utf8:decode(STRING) turns on UTF-8 flag only if source string is
valid UTF-8 and contains multi-byte UTF-8 characters... and that if
string doesn't have UTF-8 flag set it is treated as in native Perl
encoding, i.e.  'latin1' / 'iso-8859-1' (unless native encoding it is
EBCDIC ;-)).  It was ':utf8' layer that actually converted 'latin1'
(no UTF-8 flag == native == 'latin1) to 'utf8'.


Let's make use of the fact that utf8:decode(STRING) returns false if
STRING is invalid as UTF-8 to check whether to enable fallback mode.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Excuse me for overly long commit message...

Resent as part of to_utf8 fixes for better visibility

 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d24763b..75b0970 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1443,8 +1443,7 @@ sub validate_refname {
 sub to_utf8 {
 	my $str = shift;
 	return undef unless defined $str;
-	if (utf8::valid($str)) {
-		utf8::decode($str);
+	if (utf8::valid($str) && utf8::decode($str)) {
 		return $str;
 	} else {
 		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
-- 
1.7.6
