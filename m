From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repack command on larger pack file
Date: Mon, 26 Oct 2015 00:11:21 -0700
Message-ID: <xmqqziz6hzom.fsf@gitster.mtv.corp.google.com>
References: <loom.20151026T065553-934@post.gmane.org>
	<xmqq611ujfn0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sivakumar Selvam <gerritcode@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 08:11:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqbwH-0004WG-9q
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 08:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbbJZHLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 03:11:25 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752964AbbJZHLY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 03:11:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFD3B20838;
	Mon, 26 Oct 2015 03:11:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7y7qIAmyd3WZ1AOYQr39wfSpPE8=; b=lfonJp
	0XHZH+TlFN9mq/+UkYY9kl7kcGYOdy17yE7jb++8D2IARiGWM6ZUtSzIv2K2oH75
	yRs8HWr++PblBo6c3VA5TVyDQs977HUGZIZaTJ5M30+O5OLW4/p0TetUukq80c+H
	scg8uuHMUOOlIeSQzE2HgJKrvuxyIGWKJQfac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AocRSYB6YHKBfgDZyA3tnpEMRbeI0UDk
	8xuXp2l6KE7Ns6X7sGBcQ5WLSg3Vumn5ezgWyJpjsLaxi6lrekp79+JXa2wvTKhB
	JQ530xadpIukNvFsqkmy56rykoGQOgg0Zl2VFo6G9RCEDHzt0xIWDooOw4ga2GtX
	OmGR6kLiJ80=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B732320837;
	Mon, 26 Oct 2015 03:11:23 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C49B20835;
	Mon, 26 Oct 2015 03:11:23 -0400 (EDT)
In-Reply-To: <xmqq611ujfn0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 25 Oct 2015 23:41:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3ABB720-7BB0-11E5-8D21-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280184>

Junio C Hamano <gitster@pobox.com> writes:

> Sivakumar Selvam <gerritcode@gmail.com> writes:
>
>> ... So
>> I thought of splitting the pack file into 4 GB chunks.
> ...
> Hmmm, what is "this issue"?  I do not see anything surprising.

While the explanation might have been enlightening, the knowledge
conveyed by the explanation by itself would not be of much practical
use, and enlightment without practical use is never fun.

So let's do another tangent that may be more useful.

In many repositories, older parts of the history often hold the bulk
of objects that do not change, and it is wasteful to repack them
over and over.  If your project is at around v40.0 today, and it was
at around v36.0 6 months ago, for example, you may want to pack
everything that happened before v36.0 into a single pack just once,
pack them really well, and have your "repack" not touch that old
part of the history.

  $ git rev-list --objects v36.0 |
    git pack-objects --window=200 --depth=128 pack

would produce such a pack [*1*]

The standard output from the above pipeline will give you a 40-hex
string (e.g. 51c472761b4690a331c02c90ec364e47cca1b3ac, call it
$HEX), and in the current directory you will find two files,
pack-$HEX.pack and pack-$HEX.idx.

You can then do this:

  $ echo "v36.0 with W/D 200/128" >pack-$HEX.keep
  $ mv pack-$HEX.* .git/objects/pack/.
  $ git repack -a -d

A pack that has an accompanying .keep file is excempt from
repacking, so once you do this, your future "git repack" will only
repack objects that are not in the kept packs.



[Footnote]

*1* I won't say 200/128 gives you a good pack; you would need to
experiment.  In general, larger depth will result in smaller pack
but it will result in bigger overhead while you use the repository
every day.  Larger window will spend a lot of cycles while packing,
but will result in a smaller pack.
