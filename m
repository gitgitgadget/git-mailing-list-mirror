Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3E01F404
	for <e@80x24.org>; Wed, 24 Jan 2018 19:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeAXTs0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 14:48:26 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:34400 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeAXTsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 14:48:25 -0500
Received: from theoden.lucaswerkmeister.de (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id C05FC19586F;
        Wed, 24 Jan 2018 20:48:20 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1516823300;
        bh=VRg8HRLkxQh4VTF9cpLCihalCxJuZikAHYHXyMuZMc4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Reply-To:
         Subject:Date:To:Cc:In-Reply-To:References:Message-Id:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version;
        b=MK73sruNSzqSHP4234QJ7yzqI0EAbBQovKH+zHROfPiEXzg0TfIg/qZMLe62Y9w5o
         o3gG2snncFCCRzRws0hCN5ShGyL2mHnt/6NBiUDHUJ+zgoxbImlgpZU2kGKnWf2JMB
         kD5EisFjETxk8s+mAyU3l5U5VJRwVPoxrz1OxSMM=
Subject: Re: [PATCH] daemon: add --no-syslog to undo implicit --syslog
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20180122232304.4863-1-mail@lucaswerkmeister.de>
 <87shaxh2b9.fsf@evledraar.gmail.com>
 <xmqqh8rcig0x.fsf@gitster.mtv.corp.google.com>
 <18ef807d-a642-17b2-fc32-af0c3b963a71@lucaswerkmeister.de>
 <xmqqtvvbds42.fsf@gitster.mtv.corp.google.com>
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
Message-ID: <740d5b61-884d-76df-a226-9d8a1245f528@lucaswerkmeister.de>
Date:   Wed, 24 Jan 2018 20:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqtvvbds42.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.01.2018 19:33, Junio C Hamano wrote:
> Lucas Werkmeister <mail@lucaswerkmeister.de> writes:
> 
>>> Moreover, --detach completely dissociates the process from the
>>> original set of standard file descriptors by first closing them and
>>> then connecting it to "/dev/null", so it will be nonsense to use this
>>> new option with it.
>>
>> Ah, I wasn’t aware of that – so with --detach, --no-syslog would be
>> better described as “disables all logging” rather than “log to stderr
>> instead”. IMHO it would still make sense to have the --no-syslog option
>> (then mainly for use with --inetd) as long as its interaction with
>> --inetd is properly documented.
> 
> Because "--detach --no-syslog" is a roundabout way to ask for
> sending the log to _nowhere_, I actually would say that "nonsense"
> is a bit too strong a word for the combination of your thing with
> "--detach".
> 
> It might make more sense to introduce a new "--send-log-to=<dest>"
> option, where the destination can be one of: syslog, stderr, none.
> 
> The you can make the current "--syslog" option a synonym to
> "--send-log-to=syslog".  The internal variable log_syslog would
> probably become
> 
> 	enum log_destination { 
> 		LOG_TO_NONE = -1,
> 		LOG_TO_STDERR = 0,
> 		LOG_TO_SYSLOG = 1,
> 	} log_destination;
> 
> and wherever the current code assigns 1 to log_syslog, you would be
> setting it LOG_TO_SYSLOG.
> 
> Then those who want no log can express that wish in a more direct
> way, i.e. "daemon --send-log-to=none", perhaps.
> 
> Such an approach leaves open room for future enhancement.  It is not
> too far-fetched to imagine something like:
> 
> 	git daemon --send-log-to=/var/log/git-daemon.log
> 
> by introducing the fourth value to "enum log_destination"; perhaps
> the file is opened and connected to stderr to accept the logs,
> combined with a new feature that tells the daemon to close and
> reopen the log file when it receives a HUP or something like that.

Sounds interesting… do you think it would be worth it supporting
multiple destinations? Right now this could be implemented fairly easily
by making log_destination a bit field (and --syslog would then imply
--send-log-to=syslog --no-send-log-to=stderr or something like that). On
the other hand, that doesn’t allow for this nice trick of reusing the
stderr fd for a log file in case of future enhancement.
