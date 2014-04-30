From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Wed, 30 Apr 2014 08:13:01 -0700
Message-ID: <xmqqk3a6hmv6.fsf@gitster.dls.corp.google.com>
References: <1398718883-5630-1-git-send-email-dborowitz@google.com>
	<CABPQNSYDD7g3nOwb2ZaOQ9M9gQnjzQyKP4Zo-i8p4o-s30bk1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Borowitz <dborowitz@google.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 30 17:13:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfWCB-0004N6-2B
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 17:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbaD3PNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 11:13:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759044AbaD3PNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 11:13:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FC3E7F1EC;
	Wed, 30 Apr 2014 11:13:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K7iHl86E9QSDD+x3CrlsicTAFFg=; b=TitMEU
	bixPFAIaGC4ZECPfzTamP/hEFlRCB23e9V7N0a3gQSxtRc3mm2EHVI1mfUM6Qefi
	IDGh/yHd5uncbeZru/FupKBo7Udft4xsge7IjTVzDgDdNTssf0CyBonfwe5VSDix
	B6Gsqxg67lMaPtz+AVOPbLcYa2k0yAJ1AZSUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fk/xGaVo7mDgxsSt3SMriYIFjrtPELNw
	aWuFPXgSPg2O8N81iayyKj0dssYULBxpM1RTFJW+nle/PeYxXG6yqApfwFSVVzNJ
	6+SmR8tTnP1WZwSprh+WsZWalm0JeCPHsDGM40YlVjwHCFzoIXjy427itBtP4o1s
	T9N/MSQsJc8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F8137F1EB;
	Wed, 30 Apr 2014 11:13:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77C347F1E1;
	Wed, 30 Apr 2014 11:13:03 -0400 (EDT)
In-Reply-To: <CABPQNSYDD7g3nOwb2ZaOQ9M9gQnjzQyKP4Zo-i8p4o-s30bk1Q@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 30 Apr 2014 15:04:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ECE3E61E-D079-11E3-9F0C-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247719>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> This is wrong, no? With CURL_CONFIG not set, it currently *does* run
> curl-config, see below.
> ...
>>         ifdef CURLDIR
>> +               CURL_LIBCURL =
>> +       else
>> +               CURL_CONFIG = curl-config
>> +               ifeq "$(CURL_CONFIG)" ""
>> +                       CURL_LIBCURL =
>> +               else
>> +                       CURL_LIBCURL := $(shell $(CURL_CONFIG) --libs)
>> +               endif
>
> Doesn't that definition just define CURL_CONFIG unconditionally? How
> are the first condition ever supposed to get triggered?
>
> $ make
> make: curl-config: Command not found
> GIT_VERSION = 1.9.2.462.gf3f11fa
> make: curl-config: Command not found
>     * new build flags
>     * new link flags
>     * new prefix flags
>     GEN common-cmds.h
> ...
>
> Yuck.

An earlier iteration of the patch used "CURL_CONFIG ?= curl-config",
but that would not have been much different:

        $ cat >Makefile <<\EOF
        CURL_CONFIG ?= curl-config
        ifeq "$(CURL_CONFIG)" ""
                X=Empty
        else
                X=NotEmpty
        endif
        ifdef CURL_CONFIG
                Z=Defined
        else
                Z=Undefined
        endif
        all::
                @echo "$(X) $(Z) CURL_CONFIG=<$(CURL_CONFIG)>"
        EOF
        $ make
        NotEmpty Defined CURL_CONFIG=<curl-config>
        $ make CURL_CONFIG=""
        Empty Undefined CURL_CONFIG=<>
        $ CURL_CONFIG="" make
        Empty Undefined CURL_CONFIG=<>

As the first one (the default) will still use curl-config and
passing an explicit CURL_CONFIG="" on the command line would be the
only way to squelch this unpleasantness.  If you change

	CURL_CONFIG ?= curl-config

to

	CURL_CONFIG = curl-config

in the above illustration, the first two would be the same result as
above, and the last one will behave the same as the first one---an
environment set to empty is still protected from the default defined
in the Makefile.

I think something along the lines of 

	ifdef CURLDIR
        	CURL_LIBCURL =
	else
		CURL_CONFIG = curl-config
		CURL_LIBCURL := $(shell sh -c '$(CURL_CONFIG) --libs' 2>/dev/null)
	fi

may be the right way to write this?

Note that $(shell $(CURL_CONFIG) --libs) when CURL_CONFIG is empty
would barf when $(CURL_CONFIG) expands to an empty string.
