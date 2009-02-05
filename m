From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Question about --tree-filter
Date: Thu, 05 Feb 2009 09:32:29 +0100
Message-ID: <498AA41D.3000609@viscovery.net>
References: <loom.20090204T155824-858@post.gmane.org> <4989C437.4070401@viscovery.net> <4989FDC6.2080404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzgN-0000EM-2E
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbZBEIcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbZBEIcc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:32:32 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13405 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbZBEIcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:32:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LUzev-0001a2-Vr; Thu, 05 Feb 2009 09:32:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BA44569F; Thu,  5 Feb 2009 09:32:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4989FDC6.2080404@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108536>

[ Don't cull Cc list, please! ]

Sergio Callegari schrieb:
> And if I experiment filter-branch again, with exactly the same
> parameters, apparently some of the files that did not get the new blob
> in the beginning do...  which looks completely weird.

I think I know what's going on. filter-branch has this code where the
tree-filter is applied:

	git checkout-index -f -u -a ||
		die "Could not checkout the index"

This command may take a while to complete, and at the end it writes the
index file. At this point:

(=) Some files may have the same timestamp as the index file.

(<) Others have an earlier timestamp.

Later we have this code:

	(
		git diff-index -r --name-only $commit
		git ls-files --others
	) |
	git update-index --add --replace --remove --stdin

The files (=) are racily-clean, and are added to the database; they pass
through the clean filter (rezip). The files (<) are regarded as unchanged,
and are not added again, and are not rezipped.

>    find ./ -type f -exec touch \{\} \;

This could help, too, because now all files are regarded as either
racily-clean (same timestamp as index file) or as changed (newer timestamp).

-- Hannes
