From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Thu, 18 Jun 2015 13:06:54 -0700
Message-ID: <xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:07:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g5V-0001N4-9o
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbbFRUG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:06:57 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36212 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbbFRUG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:06:56 -0400
Received: by iecrd14 with SMTP id rd14so62146281iec.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hv4DukYo0LZTPw01o76r8hbKX1qTyljodY9Lk3HULoI=;
        b=oZ/WCLd4MMdGWiyn+cOu3hEmR149IVIeM4LYLsHYs75Vhm395DnWg4AkiAPoFv+C/N
         C6ezD5pYooc/0gn0m/02WFlFbPvvs8JuIzHTVbwH8FqPtTlejCGrUMW47dZY4ZokvioF
         zEIHCIA55Nm6Ijo93T4W0YiTxwGV5ZvSRplwgji1HFBlGktMGehxBJWilOozCBo9suqb
         rHqPBaQShcePgG1VYg5QWLXHO7zeFof+O2sfHTdPTVn1t1RjiPvif397kR29zooT9LbG
         wIxdLj96prQIYM8OJOsi8wIeIa43ZZJdB3J+uzdJ0KpX2j2yg3HIw46N5+8JddohZO/V
         z9sg==
X-Received: by 10.50.178.230 with SMTP id db6mr20245029igc.26.1434658016169;
        Thu, 18 Jun 2015 13:06:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id w4sm201049igl.22.2015.06.18.13.06.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 13:06:55 -0700 (PDT)
In-Reply-To: <xmqqoakceq8s.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 18 Jun 2015 13:05:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272041>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> This change looks ugly and unnecessary.  All the machinery after and
>>> including the point set_outdir() is called, including reopen_stdout(),
>>> work on output_directory variable and only that variable.
>>> 
>>> Wouldn't it work equally well to have
>>> 
>>> 	if (!output_directory)
>>>         	output_directory = config_output_directory;
>>> 
>>> before a call to set_outdir() is made but after the configuration is
>>> read (namely, soon after parse_options() returns), without making
>>> any change to this function?
>>
>> Don't we load the config before parsing options here? In that case, we
>> can use our usual strategy to just set output_directory (which is
>> already a static global) from the config callback, and everything Just
>> Works.
>>
>> We do have to bump the definition of output_directory up above the
>> config callback, like so (while we are here, we might also want to
>> drop the unnecessary static initializers, which violate our style guide):
>
> You would also need to remove the "oh you gave me -o twice?" check,
> and change the semantics to "later -o overrides an earlier one",
> wouldn't you?  Otherwise you would never be able to override what
> you read from the config, I am afraid.

By the way, I actually think "later -o overrides an earlier one" is
a good change by itself, regardless of this new configuration.
