From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 12:58:57 +0200
Message-ID: <480F1671.2060602@viscovery.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net> <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> <20080423080826.GA11935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 12:59:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JochY-0005o4-HR
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 12:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbYDWK7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 06:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbYDWK7A
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 06:59:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19843 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYDWK7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 06:59:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jocgj-00056r-MZ; Wed, 23 Apr 2008 12:58:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 632136D9; Wed, 23 Apr 2008 12:58:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080423080826.GA11935@sigill.intra.peff.net>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80209>

Jeff King schrieb:
> It was easy enough to work up the patch below, which allows
> 
>   git filter-branch --blob-filter 'tr a-z A-Z'
...
> +munge_blobs() {
> +	while read mode sha1 stage path
> +	do
> +		if ! test -r "$workdir/../blob-cache/$sha1"
> +		then
> +			new=`git cat-file blob $sha1 |
> +			     eval "$filter_blob" |
> +			     git hash-object -w --stdin`
> +			printf $new >$workdir/../blob-cache/$sha1
> +		fi
> +		printf "%s %s\t%s\n" \
> +			"$mode" \
> +			$(cat "$workdir/../blob-cache/$sha1") \
> +			"$path"
> +	done
> +}

In practice, this is not sufficient. The blob filter must have an
opportunity to decide what it wants to do, not just blindly munge every
blob. The minimum is a path name, e.g. in $1:

	new=$(git cat-file blob $sha1 |
		$SHELL_PATH -c "$filter_blob" ignored "$path" |
		git hash-object -w --stdin)

-- Hannes
