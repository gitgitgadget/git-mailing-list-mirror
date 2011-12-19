From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/3 v2 (bugfix)] gitweb: Fix fallback mode of to_utf8 subroutine
Date: Mon, 19 Dec 2011 17:21:17 +0100
Message-ID: <201112191721.17478.jnareb@gmail.com>
References: <1324113743-21498-1-git-send-email-jnareb@gmail.com> <201112190154.19107.jnareb@gmail.com> <201112191311.58787.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Juergen Kreileder <jk@blackdown.de>,
	Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 17:21:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcfxv-0001EL-N3
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 17:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab1LSQVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 11:21:24 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46795 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1LSQVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 11:21:21 -0500
Received: by eekc4 with SMTP id c4so5596421eek.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=E+MaOh18DGwJjxQfbrUYKF3+THkYyYdG4jxWt0wIt3U=;
        b=ad3MV/XHqu0zJYt90nsC4O65rBrCugnI+qFdZS8TpDpy2DgHu5ZQbqfTbADJHFe1Iu
         VgArI/L953cNOUKnznEtN4ziFDeWTVHEXcQn/wQtxxvBDVespNqCaoRb7L3RFu6CzjNF
         ScnliSNJEEaHWtNgWi4Ed4zlTNpsBd4Spry/M=
Received: by 10.14.52.200 with SMTP id e48mr4425344eec.72.1324311680743;
        Mon, 19 Dec 2011 08:21:20 -0800 (PST)
Received: from [192.168.1.13] (aehn116.neoplus.adsl.tpnet.pl. [79.186.195.116])
        by mx.google.com with ESMTPS id s16sm46374346eef.2.2011.12.19.08.21.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 08:21:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201112191311.58787.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187455>

e5d3de5 (gitweb: use Perl built-in utf8 function for UTF-8 decoding.,
2007-12-04) was meant to make gitweb faster by using Perl's internals
(see subsection "Messing with Perl's Internals" in Encode(3pm) manpage)

Simple benchmark confirms that (old = 00f429a, new = this version):
note that it is synthetic benchmark of standalone subroutines, not
of gitweb itself (where probably no visible difference in performace
will show)

        Rate  old  new
  old 1582/s   -- -64%
  new 4453/s 181%   --

Unfortunately it made fallback mode of to_utf8 do not work...  except
for default value 'latin1' of $fallback_encoding (because 'latin1' is
Perl native encoding), which is probably why it was not noticed for so
long.


utf8::valid(STRING) is an internal function that tests whether STRING
is in a _consistent state_ regarding UTF-8.  It returns true is
well-formed UTF-8 and has the UTF-8 flag on _*or*_ if string is held
as bytes (both these states are 'consistent').

For gitweb in most cases the second option was true, as output from
git commands is opened without ':utf8' layer.  So utf8::valid is not
useful for to_utf8.

What made it look as if to_utf8() fallback mode worked correctly
(though only for $fallback_encoding at its default value 'latin1')
was the fact that utf8::decode(STRING) turns on UTF-8 flag only if
source string^W octets form a valid UTF-8 and it contains multi-byte
UTF-8 characters... this means that if string was not valid UTF-8
it didn't get UTF-8 flag.

When string doesn't have UTF-8 flag set, it is treated as if it was in
native Perl encoding, which is 'latin1' (unless native encoding is
EBCDIC ;-)).  So it was ':utf8' layer that actually converted 'latin1'
(no UTF-8 flag == native == 'latin1) to 'utf8', and not to_utf8()
subroutine.  Fallback mode was never triggered.


Let's make use of the fact that utf8::decode(STRING) returns false if
STRING is invalid as UTF-8 to check whether to enable fallback mode.

Note however that if STRING has UTF-8 flag set already, then
utf8::decode also returns false, which could cause problems if given
string was already converted with to_utf8().  Such double conversion
can happen in gitweb.  Therefore we have to check if STRING has UTF-8
flag set with utf8::is_utf8(); if this subroutine returns true then we
have already decoded (converted) string, and don't have to do it
second time.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski wrote:
> P.S. I started to get strange errors
> 
>  XML Parsing Error: xml processing instruction not at start of external entity
>  Location: http://localhost/cgi-bin/gitweb/gitweb.cgi
>  Line Number 37, Column 1:
>  <?xml version="1.0" encoding="utf-8"?>
>  ^
> 
> while "show source" shows that '<?xml version="1.0" encoding="utf-8"?>'
> is the first line.  WTF?!?
> 
> P.P.S. Now I am getting errors when running gitweb, but only in some
> cases (via mod_cgi not as standalone script, only when using lynx),
> namely it looks like it falls back to 'latin1' when doing content
> which is valid UTF-8.
> 
> Will investigate.

Now it is fixed; the error was caused by to_utf8 not dealing with double
encoding for strings outside 7bit ASCII.

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d24763b..fc41b07 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1443,8 +1443,8 @@ sub validate_refname {
 sub to_utf8 {
 	my $str = shift;
 	return undef unless defined $str;
-	if (utf8::valid($str)) {
-		utf8::decode($str);
+
+	if (utf8::is_utf8($str) || utf8::decode($str)) {
 		return $str;
 	} else {
 		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
-- 
1.7.6
