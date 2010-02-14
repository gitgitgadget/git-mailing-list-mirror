From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/6] git svn: Fix launching of pager
Date: Sun, 14 Feb 2010 06:06:10 -0600
Message-ID: <20100214120610.GD3499@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgdFH-0003lH-Hg
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 13:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758469Ab0BNMGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 07:06:16 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:64909 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758461Ab0BNMGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 07:06:13 -0500
Received: by iwn39 with SMTP id 39so1364034iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 04:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dZBVhAi+mNQWvLmt4iplmneVpdodsjchtJ/C1w54xgs=;
        b=Cp/Swtzai8KR+VVYFLwprZqpr08V2iteSfG2/F2GaB07ERHDdc+vjd1WYgX2oy7IhF
         x+Uxnf/vm+w+8oWFMkTXVLcVwkSlDzNPvF04sR+I8p2bBu/Ycv/p4cBbMUq6nWPnlxN1
         2w5k3aFu0QI8l2jknLvwJd4CpgW0ITkg4BDRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XPQIu9CrybhBqOfGVcCzFONIgi26mb7wI0Kp3XxqY0OC5/CDj8gMzlgxg86XdjB87N
         4dcJWl9wIgT7sCY4gT3QCKh86DCKjLjBFWPyrvGAU980lC6o6vAJLbb4CtnOF9lw1Bqh
         LWbvFtQ6ShGUIBfkkf4pQubsujLLBcAHCOuRc=
Received: by 10.231.146.130 with SMTP id h2mr3013108ibv.43.1266149172871;
        Sun, 14 Feb 2010 04:06:12 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5113284iwn.8.2010.02.14.04.06.12
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 04:06:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214115430.GA1849@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139904>

In commit dec543e (am -i, git-svn: use "git var GIT_PAGER"), I tried
to teach git svn to defer to git var on what pager to use. In the
process, I introduced two bugs:

 - The value set for $pager in config_pager has local scope, so
   run_pager never sees it;

 - git var cannot tell whether git svn=E2=80=99s output is going to a
   terminal, so the value chosen for $pager does not reflect that
   information.

=46ix them.

Reported-by: Sebastian Celis <sebastian@sebastiancelis.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Oops.  Eric, this bug is masked by another bug in "git var" whose fix
is patch 2 from this series I sent to the list, but whatever happens,
I think this is an improvement.  Sorry for the breakage.

 git-svn.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..473a0b9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5459,7 +5459,12 @@ sub git_svn_log_cmd {
=20
 # adapted from pager.c
 sub config_pager {
-	chomp(my $pager =3D command_oneline(qw(var GIT_PAGER)));
+	if (! -t *STDOUT) {
+		$ENV{GIT_PAGER_IN_USE} =3D 'false';
+		$pager =3D undef;
+		return;
+	}
+	chomp($pager =3D command_oneline(qw(var GIT_PAGER)));
 	if ($pager eq 'cat') {
 		$pager =3D undef;
 	}
@@ -5467,7 +5472,7 @@ sub config_pager {
 }
=20
 sub run_pager {
-	return unless -t *STDOUT && defined $pager;
+	return unless defined $pager;
 	pipe my ($rfd, $wfd) or return;
 	defined(my $pid =3D fork) or ::fatal "Can't fork: $!";
 	if (!$pid) {
--=20
1.7.0
