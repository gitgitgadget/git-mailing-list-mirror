From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git notes merge' implementation questions
Date: Wed, 21 Apr 2010 17:19:16 -0700
Message-ID: <7vzl0w730b.fsf@alter.siamese.dyndns.org>
References: <201004210957.48138.johan@herland.net>
 <7viq7ka3zr.fsf@alter.siamese.dyndns.org>
 <201004220208.03706.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:19:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4k8f-0006CG-Gv
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab0DVATY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:19:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0DVATX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:19:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD5C6AC6E7;
	Wed, 21 Apr 2010 20:19:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j/FXkJLKtF87r+ZgJT8UWukL99E=; b=TQ8D22
	ZdeZk87M+wKpb9Ir2t2PxdFfoNVzayreTDlz+exJVI3bvhLH8172tAL9IWOYRS0B
	IIZTHZxROIL4wTaiuAHD9nfC1DLcM883T0H14FlWRQ4BfeDjPPkFb4XnhKL2cKQ/
	yIVS23YORe7n6KufByCdQRTIrTidxI5tUxOnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jzyft/p6nANSphlx/zmQ5rlOnqTbps+T
	LuUkqouxSrzGtDTwgH/UewLEABjPo9CubzKAiUjR2w0Tr/7BBqr61mSI9wPz/vGc
	voTaTKkpjV5rmjyox/7HWI9wn58ctBsqdiQMpRyaJz0g5CPs48a1NzTqR71V82Jn
	A/0BiQgvMDU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7282AC6E3;
	Wed, 21 Apr 2010 20:19:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CCDFAC6DF; Wed, 21 Apr
 2010 20:19:18 -0400 (EDT)
In-Reply-To: <201004220208.03706.johan@herland.net> (Johan Herland's message
 of "Thu\, 22 Apr 2010 02\:08\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B262D5F6-4DA4-11DF-9E03-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145484>

Johan Herland <johan@herland.net> writes:

> Next, we will need to be somewhat careful about using "ls-tree", to avoid 
> needlessly unpacking subtrees that are identical between <ours> and 
> <theirs>.

My mentioning of "ls-tree" is only about what needs to be done at the
conceptual level.  In practice, assuming that notes trees have mostly the
same fan-out structure, you would run "diff-tree -r" of (base,ours) and
(base,theirs) pair _without_ anything fancy like rename detection, and
pick out pieces (one tree may have ab/cdx{36} while the other tree may
have abcd/x{36} that are notes about the same object---you treat this as
if it is a partial ls-tree output that pertains only to the different
parts, and make canonical "list of annotated objects" by removing '/'.

All of this is very specific to merging "notes" and normal "merge" does
not even want to know about it; I don't think you can avoid doing this
yourself without touching "merge" if you want to merge "notes" correctly.
