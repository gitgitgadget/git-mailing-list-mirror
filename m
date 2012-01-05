From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Fix file links in "grep" search
Date: Thu, 5 Jan 2012 21:26:48 +0100
Message-ID: <201201052126.49087.jnareb@gmail.com>
References: <CA+uOhx6i-07kW8K0y3Co++2ABD=Lmaq3r4h1hN4YLskAE+hR1Q@mail.gmail.com> <7vhb0cqpix.fsf@alter.siamese.dyndns.org> <CANQwDwfnp167Uth5TLbCD6OR-Xe6JD-2vENiJVnipi1YdjnMPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Perl <th.perl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 21:26:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RittW-0004re-FZ
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 21:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727Ab2AEU0d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 15:26:33 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60432 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179Ab2AEU0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 15:26:32 -0500
Received: by eekc4 with SMTP id c4so631426eek.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=L8GVaSBJVbhWh/Lu61DsP8HnBcLIaEJIisyahqb7/GI=;
        b=V6oXN1gHCymULTRNejKmI9Kwt/jPn4phNkN7rqWLtQEam9k5/EXTafgdqTHBPNZBXx
         +TDeRsZrQJnUB/wZNainZukjxtfdshAENmfuLG9HZiShM0ebUyyfJHb8uSkhozlFr5/u
         NS/IiG1SaUO7nW1FX2eYnqDdiTiWhO/V6XHpQ=
Received: by 10.213.25.139 with SMTP id z11mr676792ebb.80.1325795191229;
        Thu, 05 Jan 2012 12:26:31 -0800 (PST)
Received: from [192.168.1.13] (abvt109.neoplus.adsl.tpnet.pl. [83.8.217.109])
        by mx.google.com with ESMTPS id t1sm238064289eeb.3.2012.01.05.12.26.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jan 2012 12:26:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CANQwDwfnp167Uth5TLbCD6OR-Xe6JD-2vENiJVnipi1YdjnMPQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187992>

There were two bugs in generating file links (links to "blob" view),
one hidden by the other.  The correct way of generating file link is

	href(action=3D>"blob", hash_base=3D>$co{'id'},
	     file_name=3D>$file);

It was $co{'hash'} (this key does not exist, and therefore this is
undef), and 'hash' instead of 'hash_base'.

To have this fix applied in single place, this commit also reduces
code duplication by saving file link (which is used for line links) in
$file_href.

Reported-by: Thomas Perl <th.perl@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Wed, 4 Jan 2012, Jakub Nar=EAbski wrote:
> On Wed, Jan 4, 2012 at 1:28 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Thomas Perl <th.perl@gmail.com> writes:
>>
>>> I think I found a bug in gitweb when grep'ing for text in a branch
>>> different from "master". Here's how to reproduce it:
>>
>> Thanks for a detailed report (and thanks for gpodder ;-).
>>
>> Jakub, care to take a look?
>=20
> I see the bug: it should be 'hash_base' not 'hash' in href()
> creating link to "blob" view in git_search_files().
>=20
> I'll try to send a fix soon...

Actually there were two errors, one hiding the other...


Thomas, could you check if this fixes your issue?

 gitweb/gitweb.perl |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fc41b07..fa58156 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5852,7 +5852,7 @@ sub git_search_files {
 	my $lastfile =3D '';
 	while (my $line =3D <$fd>) {
 		chomp $line;
-		my ($file, $lno, $ltext, $binary);
+		my ($file, $file_href, $lno, $ltext, $binary);
 		last if ($matches++ > 1000);
 		if ($line =3D~ /^Binary file (.+) matches$/) {
 			$file =3D $1;
@@ -5867,10 +5867,10 @@ sub git_search_files {
 			} else {
 				print "<tr class=3D\"light\">\n";
 			}
+			$file_href =3D href(action=3D>"blob", hash_base=3D>$co{'id'},
+			                  file_name=3D>$file);
 			print "<td class=3D\"list\">".
-				$cgi->a({-href =3D> href(action=3D>"blob", hash=3D>$co{'hash'},
-						       file_name=3D>"$file"),
-					-class =3D> "list"}, esc_path($file));
+				$cgi->a({-href =3D> $file_href, -class =3D> "list"}, esc_path($fil=
e));
 			print "</td><td>\n";
 			$lastfile =3D $file;
 		}
@@ -5888,10 +5888,9 @@ sub git_search_files {
 				$ltext =3D esc_html($ltext, -nbsp=3D>1);
 			}
 			print "<div class=3D\"pre\">" .
-				$cgi->a({-href =3D> href(action=3D>"blob", hash=3D>$co{'hash'},
-						       file_name=3D>"$file").'#l'.$lno,
-					-class =3D> "linenr"}, sprintf('%4i', $lno))
-				. ' ' .  $ltext . "</div>\n";
+				$cgi->a({-href =3D> $file_href.'#l'.$lno,
+				        -class =3D> "linenr"}, sprintf('%4i', $lno)) .
+				' ' .  $ltext . "</div>\n";
 		}
 	}
 	if ($lastfile) {
--=20
1.7.6
