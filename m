From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odd behavior with git-rebase
Date: Fri, 23 Mar 2012 13:33:30 -0700
Message-ID: <7vvclvrrad.fsf@alter.siamese.dyndns.org>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 21:34:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBBBX-0005Az-Cy
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 21:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759885Ab2CWUde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 16:33:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756586Ab2CWUdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 16:33:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E77046C43;
	Fri, 23 Mar 2012 16:33:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fLZoCTiGbiBq8ulXbgOOzQbWhI8=; b=V7xJh7
	jXKAQN9xTQEBmUZCaD5Axk8fX1ostE1Bxda6t66oq2GDyQCTsFB4Q67aHE3ig7Lq
	2K3/gabcxAFJRCw0Wb53S+opuXNEKz/8GKk7fjm9W7CJH3FTk7loZ6ClAKpopxZs
	/+rJsND4wimldWERKuwSPmyvXYYbpu4lF2OdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yp+W61UzFubZo0BGzKGdCRNYnMI+GOsZ
	HSIvJsb0OsUzntyqJYWxCFeZ7nanBoLqcgMrWGwcAwscZxcl2mr08k6lABOSbl1S
	bcY6GbglReNsQATlcoZ6i3nFdGSh23GWeJsh2cRLhVeeo2IW+sVM46LUC5U3tvwp
	l9TDh3jsXLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E03DD6C42;
	Fri, 23 Mar 2012 16:33:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6086E6C3F; Fri, 23 Mar 2012
 16:33:32 -0400 (EDT)
In-Reply-To: <20120323185205.GA11916@hmsreliant.think-freely.org> (Neil
 Horman's message of "Fri, 23 Mar 2012 14:52:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74F2E182-7527-11E1-8C52-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193800>

Neil Horman <nhorman@tuxdriver.com> writes:

> I know that git cherry-pick allows for picking of empty commits, and it appears
> the rebase script uses cherry-picking significantly, so I'm not sure why this
> isn't working, or if its explicitly prevented from working for some reason.

The primary purpose of "rebase" is (or at least was when it was conceived)
to clean up the existing history, and a part of the cleaning up is not to
replay a patch that ends up being empty.  Even though we try to omit an
already applied patch by using "git cherry" internally when choosing which
commits to replay, a commit that by itself is *not* empty could end up
being empty when a similar change has already been made to the updated
base, and we do want to omit them.

A commit that is empty (i.e. --allow-empty) by itself was a much later
invention than the basic rebase logic, and the rebase may want to be
updated to special case it, but as the default behaviour it is doing the
right thing by not letting an empty commit into the cleaned up history.
