From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff across submodules
Date: Thu, 20 Sep 2012 13:52:41 -0700
Message-ID: <7vr4pwa02u.fsf@alter.siamese.dyndns.org>
References: <1347937959.96154.YahooMailClassic@web39403.mail.mud.yahoo.com>
 <5058C53B.5040401@web.de> <7vobl3m8pb.fsf@alter.siamese.dyndns.org>
 <7v4nmtfxvx.fsf@alter.siamese.dyndns.org> <505B73CE.5030009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 22:52:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEnk0-0008LV-Ea
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 22:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab2ITUws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 16:52:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab2ITUwr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 16:52:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6F799FAF;
	Thu, 20 Sep 2012 16:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rP+m2FOMotok29O34McWgcHEjqE=; b=EPQAif
	6I7Rq5u/igiRMpTgu99mBUJNh9weYdclHRBmmGKlP4nLGnA+XSyKtqkOqNxyq6s3
	tMK4rxgCvapT0PEdcKaS6czY7UJ9QuzzA1OA0AWYU8DwJQ9/eg4IgEPWL79LPMyH
	XzIyjAS/2ebpdVyqr/2dOK4CTih0l8Es5uZ+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q//qf+HJgxZaq/NrlevDPpA9NWOhSBNS
	NSgHcLp+ljXGeLB8DqeKxExJYz/RPHbaAkKgzgHYByGV+Yjdias9Sof4DqlMLxwk
	VcrQKqO4tJq2p3V2VS0VmWPnHOmnkCSatLAO6LG+UyobBfa3z8zq5vNrqMhgplZi
	VWnN2EOsJ9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A40F59FAC;
	Thu, 20 Sep 2012 16:52:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C37129FA7; Thu, 20 Sep 2012
 16:52:45 -0400 (EDT)
In-Reply-To: <505B73CE.5030009@web.de> (Jens Lehmann's message of "Thu, 20
 Sep 2012 21:51:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2132B6EA-0365-11E2-8B72-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206091>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> That's pretty cool! Even though diff options like --stat and --name-only
> still won't take into account what happened inside the submodule this
> approach makes it possible to see the diff recursively. Wouldn't it make
> sense add this script to contrib (after teaching it new and removed
> submodules and documenting its use in a few lines after the shebang)?

A few things somebody may want to work on while doing that "few
lines of documentation" I know about are:

 * From the core side, pass options that are releavant when
   generating patch (i.e. with p) in environment variables to the
   external diff script;

 * Not using "s/$1" and "m/$1" as prefix; instead, pass src/dst
   prefix values (i.e. s/ and m/) from the core side in environment
   variables, and make the external diff script itself aware of
   possibly nested submodules, e.g.

    SUBMODULE_PATH="${SUBMODULE_PATH}$1"
    export SUBMODULE_PATH
    exec git --no-pager diff -p \
    	--src-prefix="$SRC_PREFIX/$SUBMODULE_PATH" \
    	--dst-prefix="$DST_PREFIX/$SUBMODULE_PATH" "$3" "$6"

After people gain sufficient experience with it, as the next step,
we can think about how to handle --stat and other options when we
are run without -p (currently the attribute mechanism would not
trigger) and then we can call the result a native "diff that
recurses into submodules" that people can use without setting up the
attributes based mechanism.
