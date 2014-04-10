From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Make update_refs more atomic V2
Date: Thu, 10 Apr 2014 11:53:28 -0700
Message-ID: <xmqq38hlxbh3.fsf@gitster.dls.corp.google.com>
References: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 10 20:53:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYK6W-0004UP-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbaDJSxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:53:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934889AbaDJSxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:53:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED5BA7BCC8;
	Thu, 10 Apr 2014 14:53:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4gPnSrXAt6mwbObsZRXo5b6jP2Y=; b=Y7MaiV
	GpYq3GB8FWEjbVizFDkD1r4u9L7CLqLtuo8VduCQqBXhsEFejzsNFsTJF4A3cM+7
	Z9JL8xglwFO2xhiZJSSvlHFtcGPXTP+XBU9r0l8hwmE7mkXczIw8k3OEbSjkdRMh
	6izeUd3+elbi3XUxAOhCFTNBvue9pR/DjBSFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wqx2RDAMrxdFAlV2aacb+rlb/7CbSqiu
	IEJeI3Nzl4ykwR1dMgSMIm3af7iKF+OBZEvWh1DCpSxbnht1JjkAQ9Cau+qiYn4+
	IkGdBYPBLOZO3pM+prnG3ILI4oVkQi2ifJtWnj3qnKvAXXlbWrgfW7UzSLOQcjth
	Az4HqAL+Ois=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D73ED7BCC7;
	Thu, 10 Apr 2014 14:53:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E33B7BCC6;
	Thu, 10 Apr 2014 14:53:30 -0400 (EDT)
In-Reply-To: <1397154625-11884-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Thu, 10 Apr 2014 11:30:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6889C322-C0E1-11E3-850B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246033>

CC'ing Michael who has been active in this area as an area expert.

Ronnie, please make it a habit to run something like

    $ git shortlog --no-merges --since=18.months <affected paths>...

to help you decide who your series may want to be reviewed by,
before sending them.

Thanks.

Ronnie Sahlberg <sahlberg@google.com> writes:

> refs.c:update_refs() intermingles doing updates and checks with actually
> applying changes to the refs in loops that abort on error.
> This is done one ref at a time and means that if an error is detected that
> will fail the operation after only some of the ref operations have been
> been updated on the disk.
>
> These patches change the update and delete functions to use a three
> call pattern of
>
> 1, lock
> 2, update, or flag for deletion
> 3, apply on disk
>
> In the final patch I change update_refs to perform these actions in three
> separate loops where the final loop to 'apply on disk' all the changes will
> only be performed if there were no error conditions detected during any of
> previous loops.
>
> This should make the changes of refs in update_refs slightly more atomic.
>
>
> This may overlap with other current patch series for making refs updates
> more atomic which may mean these patches become obsolete, but I would still
> like some review and feedback on these changes.
>
> Version 2:
> Updates and fixes based on Junio's feedback.
> * Fix the subject line for patches so they comply with the project standard.
> * Redo the update/delete loops so that we maintain the correct order of
>   operations. Perform all updates first, then perform the deletes.
> * Add an additional patch that allows us to do the update/delete in the correct
>   order from within a single loop by first sorting the refs so that deletes
>   are after all non-deletes.
>
>
> Ronnie Sahlberg (4):
>   refs.c: split writing and commiting a ref into two separate functions
>   refs.c: split delete_ref_loose() into a separate flag-for-deletion and
>     commit phase
>   refs.c: change update_refs to run the commit loops once all work is
>     finished
>   refs.c: sort the refs by new_sha1 and merge the two update/delete
>     loops into one
>
>  branch.c               |  10 ++++-
>  builtin/commit.c       |   5 +++
>  builtin/fetch.c        |   7 +++-
>  builtin/receive-pack.c |   4 ++
>  builtin/replace.c      |   6 ++-
>  builtin/tag.c          |   6 ++-
>  fast-import.c          |   7 +++-
>  refs.c                 | 102 +++++++++++++++++++++++++++++++++----------------
>  refs.h                 |   6 +++
>  sequencer.c            |   4 ++
>  walker.c               |   4 ++
>  11 files changed, 123 insertions(+), 38 deletions(-)
