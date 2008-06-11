From: Andreas Ericsson <ae@op5.se>
Subject: Re: Consolidate SHA1 object file close
Date: Wed, 11 Jun 2008 09:42:54 +0200
Message-ID: <484F81FE.7070801@op5.se>
References: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 09:43:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Kzq-00073V-4h
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 09:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbYFKHm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 03:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbYFKHm7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 03:42:59 -0400
Received: from mail.op5.se ([193.201.96.20]:42879 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881AbYFKHm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 03:42:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2D1C61B800AE;
	Wed, 11 Jun 2008 09:39:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGLiShoBb7QK; Wed, 11 Jun 2008 09:39:19 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 6513B1B80089;
	Wed, 11 Jun 2008 09:39:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84596>

Linus Torvalds wrote:
> This consolidates the common operations for closing the new temporary file 
> that we have written, before we move it into place with the final name. 
> 
> There's some common code there (make it read-only and check for errors on 
> close), but more importantly, this also gives a single place to add an 
> fsync_or_die() call if we want to add a safe mode.
> 
> This was triggered due to Denis Bueno apparently twice being able to 
> corrupt his git repository on OS X due to an unlucky combination of kernel 
> crashes and a not-very-robust filesystem.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> Junio, this is just the scaffolding, without the actual fsync_or_die call. 
> 
> I think it's a worthy place-holder regardless of whether we really want to 
> do the fsync (whether conditionally with a config option or not, and 
> whether there are more clever options like aio_fsync()).
> 
>  sha1_file.c |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index adcf37c..f311c79 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2105,6 +2105,15 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
>  	return 0;
>  }
>  
> +/* Finalize a file on disk, and close it. */
> +static void close_sha1_file(int fd)


Why close_sha1_file() when it operates on any old file?
I'd name it crash_safe_close() or perhaps close_and_fsync() or
something instead, as it's got nothing to do with sha1's and
everything to do with plain old files.

Other than that, I'm all for it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
