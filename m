From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Localization: Timestamps get wrong if using different locales
Date: Sun, 05 Aug 2012 13:47:27 -0700
Message-ID: <7vmx292hi8.fsf@alter.siamese.dyndns.org>
References: <501E3828.40708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Miebach <christoph.miebach@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 22:47:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy7jd-0006AY-AG
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 22:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab2HEUrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 16:47:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50387 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936Ab2HEUra (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 16:47:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E151B85D8;
	Sun,  5 Aug 2012 16:47:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ykv6EHXLyPSONz/aQUIADWHla0s=; b=MZZIIG
	teVtN1ktFpYe1nUY2ahtFrsDM82IFX8phBTQgIPA9IT69Eg2RDvsFYrrfHNxcfKD
	TtYfCIsLzXl9zO/QBRKI6G9+3dJGP5kgnQtsNWab/IGdCw07bgkrpPwp1JI53oew
	+opRhtRWxwTUFfAlNXwetpW8lDPbV8ZoYlkiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tDLS8V5TQf4GvN6sI2VAHltsCjFtOEY0
	h62/W8DEk3jlQ2TvOMtol3OTI3uYZmgt9Vt0PR7O+ogoSLIdJZ1dPOnBLb85edGz
	AAyP3ks9jyVlEfhejewZd18R675kiY6H98w0KzBKIkcN8wf+zR1hux+AgykebiV1
	N8HSjz4/JqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF85085D6;
	Sun,  5 Aug 2012 16:47:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33F8E85D5; Sun,  5 Aug 2012
 16:47:29 -0400 (EDT)
In-Reply-To: <501E3828.40708@web.de> (Christoph Miebach's message of "Sun, 05
 Aug 2012 11:08:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C57EA22C-DF3E-11E1-9E0E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202922>

Christoph Miebach <christoph.miebach@web.de> writes:

> Running this commands locally (german locale) lead to some wrong dates
> for the patches upstream.
>
> git format-patch -o patches origin

What does "git show -s --pretty=fuller HEAD" give you at this point?
This is to check what kind of timestamps are stored in the original
commit objects.

And what does "grep '^Date: ' patches/0001-*" show you at this point?
This is to see if the problem is at the "format-patch" step.

> git send-email --compose --no-chain-reply-to --to some@address.com
> --suppress-cc=author patches/0001-l10n-Turkish-update.patch

And what does "grep '^Date: '" for the message that is received by
recipients show at this step?  They cannot be

>
>
> The local
> Date: Sat, 4 Aug 2012
> became
>       Wed, 8 Dec 2004

as these two do not even have times and zones.  It should read
something like

    Date: Sun, 05 Aug 2012 13:39:12 -0700

or something.    

Also "Date" on which message do you see your problem with?  The one
that is created with --compose?  Or the one that was originally
produced by format-patch and then sent?  Or both?

The timestamps used by git-send-email is obtained by calling time()
function of Perl, and is not affected by timezone, and the function
format_2822_time() implements the e-mail header timestamp in a way
that should not be affected by any locales as far as I know, so it
is curious where the "breakage" is coming from.

> Shall I provide more information?

Yes.
