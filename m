From: John Keeping <john@keeping.me.uk>
Subject: Re: Odd rebase behavior
Date: Wed, 16 Dec 2015 22:17:16 +0000
Message-ID: <20151216221716.GD1581@serenity.lan>
References: <877fkf9j5h.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
	gitster@pobox.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 23:17:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KOI-0001FT-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbbLPWRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:17:42 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:55747 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbbLPWRm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:17:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 468EDCDA570;
	Wed, 16 Dec 2015 22:17:41 +0000 (GMT)
X-Quarantine-ID: <Hsip9i2AXj1n>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hsip9i2AXj1n; Wed, 16 Dec 2015 22:17:37 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 84F90866002;
	Wed, 16 Dec 2015 22:17:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <877fkf9j5h.fsf@waller.obbligato.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282615>

On Tue, Dec 15, 2015 at 09:17:30PM -0600, David A. Greene wrote:
> According to the rebase man page, rebase gathers commits as in "git log
> <upstream>..HEAD."  However, that is not what happens in the tests
> below.  Some of the commits disappear.
> 
> The test basically does this:
> 
> - Setup a master project and a subproject, merged via a subtree-like
>   merge (this is how git-subtree does it).
> 
> - Add some commits to the subproject directory after the subtree merge,
>   to create some history not in the original subproject.
> 
> - filter-branch --subdirectory-filter to extract commits from the
>   subproject directory.
> 
> - Rebase those commits back on to the original subproject repository.
> 
> The above loses all commits made after the subproject is merged into
> the main project.
[snip]
> # Does not preserve master4 and master5.
> test_expect_success 'Rebase default' '
> 	git checkout -b rebase-default master &&
> 	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> 	git commit -m "Empty commit" --allow-empty &&
> 	git rebase -Xsubtree=files_subtree  --preserve-merges --onto files-master master &&

It seems that the problem is introduces by --preserve-merges (and
-Xsubtree causes something interesting to happen as well).  I see the
following behaviour:

git rebase --onto files-master master

	Works (master4 and master5 preserved).

git rebase --preserve-merges --onto files-master master

	Behaves as described above (master4 and master5 are lost).

git rebase -Xsubtree=files_subtree --onto files-master master

	fatal: Could not parse object 'b15c4133fc3146e1330c84159886f0f7a09fbf43^'
	Unknown exit code (128) from command: git-merge-recursive b15c4133fc3146e1330c84159886f0f7a09fbf43^ -- HEAD b15c4133fc3146e1330c84159886f0f7a09fbf43 

git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master

	Same as the version with only --preserve-merges.
