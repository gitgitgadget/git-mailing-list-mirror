From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Wed, 03 Aug 2011 18:48:23 -0700
Message-ID: <7vaabq6j6g.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <7v4o1y81sv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 03:49:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qon3h-000772-AX
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 03:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab1HDBs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 21:48:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755944Ab1HDBs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 21:48:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5F814A6E;
	Wed,  3 Aug 2011 21:48:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KkUtQgJKGrYShfBocl8ZtS2dlTc=; b=Jr8+vo
	vE2G4BHtu+SXHByEAridkwyR1bKpztmfD9LnW0QCRGIDPTBrw6dtY9K/Wx5jvlnG
	/lAydlmDFI6vHKqWBWm0Uiat7gTv4LO0Ols/VVT2ZBuKDpM9aUez/ZDnGdDzu5sA
	G+fU9xNCaORXYcCaGr14c91i6j3/b8w5ZwBNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r+W/I3j+OUZV8lCXd/Yvh9FlcKe/8EyB
	jZP0cd23Gtui4thtiSsmrZUB42ObWGpxU9N4XO0N3rYAMRVpvp69pGVKHIazPbI0
	dBmqGSPFR1R8SURrVraLUcyTjODiVAmbZTRfn61YgPC3+5/IsWCe1V0Ki9fMPvhA
	t67XfjFtyAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADC4E4A6D;
	Wed,  3 Aug 2011 21:48:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D0C04A6C; Wed,  3 Aug 2011
 21:48:25 -0400 (EDT)
In-Reply-To: <7v4o1y81sv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 03 Aug 2011 17:20:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7B7C8F8-BE3B-11E0-B828-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178650>

A very simple reproduction recipe.

-- >8 --
#!/bin/sh

mkdir en && cd en || exit

git init

echo 1 >one
git add one
git commit -m 'origin'

git checkout -b side
git mv one two
git commit -m 'side renames one to two'

git checkout master
echo 2 >one
git add one
git commit -m 'master updates one'

git checkout HEAD^0
git merge side
-- 8< --

Tonight's "pu" fails like this:

$ git merge side
error: addinfo_cache failed for path 'two'
Merge made by the 'recursive' strategy.
 one |    1 -
 two |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)
 delete mode 100644 one
 create mode 100644 two
