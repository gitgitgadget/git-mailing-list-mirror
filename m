From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/1] git-clone: fix relative path problem in the
 alternates
Date: Mon, 22 Aug 2011 12:10:12 -0700
Message-ID: <7v7h65w9d7.fsf@alter.siamese.dyndns.org>
References: <1314003957-9455-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 21:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvZt7-0006za-NN
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 21:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab1HVTKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 15:10:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab1HVTKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 15:10:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86D874948;
	Mon, 22 Aug 2011 15:10:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eT2mjTifSpofAzoujlWuh4NxuD8=; b=mmff5n
	AsgC0qkek+sZ5F6aTRiYfPPHWda0V49tv5DCXy+dKyfHA4yu3N9HOGXjtgcQUHLl
	wYbt23ogvdW80i4Uaroa80Tv49Rb027LneYSJTph/QDjsIKDdn93f2IjP6nQ2UFa
	ays47NXlMCGh+TYhBirRrgTgmFvLpHKtgIcRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GFX5Ou2FfkUKvkYS+J59gmGvA7zcNv5A
	JDRkaVNTmLTwbTEyV55ARtFCYp07Yv2Yr+yM96pQhBuxbm9JyDXXnf2et9ICDYYx
	x+FNtxtZ0pfeOv+DjdJ7N8Z+uxtE6NLxfpnqIASCAj/c1y0mpIjzTSPYNrb1hU9I
	LOErHLI/J0k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E7E24947;
	Mon, 22 Aug 2011 15:10:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1628E4946; Mon, 22 Aug 2011
 15:10:13 -0400 (EDT)
In-Reply-To: <1314003957-9455-1-git-send-email-jason77.wang@gmail.com> (Hui
 Wang's message of "Mon, 22 Aug 2011 17:05:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D537416-CCF2-11E0-8A22-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179881>

Hui Wang <jason77.wang@gmail.com> writes:

> 2. current git system only provides add_to_alternates_file()in the sha1_file.c
> to update lockfile, this function can add a line to lockfile but can't empty
> and write lockfile,

I do not see the need for "empty and write" in the first place. You are
spending cycles to go through all the lines in the input, inspecting and
holding the replacement somewhere, it is a one-time cost for cloning, and
the alternates file wouldn't be humongous anyway, so I do not see the need
for "we don't touch if there is no relative path in the file" if it makes
the code more complex than a stupid "one line at a time" approach.

> 3. current existing add_to_alternates_file() will unconditionally append
> "/objects" at each new added line, that need us to parse and  remove
> "/objects" from each line read out from source alternates, this is a little
> bit complicated.

Clone with --reference is the only other caller of that function; I would
say it is perfectly fine to make it the caller's responsibility to append
"/objects" if that makes the resulting code easier to maintain.
