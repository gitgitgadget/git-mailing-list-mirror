From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/3] Make index preloading check the whole path to the
 file
Date: Thu, 09 Jul 2009 20:12:31 -0700
Message-ID: <7v8wixw7s0.fsf@alter.siamese.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain>
 <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091348490.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 05:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP6Xb-0006OA-Ea
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 05:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbZGJDMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 23:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbZGJDMn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 23:12:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbZGJDMm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 23:12:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ED3A226B37;
	Thu,  9 Jul 2009 23:12:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B153C26B36; Thu, 
 9 Jul 2009 23:12:32 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907091348490.3352@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 9 Jul 2009 13\:50\:26 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8744F83A-6CFF-11DE-927C-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123030>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 9 Jul 2009 13:37:02 -0700
> Subject: [PATCH 7/3] Make index preloading check the whole path to the file
>
> This uses the new thread-safe 'threaded_has_symlink_leading_path()'
> function to efficiently verify that the whole path leading up to the
> filename is a proper path, and does not contain symlinks.
>
> This makes 'ce_uptodate()' a much stronger guarantee: it no longer just
> guarantees that the 'lstat()' of the path would match, it also means
> that we know that people haven't played games with moving directories
> around and covered it up with symlinks.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> Totally trivial, now that we have a thread-safe symlink checker.
>
> If we have leading symlinks in the cache-entry path, we will refuse to 
> mark it up-to-date. There's no need to even try to stat anything under 
> that directory.
>
>  preload-index.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/preload-index.c b/preload-index.c
> index 88edc5f..c3462dc 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -34,6 +34,7 @@ static void *preload_thread(void *_data)
>  	struct thread_data *p = _data;
>  	struct index_state *index = p->index;
>  	struct cache_entry **cep = index->cache + p->offset;
> +	struct cache_def cache;
>  
>  	nr = p->nr;
>  	if (nr + p->offset > index->cache_nr)
> @@ -49,6 +50,8 @@ static void *preload_thread(void *_data)
>  			continue;
>  		if (!ce_path_match(ce, p->pathspec))
>  			continue;
> +		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
> +			continue;

I must be missing something very obvious, but how would this call behave
on an uninitialized cache defined above, or do we need reset_lstat_cache()
on it before the first use?

>  		if (lstat(ce->name, &st))
>  			continue;
>  		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
> -- 
> 1.6.3.3.415.ga8877
