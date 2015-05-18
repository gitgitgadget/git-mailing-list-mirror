From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/14] pull: set reflog message
Date: Mon, 18 May 2015 14:53:07 -0700
Message-ID: <xmqqmw11a6yk.fsf@gitster.dls.corp.google.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-11-git-send-email-pyokagan@gmail.com>
	<390e789e8f84122d52185f22e6e798f2@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 18 23:53:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuSyJ-0002OE-QP
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 23:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbbERVxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 17:53:11 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:32796 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbERVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 17:53:09 -0400
Received: by iebgx4 with SMTP id gx4so182093890ieb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gxwN0car21eBb8JfCBSBDz3yLBGCYw+rY2d7d/rzOdE=;
        b=s673z6ckZdQfKXAqy6oy1M5uTuawc7fqkpqUESpdA3Dt3laqOQU1Z5VW6ojl7ogSPV
         SRkSZZfXPpMocg5FimN8RqNDEQazOEamDWo6CyDZMvH4TRDSuf2ItwkbXA3TZ/kAGZzY
         b1ihjMgY/6Oz4IOMk620fkQvv1mvtROcWnCw0rLVY8JcSIz1VX6C3/AQzzBMxzjaSxeZ
         uFQLdNyydco+71UvLKt/ZMmfx6sanfm4Lh9SNEPQ7fJAIkQ9YUpqRp1h+fLMBwDmSwVS
         F3I5H6o4gimmeC9V1GRLL4Q6YlDlgsjeubjxHw7Qy2AAxcwS24toLstjJsmUGV+9xQVJ
         k9Qg==
X-Received: by 10.50.114.70 with SMTP id je6mr17238810igb.43.1431985989224;
        Mon, 18 May 2015 14:53:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id r4sm6423016igw.12.2015.05.18.14.53.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 14:53:08 -0700 (PDT)
In-Reply-To: <390e789e8f84122d52185f22e6e798f2@www.dscho.org> (Johannes
	Schindelin's message of "Mon, 18 May 2015 21:27:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269325>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>>  /**
>> + * Sets the GIT_REFLOG_ACTION environment variable to the concatenation of argv
>> + */
>> +static void set_reflog_message(int argc, const char **argv)
>> +{
>> +	int i;
>> +	struct strbuf msg = STRBUF_INIT;
>> +
>> +	for (i = 0; i < argc; i++) {
>> +		strbuf_addstr(&msg, argv[i]);
>> +		strbuf_addch(&msg, ' ');
>> +	}
>> +
>> +	strbuf_rtrim(&msg);
>
> Since this is not performance critical code, I would be slightly in
> favor of simplifying thusly:
>
> /* Join the argument list, separated by spaces */
> for (i = 0; i < argc; i++)
> 	strbuf_addf(&msg, "%s%s", i ? " " : "", argv[i]);

Yeah, either that, or "insert separator only before adding to
something else" pattern, i.e.

	for (i = 0; i < argc; i++) {
        	if (i)
                	addch(&msg, ' ');
		addstr(&msg, argv[i]);
	}

Both are easier to read than "always append SP and trim at the end".
Besides, trimming at the end makes readers wonder if there are cases
where argv[argc-1] ends with whitespaces and the code on purpose
removes them.




                        	
