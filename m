From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Wed, 02 Jul 2014 10:09:45 -0700
Message-ID: <xmqq8uobit5y.fsf@gitster.dls.corp.google.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>
	<vpqoax8m8bh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:10:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2O2k-0007kY-HC
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbaGBRJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:09:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53182 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670AbaGBRJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:09:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C483822EB6;
	Wed,  2 Jul 2014 13:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XM1w/fd3gWwrGBYdkxbMSv5XOrQ=; b=unDlXE
	tJPCnLe37tWJrIAEfjxtQW3pFhocsmYXSGrU3tpAos1bDecex+W3Uh2eO0FG/riR
	cjUC6zmdk9V+i7RwLDHN8JCDYt2TMGlpf1CEm6ppjoMDokKXoiqWebriYvQf53HT
	CJThyx0KZhOIM3S2QRsRnAaISTBKijmjlryiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T2m9FPKzcW0GlRaGDa04OHmnb0lP75is
	3PIwVmpjELmh9doNgUTI/4+HypEPfomBVoLgaLYt+g7Bt/ffUmLHdyl6DNZTP3ux
	booxPgKy72LEhXTYE7z1dhp/h3rWRKO5HbzanHMx4A45n0H/VEx/rK5iVYOcT3z5
	pIFSECdN8Fw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBA4922EB5;
	Wed,  2 Jul 2014 13:09:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D660622EB1;
	Wed,  2 Jul 2014 13:09:35 -0400 (EDT)
In-Reply-To: <vpqoax8m8bh.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	02 Jul 2014 11:14:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A4B0D03C-020B-11E4-AF87-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252799>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I don't like the name "the_config_set". It's not the only one. Perhaps
> repo_config_set? (not totally satisfactory as it does not contain only
> the repo, but the repo+user+system)
>
> What do others think?

I actually do like "the_configset", which goes nicely parallel to
"the_index".  Neither is the only one, but most of the time our code
operates on the primary one and "the_frotz" refers to it (and
convenience wrappers that does not specify which set defaults to
it).

> What is the reason to deal with `the_config_set` and other config sets
> differently? You're giving arguments to store `the_config_set` as a
> single hashmap, but what is the reason to store others as multiple
> hashmaps?

Confusion, probably.  "the_configset" should be just a singleton
instance used to store the values we use for the default config
system, but its shape should be exactly the same as the other ones
users can use to read .gitmodules and friends with.

> And actually, I don't completely buy your arguments: having 3 or 4
> hashmaps (.git/config, ~/.gitconfig, ~/.config/git/config and
> /etc/gitconfig) would be a O(4) lookup, which is still O(1), and you
> could deal with include directives by having ".git/config and included
> files" in a hashmap, "~/.gitconfig and included files" in a second
> hashmap, ...

OK.

> I would personally find it much simpler to have a single hashmap. We'd
> lose the ability to invalidate the cache for only a single file, but I'm
> not sure it's worth the code complexity.

OK, too.
