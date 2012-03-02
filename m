From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] index-pack: support multithreaded delta resolving
Date: Thu, 01 Mar 2012 22:09:45 -0800
Message-ID: <7v4nu7ilee.fsf@alter.siamese.dyndns.org>
References: <1330403813-2770-1-git-send-email-pclouds@gmail.com>
 <1330403813-2770-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 07:09:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Lgi-0007LG-5A
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 07:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791Ab2CBGJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 01:09:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754Ab2CBGJv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 01:09:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 030776D28;
	Fri,  2 Mar 2012 01:09:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DAEPq7HF8POqjBnHQN6FzFNsmS0=; b=XFD9Z+7r4lKYViQlKWw3
	NHcd+Gui4Ni1iirFKOyZCHpjpKcKnBDtBxyVHXvChZxrOl1EmPvsdIT4jdCmeMDi
	tJ9keymNHxV9ovxeQ0fcJOWoCI8X2mbEld+wKO9FS9/yJVGkltyd3MfD+EguYSxk
	dumQ94+Cx7wijVcAjeYImKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Np0gse3weqjzVSER2LsfiL+n2Kzu/2gXqzrMDDoh7E8jYU
	EQG0GXLj/TCip7QT3CKU1iTfyns66Am4jmXJW0UibyrDHGIHk+sA8iMKYPS9KRnQ
	eG4WFxUQaVQc7qST4lgaecXEbRTFCbBbqd6YM40rc33C6eIS6evnQBWr4sOSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE2C76D27;
	Fri,  2 Mar 2012 01:09:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CEA66D26; Fri,  2 Mar 2012
 01:09:47 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 503C4A54-642E-11E1-B991-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192003>

When applied to 25a7850 and then merged to 'pu', the result fails to
correctly produce pack .idx file.

I spent an hour or so this afternoon, scratching my head, staring at the
output from tests added to t5510 by today's tr/maint-bundle-boundary topic
to see where it breaks.  Its last test creates a bundle that has three
objects, extracts a pack from it, and runs "index-pack --fix-thin" on it.

This topic makes it fail with "fatal: pack has 1 unresolved deltas".
