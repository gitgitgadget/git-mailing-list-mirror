From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when   file is open
Date: Wed, 04 Feb 2009 15:01:08 +0100
Message-ID: <49899FA4.2020003@viscovery.net>
References: <cover.1233751281.git.barvik@broadpark.no> <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUj6C-0008V0-Md
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbZBDOt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbZBDOtz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:49:55 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3677 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZBDOtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 09:49:53 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LUj4T-00017B-SH; Wed, 04 Feb 2009 15:49:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BFCE06D9; Wed,  4 Feb 2009 15:01:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108371>

Kjetil Barvik schrieb:
> Currently inside write_entry() we do an lstat(path, &st) call on a
> file which have just been opened inside the exact same function.  It
> should be better to call fstat(fd, &st) on the file while it is open,
> and it should be at least as fast as the lstat() method.
...
> @@ -145,6 +146,11 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
>  		}
>  
>  		wrote = write_in_full(fd, new, size);
> +		/* use fstat() only when path == ce->name */
> +		if (state->refresh_cache && !to_tempfile && !state->base_dir_len) {
> +			fstat(fd, &st);
> +			fstat_done = 1;
> +		}
>  		close(fd);

I've a bad gut feeling about this: It may not work as expected on Windows
because there is this statement in the documentation:

  "The only guarantee about a file timestamp is that the file time is
   correctly reflected when the handle that makes the change is closed."

(http://msdn.microsoft.com/en-us/library/ms724290(VS.85).aspx)

We are operating on a temporary file. It could happen that the fstat()
returns the time when the file was created, as opposed to when the
write_in_full() was completed successfully. The fstat()ed time ends up in
the index, but it can be different from what later lstat() calls report
(and the file would be regarded as modified).

I have the suspicion that the gain from this patch is minimal. Would you
mind playing it safe and drop this patch?

-- Hannes
