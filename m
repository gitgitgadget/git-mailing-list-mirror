From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Wed, 1 Dec 2010 12:50:46 -0600
Message-ID: <20101201185046.GB27024@burratino>
References: <20101201171814.GC6439@ikki.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 19:51:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrlf-0007KT-5q
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab0LASu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 13:50:57 -0500
Received: from mail-ww0-f66.google.com ([74.125.82.66]:57812 "EHLO
	mail-ww0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab0LASu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:50:56 -0500
Received: by wwe15 with SMTP id 15so178642wwe.1
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YowPnZJXRMNn7VYu9H6wXWDUdp6dt3v8bsM1CchgD8o=;
        b=Ip5tmwQOkMGgVnHR5MU1cisRXdLfEKl9bYvJb0IozhH1du/WAMDKkYdGwHF+qolGFo
         1AaFXeBLMvi8ZAM4alFuOx1TjeWhNe5bl4ta/GY0FTwMVtm0jYD5uzgcVsTgOBJZzoSN
         q7YuMh5qsCwGYWnyDKN1AEe4p+Y019hHokhOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jQB8BU6PmCaAcBbAFmYM4C750cOqDo+DX1OwgR7fTwEvIVH795lx0nKzQ+wImOn0TZ
         Pla+IB+/nvaYbCqwzcadxRrGep7WCpdLys1EQxxgsUx9DWTviOMpYhe3kIohQKhR3ZZ2
         8ahTPElb5dF0tODj2kdoKjP1kA5/ddCk4lKTI=
Received: by 10.227.153.199 with SMTP id l7mr9814930wbw.133.1291229455144;
        Wed, 01 Dec 2010 10:50:55 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id 11sm199239wbj.13.2010.12.01.10.50.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 10:50:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201171814.GC6439@ikki.ethgen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162571>

	git submodule add -b $branch $repository

fails when HEAD already points to $branch in $repository.

Reported-by: Klaus Ethgen <Klaus@Ethgen.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Klaus,

Klaus Ethgen wrote at <http://bugs.debian.org/605600>:

> Strange problem, if I create a submodule of an other repository givin=
g
> the currently used HEAD branch I get the error: =C2=BBfatal: git chec=
kout:
> branch myimbabranch already exists=C2=AB while when giving other bran=
ch
> work well.

Interesting.  The problem is in cmd_add of git-submodule.sh; this
patch demonstrates a quick fix.  Jens, any idea why git submodule
is not using "clone --branch" directly?

diff --git a/git-submodule.sh b/git-submodule.sh
index 33bc41f..6242d7f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,7 +241,7 @@ cmd_add()
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
 			'') git checkout -f -q ;;
-			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
+			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
 			esac
 		) || die "Unable to checkout submodule '$path'"
 	fi
