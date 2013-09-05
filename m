From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3] check-ignore: Add option to ignore index contents
Date: Thu, 05 Sep 2013 15:27:36 -0700
Message-ID: <xmqqbo46hpk7.fsf@gitster.dls.corp.google.com>
References: <20130905160801.GA22710@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Dave Williams <dave@opensourcesolutions.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 06 00:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHi1l-0003xj-L7
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 00:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302Ab3IEW1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 18:27:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158Ab3IEW1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 18:27:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF5F93F560;
	Thu,  5 Sep 2013 22:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=SAHRzNedp1RVvd9WXlEAepjy7rE=; b=aRrWFbgSE+8pzc+HPrXm
	/7TImmVSEW/PSJ81x7IlP14hOv/omytmJNksGEI6NNgcYtX1433+YDasPnZLAH+O
	bJzxTyR+9Q4EdsuixvtKFoOZQFqlp7NOvPs+IbHpqm3cNm6ZfkeEkJTI7Pv+/nR5
	bUDgpGq0jC3P/Ft0aLCttK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XFOAp64qCSE3FIp3hKvKGgaEVGSvBLG0kfok2FLuB0RCyJ
	TIEO/YLqjky2+yCndO5JghjZxVLmKTXvzgLGp6LmjIs4EfGa6hrwFd2R4BeBX2Jq
	XmSIH4u7KkGvBLya5BKGJqKcksm+bXc2hmtaETIbRLkEeAST00HUa3Tf5D1rA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B63A3F55B;
	Thu,  5 Sep 2013 22:27:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F362F3F551;
	Thu,  5 Sep 2013 22:27:39 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 603266AA-167A-11E3-9585-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233998>

Dave Williams <dave@opensourcesolutions.co.uk> writes:

> check-ignore currently shows how .gitignore rules would treat untracked
> paths. Tracked paths do not generate useful output.  This prevents
> debugging of why a path became tracked unexpectedly unless that path is
> first removed from the index with `git rm --cached <path>`.
>
> This option (-i, --no-index) simply by-passes the check for the path
> being in the index and hence allows tracked paths to be checked too.

Now the long option name is "--no-index", it makes me wonder if "-i"
is a good synonym for it, and the longer I stare at it, the more
certain I become convinced that it is a bad choice.

Do we even need a short-and-sweet one-letter option for this?  I'd
prefer starting with only the long option.

I came up with a squashable tweak to remove "-i" on top of this
patch; will tentatively queue this patch with it to 'pu'.

> In particlar Junio queried my approach in
> builtin/git-check-ignores.c that bypassed the functions that check
> a path is in the index as well as avoiding reading the index in
> the first place.

Thanks.

I think this version is cleaner without those "if (!no_index)" used
for special casing in the codeflow.  An empty index is a valid
state, in which the in-core index starts when any git program
begins.  Not reading the index should be the only thing necessary to
mimick the state in which nothing has been added to the index, and
if that is not the case, we have found a bug in the existing code.

> Regarding the test script I have tidied up the variables containing the
> separate option switches so they dont contain leading spaces, instead I
> have added spaces as needed when formatting the command line.  This
> not only improves my patch but also the existing code which was a little
> inconsistent in this respect.

Yeah, that's very much appreciated.

> Finally I have rebased from the latest commmit on master to pick up
> unrelated recent changes made to builtin/check-ignores.c and updated my
> code to be consistent with this.
>
> Hopefully I have put these patch notes in the right place now! Let me
> know if not.
>
> Dave

Nicely done.
