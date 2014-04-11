From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Make update refs more atomic
Date: Fri, 11 Apr 2014 15:27:05 -0700
Message-ID: <xmqqwqevpkna.fsf@gitster.dls.corp.google.com>
References: <1397248790-10403-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 00:27:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYjul-0001eG-IC
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 00:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbaDKW1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 18:27:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbaDKW1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 18:27:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 160297A1E6;
	Fri, 11 Apr 2014 18:27:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a5yuHaVgPPJ4iQQBDlhJQwioE68=; b=CX6mkl
	Xalv0ro0nzQMGVzyUR6WMuBwijHXRaxgwXn2k4MW8ab5nnbv0LgIo2qarDGwlCM0
	9eOyk4D7UPOWg3suVrRquefnluVZnmIbO/r1bKaLG1o2lOpsG2pFJ773Lmrxk6We
	Y47fkkyKS1D7vMo6ZY3PNQXEhqlcuOkO/vfBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gt1Ty4rrRvTXYhUBU5huY5n++DKTJPvr
	X13ecQM+i1pfzkVILs7uucMLJ+z6XnuUGBFyImCY3f8woOr3ptbpO3jxACUIu/pj
	JgIrzGwtuBjAW24SGaTu25MTSVkJNatRnH48n5EZJK2dCdlPYr6QFI07A9OpgG9Z
	MqY6ZdQMnoQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F41B07A1E5;
	Fri, 11 Apr 2014 18:27:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5FB17A1E3;
	Fri, 11 Apr 2014 18:27:06 -0400 (EDT)
In-Reply-To: <1397248790-10403-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Fri, 11 Apr 2014 13:39:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A100C82-C1C8-11E3-A581-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246154>

Ronnie Sahlberg <sahlberg@google.com> writes:

> refs.c:ref_transaction_commit() intermingles doing updates and checks with
> actually applying changes to the refs in loops that abort on error.
> This is done one ref at a time and means that if an error is detected that
> will fail the operation partway through the list of refs to update we
> will end up with some changes applied to disk and others not.
>
> Without having transaction support from the filesystem, it is hard to
> make an update that involves multiple refs to guarantee atomicity, but we
> can do a somewhat better than we currently do.
>
> These patches change the update and delete functions to use a three
> call pattern of
>
> 1, lock
> 2, update, or flag for deletion
> 3, apply on disk  (rename() or unlink())
>
> When a transaction is commited we first do all the locking, preparations
> and most of the error checking before we actually start applying any changes
> to the filesystem store.
>
> This means that more of the error cases that will fail the commit
> will trigger before we start doing any changes to the actual files.
>
>
> This should make the changes of refs in refs_transaction_commit slightly
> more atomic.

Hmph.  At least 5801 9350 and 9300 seem to fail with these three
queued on top of mh/ref-transaction series.
