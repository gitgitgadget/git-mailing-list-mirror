From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 6/7] tests: Add tests for automatic use of pager
Date: Mon, 22 Feb 2010 09:19:45 +0100
Message-ID: <4B823E21.1060707@viscovery.net>
References: <20100219065010.GA22258@progeny.tock> <20100219071857.GF29916@progeny.tock> <7v8wanq0c3.fsf@alter.siamese.dyndns.org> <20100221020317.GA7651@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 10:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjTWO-00081K-V7
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 09:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab0BVITw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 03:19:52 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57801 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752733Ab0BVITu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 03:19:50 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NjTW5-0005mf-RP; Mon, 22 Feb 2010 09:19:46 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8F2801660F;
	Mon, 22 Feb 2010 09:19:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100221020317.GA7651@progeny.tock>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140647>

Don't the following pager settings suffer from a race condition?

> +	cat > $less <<-EOF &&
> +	#!$SHELL_PATH
> +	: > default_pager_used
> +	EOF

> +	PAGER=": > PAGER_used" &&

> +	PAGER=: &&

> +	git config core.pager ": > core.pager_used" &&

> +	git config core.pager : &&
> +	GIT_PAGER=": > GIT_PAGER_used" &&

They depend on that the subsequent 'git log' writes to the pipe (and does
not fill it) before the pager can run. If the pager runs first and
completes, and then 'git log' writes to the pipe, it will die from
SIGPIPE, won't it?

I suggest to rewrite all ':' to something that processes stdin, eg. 'wc'
(not 'cat', because this is a magic token).

-- Hannes
