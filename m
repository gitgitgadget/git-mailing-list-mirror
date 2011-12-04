From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Handling of non-UTF8 data in gitweb
Date: Sun, 4 Dec 2011 17:09:30 +0100
Message-ID: <201112041709.32212.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 17:09:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXEdN-00086T-Jq
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 17:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab1LDQJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Dec 2011 11:09:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40704 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab1LDQJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 11:09:40 -0500
Received: by wgbdr13 with SMTP id dr13so5455907wgb.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2011 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        bh=wM4mM1h8yDaHSP+ykHq67jRpDOCLRsL8y4w8LT0jL0Y=;
        b=pNLLF5fh+nXcNPxIMUwgEz/zk831K9LnUaWWpQVosLb0uUmUkoxtGh7Fj2lx7bmm07
         iilPmJfQGmrQH83Zmg9bn0JyNKSAW/emoHvdINMkfPLk87ib5AzCptFPq4vT33arPBkA
         BMGkpUxKi/nbXHeJRcTB4B5t9RKgVr+1whMtY=
Received: by 10.216.137.10 with SMTP id x10mr1375042wei.29.1323014978609;
        Sun, 04 Dec 2011 08:09:38 -0800 (PST)
Received: from [192.168.1.15] (abwr217.neoplus.adsl.tpnet.pl. [83.8.241.217])
        by mx.google.com with ESMTPS id ep16sm22959708wbb.21.2011.12.04.08.09.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Dec 2011 08:09:34 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186271>

Hello!

Currently gitweb converts data it receives from git commands to Perl=20
internal utf8 representation via to_utf8() subroutine

 # decode sequences of octets in utf8 into Perl's internal form,
 # which is utf-8 with utf8 flag set if needed.  gitweb writes out
 # in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
 sub to_utf8 {
 	my $str =3D shift;
 	return undef unless defined $str;
 	if (utf8::valid($str)) {
 		utf8::decode($str);
 		return $str;
 	} else {
 		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
 	}
 }

Each part of data must be handled separately.  It is quite error prone
process, as can be seen from quite a number of patches that fix handlin=
g
of UTF-8 data (latest from J=C3=BCrgen).


Much, much simpler would be to force opening of all files (including=20
output pipes from git commands) in ':utf8' mode:

  use open qw(:std :utf8);

[Note: perhaps instead of ':utf8' it should be ':encoding(UTF-8)'=20
 there...]

But doing this would change gitweb behavior.  Currently when=20
encountering something (usually line of output) that is not valid=20
UTF-8, we decode it (to UTF-8) using $fallback_encoding, by default
'latin1'.  Note however that this value is per gitweb installation,
not per repository.

Using "use open qw(:std :utf8);" would be like changing the value of=20
$fallback_encoding to 'utf8' -- errors would be ignored, and characters=
=20
which are invalid in UTF-8 encoding would get replaced[1] with=20
substitution character '=EF=BF=BD' U+FFFD.

Though at least for HTML output we could use Encode::FB_HTMLCREF=20
handling (which would produce &#NNN;) or Encode::FB_XMLCREF (which
would produce &#xHHHH;), though this must be done after HTML escaping..=
=2E
and is probaby not worth it (FYI this can be done by setting=20
$PerlIO::encoding::fallback to either of those values[2])

[1] http://perldoc.perl.org/Encode.html#Handling-Malformed-Data
    http://p3rl.org/Encode
[2] http://perldoc.perl.org/PerlIO/encoding.html
    http://p3rl.org/PerlIO::encoding

I don't know if people are relying on the old behavior.  I guess
it could be emulated by defining our own 'utf-8-with-fallback'
encoding, or by defining our own PerlIO layer with PerlIO::via.
But it no longer be simple solution (though still automatic).


Alternate approach would be to audit gitweb code, and call to_utf8
before storing extracted output of git command in variable (excluding
save types like SHA-1, filemode, timestamp and timezone).  The fact
that to_utf8 is idempotent and can be called multiple times would
help here, I think.


The correct solution would be of course to respect `gui.encoding`
per-repository config variable, and `encoding` gitattribute...
though the latter is hampered by the fact that there is currently
no way to read attribute with "git check-attr" from a given tree:
think of a diff of change of encoding of a file!

--=20
Jakub Narebski
Poland
