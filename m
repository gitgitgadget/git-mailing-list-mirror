From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] Write new giturl(7) manpage
Date: Mon, 29 Mar 2010 20:29:26 +0530
Message-ID: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 16:59:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwGRX-0001hb-H1
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 16:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab0C2O7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 10:59:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51478 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab0C2O7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 10:59:48 -0400
Received: by gyg13 with SMTP id 13so1484104gyg.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=OSQEAp2/E4isZ6UnRHmzhrdxuI3EeV79Ake0PoAEYgk=;
        b=iBPdIANxjhGzTQeMAk7YgYwDipFhSd7eRtPXtf10Wd0Yt5LiPL9dOtp7TFw5Xw/6hc
         m83osH1IHiUo20WEQQIVFliFOI/1P/kI9NqfNIJYQ60arflTa+6g3yK3oP8TT/WueEmE
         GRf3fU1Uj2J7XRC0IIwyWkbG2EJdfFNlCb3cI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=JGFqLG0T6gaafJHRUuPd6gSNbQmc/6fLYU4j4xDIxwrqnCuyuZA4HJuAV3FXFDu6j+
         MuaNsAWn89pRcH8KEBtSa+zAwqwmgeJT3n0PNL9JgklRJFRWKRAm93Sy+XL3WqNn00C4
         cBqlAdMsBuRwb0U7XuVWiZzzn2d/gGQ8MdCTI=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 07:59:26 -0700 (PDT)
Received: by 10.90.60.36 with SMTP id i36mr1939854aga.106.1269874786187; Mon, 
	29 Mar 2010 07:59:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143479>

Write a new manpage for documenting how different URLs are handled by
remote helpers.
---
 It severely lacks polish, but I thought I'd send in an early draft req=
uesting
 comments. Also, I've made it more cryptic than Jonathan's revision and
 included more references.

 I'm not entirely happy with it because the remote vcs setting doesn't
 quite fit here. Plus, it seems like a dirty hack to me. The name doesn=
't do
 justice: giturl exists to host Ilari's remote helper notes. How can it=
 be
 expanded to be more general?

 Why doesn't urls.txt document <transport>::<address> syntax? Should I
 fix this?

 Documentation/giturl.txt |   85 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/giturl.txt

diff --git a/Documentation/giturl.txt b/Documentation/giturl.txt
new file mode 100644
index 0000000..9ffd17c
--- /dev/null
+++ b/Documentation/giturl.txt
@@ -0,0 +1,85 @@
+giturl(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+giturl - An overview on how different URLs are handled by Git
+
+SYNOPSIS
+--------
+git *
+
+DESCRIPTION
+-----------
+
+URLs are used in two places. Directly on the command line by the end
+user, and in remotes configuration (see REMOTES section below). They
+all have the general structure described in the URLS section
+below. While most of them are handled by Git internally, some of them
+are handled by remote helper programs. When a URL thatgit doesn't
+handle internally is encountered either on the command line or in the
+remotes configuration, a remote helper that does will be used
+transparently by the transport machinery of git (i.e., by commands
+such as git ls-remote, git send-pack, and git archive --remote). The
+following is a list of such URLs:
+
+<transport>::<address>
+~~~~~~~~~~~~~~~~~~~~~~
+A URL of the form `<transport>::<rest-of-URL>` is used on the command
+line by the end-user.
+
+The 'git remote-<transport>' helper will be invoked with the full
+<transport>::<rest-of-URL> URL as the first argument and <address> as
+the second argument.
+
+<name> with vcs set
+~~~~~~~~~~~~~~~~~~~
+`remote.<name>.vcs` is set to `<transport>` (see
+git-config[1]). `remote.<name>.url` is optionally set to a URL of the
+form `<transport>://<rest-of-URL>`.
+
+If the `remote.<name>.url` is set, the helper will be invoked with
+`<name>` as the first argument and `<rest-of-URL>` as the second
+argument.  Otherwise, the helper will be invoked with a single
+argument, `<name>`.
+
+<nickname> with vcs unset
+~~~~~~~~~~~~~~~~~~~~~~~~~
+`remote.<name>.url` is set to a URL of the form
+`<transport>://<rest-of-URL>`.
+
+The =91git remote-<transport>=92 helper will be invoked with the
+`<name>` as first argument and `<transport>://<rest-of-URL>` as the
+second argument.
+
+Exception: the built-in 'rsync', 'file', 'git', 'ssh', 'git+ssh', and
+'ssh+git' transports are not handled using remote helpers.
+
+<transport>://<rest-of-URL>
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+A URL of the form `<transport>://<rest-of-URL>` is used on the command
+line by the end-user.
+
+If 'transport' is not one of the built-in protocols listed above, the
+'git remote-<transport>' helper will be invoked with two arguments,
+both equal to the full `<transport>://<rest-of-URL>` URL.
+
+include::urls-remotes.txt[]
+
+SEE ALSO
+--------
+linkgit:git-remote-helpers[1]
+linkgit:git-remote[1]
+linkgit:git-config[1]
+
+Author
+------
+Written by Ramkumar Ramachandra
+
+Documentation
+-------------
+Documentation by Ilari Liusvaara and the git-list <git@vger.kernel.org=
>
+
+GIT
+---
+Part of the linkgit:git[1] suite
--=20
1.7.0.3
