From: Junio C Hamano <gitster@pobox.com>
Subject: Re: switching branches when they use different submodule remotes
Date: Fri, 08 Apr 2011 13:45:01 -0700
Message-ID: <7vei5c322a.fsf@alter.siamese.dyndns.org>
References: <p0624080dc9c4f8ff178c@[192.168.1.122]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:45:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8IYT-0005Sh-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab1DHUpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 16:45:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757841Ab1DHUpN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 16:45:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 816665387;
	Fri,  8 Apr 2011 16:47:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SSSk60bvLAWgfrW9Qvpnp4kjJic=; b=Sl3ODP
	0pf0Hr3fa5YB51ixDyjK4eKDRsVPCXElUdVWZ6cA4hm4+I7W73TWjWM0qvP0qduF
	EjCjZzTbzYnmE8WSXhqgsKG0+XzZEb2gDA5H4hetAMoX7KSAWqCXLRzUL0C4u0jr
	uRdKQ/PJiBXZfsGu96RYYYW/P8GEIWfuAHvNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XY96TVTFVhKJHLDH6KUqrcrtotdxEMXR
	IGg+OLMbyTj6SlvEzxbnD2dmfRFRJjV8qz7/+1JttP/hASwvGiLapsuKAGOW7vvk
	OaStgIKj37d768aMotGuKexHUJc+tBmkfu99GobI16y35FV4f48RFKjEzuPrC7rz
	0AzfPEzbMh0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 494E15386;
	Fri,  8 Apr 2011 16:47:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4FE7D5382; Fri,  8 Apr 2011
 16:46:59 -0400 (EDT)
In-Reply-To: <p0624080dc9c4f8ff178c@[192.168.1.122]> (Stephen Bannasch's
 message of "Fri\, 8 Apr 2011 13\:52\:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B0DABEA-6221-11E0-A1DA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171162>

Stephen Bannasch <stephen.bannasch@deanbrook.org> writes:

> it made it clear that executing init does not alter existing
> information in .git/config so I deleted the reference in ./git/config
> manually and started over.
>
> Is there a better way to handle this?

Perhaps "submodule sync"?

There are at least two different scenarios where you may have multiple
URLs for a given submodule path.

 - These two URLs may represent two projects with different histories, and
   depending on the commit that is checked out, your superproject may want
   to use a URL for the repository that appears in .gitmodules that is
   checked out.  "submodule sync" would be one solution for this case.

 - These two URLs may represent a single project but the repository
   migrated and the old URL may not even work anymore.  In such a case,
   even when you checked out an old commit of the superproject, you do not
   want to use the old and now decommissioned URL in the .gitmodules file.

There can be combinations and variants of the above two.

In very early days of "git submodule" Porcelain support, there were a lot
of design discussion taking these two situations into account.  I don't
recall the details, but the core idea was:

 - record a tuple <the value chosen by the user, the value the user saw in
   .gitmodules when the user chose the value> in .git/config;

 - when .gitmodules has a value that the user has not seen, ask the user
   what to do. The user may want to use the value recorded in .gitmodules,
   or may want to use the value already in .git/config.  This would result
   in a new tuple <the value chosen, the value in .gitmodules> recorded in
   .git/config;

 - when .gitmodules has a value that the user has seen, use the
   corresponding value the user chose to use.

which would have solved both use cases; unfortunately, nobody has been
inclined to implement anything like that so far.
