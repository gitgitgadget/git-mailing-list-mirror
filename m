From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v4 1/2] filter-branch: stop special-casing $filter_subdir
 argument
Date: Wed, 11 Nov 2009 09:30:28 +0100
Message-ID: <4AFA7624.5040400@viscovery.net>
References: <4AE945D0.5030403@viscovery.net> <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N88bU-0002sa-FS
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020AbZKKIab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 03:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756496AbZKKIa2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:30:28 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40617 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbZKKIaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 03:30:25 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N88ay-00007A-Kx; Wed, 11 Nov 2009 09:30:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 69D076D9; Wed, 11 Nov 2009 09:30:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132619>

Thomas Rast schrieb:
> Johannes Sixt wrote:
>> # we need "--" only if there are no path arguments in $@
>> nonrevs=$(git rev-parse --no-revs "$@") || exit
>> dashdash=${nonrevs+"--"}
>>
>> (including the comment; you can drop the dquotes in the dashdash
>> assignment if you think the result is still readable.)
> 
> Ok.  I was briefly scared that this was bash-specific syntax, but dash
> seems happy so I'll trust your advice.

You shouldn't. I'm wrong ;-)

In the snippet above, dashdash will always be set to "--" because a mere
'+' in the variable expansion only tests whether the variable ('nonrevs')
is unset, but it is always set. Even ${nonrevs:+"--"} is wrong, and your
earlier 'test -z' invocation was the correct way to set dashdash.

But...

I did some testing, and now I have to wonder about the use-case that you
present in the commit message:

> Furthermore, the case for --subdirectory-filter supplies its own --,
> so the user cannot provide one himself, so the following was
> impossible:
>
>   git filter-branch --subdirectory-filter subdir -- --all -- subdir/file

If you try in git.git itself:

  $ git rev-list --simplify-merges --all -- \
	Documentation/git-commit.txt | wc -l
  84
  $ git rev-list --simplify-merges --all -- \
	Documentation/git-commit.txt Documentation | wc -l
  4624

I thought that the intention to give an extra path argument is to reduce
the number of commits that remain in the rewritten history. But by giving
--subdirectory-filter, the path filter actually loosened, and many more
commits are rewritten.

Since your intention to write this patch is actually to implement
--remap-to-ancestor, I suggest that we defer the question whether the
above use-case makes sense, and only rewrite this particular paragraph in
the commit message to point out the real bug:

-----
Furthermore, --subdirectory-filter supplies its own '--', and if the user
provided one himself, such as in

  git filter-branch --subdirectory-filter subdir -- --all -- subdir/file

an extra '--' was used as path filter in the call to git-rev-list that
determines the commits that shall be rewritten.
-----

I'll submit a replacement patch.

-- Hannes
