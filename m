From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] After chdir to run grep, return to old directory
Date: Wed, 07 May 2014 10:42:12 -0700
Message-ID: <xmqqlhudbi4r.fsf@gitster.dls.corp.google.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	<1399072451-15561-2-git-send-email-dturner@twopensource.com>
	<xmqqtx92czqv.fsf@gitster.dls.corp.google.com>
	<1399421211.11843.53.camel@stross>
	<20140507030037.GB20726@sigill.intra.peff.net>
	<1399433631.11843.57.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 07 19:42:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi5rK-00032O-Jd
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 19:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbaEGRmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 13:42:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55203 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbaEGRmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 13:42:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E28FD148C6;
	Wed,  7 May 2014 13:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DJdnNDZ4Qm248DRg3D2qKW/xa68=; b=tio+uQ
	+Xzaawq6PasZVWuN63nINrp58cekYOXwlvwVIeAZQbjdzRkbrmZ2H6hOxOQBW9HP
	vyuDU/ZMisXdtDcnmrx4RtflGxCJMmUluFT46iOhoUQHUam2swy1/2LVXKeD+HzU
	mF/MEjQJiCbAOJuvqXVaQYITlhS4IVzjOslzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RlIB3cdiLmLQkJn/PaG8x3prgP6YKIfu
	uO87rbHtkIuAknkZlA+po+SfLbuJm1Yi4K3ARfTQbTgvpA/nb83evzD7XiaNDIXG
	dTqPvC1hqaSWLth/Dz9J5iJdJqfaSaGa3K/D53geuU4wuGIJ53vi+bsHJrVHMjyn
	v77UrvmhrLY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D68A5148C5;
	Wed,  7 May 2014 13:42:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 73421148C4;
	Wed,  7 May 2014 13:42:14 -0400 (EDT)
In-Reply-To: <1399433631.11843.57.camel@stross> (David Turner's message of
	"Tue, 06 May 2014 20:33:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ECF88048-D60E-11E3-8410-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248335>

David Turner <dturner@twopensource.com> writes:

> This causes my test to pass and generally seems correct to me.

Yes, this approach is very sensible, and I'll queue.

But watchman support _should_ be prepared for a program that does
not do this.  Developing your support in on a codebase with this
patch may be sweeping a bug in your code under the rug.

Thanks both for working on your respective changes ;-).

>
> On Tue, 2014-05-06 at 23:00 -0400, Jeff King wrote:
> ...
>> That being said, this really seems like something that the run-command
>> interface should be doing, since it can handle the chdir in the forked
>> child. And indeed, it seems to support that.
>> 
>> Maybe:
>> 
>> -- >8 --
>> Subject: grep: use run-command's "dir" option for --open-files-in-pager
>> 
>> Git generally changes directory to the repository root on
>> startup.  When running "grep --open-files-in-pager" from a
>> subdirectory, we chdir back to the original directory before
>> running the pager, so that we can feed the relative
>> pathnames to the pager.
>> 
>> We currently do this chdir manually, but we can ask
>> run_command to do it for us. This is fewer lines of code,
>> and as a bonus, the chdir is limited to the child process,
>> which avoids any unexpected surprises for code running after
>> the pager (there isn't any currently, but this is
>> future-proofing).
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>  builtin/grep.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 69ac2d8..43af5b7 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -361,9 +361,7 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
>>  		argv[i] = path_list->items[i].string;
>>  	argv[path_list->nr] = NULL;
>>  
>> -	if (prefix && chdir(prefix))
>> -		die(_("Failed to chdir: %s"), prefix);
>> -	status = run_command_v_opt(argv, RUN_USING_SHELL);
>> +	status = run_command_v_opt_cd_env(argv, RUN_USING_SHELL, prefix, NULL);
>>  	if (status)
>>  		exit(status);
>>  	free(argv);
