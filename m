From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0 3/3] Bigfile: teach "git add" to send a large file
 straight to a pack
Date: Mon, 09 May 2011 08:58:56 -0700
Message-ID: <7v4o53rhkv.fsf@alter.siamese.dyndns.org>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
 <1304844455-23570-4-git-send-email-gitster@pobox.com>
 <BANLkTimo_D_s-=zjPAbStvETRh8d_Tpa_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 09 17:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJSrZ-0005iS-0g
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 17:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab1EIP7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 11:59:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab1EIP7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 11:59:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC64D5EEF;
	Mon,  9 May 2011 12:01:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ufBXPlWcDJGX5HkLN0KXvqiIrAo=; b=jbD2Oc
	LzUpf7NxL6ont6CPfCSWiiSJN78mOd08N1T31L7lABLmHkbPpCNZB3yPIt0T4+jl
	FiP2XoLlmtU5Wip1p4mu3vN0+HnGxWQiJdSnTjBfZyTBq4RVeHZiSjdzidjS08Mc
	DpENcVYWYyhEPbtpjwGJJRcSt1HHgI9FhMy2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SSj9m42iM4/GCyraL6GpRGK3ej+LsJjH
	acOvVyvleVtM2NKk3ujst823po13xv03q+wPYeszdOPgyAFXWi16xThmW+jbu01n
	BFiTu7UbA3htMBGKIsj91Cpg+dVDk201sLh/bEM9iKMkafRFwh6hv5ywkZBCdlyA
	q6Kn5TSrOw8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B915A5EEE;
	Mon,  9 May 2011 12:01:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 405A65EEC; Mon,  9 May 2011
 12:01:03 -0400 (EDT)
In-Reply-To: <BANLkTimo_D_s-=zjPAbStvETRh8d_Tpa_w@mail.gmail.com> (Shawn
 Pearce's message of "Mon, 9 May 2011 07:05:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C5B67FE-7A55-11E0-9752-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173240>

Shawn Pearce <spearce@spearce.org> writes:

> The other problem here is the caller cannot access the written objects
> until the pack is closed. That is one of the things that has made
> fast-import difficult for git-svn to use, because git-svn expects the
> object to be available immediately. I assume that within a single git
> add or git update-index process we don't need to worry about this, so
> its probably a non-issue.

Yes, it is part of a possible issue to be addressed in the plan.

I envisioned that the "API" I talked about in the NEEDSWORK you quoted
would keep an open file descriptor to the "currently being built" packfile
wrapped in a "struct packed_git", with an in-core index_data that is
adjusted every time you add a straight-to-pack kind of object. Upon a
"finalize" call, it would determines the final pack name, write the real
pack .idx file out, and rename the "being built" packfile to the final
name to make it available to the outside world.

Within a single git process that approach would give access to the set of
objects that are going straight to the pack.  When it needs to spawn a git
subprocess, it however would need to finalize the pack to give access to
the new object, just like when fast-import flushes when asked to expose
the marks.

After all, this topic is about handling large binary files that would not
fit in core at once (we do not support them now at all). It may not too
bad to say we stuff one object per packfile and immediately close the
packfile (which is what the use of fast-import by the POC patch
does). Once the packfile is closed, the object in it is automatically
available to the outside world, and it is just the matter of making a
reprepare_packed_git() call to make it available to ourselves. When there
are many such objects, as they would exceed bigfilethreashold, repacking
them would just amount to copying the already compressed data literally (I
haven't re-checked the code though) and the cost shouldn't be more than
proportional to the size of the data. Expecting any system to do better
than that is asking for moon and I am not willing to bend backwards to
cater to such demands before running out of other better things to do ;-).

So I am tempted to keep the "spawn an external fast-import" code at least
for now, and give it a higher priority to make the other side (writing out
the blob to a working tree) streamable.
