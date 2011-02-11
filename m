From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] git-svn.perl should check GIT_ASKPASS environment
Date: Fri, 11 Feb 2011 10:25:45 +0100
Message-ID: <AANLkTinkv0dNxNxehud0Byuu9tpqxp1kBMJ1OyEcfVQ_@mail.gmail.com>
References: <1c47e93c-5b7c-4aed-8a78-807d3aff2700@n36g2000pre.googlegroups.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jose Roberto Garcia Chico <jose@toro-asia.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 10:26:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnpGb-0004DY-R0
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 10:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab1BKJ0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 04:26:09 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab1BKJ0H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 04:26:07 -0500
Received: by fxm20 with SMTP id 20so2463348fxm.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 01:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=s9TCGekXfRp1ymfRnw4xGgRqcfGcZuOrnACiLRKeNuY=;
        b=YvlE2PBoaS9vA2dXdjXccNRRvRmO6J5IIn/1EFUX+vh5SvvyHAYvPtS2odossj2BGF
         iAkEadmIAe3KrlBHXPmxuH6wm/3qhzJgb9KaBdeX2liEbLh4C1kNPDNprVCh4kbMHLMV
         ohUPf63v3jb9rIHkJz8biWdaLMmopnaFTUCNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=wzCrcJOjtGVc/hLbyVJx7Z0gmHbU4XGDoqW/laiZSE0JBXK2SYwXCCQy3wWpIaFcRr
         LrXDi9d1+2/116ln3+h9ChdANpwlKk/lKeCs0btiRcghWesUsiUxy/QfXQY7hruvHPBT
         aEvAZBVbdBvdPVnGu9tHJZP1Fu1uyvA9D/2dU=
Received: by 10.223.79.7 with SMTP id n7mr272303fak.71.1297416365190; Fri, 11
 Feb 2011 01:26:05 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Fri, 11 Feb 2011 01:25:45 -0800 (PST)
In-Reply-To: <1c47e93c-5b7c-4aed-8a78-807d3aff2700@n36g2000pre.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166546>

On Fri, Feb 11, 2011 at 9:17 AM, Jose Roberto Garcia Chico
<jose@toro-asia.com> wrote:
> git-svn.perl problem.
>
> prompt:
> =A0 =A0 =A0 =A0print STDERR $may_save ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0"(R)eject, accept (t)emporarily or accept =
(p)ermanently? " :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0"(R)eject or accept (t)emporarily? ";
> =A0 =A0 =A0 =A0STDERR->flush;
> =A0 =A0 =A0 =A0$choice =3D lc(substr(<STDIN> || 'R', 0, 1));
>
> should check GIT_ASKPASS environment.
>
> For further information
>
> http://code.google.com/p/tortoisegit/issues/detail?id=3D706
>

As was already said in the thread you're linking to, this isn't a
Windows-specific git-issue. CC'ing the main Git mailing list, where
this discussion belongs.

But I don't think it should check GIT_ASKPASS, GIT_ASKPASS isn't a
general-purpose dialog-box hook, it's a hook for getting *passwords*.
To allow git-svn to query the user of a non-terminal user, another
mechanism would probably be created. But in any case, I we should do
something other than just waiting if we're not connected to a TTY. I
don't really know Perl that well, but perhaps something like this does
the trick?

diff --git a/git-svn.perl b/git-svn.perl
index 177dd25..24f3486 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3964,6 +3964,9 @@ sub ssl_server_trust {
 	                               issuer_dname fingerprint);
 	my $choice;
 prompt:
+	if (!-t STDERR || !-t STDIN) {
+		return -1;
+	}
 	print STDERR $may_save ?
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
