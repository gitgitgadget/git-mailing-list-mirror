From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] send-email: do not check for editor until needed
Date: Mon, 22 Mar 2010 18:25:31 -0500
Message-ID: <20100322232531.GA2168@progeny.tock>
References: <20100322145947.GA1709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Mar 23 00:25:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntr0E-00073B-EN
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 00:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab0CVXZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 19:25:39 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:21182 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab0CVXZi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 19:25:38 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1360115qwh.37
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mezPNVXUnuhUL4g2DgLCGWHYNawmoraMMWzdNeP2nEg=;
        b=gPFHMRITjpzCz1MzBokD63ufOtgLXzzhP2vrVPtAbdbVtkzaOOHRRpqDEda+/kX4bQ
         GD8U+2NzhpL54/re4qkAQXw3uBQn4MIoQ30bVaB1E1DaxaaAhj1lt/w2o9dgJ8sBU435
         EbIKpE9abPHepz7+BR3veh6rO5M5u30/hCMfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Mt2rqGPTKvZ2JkPGPKiUMQGkyfi7+94ck1sm2Cq6Ye8LnnK5x7Xr6LjVPoBu1uGMXP
         A+NA5WogyRsF2v8YABafDifmNSa2c5szLl39pOKzrDyavLF55pCbeKhPKx747rhsFeQr
         7b8bf4Cw2FK8THQxYAlsfLZte9ThtU+IIIpL0=
Received: by 10.229.97.147 with SMTP id l19mr644762qcn.24.1269300337307;
        Mon, 22 Mar 2010 16:25:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1759051qyk.11.2010.03.22.16.25.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 16:25:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100322145947.GA1709@pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142976>

Since b4479f074 (add -i, send-email, svn, p4, etc: use "git var
GIT_EDITOR", 2009-10-30), when called with TERM=3Ddumb and without
GIT_EDITOR set, git send-email has been failing whether it needs
an editor or not:

 $ ssh localhost git send-email --to=3Dme --suppress-cc=3Dall HEAD^..HE=
AD
 fatal: Terminal is dumb, but EDITOR unset
 var GIT_EDITOR: command returned error: 128

This breaks use of git send-email in existing hook scripts.

So do not check for an editor unless it is needed.

Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Uwe Kleine-K=F6nig wrote:

> since b4479f074760a788dd4e353b8c86a7d735afc53e git send-email (and
> others) use git var GIT_EDITOR.  This is OK as such but it breaks the
> post-receive hooks that I use on several repositories.
[...]
> IMHO git send-email should only call $(git var GIT_EDITOR) when it
> actually needs it.

Thanks for reporting.  Does this patch work for you?

Now if I try without a tty, I get a different error:

 $ ssh localhost cd $(pwd) '&&' \
	git send-email --to=3Dme --suppress-cc=3Dall HEAD^..HEAD
 Can't locate object method "IN" via package "FakeTerm" at
 /home/jrn/tmp-git/libexec/git-core/git-send-email line 645.
 /tmp/olTiwjzrjx/0001-Git-1.7.0.3.patch

I assume I am not using it correctly, since the relevant code has
been around for a while.

 git-send-email.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e05455f..9406cdd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -162,9 +162,16 @@ my $compose_filename;
=20
 # Handle interactive edition of files.
 my $multiedit;
-my $editor =3D Git::command_oneline('var', 'GIT_EDITOR');
=20
 sub do_edit {
+	my $editor;
+
+	if ($#_ =3D=3D 0) {
+		return;
+	}
+	git_cmd_try {
+		$editor =3D Git::command_oneline('var', 'GIT_EDITOR');
+	} "no suitable text editor configured\n";
 	if (defined($multiedit) && !$multiedit) {
 		map {
 			system('sh', '-c', $editor.' "$@"', $editor, $_);
--=20
1.7.0.2
