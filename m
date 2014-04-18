From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Store refreshed stat info in a separate file?
Date: Fri, 18 Apr 2014 10:43:50 -0700
Message-ID: <xmqq4n1qcz3d.fsf@gitster.dls.corp.google.com>
References: <CACsJy8CzZ7H4pffNccBBpvpn5oT5tud-Tx=Nu1c=q2SB7Zi8eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 19:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbCpU-0003yF-Ke
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 19:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbaDRRnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 13:43:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbaDRRny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 13:43:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC7B879BC4;
	Fri, 18 Apr 2014 13:43:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DfepaKgV/Wv32YPPSsflAql6RZI=; b=QGHzqo
	bK+0hM6kckuCEBZcZPSVgLuR1zzYuDvrjxp8i4QjzW+sbj9Muf9DTkrWRxDSaDpJ
	Jspu/+jRESknHXo+2frYAvjSFMpD6VDnk2jmlRyLtyM446v5piYf6XHYz6K/HmZm
	xhwHhNP4WhwfkfHnCihI6vwoCUQY2AbpB66Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/970oOIpjgDrKvcyMGgqDvUuTxetl4k
	FQLzeiP4r/AjQ7uU5/fyu4+SBVVhPQ1O7FKXG2BrnR8j+OQN9JG9BvD6WLln/oIs
	5aqiw7rZeR8hXN7lkF/twibHBvZ7Vc9EBGygw16C8GuPFhG6jFVwsOYmgL4NeP/E
	PHYVEAFoaLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92A2379BC1;
	Fri, 18 Apr 2014 13:43:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1791A79BBE;
	Fri, 18 Apr 2014 13:43:52 -0400 (EDT)
In-Reply-To: <CACsJy8CzZ7H4pffNccBBpvpn5oT5tud-Tx=Nu1c=q2SB7Zi8eg@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 18 Apr 2014 21:20:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 01514716-C721-11E3-B4AB-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246477>

Duy Nguyen <pclouds@gmail.com> writes:

> The major cost of writing an index is the SHA-1 hashing. The bigger
> the written part is, the higher cost we pay. So what if we write
> stat-only data to a separate file? Think of it as an index extension,
> only it stays outside the index. On webkit with 182k files, the stat
> data size would be about 6MB (its index v4 is 15M for comparison). But
> with stat-only we could employ some cheap but efficient compressing,
> sd_dev, sd_uid and sd_gid are likely the same for every entry. And we
> could store the stat data of updated entries only. So I'm hoping to
> get that 6MB down to a few hundred KBs. That makes hashing lightning
> fast.

It is perfectly OK to store your verbose stat data after deflating
it in the index as an index extension, so "storing 6MB that can be
compressed efficiently without compressing is dumb" applies whether
the result is stored in the index or in a separate file, I would
think.

Having said that, I do not think there is a fundamental reason why
the stat data has to live inside the same index file.  A separate
file is just fine, as long as you can reliably detect that they went
out of sync for whatever reason (e.g. "the index proper updated, a
stale stat file left beind"), and storing the trailer checksum from
the corresponding index in this new file is an obvious and good
solution.

I am not sure if that should be called index.stat, though.  It is
more about untracked files.  The stat data for cached paths are in
the index proper, so what you are adding is not what we would call
"stat info" when we talk about the index.
