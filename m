From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH v2] patch-ids: cache patch IDs in a notes tree
Date: Sun, 12 May 2013 12:57:43 +0100
Message-ID: <20130512115743.GJ2299@serenity.lan>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
 <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
 <20130511214900.GF2299@serenity.lan>
 <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
 <alpine.DEB.1.00.1305111846160.8213@s15462909.onlinehome-server.info>
 <20130512090850.GH2299@serenity.lan>
 <20130512114131.GI2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 12 13:57:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUua-0003C1-U8
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab3ELL5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:57:52 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49107 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3ELL5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:57:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A7208CDA5CD;
	Sun, 12 May 2013 12:57:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OWXDfctlTWt2; Sun, 12 May 2013 12:57:51 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9A50BCDA57C;
	Sun, 12 May 2013 12:57:45 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130512114131.GI2299@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224043>

On Sun, May 12, 2013 at 12:41:31PM +0100, John Keeping wrote:
> diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
> index 28d4f6b..378cf3e 100755
> --- a/t/t6007-rev-list-cherry-pick-file.sh
> +++ b/t/t6007-rev-list-cherry-pick-file.sh
> @@ -207,4 +207,20 @@ test_expect_success '--count --left-right' '
>  	test_cmp expect actual
>  '
>  
> +cat >expect <<EOF
> +3	2	0
> +EOF
> +
> +test_expect_success 'rev-list --cherry-mark caches patch ids' '
> +	test_config patchid.cacheref patchids &&
> +	git rev-list --cherry-mark --left-right --count F...E >actual &&
> +	test_cmp expect actual &&
> +	git notes --ref patchids show master >cached_master &&

I forgot to update this test, it needs a "| sed -e 1q" in the middle of
this line to make sure that we're only checking the patch ID and not the
diffopts hash and Git version.

> +	git log -p -1 master | git patch-id | sed -e "s/ .*//" >patch-id_master &&
> +	test_cmp patch-id_master cached_master &&
> +	# Get the patch IDs again, now they should be cached
> +	git rev-list --cherry-mark --left-right --count F...E >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
