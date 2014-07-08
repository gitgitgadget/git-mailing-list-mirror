From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] cache-tree: Write updated cache-tree after commit
Date: Tue, 08 Jul 2014 11:32:36 -0700
Message-ID: <xmqqfvibaegr.fsf@gitster.dls.corp.google.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
	<1404619619-4774-4-git-send-email-dturner@twitter.com>
	<xmqq61j9c4xb.fsf@gitster.dls.corp.google.com>
	<xmqq7g3obsqm.fsf@gitster.dls.corp.google.com>
	<CACsJy8C20oFdATHKTLK=9U3_kHu1QsuS4i74RPgQn0aTwVCC8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 20:32:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4aC8-0004Ug-SK
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 20:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbaGHScp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 14:32:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51852 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697AbaGHSco (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 14:32:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD57227425;
	Tue,  8 Jul 2014 14:32:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qFXGNFJXQ5AhSUK3WuA08Jh1vHU=; b=mHxB8o
	+sdZFO5SRONLqc+Hpimc8GKcAjuS5gRNfhiZR2CPM7Js7a/WRAptQiZIO5GfO6Vs
	niVuuIyrxgx9XwKu43u4D0SqY3sZVLsjBD4j/jGXPMtCcJqTUlNb3uYtIBT+MgYx
	8BN4zWnuYKaJU4dUpB/xNoeH6/OEaRd1IFOaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lbjLfW7fWfygeFcg4tVyw0R3IQ7y+EZT
	QexoVy7ZMhSoKbgYRg2hIQ7UcPAImj/vnqFf599bhh/tS6GtJ5LiqvlI6ETJzWUT
	ipigqk6zHFA49QL1O5YLHxPbRXbH6/9eycgl7DscJacn4klhpZSgCRv/jkRS7AYQ
	61LbaBAVrkg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A228D27424;
	Tue,  8 Jul 2014 14:32:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7A27327421;
	Tue,  8 Jul 2014 14:32:25 -0400 (EDT)
In-Reply-To: <CACsJy8C20oFdATHKTLK=9U3_kHu1QsuS4i74RPgQn0aTwVCC8w@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 8 Jul 2014 17:32:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 354B504C-06CE-11E4-B234-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253037>

Duy Nguyen <pclouds@gmail.com> writes:

> ... I know the
> "index_file" in prepare_to_commit() is probably "index.lock" or
> something, but that does not stop us from locking again
> ("index.lock.lock") if we want to update it.

We grabbed the lock on the real index and we have written out the
result of "update-index --refresh" to it (and closed), but we still
want to and do keep the lock while "add -i" works on it.  And then
after "add -i" returns, we still have the lock on the real index and
the patch wants to write to it again to store the refreshed cache-tree
under that lock.

It may be the case that the API suite currently lacks a way to allow
the caller to reopen the same "index.lock" file after calling
write-locked-index(CLOSE_LOCK), and taking a lock on "index.lock" to
write into "index.lock.lock" and renaming it to "index.lock" could
be a workaround for it, but doesn't that sound a wrong workaround?
