From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: combined diff, but not condensed, howto?
Date: Thu, 18 Sep 2008 09:30:59 +0200
Message-ID: <48D203B3.90807@viscovery.net>
References: <48D0B907.7040903@viscovery.net> <7vwsha6761.fsf@gitster.siamese.dyndns.org> <48D1EDB7.5070107@viscovery.net> <7vy71qyo9d.fsf@gitster.siamese.dyndns.org> <48D1F426.4040208@viscovery.net> <7vskryym24.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 09:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDzq-0008W9-Jz
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 09:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbYIRHbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 03:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbYIRHbF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 03:31:05 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12741 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbYIRHbE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 03:31:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KgDye-00057S-8E; Thu, 18 Sep 2008 09:31:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 04BFD4FB; Thu, 18 Sep 2008 09:30:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vskryym24.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96178>

Junio C Hamano schrieb:
> It is very much Ok and useful for "git diff" to default to "--cc -p", and
> it may be fine for "git diff-files -p" to default to "--cc".
> 
> But I think ideally an explicit "git diff -c" and "git diff-files -c -p"
> should not turn the "dense combined" mode on.
> 
> The commonality of these two functions is striking and calls for proper
> refactoring, but aside from that, I think a patch like this should be
> applied.  What do you think?

This makes a lot of sense. As I mention in my initial post, I was
wondering why 'diff -c' was the same as 'diff --cc'.

> diff --git i/builtin-diff-files.c w/builtin-diff-files.c
> index 9bf10bb..2b578c7 100644
> --- i/builtin-diff-files.c
> +++ w/builtin-diff-files.c
> @@ -50,7 +50,12 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  	    3 < rev.max_count)
>  		usage(diff_files_usage);
>  
> -	if (rev.max_count == -1 &&
> +	/*
> +	 * "diff-files --base -p" should not combine merges because it
> +	 * was not asked to.  "diff-files -c -p" should not densify
> +	 * (the user should ask with "diff-files --cc" explicitly).
> +	 */
> +	if (rev.max_count == -1 && !rev.combine_merges &&
>  	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
>  		rev.combine_merges = rev.dense_combined_merges = 1;

Hm... In my tests, a bare 'git diff-files --cc' produces a combined diff,
but 'git diff-files -c' does not.

> diff --git i/builtin-diff.c w/builtin-diff.c
> index 037c303..9fb30c6 100644
> --- i/builtin-diff.c
> +++ w/builtin-diff.c
> @@ -223,7 +223,12 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
>  		argv++; argc--;
>  	}
>  
> -	if (revs->max_count == -1 &&
> +	/*
> +	 * "diff --base" should not combine merges because it was not
> +	 * asked to.  "diff -c" should not densify (the user should ask
> +	 * with "diff --cc" explicitly.

I don't see why you add "the user should ask with 'diff --cc'" when this
becomes the default anyway.

> +	 */
> +	if (revs->max_count == -1 && !revs->combine_merges &&
>  	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
>  		revs->combine_merges = revs->dense_combined_merges = 1;

-- Hannes
