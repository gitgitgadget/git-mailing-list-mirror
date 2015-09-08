From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: match --signoff to the original scripted version
Date: Tue, 08 Sep 2015 11:14:16 -0700
Message-ID: <xmqqlhcg93t3.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
	<20150908062523.GE26331@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:14:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNPT-0002mL-D1
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbbIHSOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:14:20 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36157 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbbIHSOT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:14:19 -0400
Received: by padhk3 with SMTP id hk3so45600101pad.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RjW/UreBm3i67PQ4hRvcW03ElTrW6+UWaEbCPFI84F8=;
        b=fbaPd+2/w4nlVpipTxvBxM9ddHCVECGat51KwyvQGD9SrC713mGBJdxwrPiSCydxkV
         clrYwInp/tQXAm+nuL9MIq1cW+D9lqrnWpBdadkAuZl9cVTOIymji3gHK8OBoLBUzHXI
         CaAvIX581DqT7TJCElKHD3HTHtO5GlDb6vkjzyIUeBxHnhfQmfwe2ATEPFjaPqjhnSZM
         aGc0DzHtqaKcaV2q1iMbHVco1acdiy+wKJnXPgwqdae8SB3QHoqSzOLOUFP0W9X+CaU9
         3u14pXV2HzU/My3cuL5NcoEwGBGqQp9WPaLT90hhhezVeZOCp/YICLkxCgEk04Fy/gN7
         gxgA==
X-Received: by 10.66.141.141 with SMTP id ro13mr52050722pab.68.1441736058642;
        Tue, 08 Sep 2015 11:14:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id gx11sm4172787pbd.82.2015.09.08.11.14.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 11:14:16 -0700 (PDT)
In-Reply-To: <20150908062523.GE26331@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 8 Sep 2015 02:25:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277510>

Jeff King <peff@peff.net> writes:

> On Sat, Sep 05, 2015 at 09:56:27PM -0700, Junio C Hamano wrote:
>
>> +static void am_signoff(struct strbuf *sb)
>> +{
>> +	char *cp;
>> +	struct strbuf mine = STRBUF_INIT;
>> +
>> +	/* Does it end with our own sign-off? */
>> +	strbuf_addf(&mine, "\n%s%s\n",
>> +		    sign_off_header,
>> +		    fmt_name(getenv("GIT_COMMITTER_NAME"),
>> +			     getenv("GIT_COMMITTER_EMAIL")));
>> +	if (mine.len < sb->len &&
>> +	    !strcmp(mine.buf, sb->buf + sb->len - mine.len))
>> +		goto exit; /* no need to duplicate */
>
> Here you insert the "\n" directly at the start of "mine", so the test
> "does it contain S-o-b at the beginning of a line" does not count the
> first line. Probably fine, as somebody putting a S-o-b in their subject
> deserves whatever they get.

Yup.

>> +	/* Does it have any Signed-off-by: in the text */
>> +	for (cp = sb->buf;
>> +	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
>> +	     cp = strchr(cp, '\n')) {
>> +		if (sb->buf == cp || cp[-1] == '\n')
>> +			break;
>> +	}
>
> Here you are more careful about finding S-o-b at sb->buf.

It is not being careful for that, actually.  It just is avoiding to
access sb->buf[-1], which would be a realproblem.  "The beginning of
buffer is also at the beginning of a line" is merely a happy side
effect ;-).
