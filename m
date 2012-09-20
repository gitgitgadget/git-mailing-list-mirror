From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: fix shell expansion of items
Date: Thu, 20 Sep 2012 20:11:52 +0200
Message-ID: <20120920181152.GA4689@goldbirke>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
 <20120920014608.GA27782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:14:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TElGP-0006RP-04
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 20:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab2ITSOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 14:14:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:61660 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab2ITSOD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 14:14:03 -0400
Received: from localhost6.localdomain6 (p5B130601.dip0.t-ipconnect.de [91.19.6.1])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MSp3l-1T6kSC29YL-00Rk0L; Thu, 20 Sep 2012 20:11:53 +0200
Content-Disposition: inline
In-Reply-To: <20120920014608.GA27782@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:XEMvIj9N1H+snuNzFLiQ/MNCFAeqtV20RFUB15kO0C/
 m/PoOplXOx4XswVZHOKhD1/P9dgcH8gcLG35qCtyN7ycydix0m
 eDM20ZRbKRnsvLJ7Z3zeewNIgXO+V41p6Gk3Px6XMGbs+IzSUY
 GWVHIrC1FwEy7faI8pE1YP8nQMrtTKwteU8dE3/3RDVaN4unMY
 7WsGQhFWQuBcZCu3l2fr18qxA2mwbZIFVaNMqDDHyP51ye9rL9
 iifF70A4EJiwmlgP/CuZl1IYtwsqdXQxCtdIw0vZzzNMqY0drX
 s9C1UstuCrYmz1aBHmKDjVswotdMTEjxuQAqcwSbpWXGNYyxr4
 AgvDKjmYoB7GpgdzYIaI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206067>

Hi,

On Wed, Sep 19, 2012 at 09:46:08PM -0400, Jeff King wrote:
> On Thu, Sep 20, 2012 at 04:15:15AM +0200, Felipe Contreras wrote:
> 
> > As reported by Jeroen Meijer[1]; the current code doesn't deal properly
> > with items (tags, branches, etc.) that have ${} in them because they get
> > expaned by bash while using compgen.
> > 
> > A simple solution is to quote the items so they get expanded properly
> > (\$\{\}).
> > 
> > In order to achieve that I took bash-completion's quote() function,
> > which is rather simple, and renamed it to __git_quote() as per Jeff
> > King's suggestion.
> > 
> > Solves the original problem for me.
> 
> Me too. Thanks.

While it solves the original problem, it seems to break refs
completion, as demonstrated by the following POC test:


diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 92d7eb47..fab63b95 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -228,4 +228,11 @@ test_expect_success 'general options plus command' '
 	test_completion "git --no-replace-objects check" "checkout "
 '
 
+test_expect_success 'basic refs completion' '
+	touch file &&
+	git add file &&
+	git commit -m initial &&
+	test_completion "git branch m" "master "
+'
+
 test_done
-- 
1.7.12.1.438.g7dfa67b


which fails with:

--- expected    2012-09-20 18:05:23.857752925 +0000
+++ out 2012-09-20 18:05:23.877752925 +0000
@@ -1 +1 @@
-master 
+
