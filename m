From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 22/48] merge-recursive: Fix sorting order and directory
 change assumptions
Date: Mon, 11 Jul 2011 09:04:37 +0200
Message-ID: <4E1AA085.9010908@viscovery.net>
References: <1307518278-23814-1-git-send-email-newren@gmail.com> <1307518278-23814-23-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 09:04:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgAXv-0005fo-DS
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 09:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208Ab1GKHEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 03:04:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27471 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757083Ab1GKHEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 03:04:41 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QgAXl-0007Dl-9y; Mon, 11 Jul 2011 09:04:37 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F0E201660F;
	Mon, 11 Jul 2011 09:04:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1307518278-23814-23-git-send-email-newren@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176834>

Am 6/8/2011 9:30, schrieb Elijah Newren:
>  test_expect_success 'modify/delete + directory/file conflict; other way' '
> +	# Yes, we really need the double reset since "letters" appears as
> +	# both a file and a directory.
> +	git reset --hard &&
>  	git reset --hard &&
>  	git clean -f &&
>  	git checkout modify^0 &&
> +
>  	test_must_fail git merge delete &&
>  
> -	test 3 = $(git ls-files -s | wc -l) &&
> -	test 2 = $(git ls-files -u | wc -l) &&
> -	test 1 = $(git ls-files -o | wc -l) &&
> +	test 5 -eq $(git ls-files -s | wc -l) &&
> +	test 4 -eq $(git ls-files -u | wc -l) &&
> +	test 1 -eq $(git ls-files -o | wc -l) &&
>  
>  	test -f letters/file &&
> +	test -f letters.txt &&
>  	test -f letters~HEAD
>  '

A heads-up: This test case fails here on Windows. The messages produced are:

Merging:
63e2d2b modified
virtual delete
found 1 common ancestor(s):
e6b31cd initial
CONFLICT (modify/delete): letters deleted in delete and modified in HEAD.
Version HEAD of letters left in tree at letters~HEAD.
Adding letters/file
error: failed to create path 'letters/file': perhaps a D/F conflict?
Auto-merging letters.txt
CONFLICT (add/add): Merge conflict in letters.txt
Automatic merge failed; fix conflicts and then commit the result.

whereas they are on Linux:

Merging:
274ce87 modified
virtual delete
found 1 common ancestor(s):
343abf7 initial
Removing letters to make room for subdirectory; may re-add later.
Adding letters/file
CONFLICT (modify/delete): letters deleted in delete and modified in HEAD.
Version HEAD of letters left in tree at letters~HEAD.
Auto-merging letters.txt
CONFLICT (add/add): Merge conflict in letters.txt
Automatic merge failed; fix conflicts and then commit the result.

As you can see, "Removing letters..." is missing on Windows, and the file
'letters' is indeed left in the working tree. Any quick ideas where to
begin debugging this?

-- Hannes
