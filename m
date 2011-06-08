From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Wed, 08 Jun 2011 09:50:23 -0700
Message-ID: <7vhb802row.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>
 <BANLkTiksHRmp102XDJP5+-CLGj8hZXUR=g@mail.gmail.com>
 <1307548930.19438.30.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Harris <git@peter.is-a-geek.org>, geoffrey.russell@gmail.com,
	git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULxp-0000a9-PO
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab1FHQug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 12:50:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1FHQug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 12:50:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 398FE5819;
	Wed,  8 Jun 2011 12:52:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JhdZu2iw5JNxkkQpbS7Nh8774wE=; b=gcPO8g
	nckvarayCfyjwDgYkEXQm+bYcSOSwxi+NLaoZl+gqMLQhLUmT2DYLUu0NYHxGCye
	C/93eg5wkd5oRLqDUSiNujNim5qaJmHVXBczxl8z/V59sk5O/stLLIhUBS1BQRzC
	4OAtt3lTjFaGO23BrHfNG1frUMWSS3GLxC2ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ot6JskesvscHcBZepljJpiTSDPtw5T0D
	dUlJuyVoViWZy9BpWt6TV/SJXq6iGtTHT0akeunLIwrG4L71DzueYEjr2CrFOC/P
	wO5HClqjTcvaDKdBvR0UjPSpRV8mOgkoxL0FCU6e4/5TSEAoLL0WNyuz810pPGqd
	o0UUDbCfUl8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E992F5816;
	Wed,  8 Jun 2011 12:52:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9266857EF; Wed,  8 Jun 2011
 12:52:35 -0400 (EDT)
In-Reply-To: <1307548930.19438.30.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Wed, 08 Jun 2011 12:02:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9089D2E-91EF-11E0-9600-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175399>

Drew Northup <drew.northup@maine.edu> writes:

>> That's why. See gc.autopacklimit in "git help config" -- by default,
>> git will gc if there are more than 50 pack files.
>
> Do we want to consider ignoring (or automatically doubling, or something
> like that) gc.autopacklimit if that number of packs meet or exceed
> gc.packSizeLimit? I have no idea what the patch for this might look
> like, but it seems to make more sense than this situation.

This is unrelated to the auto-gc, but it also would be fruitful to
question if it is a sane setting to limit packfiles to 30M, when the
repository needs 100 of them (total around 3G??). Just like having too
many loose object files degrade performance (and that is one of the
reasons we pack them in the first place), having many packs will degrade
performance unnecessarily and to a worse degree, as "check which pack has
this particular object" code has to examine all packs, unlike the loose
object case where we let the .git/objects/?? fan-out to give us some
hashing and the filesystem to do the heavylifting for us.
