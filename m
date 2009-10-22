From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 1/2] filter-branch: stop special-casing $filter_subdir
 argument
Date: Thu, 22 Oct 2009 10:31:56 +0200
Message-ID: <4AE0187C.4040608@viscovery.net>
References: <95535b01e2181d321190c6d93b2834188612a389.1256148512.git.trast@student.ethz.ch> <95535b01e2181d321190c6d93b2834188612a389.1256149428.git.trast@student.ethz.ch> <4ADFF66F.1080005@viscovery.net> <200910221005.11813.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 22 10:32:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0t5b-0007qJ-68
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbZJVIb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 04:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbZJVIb5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:31:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41314 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZJVIb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 04:31:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N0t5Q-0003yZ-VB; Thu, 22 Oct 2009 10:31:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BB369A4A1; Thu, 22 Oct 2009 10:31:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <200910221005.11813.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131007>

Thomas Rast schrieb:
> Well, I just observed while writing the patch that you cannot say
> 
>   git filter-branch --subdirectory-filter subdir -- --all -- subdir/file

Please include this in the commit message.

> Johannes Sixt wrote:
>> Thomas Rast schrieb:
>>> @@ -257,15 +257,29 @@ git read-tree || die "Could not seed the index"
>>>  # map old->new commit ids for rewriting parents
>>>  mkdir ../map || die "Could not create map/ directory"
>>>  
>>> +non_ref_args=$(git rev-parse --no-revs --sq "$@")
>>> +dashdash=--
>>> +for arg in "$non_ref_args"; do
>> At this point $non_ref_args might contain one or more IFS-separatable
>> words, but if you say "$non_ref_args" here, this loop will be entered
>> exactly once. But even if you drop the dquotes, the --sq quoting that you
>> requested from rev-parse bought you nothing.
> 
> Hrm.  Ok, so the ".." were clearly in mistake, but why could I remove
> the --sq?  Doesn't the shell expand the arguments provided by
> $non_ref_args if I use it without quotes nor --sq, so that it might
> accidentally expand paths or such?

When the shell expands $variable (outside quotes), it does not apply
quotes anymore, but only word-splits using $IFS. In your code, the words
would contain literal single-quotes, and paths with spaces would still be
split into words.

Wouldn't it be sufficient to just check whether any non-rev arguments are
present, and to suppress '--' if there are, like:

dashdash=
test -z "$(git rev-parse --no-revs "$@")" && dashdash=--

OK, this still leaves you with the problem that you want to separate
non-rev arguments from rev arguments. Right?

For this I suggest that you extract revs into a regular variable (because
the SHA1s can be word-split in a predictable way), and that you leave the
non-rev arguments in $@:

revs=$(git rev-parse --revs "$@")	# don't know if this works
eval set -- "$(git rev-parse --no-revs --sq "$@")"	# dquotes?

or so... This way you 'eval' should not be needed in later code.

-- Hannes
