From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Wed, 04 Mar 2009 16:41:44 -0800
Message-ID: <7vk5744x87.fsf@gitster.siamese.dyndns.org>
References: <cover.1236187259.git.barvik@broadpark.no>
 <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Thu Mar 05 01:44:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf1gx-0003wO-EJ
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 01:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbZCEAlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 19:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbZCEAlw
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 19:41:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbZCEAlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 19:41:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 864239F01F;
	Wed,  4 Mar 2009 19:41:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 62BC69F01E; Wed,
  4 Mar 2009 19:41:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69BB7B08-091E-11DE-AD85-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112248>

Kjetil Barvik <barvik@broadpark.no> writes:

> Change the source code such that when USE_NSEC is not defined,
> possible nanosecond timestamps will still be saved in the index file,
> but not used inside if-test's, and will therefore not affect the
> outcome of GIT commands, other than the saved nanosecond timestamps in
> the index file.
>
> This will make it easier to use a system with 2 versions of GIT, one
> with and one without USE_NSEC defined.

I take it that you are responding to my earlier question with this patch?

    From: Junio C Hamano <gitster@pobox.com>
    Subject: Re: [PATCH/RFC v2 2/3] make USE_NSEC work as expected
    Date: Fri, 20 Feb 2009 00:35:35 -0800
    Message-ID: <7vab8hfqug.fsf@gitster.siamese.dyndns.org>

    Kjetil Barvik <barvik@broadpark.no> writes:

    > diff --git a/read-cache.c b/read-cache.c
    > index 940ec76..ca4bec2 100644
    > --- a/read-cache.c
    > +++ b/read-cache.c
    > @@ -67,8 +67,15 @@ void rename_index_entry_at(struct index_state *istate,..
    >   */
    >  void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
    >  {
    > -	ce->ce_ctime = st->st_ctime;
    > -	ce->ce_mtime = st->st_mtime;
    > +	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
    > +	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
    > +#ifdef USE_NSEC
    > +	ce->ce_ctime.nsec = (unsigned int)st->st_ctim.tv_nsec;
    > +	ce->ce_mtime.nsec = (unsigned int)st->st_mtim.tv_nsec;
    > +#else
    > +	ce->ce_ctime.nsec = 0;
    > +	ce->ce_mtime.nsec = 0;
    > +#endif

    How does this affect a use case where the same index file used with two 
    instances of git (one compiled with and another without USE_NSEC)?
