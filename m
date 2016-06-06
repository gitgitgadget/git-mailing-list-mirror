From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] pull: add --set-upstream
Date: Mon, 06 Jun 2016 12:06:10 -0700
Message-ID: <xmqqoa7ew319.fsf@gitster.mtv.corp.google.com>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
	<20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
	<vpqvb1mgvn5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:06:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9zqs-0003qh-SC
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbcFFTGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 15:06:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751608AbcFFTGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 15:06:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B65CC225ED;
	Mon,  6 Jun 2016 15:06:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jOS9ltotrRBrNQkSrDE6f6/VLqw=; b=MTqT1H
	XSGdvrGye5KDBMJelaUP5rzmKMObsOB2Yt/xzdcyrnXK62Nd2b65jATKQZdImNXs
	dNVhhBKHRBEKr29nQSjk6ozUa95c4pEwePI6qh08NSYyH35doHkS7/ChYYjpi8EW
	gun4C+XzQ7JRkW+HsqKpMK4Si2Tl7QpN0gScE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=goktabsFiCn6kxhwt4dnynOdO+HADG29
	qSpLCcGHUJ+eRNyH8wal30Q7P77zzMlGIdLS+J6MZw2XEYbi6rSdhcW+VLLgL2Pt
	rk4DPWpNooqA0r3dPJ0aExmaoaXQ2I/+3TB4X5xXw3GeYaSdWdVzG+wVzehK0a9F
	cja51Es2dEQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE333225EC;
	Mon,  6 Jun 2016 15:06:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 336E8225EB;
	Mon,  6 Jun 2016 15:06:12 -0400 (EDT)
In-Reply-To: <vpqvb1mgvn5.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	06 Jun 2016 17:54:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC17A270-2C19-11E6-8CF0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296551>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> +test_config_unchanged () {
>> +	git config --list --local >original
>> +	"$@"
>> +	git config --list --local >modified
>> +	test_cmp original modified
>> +}
>
> The test passes if "$@" fails. You should &&-chain the lines here to
> catch things like crashes or unexpected "exit 1" in git.

That is true, but allowing "$@" failure may be deliberate.  After
all, "git pull -u there that", when pulling that from there fails,
may not want to update the upstream tracking information.

But I am unhappy with a more serious problem with the tests in this
patch.  They assume that "-u" option will forever be the only thing
that is allowed to modify the configuration during "git pull -u".
It should never make such an assumption.

The only thing these additional tests later in the patch (ommitted)
want to check, if I understand them correctly, is that when -u is
used on a ref that shouldn't be tracked from the given remote then 
remote.<that remote>.merge etc. are not updated.  Make a list of the
configuration variables the feature cares about, and check them and
ignore changes to any other variable.  Somebody else's feature that
will be added to "git pull" may have legitimate reason to update
configuration variables that are not releated to this feature, and
you shouldn't be writing your test for your feature in such a way
to forbid such a new feature by others from being added.
