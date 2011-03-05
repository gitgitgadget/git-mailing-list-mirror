From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 16:05:35 -0800
Message-ID: <7vd3m65t4g.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
 <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 <7vy64u65ta.fsf@alter.siamese.dyndns.org>
 <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org> <4D717116.3050305@miseler.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Miseler <alexander@miseler.de>
X-From: git-owner@vger.kernel.org Sat Mar 05 01:05:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvf0J-0002es-0p
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 01:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760227Ab1CEAFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 19:05:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760224Ab1CEAFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 19:05:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3DD7324D;
	Fri,  4 Mar 2011 19:07:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AUzXNoC8cwIGyxSexvjw6YN90es=; b=dPEOCp
	u41eskh3oNMAWmOhnz+w9HRZ039U7+5Hvl3JOBiEfESmblfHHzWuBw/+cJHUdmPx
	60pAuAQ1uS3/Xdk0zHCOC7HCx0DxMUxXRgnmCoIilJtPV2XRxqwcKXfFIRakVtZK
	T/o5WBivL24zwvhev5E7drIqjJR+n4eb9BHnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MSkg0d8Tm/1X1V0vzyNcO+3MV6jciB3G
	cVVxr0mvMtY+9yafY7XWySGUNvtZlYSFDZqiUHYOY9/P64O9hdTJLEfmhygm/ij6
	kU2N9aPDtw3L+sVpDKO+ml26zUxdo4RaosM6Z7jfUC0w1E/PYE2yucXr9RqVBLY6
	Ji5V8L83ym8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C83FD324C;
	Fri,  4 Mar 2011 19:07:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CECB5324A; Fri,  4 Mar 2011
 19:06:59 -0500 (EST)
In-Reply-To: <4D717116.3050305@miseler.de> (Alexander Miseler's message of
 "Sat\, 05 Mar 2011 00\:09\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F7D2F76-46BC-11E0-B053-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168476>

Alexander Miseler <alexander@miseler.de> writes:

> .... On a side note: if this problem is tackled it might be
> sensible to add a heuristic to git format-patch that increases the
> context size for hunks that are likely to be ambiguous.

In general that approach would not help.  Imagine a case where the
problematic patch from David Henningsson were only about moving the
calling site of check_required() within the element_probe() function.
IOW, imagine that the hunk starting at line 1018 to modify
check_required() itself weren't involved in his change.

Before or after such a change, there would be only one location that
closes two blocks followed by a blank line and return 0 at the end of the
function, which is the necessary context of the "moved after" hunk of the
patch, so when producing the patch, there is no way for format-patch to
notice that it is likely to become ambiguous.

But if the change to check_required() were applied as a separate patch
before the change to move the call site was applied, at the application
time, the patch becomes ambiguous.
