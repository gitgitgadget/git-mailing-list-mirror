From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Thu, 24 Jul 2014 12:54:24 -0700
Message-ID: <xmqqlhri8rdb.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
	<vpqlhrjqmyw.fsf@anie.imag.fr>
	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>
	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr>
	<xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>
	<53D15EB4.1050303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:54:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAP65-00032f-Ve
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 21:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934451AbaGXTyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 15:54:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63030 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934176AbaGXTyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 15:54:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41E922B396;
	Thu, 24 Jul 2014 15:54:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NTEv1tCov65l3W/J+8Uyuk5mjLk=; b=YbW1cT
	17wWHHaD/5yw/m1JyRIJv3e92dywAcv3NsiViZTufeQQhBKCeIqjwGGMpXj2S7Xd
	+17lC2iP8/sszNrQTwd1/dPhpMZUGf8jjUN75BPyDBN2nEaRTbdaLn7gkR8xNI2N
	JdImUzZSB5W09lbyHjrMbgM2V/C94xOP0K0UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pXNf+UcIGvVUltzbfDBslX0YA5NqrV7J
	V/bYjbS7mgGnZtXIn8TkH/zt/TTkgLuVN+0kBzBYWUDs8bnkgP7Fme7Us1RaK+4j
	hhElG5hYzrlYENVh0f+YtCl6fTniwIGwng3/qlcD+VoyKNOY535ynjCv3Wq9+E+1
	ROcrvOcO/Y4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3629B2B395;
	Thu, 24 Jul 2014 15:54:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 128372B38D;
	Thu, 24 Jul 2014 15:54:26 -0400 (EDT)
In-Reply-To: <53D15EB4.1050303@gmail.com> (Tanay Abhra's message of "Fri, 25
	Jul 2014 00:59:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 50CBDE4A-136C-11E4-A7BA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254183>

Tanay Abhra <tanayabh@gmail.com> writes:

> If we take the easy way out, fixing UI mistakes would be easier,
> just replace git_config_cache() with git_config_raw() for such cases.

I do not think that would fly well.

The kind of "let's migrate funcname users to xfuncname while still
supporting the old uses" change will be done in the callback
functions like userdiff_config().  But it is very typical that
multiple config callback functions are cascaded (e.g. many
eventually end up calling git_default_core_config()); in order to a
workaround you suggest to help a callback in deep in a cascade chain
would require you to see which ones among all the callback functions
will eventually call the callback you are updating for migration and
update all git_config() calls to git_config_raw().

If you fix it properly (assuming it is feasible; I haven't heard if
you even tried to see how much work it would involve), you do not
need to introduce "git_config_cached()" (or "_raw()" for that
matter), which is a huge plus.  git_config() would instead do the
right thing automatically, giving the same semantics except that it
does not read the same file twice when it is known that the file has
not changed.

I can understand "If we take the easy way out, we do not have to do
much".  But it would not make it any easier---it essentially closes
the door for "oops, funcname is error-prone; let's give people
xfuncname" type of migration.
