From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Tue, 28 Jan 2014 13:28:51 +0100
Message-ID: <20140128122851.GA1102@camk.edu.pl>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
 <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
 <20140127175953.GA18041@camk.edu.pl>
 <20140127185829.GE27577@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 13:29:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W87mz-0000zt-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 13:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbaA1M3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 07:29:08 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:57192 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662AbaA1M3H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 07:29:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id AEBF05F0001;
	Tue, 28 Jan 2014 13:29:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id i9HAlvEt-gE7; Tue, 28 Jan 2014 13:29:19 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 33A775F0005;
	Tue, 28 Jan 2014 13:29:16 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id B4F824812C; Tue, 28 Jan 2014 13:28:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140127185829.GE27577@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241185>

On Mon, Jan 27, 2014 at 10:58:29AM -0800, Jonathan Nieder wrote:
> Hi,

> Kacper Kornet wrote:

> > The change in release numbering also breaks down gitolite v2 setups. One
> > of the gitolite commands, gl-compile-conf, expects the output of git --version 
> > to match /git version (\d+)\.(\d+)\.(\d+)/. 

> > I have no idea how big problem it is, as I don't know how many people
> > hasn't migrate to gitolite v3 yet. 

> http://qa.debian.org/popcon.php?package=gitolite says there are some.
> I guess soon we'll see if there are complaints.

> http://gitolite.com/gitolite/migr.html says gitolite v2 is still
> maintained.  Hopefully the patch to gitolite v2 to fix this would not
> be too invasive --- e.g., how about this patch (untested)?

> Thanks,
> Jonathan

> diff --git i/src/gl-compile-conf w/src/gl-compile-conf
> index f497ae5..8508313 100755
> --- i/src/gl-compile-conf
> +++ w/src/gl-compile-conf
> @@ -394,8 +394,9 @@ die "
>      the server.  If it is not, please edit ~/.gitolite.rc on the server and
>      set the \$GIT_PATH variable to the correct value\n
>  " unless $git_version;
> -my ($gv_maj, $gv_min, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)\.(\d+)/);
> +my ($gv_maj, $gv_min, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)\.([^.-]*)/);
>  die "$ABRT I can't understand $git_version\n" unless ($gv_maj >= 1);
> +$gv_patchrel = 0 unless ($gv_patchrel =~ m/^\d+$/);
>  $git_version = $gv_maj*10000 + $gv_min*100 + $gv_patchrel;  # now it's "normalised"

>  die "\n\t\t***** AAARGH! *****\n" .

It works for 1.9.rc1 but I think it will fail with final 1.9. The
following version should be ok:

diff --git a/src/gl-compile-conf b/src/gl-compile-conf
index f497ae5..c391468 100755
--- a/src/gl-compile-conf
+++ b/src/gl-compile-conf
@@ -394,7 +394,7 @@ die "
     the server.  If it is not, please edit ~/.gitolite.rc on the server and
     set the \$GIT_PATH variable to the correct value\n
 " unless $git_version;
-my ($gv_maj, $gv_min, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)\.(\d+)/);
+my ($gv_maj, $gv_min, undef, $gv_patchrel) = ($git_version =~ m/git version (\d+)\.(\d+)(\.(\d+))?/);
 die "$ABRT I can't understand $git_version\n" unless ($gv_maj >= 1);
 $git_version = $gv_maj*10000 + $gv_min*100 + $gv_patchrel;  # now it's "normalised"
 
-- 
  Kacper
