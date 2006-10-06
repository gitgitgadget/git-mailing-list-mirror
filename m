From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Fri, 6 Oct 2006 12:31:05 +0200
Message-ID: <200610061231.06017.jnareb@gmail.com>
References: <20060919212725.GA13132@pasky.or.cz> <ef43do$fm1$1@sea.gmane.org> <7vac4qs43g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 12:31:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVmyX-0006xB-6F
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 12:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWJFKa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 6 Oct 2006 06:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWJFKa3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 06:30:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:23421 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751420AbWJFKa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 06:30:28 -0400
Received: by ug-out-1314.google.com with SMTP id 36so290704ugg
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 03:30:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tkNijyVZ2w/72zlhnWG/G2WxsV0Iuho/NInQt+FQSNBLKP/gv5+i9oWut3S7qBzHrFILZ/AiWpoRp92tiNm02YBnTjV7kKzFbzZ1jtNvhcYC8Z9ui6QrpudL0HbCLTY6jKuI4uwkBimIlUxaQ8v23X0vnhlEpbIlKmwiG92LYb0=
Received: by 10.66.252.4 with SMTP id z4mr3033599ugh;
        Fri, 06 Oct 2006 03:30:26 -0700 (PDT)
Received: from host-81-190-18-48.torun.mm.pl ( [81.190.18.48])
        by mx.google.com with ESMTP id a1sm2023357ugf.2006.10.06.03.30.25;
        Fri, 06 Oct 2006 03:30:26 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vac4qs43g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28397>

Rename $githelp_url and $githelp_label to $logo_url and $logo_label to
be more obvious what they refer to; while at it add commented out
previous contents (git documentation at kernel.org). Add comment about
logo size.

Use $cgi->a(...) to generate Git logo link; it automatically escapes
attribute values when it is needed.  Escape href attribute using
esc_url instead of (incorrect!) esc_html.

Move styling of git logo <img> element from "style" attribute to CSS
via setting class to "logo".  Perhaps we should set it by id rather
than by class.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:

>>> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"<a href=3D\"" . esc_html($githel=
p_url) .
>>> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"\" title=3D\"" . esc_html($githe=
lp_label) .
>>> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0"\">" .
>>
>> Why not use $cgi->a_begin({-href=3D>esc_param($githelp_url),
>> -title=3D>$githelp_label}); or just plain $cgi->a and $cgi->img?
>
> Be my guest and send in a proper patch please.
>
> I was merely demonstrating my preference on how definition of
> default values and actual use of them are separated.

And here it is. By the way, esc_html was incorrect, I think.

 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |   17 +++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 668e69a..3f62b6d 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -16,6 +16,11 @@ a:hover, a:visited, a:active {
 	color: #880000;
 }
=20
+img.logo {
+	float: right;
+	border-width: 0px;
+}
+
 div.page_header {
 	height: 25px;
 	padding: 8px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3320069..a966f9f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -46,13 +46,16 @@ our $home_text =3D "++GITWEB_HOMETEXT++";
=20
 # URI of default stylesheet
 our $stylesheet =3D "++GITWEB_CSS++";
-# URI of GIT logo
+# URI of GIT logo (72x27 size)
 our $logo =3D "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
 our $favicon =3D "++GITWEB_FAVICON++";
=20
-our $githelp_url =3D "http://git.or.cz/";
-our $githelp_label =3D "git homepage";
+# URI and label (title) of GIT logo link
+#our $logo_url =3D "http://www.kernel.org/pub/software/scm/git/docs/";
+#our $logo_label =3D "git documentation";
+our $logo_url =3D "http://git.or.cz/";
+our $logo_label =3D "git homepage";
=20
 # source of projects list
 our $projects_list =3D "++GITWEB_LIST++";
@@ -1376,11 +1379,9 @@ EOF
 	print "</head>\n" .
 	      "<body>\n" .
 	      "<div class=3D\"page_header\">\n" .
-	      "<a href=3D\"" . esc_html($githelp_url) .
-	      "\" title=3D\"" . esc_html($githelp_label) .
-	      "\">" .
-	      "<img src=3D\"$logo\" width=3D\"72\" height=3D\"27\" alt=3D\"gi=
t\" style=3D\"float:right; border-width:0px;\"/>" .
-	      "</a>\n";
+	      $cgi->a({-href =3D> esc_url($logo_url),
+	               -title =3D> $logo_label},
+	              qq(<img src=3D"$logo" width=3D"72" height=3D"27" alt=3D=
"git" class=3D"logo"/>));
 	print $cgi->a({-href =3D> esc_url($home_link)}, $home_link_str) . " /=
 ";
 	if (defined $project) {
 		print $cgi->a({-href =3D> href(action=3D>"summary")}, esc_html($proj=
ect));
--=20
1.4.2.1
