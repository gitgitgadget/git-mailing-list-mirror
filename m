From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make is_gitfile a non-static generic function
Date: Tue, 11 Oct 2011 16:26:20 -0700
Message-ID: <7vsjmzcdpf.fsf@alter.siamese.dyndns.org>
References: <4E94C70E.3080003@cisco.com> <4E94C8AB.3040807@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 01:26:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDliO-000636-D0
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 01:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab1JKX0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 19:26:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab1JKX0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 19:26:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EA9F50FD;
	Tue, 11 Oct 2011 19:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pnWc74JJSw/K8FhaiqtGntz6i+A=; b=kcwGLP
	fkhsscAmH6Sovfps1lMcInDRClssMg3J4MzFLUdWag78rtn9Awj4btTU8Wwa5RW4
	WWtapRS2zo31xtnflS1WjuZXpFhoBJ7jpceQRCMv1xAMsvxGlhxDyc4q99ETdnYb
	9lDV4WlR+8ChTPqom2/ftCBt3VAQ3YDqFe0kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s44hf4cuG2NSD/JVRoz98XJGh1I+N190
	rxzpmgqKtarmBIMqfAs1Z0dz12NAXIeiUPxVaww/aKbwISywDK8idt2voD7HoLxw
	el5dQkJfcQkxWiKKZr7H6ktLwqEWJJHiCkn9FXvqAkF6c+q5CaAU6ZHZBa542Soq
	N+NqKgEIMos=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54E8650FC;
	Tue, 11 Oct 2011 19:26:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFA6050FA; Tue, 11 Oct 2011
 19:26:21 -0400 (EDT)
In-Reply-To: <4E94C8AB.3040807@cisco.com> (Phil Hord's message of "Tue, 11
 Oct 2011 18:52:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DEAF43A-F460-11E0-AD43-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183347>

Phil Hord <hordp@cisco.com> writes:

> I'm not sure this function belongs in transport.c anymore, but
> I left it here to minimize conflicts.  I think a better home would
> be path.c, but maybe not.  If someone has a preference,
> please let me know.

I would think either transport.c or setup.c is more appropriate than
path.c; the last one is more of "pathname manipulation utility bag of
functions" and does not have much to do with the "Git"-ness of the path
they deal with.

I am not sure if is_gitfile() is a good name for a global function,
though.  Also I think the interface to the function should be updated so
that the caller can choose to receive the target path when the function
returns with positive answer, making "read_gitfile()" unnecessary for such
a caller.

As a matter of fact, couldn't we somehow unify these two slightly
different implementations around the same theme, making is_gitfile()
function unnecessary? As far as I can tell, the only difference between
these functions is how they fail when given a non-gitfile, and many
callers just call read_gitfile() without first asking if it is a gitfile.
