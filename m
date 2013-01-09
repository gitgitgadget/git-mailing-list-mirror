From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On --depth=funny value
Date: Tue, 08 Jan 2013 21:19:05 -0800
Message-ID: <7vr4lv7x2u.fsf@alter.siamese.dyndns.org>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
 <CACsJy8BLLTWd+cTBj1jNW=ODPy7=Kg4-TPUdZ82YCE-0RQpMZA@mail.gmail.com>
 <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8CA-a0=HqTY9heJBhPO4M5jyLk=tf253rRKCRuTWz5teg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 06:19:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tso4Y-0006M5-OG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 06:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024Ab3AIFTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 00:19:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab3AIFTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 00:19:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F0F8715F;
	Wed,  9 Jan 2013 00:19:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9IsCne+/B1pZOrsSqu5e/dX1KOg=; b=RIYOSJ
	mUx8ki2Xmkok2QPWiZftja+kiaaLyfTO4BAzdXDwnpOURGBBrgXbymggCuJkxsd6
	/QgP0ehS0kqfmYAn22zzBokhMIlXBgkBbO0u9pixPxgJo6LW36ZK4OExVvWGZZD3
	ptLrWhDwcwAGVVFw9JjkOk8WVZWya3G3ZYAgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IFhd0melbxyJXYyZghQ3Tjr+rOeFZjxv
	6mj4jnjI1Ph7A9LvlS5M2AcZmlRnXFXXdEkuQuGvHRReABdwgyH4wgQS6SWNzfYg
	Q8WAfDF9ydRiWfqP7FJvUZbhHEZKNEjyky+9g2UKwalpKp1+NBlDq9bZZyiV/W0y
	HfqhAvyKaDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 645FD715E;
	Wed,  9 Jan 2013 00:19:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC3B87153; Wed,  9 Jan 2013
 00:19:06 -0500 (EST)
In-Reply-To: <CACsJy8CA-a0=HqTY9heJBhPO4M5jyLk=tf253rRKCRuTWz5teg@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 9 Jan 2013 11:18:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1733E1CE-5A1C-11E2-B57B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213026>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 9, 2013 at 9:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>  * We would like to update "clone --depth=1" to end up with a tip
>>    only repository, but let's not to touch "git fetch" (and "git
>>    clone") and make them send 0 over the wire when the command line
>>    tells them to use "--depth=1" (i.e. let's not do the "off-by-one"
>>    thing).
>
> You can't anyway. Depth 0 on the wire is considered invalid by upload-pack.

Yes, that is a good point that we say "if (0 < opt->depth) do the
shallow thing" everywhere, so 0 is spcial in that sense.

Which suggests that if we wanted to, we could update the fetch side
to do the off-by-one thing against the current upload-pack when the
given depth is two or more, and still send 1 when depth=1.  When
talking with an updated upload-pack that advertises exact-shallow
protocol extension, it can disable that off-by-one for all values of
depth.  That way, the updated client gets history of wrong depth
only for --depth=1 when talking with the current upload-pack; all
other cases, it will get history of correct depth.

Hmm?
