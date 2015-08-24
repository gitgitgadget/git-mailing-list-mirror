From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: terminate state files with a newline
Date: Sun, 23 Aug 2015 23:48:44 -0700
Message-ID: <xmqqegit5ghf.fsf@gitster.dls.corp.google.com>
References: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
	<xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
	<20150823055053.GA15849@yoshi.chippynet.com>
	<xmqqy4h16d1f.fsf@gitster.dls.corp.google.com>
	<20150824051344.GA12490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:48:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTlYp-0005cR-F8
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 08:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbbHXGsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 02:48:47 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35955 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbbHXGsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 02:48:46 -0400
Received: by pdbmi9 with SMTP id mi9so49762765pdb.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/InnVMPxHsXcgys8PukYkBAGHF/qE/kUTqTqMTOKGys=;
        b=QoKNAdi8JQO20EIeqd1gbPaHex6X+FsgQmYjllti4bZqXKRxJi2Lc3yvqOCNge1jbZ
         cEMIqTaCSv+cPDd34IjxKxjge9gR3UAH41FfZQgKr9jHWEePJj3Px0jm4fTsZfcSNMdO
         9IXr4qg9mi7ASq4lRhUR7sjHEt+KTAKTc7uNy8EGAxZXrZVRNz2ALflV1jQA6x3J6ZNJ
         K0YYmkOawDLqJu3qnetOG1+h/OHsZOu36+36NTrAdH1IMopjFrJ0qG2olziD81QC4Mg1
         kDHJiYazN61v2rKJokY8iKzpZGJbstXnWSMaJr9MhVr587nXhUI3KFMqLRsRpBWBG6r8
         Hqxg==
X-Received: by 10.70.39.34 with SMTP id m2mr43145678pdk.148.1440398926374;
        Sun, 23 Aug 2015 23:48:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e53a:1155:f7f9:400e])
        by smtp.gmail.com with ESMTPSA id p1sm16064863pdc.71.2015.08.23.23.48.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 23 Aug 2015 23:48:44 -0700 (PDT)
In-Reply-To: <20150824051344.GA12490@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Aug 2015 01:13:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276437>

Jeff King <peff@peff.net> writes:

> FWIW, I had a similar thought when reading the original thread. I also
> noted that all of the callers here pass "1" for the "fatal" parameter,
> and that they are either bools or single strings. I wonder if:
>
>   void write_state_bool(struct am_state *state, const char *name, int v)
>   {
> 	write_file(am_path(state, name), 1, "%s\n", v ? "t" : "f");
>   }
>
> would make the call-sites even easier to read (and of course the "\n"
> would be dropped here if it does migrate up to write_file()).
>
>> @@ -634,6 +641,9 @@ int write_file(const char *path, int fatal, const char *fmt, ...)
>>  	va_start(params, fmt);
>>  	strbuf_vaddf(&sb, fmt, params);
>>  	va_end(params);
>> +	if (sb.len)
>> +		strbuf_complete_line(&sb);
>> +
>
> I think the "if" here is redundant; strbuf_complete_line already handles
> it.

True.  And I like your write_state_bool() wrapper (which should be
"static void" to the builtin/am.c) very much.

On top of that, I think the right thing to do to write_file() would
be to first clean-up the second parameter "fatal" to an "unsigned
flags" whose (1<<0) bit is "fatal", (1<<1) bit is "binary", and make
this new call to "strbuf_complete_line()" only when "binary" bit is
not set.

The new comment I added before write_file() function needs to be
adjusted if we were to do this, obviously.
