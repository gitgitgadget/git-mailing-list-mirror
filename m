From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-prune submodule aware (and fix a SEGFAULT in the process)
Date: Fri, 17 Aug 2007 16:48:52 -0700
Message-ID: <7vtzqxen8b.fsf@gitster.siamese.dyndns.org>
References: <200707021356.58553.andyparkins@gmail.com>
	<200708170939.47214.andyparkins@gmail.com>
	<alpine.LFD.0.999.0708170956140.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 01:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMBZ2-0003mo-9j
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 01:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbXHQXtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754317AbXHQXtE
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 19:49:04 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbXHQXtD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 19:49:03 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CEF912350F;
	Fri, 17 Aug 2007 19:49:20 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708170956140.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 17 Aug 2007 09:56:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56099>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 17 Aug 2007, Andy Parkins wrote:
>>
>> Could any of the guru's give me a guide to upload-pack.c?  I assume the 
>> problem is going to be the same as it was for git-prune, the hash for the 
>> gitlink object in the tree is being assumed to be an object in the ODB; 
>> which isn't the case with gitlink entries.  Where would that be happening 
>> in git-upload-pack?  The fix is going to be..
>> 
>>  if( S_ISGITLINK(mode))
>>       continue;
>> 
>> But I've got no idea where to put it :-)
>
> Maybe this one?
>
> ---
>  builtin-pack-objects.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 24926db..77481df 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -979,6 +979,8 @@ static void add_pbase_object(struct tree_desc *tree,
>  	int cmp;
>  
>  	while (tree_entry(tree,&entry)) {
> +		if (S_ISGITLINK(entry.mode))
> +			continue;
>  		cmp = tree_entry_len(entry.path, entry.sha1) != cmplen ? 1 :
>  		      memcmp(name, entry.path, cmplen);
>  		if (cmp > 0)


This sounds very plausible.

Andy, in the repository your fetch fails, if a fetch-pack
without "--thin" before Linus's patch does not barf, that
strongly suggests that the breakage you are seeing is related to
this codepath.  And with Linus's patch, "fetch-pack --thin"
would also be fixed.
