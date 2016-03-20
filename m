From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Properties of trees referencing commit objects (mode 160000)?
Date: Sun, 20 Mar 2016 15:30:27 -0700
Message-ID: <xmqqk2kwok8s.fsf@gitster.mtv.corp.google.com>
References: <20160319221348.GA5247@x>
	<20160320041803.GC18312@sigill.intra.peff.net>
	<20160320184524.GA16064@x>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 23:30:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahlrm-0006cG-Qy
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 23:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbcCTWab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 18:30:31 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750942AbcCTWaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 18:30:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F0B94D349;
	Sun, 20 Mar 2016 18:30:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHn57fvu9LNThK8BA0lmkOGcreE=; b=k3aEL+
	Iz4LA7NEeCOXG1MGMxNMx/qsv2rzPIDYEMYZd+bo+5yZULDWIMtmpWmhrolYh0pj
	JBb2m/aPTeuodEzXj9o9ANVT2k9N6HRLmdiRXm/WOmjV9CfvJTatXKyV/HYIiK8f
	GlMW3CdtM9zfvwKKWzzDobFct/oW4szImmJ2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2gbuegbpGUeQWdaSTfMbk/iORryoxlr
	K1i3gDeeWlgF2ouTiQt4Ez+hXk9+UGmnioAvciphcvHLHKcW3w3zgkvgi+5o49cT
	kYdqD/e1B/qvVJnQAR/FcFPlb3RBpGSottfugzIe1S5vAewUvU4dSgso8+htE9FT
	OSt+OAbUJFM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65FCB4D348;
	Sun, 20 Mar 2016 18:30:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D85624D347;
	Sun, 20 Mar 2016 18:30:28 -0400 (EDT)
In-Reply-To: <20160320184524.GA16064@x> (Josh Triplett's message of "Sun, 20
	Mar 2016 11:45:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5961EDEA-EEEB-11E5-913A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289388>

Josh Triplett <josh@joshtriplett.org> writes:

> On Sun, Mar 20, 2016 at 12:18:04AM -0400, Jeff King wrote:
>> On Sat, Mar 19, 2016 at 03:13:48PM -0700, Josh Triplett wrote:
>> 
>> > I'm building some tools to track commit objects, and I'm thinking of
>> > using submodule-style references to commit objects in tree objects (mode
>> > 160000) to do so.  I'm trying to figure out some of the properties of
>> > that.
>> > 
>> > Can a commit object referenced that way live in the same repository,
>> > rather than some external repository?
>> 
>> Yes, it can be in the same repository, but...
>
> Will git clone/checkout/etc handle it properly in that case, in the
> absence of a .gitmodules file?  Or would it only work with custom tools?

That depends on the definition of "proper".  The default "proper"
way for the core Git for submodules/gitlinks is to create an empty
directory.  If you want to populate a working tree for that, you'd
need "git submodule" support, but because you are writing "some
tools" on your own, there probably is a reason why you do not want
to use "git submodule", so I am guessing that your definition of
"proper" does not match either core Git or "git submodule" considers
"proper"?  In which case you would need to implement your own
semantics (you may not even want to have an empty directory there,
for example).


>> No, we do not follow "gitlinks" like this for reachability. Neither for
>> pruning, nor for object transfer via push/fetch. So you'd need to have a
>> separate reference to it (or history containing it).
>
> Argh.  If I have a pile of disconnected commits, is there anything git
> *would* follow to see them, other than a pile of refs?

No.
