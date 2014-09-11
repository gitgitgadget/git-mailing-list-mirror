From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] hash-object --literally
Date: Thu, 11 Sep 2014 14:17:20 -0700
Message-ID: <1410470243-26552-1-git-send-email-gitster@pobox.com>
References: <xmqqoauldfij.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 23:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSBkB-0004YK-MT
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 23:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbaIKVR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 17:17:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59656 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbaIKVR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 17:17:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E9993ACDB;
	Thu, 11 Sep 2014 17:17:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nswG
	64PaYodWzF/H1ZLjfjtP9KI=; b=iSNwZLl08FNB7IIyxk9fBvnbHOim/gCEjHOM
	WB+rErUfanVDZXHyL2Fi8c7xWHKa99t1znTi7lU0u6AHdi8zPm1jzACgZt8mw3QK
	GZX3eogkzpENBPVg06nIE9EF7A8oo2G4kMrHNluvrNQ7THsw2zy+7nT4pby6/wSk
	c9oB8M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xn+IFh
	OlxFHBZG3cxNIYm7PUGXpkjg+nEZQ3iR1a1If1xO9yw36axxd8dj7yEayI74GGyM
	dFo069ewcsNs+GhpVx9SvGm/WKt0Q+UEca13/P9EdVlWtVOtcvnQiZdwXQfGz1bv
	bdS3wYmX36XnpsTTULdfHTHV0gr0gzWhj2o24=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26EAB3ACDA;
	Thu, 11 Sep 2014 17:17:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8DBA83ACD6;
	Thu, 11 Sep 2014 17:17:25 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-459-g1bc3b2b
In-Reply-To: <xmqqoauldfij.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 070D0EE2-39F9-11E4-AD4D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256878>

Our toolset may have become too tight without leaving enough escape
hatch to hinder further development.  "hash-object" makes minimum
sanity checks by default for a very good reason, but it means that
we cannot deliberately create broken datastreams to test against
fsck and other codepaths that are supposed to detect and report such
broken data that we may encounter in the field, perhaps created by
third-party tools.

These changes teach a new "--literally" option to "hash-object" to
allow us throw any garbage to create a broken loose object.  You can
even do something horrible like

	git hash-object -t bogus --literally -w --stdin </dev/null
	
by any garbage typename if you wanted to.

It probably needs to be accompanied by "cat-file --literally" that
does not take "-t <type>" option or does not complain even if the
contents look unreasonable.  But that is for another day (hint,
hint).

The second patch is optional.  I thought I may want to pass this as
a new HASH_LITERALLY bit down the callchain to index_fd(), but I
decided against it, as that will allow other codepaths to create
broken datastream, spreading this debugging aid a bit too widely for
my taste.

Junio C Hamano (3):
  hash-object: reduce file-scope statics
  hash-object: pass 'write_object' as a flag
  hash-object: add --literally option

 builtin/hash-object.c | 103 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 42 deletions(-)

-- 
2.1.0-459-g1bc3b2b
