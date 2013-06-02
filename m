From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/25] object_array_remove_duplicates(): rewrite to reduce copying
Date: Sun, 02 Jun 2013 14:02:41 -0700
Message-ID: <7vy5asmdji.fsf@alter.siamese.dyndns.org>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
	<1369472904-12875-12-git-send-email-mhagger@alum.mit.edu>
	<7vk3mhwyiq.fsf@alter.siamese.dyndns.org>
	<51A7C146.6090605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 02 23:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjFQb-0005SM-Jc
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 23:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab3FBVCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 17:02:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277Ab3FBVCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 17:02:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9823924CB8;
	Sun,  2 Jun 2013 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xjupAubzLxQWDSW8rCwqisOGSrY=; b=dbnAAi
	hO+IKBfx1UWhJ1WkAawTt/ZBU0GNfzd3UyrswRpPE9HAcVRj7P0xLjWGv49vXv3d
	4fJ0QC62BYmBwv4WUDBwWlVNobYiem0IKaQ+ZGeag2447/yZCIJAXOw1ASFnRC2E
	57u/JXObs41+DuywxxiQ+vL79ijED44Bm3pCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lPJHga9uh8I9Klg61wRDD+yuzRLwDjZT
	190fRTbkFtg2MgTqDw6rgJVHtmQNU+BGJ/g5FxLEXT8MOkV9CDBClIoXeahYBTaO
	HnNcQhS8G2yxY4szdhvUiPIOkP97pSLf5CzxuBwkAVS+HFYO7vD8/8SHhoHHOoLy
	iAIqU4MXSK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE8724CB7;
	Sun,  2 Jun 2013 21:02:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 142E824CB6;
	Sun,  2 Jun 2013 21:02:42 +0000 (UTC)
In-Reply-To: <51A7C146.6090605@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 30 May 2013 23:14:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C48B1E88-CBC7-11E2-B8D1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226183>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> The only caller of remove-duplicates is bundle.c, which gets many
>> starting points and end points from the command line and tries to be
>> nice by removing obvious duplicates, e.g.
>> 
>> 	git bundle create t.bundle master master
>> 
>> but I think its logic of deduping is wrong.  It runs dwim_ref() on
>> the incoming refs after the remove-duplicates call, so
>> 
>> 	git bundle create t.bundle master heads/mater
>> 
>> will end up with two copies of refs/heads/master.  To fix it, the
>> code must dedup the result of running dwim_ref(), and at that point,
>> there is no reason to call object_array_remove_duplicates().
>
> That sounds reasonable.
>
> I poked around this code a bit to understand what is going on, and it
> occurred to me that the object_array can include both positive and
> negative references, right?  And yet object_array_remove_duplicates()
> only considers names, not flags.  So it seems to me that if the deduping
> code would see the same reference twice, once positive and once
> negative, then it would throw an arbitrary one of them out, which would
> be wrong.
>
> But I couldn't provoke this situation, so perhaps setup_revisions()
> already specially treats combinations like "master ^master"?  (If that's
> true then why? and wouldn't it get confused by "master ^heads/master"?)

With "git bundle create t.bundle ^master master", you see two
entries in revs.pending.objects[] but they are the same object and
is already marked as uninteresting, so you will not see 'master' in
the result.

This parsing loop predates the more recent revs->cmdline mechanism,
that treats these two command line arguments as separate entities,
so that we can more reliably tell what the real end-user input is.
