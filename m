From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 08:49:19 -0800
Message-ID: <xmqqlhnf2ghc.fsf@gitster.dls.corp.google.com>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
	<20141113133615.GA28346@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:49:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoxaN-0000fa-1d
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 17:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933324AbaKMQtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 11:49:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933286AbaKMQtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 11:49:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D99CA1C504;
	Thu, 13 Nov 2014 11:49:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lOgmv8ooWslhuktgczyIN2ojCt8=; b=Y7v6tp
	YQ7egGtzGg3+9o88Pc+JwL5cJN0HyGR1Ci5OTYofE2O6WO/ULs5llKGEzgcFXMsE
	lVsjWTLTwAfV7tBGPk6fIgDhyxFF4E+qD6K/cS9zoMii4o8xbY2znMkS8Svk+Kw/
	8Eah24o6LW/OLXMhgPNBCQzZDez33k7d42ZRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pISdY3krEbcp3fxzNEi+An/lWC00Kjyb
	rFd7p7kAHOC6hEz+dikI0YUHxIoBDtRdJ/QhMSBqjfF2s8rpjdeFXTPXSCU6TvJZ
	qg7zu40oW1Z1Bv1TauYCCQc6iZifXNtR/OcoD5bMEBPZCdQ/BCsduDwwZvumThY7
	p50Yol6zZPI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0E8E1C503;
	Thu, 13 Nov 2014 11:49:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FC441C502;
	Thu, 13 Nov 2014 11:49:22 -0500 (EST)
In-Reply-To: <20141113133615.GA28346@lanh> (Duy Nguyen's message of "Thu, 13
	Nov 2014 20:36:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 04AB9000-6B55-11E4-A8DC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Nov 13, 2014 at 12:32:40PM +0000, Graeme Geldenhuys wrote:
>> [alias]
>>     deploy = !sh -c 'git archive --prefix=$1/ -o deploy_$1.zip HEAD 
>> $(git diff --name-only -D $2)' -
>> 
>> This works very well. The only problem we have so far is that if we 
>> have files with spaces in the name (eg: SQL update scripts), then the 
>> command breaks.
>> 
>> Does anybody have an idea on how this can be resolved?  Any help would 
>> be much appreciated.

Set $IFS to newline, so that $(git diff --name-only ...) output is
split at record boundaries, not inside pathnames?

A quick experiment you can do to convince yourself may be:

-- >8 --
#!/bin/sh

data () {
	echo "a"
	echo "b c" ;# SP in between
	echo "d	e " ;# HT and trailing SP
}

show () {
	for i
	do
		echo "<<$i>>"
	done
}

echo ONE
show $(data)

IFS='
'

echo TWO
show $(data)
-- 8< --

On the "git archive" invocation, there may be something that tells
the pathspecs are literal, like '--literal-pathspecs' option, to
avoid metacharacters from being expanded, though.
