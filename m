From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: match --signoff to the original scripted version
Date: Sun, 06 Sep 2015 10:39:06 -0700
Message-ID: <xmqq8u8jbg79.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
	<CACRoPnQvNowZGbqvRLuhS8cC1EaTQX3vsyaESSQVXpuRToWLOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 19:39:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYduh-0007nE-O0
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 19:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbbIFRjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 13:39:11 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36801 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbbIFRjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 13:39:09 -0400
Received: by padbj2 with SMTP id bj2so520728pad.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=x9cK8K5EQMsxahDzurW8PurhXexQpgp4pYdOuuGv3oY=;
        b=q276UoIm/PmrRujsZn8r+uqlgZMpmVu/B60urqxc1vfGHtuSRdzJ3Vt40BFs+Q7MBv
         fIltyc3lPp29AktivtCihqI2fW/h2zUUar0F4wC/VOicnkgs7L7KwPvS5Es4m/wD2Xtf
         S+7tH0T6RWQD4WigD9lxE9arV8zLqrp3GRrRMFsD35UagQVhv1uJwvnLgBiRJunxTxWR
         lZGlmaVjSJAsnn8ideub7r0rL0WJM5ba20/QU/hDVehpOiqfUzklDtogL5UwjBcAQw/G
         6xT+Tim4iHiNlrFBdJKuvJCKCVW97JabhJhif/CseUS+CFjpxM8lAlFgUXB5MLnRE0o2
         yWew==
X-Received: by 10.66.163.161 with SMTP id yj1mr35852003pab.34.1441561149057;
        Sun, 06 Sep 2015 10:39:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:91db:290:be53:1b89])
        by smtp.gmail.com with ESMTPSA id im2sm9180196pbc.34.2015.09.06.10.39.07
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sun, 06 Sep 2015 10:39:07 -0700 (PDT)
In-Reply-To: <CACRoPnQvNowZGbqvRLuhS8cC1EaTQX3vsyaESSQVXpuRToWLOQ@mail.gmail.com>
	(Paul Tan's message of "Sun, 6 Sep 2015 22:21:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277432>

Paul Tan <pyokagan@gmail.com> writes:

>> +       /* Does it have any Signed-off-by: in the text */
>> +       for (cp = sb->buf;
>> +            cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
>> +            cp = strchr(cp, '\n')) {
>> +               if (sb->buf == cp || cp[-1] == '\n')
>> +                       break;
>> +       }
>> +
>> +       strbuf_addstr(sb, mine.buf + !!cp);
>
> To add on, I wonder if the above "add a blank line if there is no
> Signed-off-by: at the beginning of a line" logic could be expressed
> more succinctly like this:
>
>     if (!starts_with(sb->buf, "Signed-off-by: ") &&
>         !strstr(sb->buf, "\nSigned-off-by: "))
>         strbuf_addch(sb, '\n');
>
>     strbuf_addstr(sb, mine.buf + 1);

That may be more obvious, but I wanted to reuse the existing
sign_off_header[]; there is no variant that has a leading "end of
previous line".

I actually think it is not an uncommon thing to ask "Give me the
first occurrence of the string NEEDLE that appears at the beginning
of lines in BUF", so the right way to address the "is it more
readable" question would probably be to have a helper function to do
just that, and use it here and other places that answer that
question by themselves due to lack of such a helper.
