From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] help: show manpage for aliased command on git <alias> --help
Date: Tue,  5 Mar 2013 14:44:41 +0000
Message-ID: <1362494681-11419-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 15:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCt7C-0001KY-0O
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 15:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab3CEOos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 09:44:48 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:48934 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab3CEOor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 09:44:47 -0500
Received: by mail-ee0-f43.google.com with SMTP id c50so4859164eek.16
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 06:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ExvEa2JnFBiCDRG9Fauv+P0r59tAglJi0QTCB07hjUI=;
        b=xVQdB95TRXF9vQd6MefPXFmK53eDFSsH79CAvGGHRnpj92HE0CASzygDYMSsKiEFLW
         qlZe4WHtelLWT/M0PyzlzS93CIiKczAZOk54peFm9EQ0xBbqZdliHSXBxubY7uhqwZst
         GUuuLX88J9ftmm6s6l9ohkGPdHNmo+Bvhn/EdLZNrFrxdePTNDZ7SatfPFc1rLwUzxiJ
         y+Vn4c99c9qPMg7/ZTc4+P+6mPZrp0rTXbhgBjjlZv7jSKBwQG40ZBlo1i62jVoANY7P
         dH01xMdr0PyZNcGNS3QeybQtwUgpq/Zbob/SHS3Fk0f6d1MrV2auj3IdueFOGj+WBPc1
         /3SQ==
X-Received: by 10.15.34.198 with SMTP id e46mr71077140eev.27.1362494686051;
        Tue, 05 Mar 2013 06:44:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by mx.google.com with ESMTPS id 44sm37765847eek.5.2013.03.05.06.44.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 05 Mar 2013 06:44:45 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217449>

Change the semantics of "git <alias> --help" to show the help for the
command <alias> is aliased to, instead of just saying:

    `git <alias>' is aliased to `<whatever>'

E.g. if you have "checkout" aliased to "co" you won't get:

    $ git co --help
    `git co' is aliased to `checkout'

But will instead get the manpage for git-checkout. The behavior this
is replacing was originally added by Jeff King in 2156435. I'm
changing it because of this off-the-cuff comment on IRC:

    14:27:43 <@Tux> git can be very unhelpful, literally:
    14:27:46 <@Tux> $ git co --help
    14:27:46 <@Tux> `git co' is aliased to `checkout'
    14:28:08 <@Tux> I know!, gimme the help for checkout, please

And because I also think it makes more sense than showing you what the
thing is aliased to.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/help.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index d1d7181..fdb3312 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -417,6 +417,7 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
 {
 	int nongit;
 	const char *alias;
+	const char *show_help_for;
 	enum help_format parsed_help_format;
 	load_command_list("git-", &main_cmds, &other_cmds);
=20
@@ -449,20 +450,21 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
=20
 	alias =3D alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
-		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
-		return 0;
+		show_help_for =3D alias;
+	} else {
+		show_help_for =3D argv[0];
 	}
=20
 	switch (help_format) {
 	case HELP_FORMAT_NONE:
 	case HELP_FORMAT_MAN:
-		show_man_page(argv[0]);
+		show_man_page(show_help_for);
 		break;
 	case HELP_FORMAT_INFO:
-		show_info_page(argv[0]);
+		show_info_page(show_help_for);
 		break;
 	case HELP_FORMAT_WEB:
-		show_html_page(argv[0]);
+		show_html_page(show_help_for);
 		break;
 	}
=20
--=20
1.7.10.4
