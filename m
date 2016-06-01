From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 48/49] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Wed, 01 Jun 2016 10:23:30 -0700
Message-ID: <xmqq8tyozuul.fsf@gitster.mtv.corp.google.com>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
	<20160524081126.16973-49-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 19:23:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89rr-0006qd-Kx
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 19:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbcFARXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 13:23:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751624AbcFARXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 13:23:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F8D82140F;
	Wed,  1 Jun 2016 13:23:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z8jD4OSuuh+0C/fCUE7s+WdT91I=; b=kUPNCc
	cq2IZym14qyVhdHqYAdiDUvV9IsEwNKDgOxoQhRGX+C/ojiQSfSCW3RCv8Jv7ubH
	/dSyTA3A6G36cXP3GUlShHMw3QW2z+NlRe+OQuJt8Y6nOYkq21k9EL5p+4rJEjpF
	cbvs+gSJAI3DC+DC5/IjlxAf1CEeafZRPmykA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Am/JeuhLTke9vp262oR0JHYLHBJ/5QBz
	tI5Iy1tCIMdOpOHIKPrmuGHoCoCBTBkujfbWzEcW0VjRF1K7po54FL0YQE6nfTIo
	rGB2v6o9i6MeLQQ9bsTyYYY4GZ6D0/+mUycveR0AiDVNJrXMGnvOQ++yFXKUa03N
	2ho1pV/5bVI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55F422140E;
	Wed,  1 Jun 2016 13:23:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C692D2140D;
	Wed,  1 Jun 2016 13:23:31 -0400 (EDT)
In-Reply-To: <20160524081126.16973-49-chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 24 May 2016 10:11:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90256D96-281D-11E6-92C9-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296136>

Christian Couder <christian.couder@gmail.com> writes:

> We cannot have a 'struct lock_file' allocated on the stack, as lockfile.c
> keeps a linked list of all created lock_file structures. So let's make the
> 'lock_file' variable a pointer to a 'struct lock_file'

Good.

> As the same instance of this struct can be reused, let's add an argument
> to init_apply_state(), so that the caller can supply the same instance to
> different calls.

Good.

> And let's alloc an instance in init_apply_state(), if the
> caller doesn't want to supply one.

This is questionable.

> -static struct lock_file lock_file;

I'd rather leave this as-is, and pass the pointer to it to
init_apply_state().  For the purpose of "cmd_apply()" which is the
first user of the "(semi-)libified apply API", that reads a single
patch and applies it before exiting, that is sufficient.

As to the "if the caller does not want to supply one, we will
allocate one that will definitely be leaked", I am mildly opposed.

By making it the responsibility of the caller, whenever a new caller
of the libified apply API is written, those who write it is _forced_
to think about not leaking the lockfile structure, which is a good
thing.

Other than that, all 49 patches look sensible to me.

Thanks for working on this.
