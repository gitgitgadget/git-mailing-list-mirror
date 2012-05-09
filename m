From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Large repo and pack.packsizelimit
Date: Wed, 09 May 2012 10:30:11 -0700
Message-ID: <7vlil1tg7w.fsf@alter.siamese.dyndns.org>
References: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net>
 <20120508203137.GA15707@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205081709010.21030@xanadu.home>
 <20120508212012.GA20044@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205081751011.21030@xanadu.home>
 <loom.20120509T113505-740@post.gmane.org>
 <CACsJy8BhSn+PB5tXME-w_cq4DVd2BULNRNLV-vk1_6yWKy+fNg@mail.gmail.com>
 <loom.20120509T131228-943@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Wed May 09 19:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSAiU-0002Uv-P7
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760521Ab2EIRaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:30:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760509Ab2EIRaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:30:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C2526568;
	Wed,  9 May 2012 13:30:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XxvNuaUtyp9iFeqHtA99dCMiBpI=; b=CGzTws
	J4afNe4ouOR1rE1I4GWnYo5+yO0O6tMOayZChvOaSoeXsEwTKXA03GbZNB7U8pFi
	lguFset/E8lrG8cbG7xr4niy8D0YfKv7/Rh04HmtAfSKQaLDF7N6zUko2JXV1sN7
	huxqg2xA9AdSstYnIcRQo4XtuRwy3haUdeh14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XlvBzzOUdkG1PdinXYT0qBT/CrLCGnZV
	6p6dV0mbzWmNZepCLAiUfOPEYgFhK+FMOzD5UVfZjZiMjCUWIdCqJcmC7e5o/Ko1
	Svj+UGtyUCXRXTPp6kozEr1mMEqh+r00NQQe6ASfl6XnvWGfR+jqDWS2OwpBFyuY
	g1NnPbe98Co=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 140C56567;
	Wed,  9 May 2012 13:30:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BF716564; Wed,  9 May 2012
 13:30:12 -0400 (EDT)
In-Reply-To: <loom.20120509T131228-943@post.gmane.org> (Thomas's message of
 "Wed, 9 May 2012 11:46:13 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1F56192-99FC-11E1-A197-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197481>

Thomas <th.acker66@arcor.de> writes:

> (1) all objects to be transferred to another repo 
> (2) all loose objects when starting a local repack
> Case (1) can be fixed by transfer.unpacklimit but there is no fix for (2).

Technically (1) is putting everything in a single pack to transfer, and it
is only the receiving end that does the chopping.

For (2), you could do something like

	keep=$( git rev-list --objects $some_rev |
	        git pack-objects --delta-base-offset pack ) &&
	mv pack-$keep.pack pack-$keep.idx .git/objects/pack/ &&
	echo "keep $some_rev" >.git/objects/pack/pack-$keep.keep

after finding a suitable $some_rev that is old enough so that it will be
an ancestor of anything that matters in the future and gives small enough
packfiles.  You may want to try doing the above multiple times, by picking
a few strategic ranges, e.g.

	for some_rev in v1.0 v1.0..v2.0 v2.0..v2.4 v2.4..v3.0
	do
		... the above four lines come here ...
	done

The objects stored in .keep packs won't participate in future repack so
your "git repack -a -d" after that will put everything that is needed only
for versions newer than v3.0 in a single new pack.
