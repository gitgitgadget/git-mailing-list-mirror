From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC v3 2/4] submodule: Teach 'update' to preserve local branches
Date: Wed,  8 Jan 2014 22:17:53 -0800
Message-ID: <34c874fbdb0c472e1fadc068baaf7ed00b7b696d.1389247320.git.wking@tremily.us>
References: <20140108040627.GD29954@odin.tremily.us>
 <cover.1389247320.git.wking@tremily.us>
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 07:19:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W18xJ-00061U-OK
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 07:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbaAIGSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 01:18:51 -0500
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:33732
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbaAIGSU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 01:18:20 -0500
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id BiHV1n0030EZKEL58iJJUR; Thu, 09 Jan 2014 06:18:18 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id BiJH1n002152l3L3MiJHr4; Thu, 09 Jan 2014 06:18:18 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id E67A3EB688C; Wed,  8 Jan 2014 22:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389248294; bh=MjOs0wSttPYs471wJvJKMAmS0t69v57lKfTvonTV0wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References;
	b=BD6tVLFXstYJ/iAOsvNZJ/DezKoLvywZZhd9mnqXhTMqFboU6F/h2//J+eJOSh0m+
	 /UGk2ugSRhPJ8KMfPaCjq8D5yIW9qnYg6/sLZe6Jg5MI3btIweXjHUIuU3wW72lXGQ
	 ME6x5vscMFn7Q7PRM9xMYjvhcKAy9goRG9ssJXUk=
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
References: <cover.1389247320.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389248298;
	bh=fX/mbssBvm15JISHXW2FBToEemg6nQYJWCLqd7kQ564=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=L3eFM+4Et9PW8oSUx6uucHMt5zWhW+cB/RxmZQFp/KUvOFxOlQnHZP5CFFyvtVOdP
	 +dO+qDckA0uhTzGfCyMUZLXxL5CtDswOVS0/8QNlJfBr6Q8kJ8GVmhdsa3+yNJBWpX
	 rxM99lLztTPZpdP2rTk4DFRYlWZt2eN8zu7qHvWaoGssGwbIoJVyEQElM8x7TlO42V
	 mb7UcwJYAchrIWbMLkh7scJPaumIhMsmEc1epI5s1s4K9E4hp3rwQTbM2EYo7GeGYv
	 LFjPtxXh8rmKR/XiAAG+6POdNx7eKXXpZYO1J8pobzVwTQ4vEQkuUEXQBnB74xZej5
	 dk+eNbpSARpTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240250>

From: "W. Trevor King" <wking@tremily.us>

There's no sense in setting up a local branch if we're just going to
go back to a detached HEAD with every checkout-mode update.  This
commit replaces the checkout with a reset, updating whatever the
locally checked out branch (or detached HEAD) happens to be.  While it
is tempting to checkout a new local-branch here (as we did after the
clone), it's more consistent to follow the lead of the other update
modes and just use the currently checked out branch.
---
 git-submodule.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 56fc3f1..c5ea7bd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -930,9 +930,9 @@ Maybe you want to use 'update --init'?")"
 				must_die_on_failure=yes
 				;;
 			*)
-				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
+				command="git reset --hard -q"
+				die_msg="$(eval_gettext "Unable to reset branch to '\$sha1' in submodule path '\$displaypath'")"
+				say_msg="$(eval_gettext "Submodule path '\$displaypath': reset branch to '\$sha1'")"
 				;;
 			esac
 
-- 
1.8.5.2.237.g01c62c6
