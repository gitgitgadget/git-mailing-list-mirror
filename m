From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cherry-pick/revert: default to topological sorting
Date: Mon, 13 Aug 2012 14:50:30 -0700
Message-ID: <7vwr12bgwp.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e51.29d0320a.65ff.2c48SMTPIN_ADDED@gmr-mx.google.com>
 <7vpq6uczis.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T12X1-00050X-28
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 23:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2HMVud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 17:50:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005Ab2HMVud (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 17:50:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 666D49425;
	Mon, 13 Aug 2012 17:50:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bBmqa0Gm0bODoXnlHZtsSDUuJu0=; b=GeHavO
	QakvH1ofsF4EP7Rx7/12OqXBQIxmfNz47sglH1h4xUDYkNBelfKj6hNnyNXM6Wh2
	Fp95C58/qvlDeOvu1/XUPZyM+EHAJnbIj704xZ5rXk1GaPxVvK06KRMtWDIt0tIs
	+kJkPZmvLutkEE0Bf2iqcChWBNmaA33Bs4X14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oy0VkaDItOwmLhagHjK6p3rifufbeBEk
	jUEIvbuYOoBEFqq5VCdWenxfP9eWbx7zODHds4mPOXCnrms5/E5XCWlSQQPr2DOE
	xM323iDgDf7rclVUtH9vKqgMDEEOYw6Yit36+77Ozb6baFxomtEWc5tVEyDRM/Rp
	/B0eog10z90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53B2E9424;
	Mon, 13 Aug 2012 17:50:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A88279422; Mon, 13 Aug 2012
 17:50:31 -0400 (EDT)
In-Reply-To: <7vpq6uczis.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 13 Aug 2012 13:23:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E754ED22-E590-11E1-8265-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203370>

Junio C Hamano <gitster@pobox.com> writes:

> y@google.com writes:
>
>> From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>>
>> When 'git cherry-pick' and 'git revert' are used with ranges such as
>> 'git cherry-pick A..B', the order of the commits to pick are
>> determined by the default date-based sorting. If a commit has a commit
>> date before the commit date of its parent, it will therfore be applied
>> before its parent.
>
> Is that what --topo-order really means?

And it turns out that the documentation is crappy.  Perhaps
something like this, but an illustration may not hurt.

 Documentation/rev-list-options.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index d9b2b5b..c147117 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -579,9 +579,10 @@ Commit Ordering
 By default, the commits are shown in reverse chronological order.
 
 --topo-order::
-
-	This option makes them appear in topological order (i.e.
-	descendant commits are shown before their parents).
+	This option makes them appear in topological order.  Even
+	without this option, descendant commits are shown before
+	their parents, but this tries to avoid showing commits on
+	multiple lines of history intermixed.
 
 --date-order::
 
