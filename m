From: Petr Baudis <pasky@suse.cz>
Subject: Re: Moving a directory into another fails
Date: Fri, 28 Jul 2006 03:43:50 +0200
Message-ID: <20060728014350.GI13776@pasky.or.cz>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com> <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de> <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Vilz <niv@iaglans.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 28 03:44:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6HOP-0004CB-LN
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 03:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWG1Bny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 21:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWG1Bnx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 21:43:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61354 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751654AbWG1Bnw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 21:43:52 -0400
Received: (qmail 25401 invoked by uid 2001); 28 Jul 2006 03:43:50 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24360>

Dear diary, on Thu, Jul 27, 2006 at 01:03:30AM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> This is a simpler sequence
> 
> cg clone git foo
> cg clone git foo1
> cd foo
> mkdir zzz
> git mv gitweb zzz
> cg diff >patch
> cg ../foo1
> cg patch <../foo/patch

Even simpler one:

	mkdir zzz
	cg-mv gitweb zzz
	cg-diff | cg-patch -R

(which would even undo the mess supposing that it worked properly)

> [jonsmirl@jonsmirl foo1]$ cg patch <../foo/patch
> mv: cannot move `gitweb/README' to `zzz/gitweb/README': No such file
> or directory

Oops. Thanks, fixed with this:

diff --git a/cg-patch b/cg-patch
index cc82f1f..923df0e 100755
--- a/cg-patch
+++ b/cg-patch
@@ -145,6 +145,8 @@ redzone_border()
 			echo "$file1: rename destination $file2 already exists, NOT RENAMING" >&2
 			return
 		fi
+		# FIXME: Remove stale empty directories related to $mvfrom
+		case $mvto in */*) mkdir -p "${mvto%/*}";; esac
 		mv "$mvfrom" "$mvto"
 	fi
 	if [ "$op" = "delete" -o "$op" = "rename" ]; then

> mv: cannot stat `"gitweb/test/M\\303\\244rchen"': No such file or directory

Junio, how am I supposed to unmangle this *censored* stuff?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
