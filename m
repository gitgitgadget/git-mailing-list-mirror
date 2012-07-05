From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] Teach rm to better handle submodules
Date: Thu, 05 Jul 2012 15:10:53 -0700
Message-ID: <7vliixrh8y.fsf@alter.siamese.dyndns.org>
References: <4FF4AAE7.40604@web.de> <7vpq8brq7y.fsf@alter.siamese.dyndns.org>
 <4FF5E5A6.7000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 00:11:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmuGM-0005YE-8O
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab2GEWK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:10:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756647Ab2GEWK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 18:10:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 901C489C5;
	Thu,  5 Jul 2012 18:10:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/93y1JyEN3z9BLHG2ueYX6htZes=; b=HJY158
	su05waDp5lEhnJnuVYBzAMer862a1xNX4PZZZC3DhiwF79wflscq5z2cxKXFJrSL
	9seComjeFQJf6S/V8uBlokHYYuAsmn8qlYBc+74hZr1gLUaAyPg2p5/vlIgCi49G
	DdVJOE+31xvaBw41MtUSXKwY7TfdVUGKWlEDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=afqlHf7+xrralTCHuOSdXyxd5apMvMC+
	sIyDu1kF9o7yCG6ylfG1gkhGFeLqhp2C7l8nRyZUrYKPbz4BcjBgkRla4TFAJs6Y
	6jzfHx6+189SiNpGCnflyrQ3haOCZGKJGZqk8qvvgQ0FStWmKm02aVR4cUWH0ycR
	2IkigrcyxW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 874BB89C4;
	Thu,  5 Jul 2012 18:10:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0694389C2; Thu,  5 Jul 2012
 18:10:54 -0400 (EDT)
In-Reply-To: <4FF5E5A6.7000506@web.de> (Jens Lehmann's message of "Thu, 05
 Jul 2012 21:06:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A63A398-C6EE-11E1-AD4E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201062>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 05.07.2012 02:44, schrieb Junio C Hamano:
> ...
>> I wouldn't claim that I have thought things through yet, but in
>> general my instinct tells me that it is a bad idea to try pushing
>> down "submodule management" related bits to the core.
>
> Am I right assuming you are only talking about 2/2 here and not
> about the bugfix in 1/2?

I was addressing the general attitude, expressed in your [0/2] cover
letter, of eagerly attempting to push down to the core side what
could be affected by non-core policy, namely, things like what is in
".gitmodules" and how the working trees and controlling repositories
of submodules are laid out (cf. the other thread on GIT_WORK_TREE
and GIT_DIR used for the top-level superproject).  The comment was
not about either of the two patches.

When making a project-wide structural change to the superproject by
adding a submodule, "git submodule add" is used to add optional
information in .gitmodules, because where the other people would
clone the history for the submodule (or if there is a place for
other people to fetch it in the first place---a private standalone
project does not even need one) is not something the core "git add"
is not interested in.  Ceasing to use a submodule project wide (the
use case (1) in the message you are responding to) by removing the
submodule tree and an entry in .gitmodule for it is the same kind of
project wide structural change, and it felt very out of place, at
least to me, to have "git rm" do anything with .gitmodules file.
