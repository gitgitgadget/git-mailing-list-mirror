From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] format-patch: introduce --base=auto option
Date: Tue, 05 Apr 2016 00:21:21 -0700
Message-ID: <xmqqk2kc34i6.fsf@gitster.mtv.corp.google.com>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
	<1459388776-18066-4-git-send-email-xiaolong.ye@intel.com>
	<xmqqtwjmo84r.fsf@gitster.mtv.corp.google.com>
	<20160401135207.GB2915@yexl-desktop>
	<xmqqlh4xjoub.fsf@gitster.mtv.corp.google.com>
	<20160405063609.GB10110@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Ye Xiaolong <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 09:21:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anLIr-0008Sg-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 09:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbcDEHVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 03:21:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754531AbcDEHV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 03:21:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E9854B978;
	Tue,  5 Apr 2016 03:21:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y1UAa9i4RtLYbi1zAe582Gf/R54=; b=UUiVMC
	/sjLrcj5Z+rz5l2NcQeQ23ZL+GIy5Z2QhR4HNydZvJL6bHHpxEPOszdsohR+8Hwk
	lLxP2BLI+PcQiRMTJOoV8mGNpbSWTq1VmTVSUKfMeEGV6SuZv0gdmc2q+9DayJmO
	vtmURR0uWHv4lOEzM/RNt9WR/5spvbswBvIvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wJn1whJJ5n/AA4H8cTFng8GiYXr9dfgR
	flYKh7ia73Lua9gW6pVcoR22LHQhhbceVlZNm8/uMn1QlGhYNxe7zfmMpQ5AtvkW
	qQRbgNjuBf0AacWuRiLtIJDZGQ4ofaaSrNlEBGGUyDi4ru9dJiDn/ow6ICoX9Q/z
	zc6bqTdmdkw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65A064B975;
	Tue,  5 Apr 2016 03:21:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DDA454B973;
	Tue,  5 Apr 2016 03:21:22 -0400 (EDT)
In-Reply-To: <20160405063609.GB10110@yexl-desktop> (Ye Xiaolong's message of
	"Tue, 5 Apr 2016 14:36:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00186E10-FAFF-11E5-B8E5-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290767>

Ye Xiaolong <xiaolong.ye@intel.com> writes:

>       ---1---o---A
>      /    \ /
>  ---O      X
>      \    / \
>       ---2---o---o---B
>
> For this criss-cross merges, as neither merge base(like 1) is better
> than the other(both 1 and 2 are 'best' merge bases), I think it should
> be fine to pick a random one as base commit(Or you prefer to show all of
> them?) and I'll add this part of discusstion into documentation.

I think you should error out; it would give you blatantly wrong to
pick either one at random.

Suppose A is where your remote-tracking branch is, and B is where
the user started working on her serie.  We are sending patches built
on top of B (not depicted) with "format-patch --base=A B..".

If you picked '1' as the base, you'll include commits on the ===
stretch as prerequisite patches (think of any non-merge --o-- in the
picture to consist of multiple commits), but you won't be showing
what the merge 'M' between '1' and '2' did to the tree of '1' to
arrive at the resulting tree of 'M'.

       ---1---o---A
      /    \ /
  ---O      X
      \    / \
       ---2---M===o===B...your.patches.here...

If you picked '2' as the base, you'll include commits on the ===
stretch as prerequisite patches, but again you won't be showing what
the merge 'M' between '1' and '2' did to the tree of '2' to arrive
at the resulting tree of 'M'..

       ---1---o---A
      /    \ /
  ---O      X
      \    / \
       ---2===M===o===B...your.patches.here...

So either case, you cannot rebuild the tree of B by going from the
base and piling on patches in such a case, because you won't have
"patch" for merge 'M'.
