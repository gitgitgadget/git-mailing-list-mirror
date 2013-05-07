From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Tue, 07 May 2013 00:12:26 -0700
Message-ID: <7vehdjmffp.fsf@alter.siamese.dyndns.org>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
	<CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com>
	<518874A5.5050002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 09:12:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZc4g-00065M-Ab
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 09:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935Ab3EGHMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 03:12:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756380Ab3EGHM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 03:12:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A56F1958E;
	Tue,  7 May 2013 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yg6jZyrdnCNIiVcvwBSWRS9LgcA=; b=FxLjOb
	4cDEZWjxCH/dQZPQZuWfGT3cJwZqZc/Y7CfUaNyaTFiUINMnq7BBwSbvPfN/oa2/
	9mEruorknvivi71uyzrYyqkZt4WMtR3gNeR1lE2W5ILSMObRN8gaZsYDk8Arfzvy
	44oYkSRKS0xcHS7YJEGJj8fECUMs/RrJDbVfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQLfMaIMWGlyBmPAtPN7hoTFleeQsTdN
	vbfUd20nI4g9VJnDIfFRR4bBGWobA4VtwSWwC3vAghYiYzTqVo6HBRji5U0Y5vSr
	gxssbVc92PBXLfifMDn4IeAzyEtJSNENdAud4a3Y+nv4pwloqJntaAqv5i1y8BC0
	sxtqBV7POPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6003B1958D;
	Tue,  7 May 2013 07:12:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCE5319588;
	Tue,  7 May 2013 07:12:27 +0000 (UTC)
In-Reply-To: <518874A5.5050002@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 07 May 2013 05:27:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79A3BFE8-B6E5-11E2-9AF7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223561>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>>>> CVS stores all of the revisions of a single file in a single filename,v
>>>>> file in rcsfile(5) format.  The revisions are stored as deltas ordered
>>>>> so that a single revision can be reconstructed from a single serial read
>>>>> of the file.
>>>>>
>>>>> cvs2git reads each of these files once, reconstructing *all* of the
>>>>> revisions for a file in a single go.  It then pours them into a
>>>>> git-fast-import stream as blobs and sets a mark on each blob.

This is more or less off-topic but in the bigger picture it is more
interesting and important X-<.

The way you describe how cvs2git handles the blobs is the more
efficient way, given that fast-import does not even attempt to
bother to create good deltas. The only thing it does is to see if
the current data deltifies against the last object.

IIRC, CVS's backend storage is mostly recorded in backward delta, so
if you are feeding the blob data from new to old, then the resulting
pack would follow Linus's law (the file generally grows over time)
and would generally give you a good deltified chain of objects.
