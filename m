From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge priority
Date: Thu, 26 Nov 2009 11:47:12 -0800
Message-ID: <7vmy295arj.fsf@alter.siamese.dyndns.org>
References: <26ae428a0911260444j45437a92r47d7f2e8b292829e@mail.gmail.com>
 <81b0412b0911260742l4beb2305y87c01dd61d7c2b57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 20:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDkJP-0004Pq-Sh
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbZKZTrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZKZTrS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:47:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbZKZTrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:47:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF308A1B0D;
	Thu, 26 Nov 2009 14:47:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=FClwJ0NFTtVgeEdfzMgpkBhglMI=; b=u8jOQaW32sGsGpic1YkMhTi
	F+iQ7K6XSXiwT3vSjK1qqw61PFL/94IHjLVUzlBIchAyzAdECT2FVTx7cbhcNYGm
	w/WQWjd2/Hptaz9STJR+0h0C96fHc2lrewDQH9Wryl25Zi0l4myriwpaQ4dCm96Q
	h1Ww42bzZQlX4vm5KF7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HMcY0xUUqu02tUw2ESqDhXe0FjPHIRATxkGSkxDzOxBa6Q2iA
	DNeT66KCGGH1KuSxS0T8BsxFRmDNXcQx0gLIduz3QnIatjJAb6/zEe+YqEhqc7Ko
	/caA0fwRBA0xsdAhJVWak3dJ2c2yd0bgfuA8dkBSrTXArjzeDnVz1LjZTM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 800B1A1B0C;
	Thu, 26 Nov 2009 14:47:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 48CB3A1B0B; Thu, 26 Nov 2009
 14:47:13 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81434508-DAC4-11DE-B2F0-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133826>

Alex Riesen <raa.lkml@gmail.com> writes:

> You can take a look at rerere, though. It should help resolving repeating
> conflicts  by recording a resolution of your choice.

Use of rerere often helps but there is a caveat.

Even if two branches (e.g. 'master' and 'maint') currently has the same
tree, the desired outcome of merging the same commit into them could be
different depending on the purpose of these branches.  You may want to
resolve a conflicted merge into 'maint' more conservatively than the way
you would resolve the exact same merge into 'master'.

Imagine a case where 'master' branch added a better helper functions in
other files, but they are not in 'maint' yet, and the conflicted part
could be resolved better if you made it call these newer helper functions
available only in 'master'.

Unfortunately the conflicts would look exactly the same to rerere, so if
you record the result of the merge to 'master', replaying that resolution
while merging the same commit to 'maint' would produce undesirable result.

As to "does the aggregated result make sense if you blindly add changes in
'stable' for only conflicted parts to an automerge result?", which was
your other point, you may refer your readers to Avery's recent updates to
resurrect -Xours option to "git merge".
