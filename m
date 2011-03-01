From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 1/3] t6022: New test checking for unnecessary updates
 of renamed+modified files
Date: Tue, 01 Mar 2011 08:33:16 +0100
Message-ID: <4D6CA13C.1000006@viscovery.net>
References: <1298941732-19763-1-git-send-email-newren@gmail.com> <1298941732-19763-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 08:33:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuK5e-0004UD-Rc
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 08:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab1CAHdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 02:33:37 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16195 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751100Ab1CAHdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 02:33:36 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PuK57-0003pc-5O; Tue, 01 Mar 2011 08:33:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D83F51660F;
	Tue,  1 Mar 2011 08:33:16 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1298941732-19763-2-git-send-email-newren@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168185>

Am 3/1/2011 2:08, schrieb Elijah Newren:
> +test_expect_failure 'avoid unnecessary update, normal rename' '
> +	git checkout -q avoid-unnecessary-update-1^0 &&
> +	touch -t 197001010000.01 rename &&

Use
	test-chmtime =1000000000 rename &&

> +	orig=$(stat --format="%Y" rename) &&

	orig=$(test-chmtime -v +0 rename) &&

> +	git merge merge-branch-1 &&
> +	new=$(stat --format="%Y" rename) &&

	new=$(test-chmtime -v +0 rename) &&

> +	echo "Checking whether stat times are same: $orig vs $new" &&

	echo "Checking whether stat times are same: ${orig%%	*} vs ${new%%	*}" &&

(that's TAB after the %%)

> +	test "$orig" == "$new" &&

	test "${orig%%	*}" = "${new%%	*}" &&

== is not portable. Actually, since the file name is the same in both
$orig and $new, you wouldn't need the %% magic in this statement.

> +	git diff-files --exit-code # Is "rename" clean, or only racily clean?

What you see here, is not "racily clean", but "stat dirty". "Racily clean"
means that git thinks that the file is clean (because the stat information
matches), but in fact the file content is not identical to the content
recorded in the index.

> +'
> +
>  test_done

-- Hannes
