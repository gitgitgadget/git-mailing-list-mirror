From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Tue, 03 May 2011 10:32:14 -0700
Message-ID: <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <kornet@camk.edu.pl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 03 19:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHJSa-0000g8-Mf
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 19:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab1ECRc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 13:32:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab1ECRc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 13:32:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4F553229;
	Tue,  3 May 2011 13:34:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r0hsx9kmRQSPZO1M9vbyTzpnJZs=; b=YpjpT0
	T6DlLLfmTPzLmkhrIVZ4csTwrMh1sUJfiiA+o0VFMEpkHX8ofiVs3xBcqNGUpRVd
	I8nPBpNnTrgHdVnNx/Yhdun4SLh9cB2DoVVHhlqMez9FbmrSF6uo8dn2CH6Le6sL
	S3RYJUrLRAWu9QPz0lx30HOibkQYKzMX7GqNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EiROUJu8ozxmTg8r/ps2lFM7m/MJTUVP
	eWtTykvgaO27TIXb+vVeoHyEfwYmORl5sg8oLZuDtbyJqvY2prVJQteWYAkLqOQ3
	hPGZ7ahjOTZWxxGX/p3fpCM2VB6AbqnKBGMoDM2A9V+CgHNUC2fp432l7wHSuXT2
	MSqdn2foF30=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2D573228;
	Tue,  3 May 2011 13:34:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5FF963227; Tue,  3 May 2011
 13:34:19 -0400 (EDT)
In-Reply-To: <4DBFA3C6.8060209@viscovery.net> (Johannes Sixt's message of
 "Tue, 03 May 2011 08:42:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95EEE86C-75AB-11E0-A8E2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172673>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Please do not set Mail-Followup-To!! It makes communication on this list
> extremely inconvenient.
>
> Am 4/28/2011 21:27, schrieb Kacper Kornet:
>> Definitions of ETC_GITCONFIG, ETC_GITATTRIBUTES and sysconfdir depend on
>> value of prefix. As prefix can be changed in config.mak.autogen, all if
>> blocks with conditions based on prefix should be placed after the file
>> is included in Makefile.
> ...
> Does this patch do anything useful? After the patch is applied, sysconfdir
> is set-but-not-used. Therefore, you can remove the assignments. But then
> you lose the reference to $(prefix) that the commit message claims is so
> important. Puzzled...

The only thing it does is to to allow you to set prefix in config.mak and
then have it propaget to the selection of ETC_GITCONFIG (if prefix is /usr,
then it is always /etc/gitconfig, otherwise it is always etc/gitconfig).
The importance of prefix is not that the value is prefixed to ETC_GIT*,
but it is used in the conditional to choose between the two.

We can get rid of assignments to sysconfdir in that sense. But you spotted
a regression. If sysconfdir is set to somewhere else, even if you set prefix
to /usr, we should set ETC_GIT* using the value given to sysconfdir.  The
original code did so, but the patch lost it.
