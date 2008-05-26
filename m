From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] lockfile: reset the correct signal
Date: Mon, 26 May 2008 21:35:13 +0200
Message-ID: <20080526193513.GA9978@localhost>
References: <20080522195546.GA29911@localhost> <7vod6wr95y.fsf@gitster.siamese.dyndns.org> <20080523221723.GA4366@localhost> <20080525182650.GA17806@localhost> <alpine.DEB.1.00.0805261031480.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 21:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0iUO-0006Mo-4C
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 21:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbYEZTfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 15:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbYEZTfU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 15:35:20 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:40112 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbYEZTfT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 15:35:19 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1652334mue.1
        for <git@vger.kernel.org>; Mon, 26 May 2008 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=EQe3nQtEAwWU+EhLG5YL1WXKEMKncni9TFuxMD7oo/0=;
        b=rLYPWqu6COKjO0Md/ANNC0uNq789heP+BDM8aDurNbmLUag36PZ2XpP3Ag6UTqme/DIwJzuFnBlaaRU+an/d5WgEYPgP4t6uoxWgkm5rhNYMwi+3mpsnzbJ0mdGZflLZjClHw054vDUyRmvPuhnGhwNPEQd1RPbpwxikZ/cEknE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=cInmKCnOp+SzEzma5SP9p2uP3Dp3xShKDXJ7brAmld/LHd83iLUb5KYsrp05hmDQmA5b/liY1+2bGVN7ORKTgRfDP/3VypBtW3sxBHEodMrMIFWzJv/yEBLC6GXglVRMDxNgl3nkv1DoyMCRRX8j8uUlsN2Vs6svQD4FKoj2S0M=
Received: by 10.103.40.5 with SMTP id s5mr543427muj.133.1211830516894;
        Mon, 26 May 2008 12:35:16 -0700 (PDT)
Received: from darc.dyndns.org ( [84.154.95.54])
        by mx.google.com with ESMTPS id g1sm35518765muf.7.2008.05.26.12.35.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 May 2008 12:35:16 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1K0iTR-0008CD-LM; Mon, 26 May 2008 21:35:13 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805261031480.30431@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82949>

In the function remove_lock_file_on_signal(), the signal handler
for SIGINT was reset, ignoring the parameter signo.

This did not pose a problem yet, as remove_lock_file_on_signal()
was only registered as a SIGINT handler.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Mon, May 26, 2008 at 10:34:11AM +0100, Johannes Schindelin wrote:
> Only from the patch did I understand that you actually meant:

Thank you for fixing that.

I also realized that using signals like that can cause races. Shouldn't we
use sigaction() instead of signal()?

Clemens
---
 lockfile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 663f18f..b0118d0 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -24,7 +24,7 @@ static void remove_lock_file(void)
 static void remove_lock_file_on_signal(int signo)
 {
 	remove_lock_file();
-	signal(SIGINT, SIG_DFL);
+	signal(signo, SIG_DFL);
 	raise(signo);
 }
 
-- 
1.5.5.1
