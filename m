From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Harden "grep" search against filenames with ':'
Date: Thu, 5 Jan 2012 21:32:56 +0100
Message-ID: <201201052132.56581.jnareb@gmail.com>
References: <CA+uOhx6i-07kW8K0y3Co++2ABD=Lmaq3r4h1hN4YLskAE+hR1Q@mail.gmail.com> <CANQwDwfnp167Uth5TLbCD6OR-Xe6JD-2vENiJVnipi1YdjnMPQ@mail.gmail.com> <201201052126.49087.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Thomas Perl <th.perl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 21:32:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ritzb-0008Ct-8T
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 21:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656Ab2AEUck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 15:32:40 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37382 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758290Ab2AEUcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 15:32:39 -0500
Received: by eekc4 with SMTP id c4so635004eek.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 12:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=2JI8Dbf+6rewGwt7/UuAWHfl50s4dEZKmVLiF164WWA=;
        b=GSfbp1Vbpw3vUOUmWMDA0R1vHYMrOzUH9V3upWZyHPQEimT47QGQkhGtms5ZMMsKLB
         PJS/tFBR9/Q+0PU7QqrBmyCzONSFQ0WcqXTAMNYAboAMOyT3yDVJvQk8P2vjNgrZfUT3
         M6X/qUFNZ50MnrxqHdzoI1z+QBFafkL2lgiIU=
Received: by 10.14.149.13 with SMTP id w13mr1296668eej.61.1325795558374;
        Thu, 05 Jan 2012 12:32:38 -0800 (PST)
Received: from [192.168.1.13] (abvt109.neoplus.adsl.tpnet.pl. [83.8.217.109])
        by mx.google.com with ESMTPS id s16sm238140379eef.2.2012.01.05.12.32.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jan 2012 12:32:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201201052126.49087.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187993>

Run "git grep" in "grep" search with '-z' option, to be able to parse
response also for files with filename containing ':' character.  The
':' character is otherwise (without '-z') used to separate filename
from line number and from matched line.

Note that this does not protect files with filename containing
embedded newline.  This would be hard but doable for text files, and
harder or even currently impossible with binary files: git does not
quote filename in

  "Binary file <foo> matches"

message, but new `--break` and/or `--header` options to git-grep could
help here.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is what I did after fixing previous issue, after looking at current
code.  Hopefully nobody sane uses filenames with embedded newlines...

  http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html

 gitweb/gitweb.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fa58156..f884dfe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5836,7 +5836,7 @@ sub git_search_files {
 	my %co = @_;
 
 	local $/ = "\n";
-	open my $fd, "-|", git_cmd(), 'grep', '-n',
+	open my $fd, "-|", git_cmd(), 'grep', '-n', '-z',
 		$search_use_regexp ? ('-E', '-i') : '-F',
 		$searchtext, $co{'tree'}
 			or die_error(500, "Open git-grep failed");
@@ -5858,7 +5858,8 @@ sub git_search_files {
 			$file = $1;
 			$binary = 1;
 		} else {
-			(undef, $file, $lno, $ltext) = split(/:/, $line, 4);
+			($file, $lno, $ltext) = split(/\0/, $line, 3);
+			$file =~ s/^$co{'tree'}://;
 		}
 		if ($file ne $lastfile) {
 			$lastfile and print "</td></tr>\n";
-- 
1.7.6
