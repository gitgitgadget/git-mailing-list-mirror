From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: gitweb - encoding problems
Date: Mon, 21 May 2007 22:57:21 +0200
Message-ID: <20070521205721.GA21771@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 22:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqExE-0007h3-En
	for gcvg-git@gmane.org; Mon, 21 May 2007 22:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbXEUU51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 16:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbXEUU50
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 16:57:26 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35287 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbXEUU5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 16:57:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3E4137037F6F;
	Mon, 21 May 2007 22:57:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v9ldFSgVRPOA; Mon, 21 May 2007 22:57:21 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id C8E307037F63; Mon, 21 May 2007 22:57:21 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48049>

I use ISO-8859-1 as my locale, so my blobs, commits and tags are in
this encoding.

On perl v5.8.6, decode_utf8 of any non utf-8 value returns undefined:

$cat xy
#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard :escapeHTML -nosticky);
use CGI::Util qw(unescape);
use CGI::Carp qw(fatalsToBrowser);
use Encode;
use Fcntl ':mode';
use File::Find qw();
use File::Basename qw(basename);

binmode STDOUT, ':utf8';

print decode_utf8('=C3=A4=C3=B6=C3=BC');
$perl xy
[Mon May 21 22:00:00 2007] xy: Use of uninitialized value in print at x=
y line 14.

If gitweb encounters, eg. an "Umlaut" (=C3=A4=C3=B6=C3=BC) in a commit/=
tag, use of
uninitialized value message are generated. In one case,
decode_utf8($long) in format_subject_html is undefined, which results
in a invalid link (a tag contains only title without any value
assignment) and a browser message, that the html is not valid.

The previous installed version of git/gitweb (1.5.0rc3) showed only
small black rhombuses, but didn't generate "uninitialized value"
messages or invalid html.

So there is regression between git-1.5.0 and git-1.5.2.

Adding $var =3D encode_utf8($var) if (!defined decode_utf8($var)) for
each "uninitialized value" message results in a correct result for me.

I wanted to post a patch with these changes, as it solved my locale pro=
blem.
But then I tried the same a different computer with a newer perl (v5.8.=
8).
$ cat x
#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard :escapeHTML -nosticky);
use CGI::Util qw(unescape);
use CGI::Carp qw(fatalsToBrowser);
use Encode;
use Fcntl ':mode';
use File::Find qw();
use File::Basename qw(basename);

binmode STDOUT, ':utf8';

print decode_utf8('=C3=A4=C3=B6=C3=BC');
$ perl x
=C3=AF=C2=BF=C5=93=C3=AF=C2=BF=C5=93=C3=AF=C2=BF

Here perl decodes the ISO-8859-1 text to something differnent:
00000000  ef bf bd ef bf bd ef bf  bd                       |=C3=AF=C2=BF=
=C5=93=C3=AF=C2=BF=C5=93=C3=AF=C2=BF

The result is, that all "Umlaute" are shown as a small black rhombus
in gitweb (and no invalid html).

mfg Martin K=C3=B6gler

cat x |hexdump -C
00000000  23 21 2f 75 73 72 2f 62  69 6e 2f 70 65 72 6c 0a  |#!/usr/bin=
/perl.|
00000010  75 73 65 20 73 74 72 69  63 74 3b 0a 75 73 65 20  |use strict=
;.use |
00000020  77 61 72 6e 69 6e 67 73  3b 0a 75 73 65 20 43 47  |warnings;.=
use CG|
00000030  49 20 71 77 28 3a 73 74  61 6e 64 61 72 64 20 3a  |I qw(:stan=
dard :|
00000040  65 73 63 61 70 65 48 54  4d 4c 20 2d 6e 6f 73 74  |escapeHTML=
 -nost|
00000050  69 63 6b 79 29 3b 0a 75  73 65 20 43 47 49 3a 3a  |icky);.use=
 CGI::|
00000060  55 74 69 6c 20 71 77 28  75 6e 65 73 63 61 70 65  |Util qw(un=
escape|
00000070  29 3b 0a 75 73 65 20 43  47 49 3a 3a 43 61 72 70  |);.use CGI=
::Carp|
00000080  20 71 77 28 66 61 74 61  6c 73 54 6f 42 72 6f 77  | qw(fatals=
ToBrow|
00000090  73 65 72 29 3b 0a 75 73  65 20 45 6e 63 6f 64 65  |ser);.use =
Encode|
000000a0  3b 0a 75 73 65 20 46 63  6e 74 6c 20 27 3a 6d 6f  |;.use Fcnt=
l ':mo|
000000b0  64 65 27 3b 0a 75 73 65  20 46 69 6c 65 3a 3a 46  |de';.use F=
ile::F|
000000c0  69 6e 64 20 71 77 28 29  3b 0a 75 73 65 20 46 69  |ind qw();.=
use Fi|
000000d0  6c 65 3a 3a 42 61 73 65  6e 61 6d 65 20 71 77 28  |le::Basena=
me qw(|
000000e0  62 61 73 65 6e 61 6d 65  29 3b 0a 0a 62 69 6e 6d  |basename);=
=2E.binm|
000000f0  6f 64 65 20 53 54 44 4f  55 54 2c 20 27 3a 75 74  |ode STDOUT=
, ':ut|
00000100  66 38 27 3b 0a 0a 70 72  69 6e 74 20 64 65 63 6f  |f8';..prin=
t deco|
00000110  64 65 5f 75 74 66 38 28  27 e4 f6 fc 27 29 3b 0a  |de_utf8('=C3=
=A4=C3=B6=C3=BC');.|
00000120
