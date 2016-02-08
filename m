From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging branches with smudge filter
Date: Mon, 08 Feb 2016 09:32:48 -0800
Message-ID: <xmqqbn7r9kfz.fsf@gitster.mtv.corp.google.com>
References: <CACqLfMk_qDhbXUjWLtBLP4o=CeKEgaWAm881h03fneuiRO-v2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Leonardo <leobasilio@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 18:33:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSpgK-00005F-7v
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 18:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbcBHRcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 12:32:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750781AbcBHRcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 12:32:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC1C4414CC;
	Mon,  8 Feb 2016 12:32:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6KUxEUyr99E7aILsDYvv+YU3Q80=; b=G/K41o
	OvhMlcikea/gfMEpVHOnNiw2wEJy/R7J5Jw5b2J7qXhQ5nNa+ljOzbpA9D4tUzT5
	jbvT25C1T3wZMrVhhaZMnStQ9NLAZf1im6qVnFOrZoeMPmPPys+RpZjoArjC8K4B
	Bz/f9Oz/oYk21utzHRo/ou4DduaiTi272/3BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L2gX9krfCT4qzmT40bMzvmZfg87GEgGa
	8equzXXHFTQULZL9I3piepNsmV+4bZCfwMYpggfQCPqfiYfvBOgsx26UG0NCrdqe
	kishoKLyQ0pVgwWWbF4pOghz+C7hcImDaQaHJtgmze1bO0iO3t2HQC0GOMrbmpgJ
	NmSkYgs9b/c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D48A9414CB;
	Mon,  8 Feb 2016 12:32:49 -0500 (EST)
Received: from pobox.com (unknown [104.133.3.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 41DA2414CA;
	Mon,  8 Feb 2016 12:32:49 -0500 (EST)
In-Reply-To: <CACqLfMk_qDhbXUjWLtBLP4o=CeKEgaWAm881h03fneuiRO-v2w@mail.gmail.com>
	(Leonardo's message of "Thu, 4 Feb 2016 21:10:37 -0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F94901FE-CE89-11E5-BD54-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285783>

Leonardo <leobasilio@gmail.com> writes:

> Hi, everybody. I'm new to git and I'd like to keep track of some codes
> we have here in our company. They have some sensitive information I
> would like to keep private. After some googling, I found some
> solutions that encrypt/decrypt the files using filters as they're
> committed/checked out. I've been using this approach and it suits my
> needs. Now I need to merge two branches, but the process is failing
> for two files in particular. First of all, here's my config file:
>
> [filter "openssl"]
>     clean = openssl enc -aes-256-cbc -a -nosalt -pass pass:password
>     smudge = openssl enc -d -aes-256-cbc -a -nosalt -pass pass:password
>     required

Git works on the "clean" representation of the data, i.e. the
representation of the blob object stored in the object database and
in the index, when manipulating the contents, e.g. diffing two
variants, patching (think "add -p"), merging, etc.

As you are making the "clean" version an encrypted opaque sequence
of bytes, it is expected that you wouldn't be able to run 3-way
merges.
