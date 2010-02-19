From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] git svn: Fix launching of pager
Date: Fri, 19 Feb 2010 01:09:54 -0600
Message-ID: <20100219070954.GD29916@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 08:09:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMzs-0003aw-D1
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0BSHJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 02:09:51 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:46860 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412Ab0BSHJu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:09:50 -0500
Received: by yxe38 with SMTP id 38so7205080yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Km0Zmjva5vVIJDU1Dg8Lre0OcBBGyY0rGu/Tm2H6fEQ=;
        b=Jh6+Yo74ei26nqJ2MnHmQxDubaM5hkWyvJjStNDHTE3ofhz3+yT+4/V7mqLC9L0uIS
         2LadBD1Ljg4H7uc0qdjnz4VHOswmnpvseJvvLnKoVwlRO1dsmO53W6LhKJ14IyETAM/z
         kmYrJ2TpBUO2BbU47SEK/opSaH5Zc0g2UNxr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kMmla7Fqn6e9fMSbngzW+IfBLPYkHZRI4Obq/GJEpbX0PURj29iKAAsCL3YhsXd2iy
         adlv4yxYR7SRPSQrAHDcRePey1HQBCnYMjAdhSEVPe8TpPLpuGcjtVwFy+p8zPnHZ99H
         fJ5TrD/Wm92dlJog1pwuTnGJCfU4oP4gwV7dI=
Received: by 10.101.134.17 with SMTP id l17mr11128793ann.74.1266563390225;
        Thu, 18 Feb 2010 23:09:50 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm4010464yxg.60.2010.02.18.23.09.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 23:09:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100219065010.GA22258@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140421>

In commit dec543e (am -i, git-svn: use "git var GIT_PAGER"), I tried
to teach git svn to defer to git var on what pager to use.  In the
process, I introduced two bugs:

 - The value set for $pager in config_pager has local scope, so
   run_pager never sees it;

 - git var cannot tell whether git svn=E2=80=99s output is going to a
   terminal, so the value chosen for $pager does not reflect that
   information.

=46ix them.

Reported-by: Sebastian Celis <sebastian@sebastiancelis.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Eric Wong wrote:

> Thanks Jonathan, confirmed this works with patch 2 of this series.
>
> Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks.

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
