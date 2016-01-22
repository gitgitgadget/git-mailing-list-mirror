From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] merge: add --rename-notes
Date: Fri, 22 Jan 2016 09:17:26 -0800
Message-ID: <xmqq60ylwn2x.fsf@gitster.mtv.corp.google.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
	<1453287968-26000-8-git-send-email-pclouds@gmail.com>
	<xmqqtwm6yg30.fsf@gitster.mtv.corp.google.com>
	<CACsJy8D3-i4UpavWZz0QU6oJE3AK06ugjPPTMOtqUA+Sa7==qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:17:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMfL7-0003JQ-TK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbcAVRRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:17:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753801AbcAVRR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:17:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B83B3D7E4;
	Fri, 22 Jan 2016 12:17:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nBfOmDmW7DEEKpENUKC5FMDT1Eg=; b=kAfqXq
	vRN+OlXxNAx0NnpndHYxwYO5gnKjrw64vgeiX2uBYpnVNjrOjH8vMBJy5KhL28CS
	ShUqO/NyQD3oRKVEW749bkkZSXf+m+4tTQSt3YakkYZLHPdSZUD0Hvcl7jXlu7Ve
	e/P9eGqnLS7eeXnl1QyMVTHUvWku8kZ40TUyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLvvCFQjWRWKjN57ISSobw9PJq6onLp4
	bt/284CbrlcsEgXFxQSMdzufMpOWmX+kyIRd2cW1udGn123psAg24auQWnsOnChn
	aWEkdAkgmGQAvql6BQ+T8+0pzi3VUIRhLpKfYvCtlAMDx3eHFJI4y0F5NlLnaJWo
	ROYkCo9iOD8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37C2E3D7E3;
	Fri, 22 Jan 2016 12:17:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 85B633D7E2;
	Fri, 22 Jan 2016 12:17:27 -0500 (EST)
In-Reply-To: <CACsJy8D3-i4UpavWZz0QU6oJE3AK06ugjPPTMOtqUA+Sa7==qQ@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 22 Jan 2016 10:35:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02DFB318-C12C-11E5-96F3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284568>

Duy Nguyen <pclouds@gmail.com> writes:

> The problem with indexing notes tree by blob is how the user will
> manage it.

I do not think they have to be incompatible goals.  Allowing the
user to specify "at this commit, this path was moved to that path"
may be a good thing.  But at the same time, using a better data
structure at runtime is also important.

Unless I am reading your "cache" code wrong, it is always reading a
flat list of unsorted "<blob> to <blob>" entries describing
everything that happened in the entire history of the project into
core, and then forcing the low-level code to find the entries
relevant to the change in the commit it is looking at at runtime.

The way the "cache" code stores and forces the runtime to use the
data makes it proportional to the size of the history of the project
(here I am assuming uniform "rename density" across history, the
longer the history of a project, the more renames there would be) to
find the manually defined renames just to show a single change, no?

What was disappointing is that the way the rename notes is used
during 'log -M' traversal is an example of a good design.  When
showing a single commit, the cost the code pays to get to the data
for a single commit out of the rename notes tree does not grow
proportional to the size of the history.
