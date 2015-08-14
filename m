From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] utf8.c: print warning about iconv errors
Date: Fri, 14 Aug 2015 15:35:58 -0700
Message-ID: <xmqqvbchfqgh.fsf@gitster.dls.corp.google.com>
References: <1433624551-20730-1-git-send-email-max@max630.net>
	<1439589334-32318-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:36:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQNa9-0000Ou-3J
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbbHNWgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:36:03 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33239 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbHNWgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:36:01 -0400
Received: by pdrh1 with SMTP id h1so35554963pdr.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gy79NGJoOu/bmaWrhylGis/Ax0gjCfh3VOyVeIiOQQk=;
        b=hjOWVEQ0Zsal8C5au5ZYhg6G/Sfo4gzc/eputkuZRFDYfR/agr6kuU5m5qv5p0R7EV
         JFcX7/3YAGz6eIstFvjx/wE7+OnQb1prMDIzcshgGdjqB2qMTcbqQz5bNRvny3l0J/ki
         XnwjZvzY8CPD8ZmY27eYToBT58B8JTTMzrGSnj9U6LAHQM1wyZHPfQ7s8973QUzWs+0I
         DQ3PlvOkOspQgvot9n4htWMkalmNayEYXEn4u4wqCQbgPSGclHWHpeUMuLGuwRxPCsZX
         xAhkNnal8DEU9fGEqP/JzoWfD1pkkKF7XjMcAN+fYp7g4uvuzv3iDW2xVbc6n1VkO5Bm
         PZ9g==
X-Received: by 10.70.43.79 with SMTP id u15mr83058979pdl.84.1439591760662;
        Fri, 14 Aug 2015 15:36:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id to5sm7186218pac.33.2015.08.14.15.35.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 15:35:59 -0700 (PDT)
In-Reply-To: <1439589334-32318-1-git-send-email-max@max630.net> (Max
	Kirillov's message of "Sat, 15 Aug 2015 00:55:34 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275970>

Max Kirillov <max@max630.net> writes:

> * do not limit number of warnings - does not worth complicating the code

Unless the warning leads to a quick "die()", wouldn't this make Git
unusable by spewing a "falling back to verbatim copy" for each and
every line of the message of a commit that has 'encoding' element in
its header in the "git log" output, no?

I suspect that this may be a huge mistake.

> +char *reencode_string_len(const char *in, int insz,
> +			  const char *out_encoding, const char *in_encoding,
> +			  int *outsz)
> +{
> +	if (!same_encoding(in_encoding, out_encoding))
> +		warning("Iconv support is disabled at compile time. It is likely that\nincorrect data will be printed or stored in repository.\nConsider using other build for this task.");
> +	return NULL;
> +}

Hmmm, I suspect this may be seen as regression by those who build
Git without ICONV for performance, knowing that there is nothing in
their data that requires character set conversion.

We'd call same_encoding() every time, which would involve a few
strcasecmp() calls.  Originally, we didn't even have a function call
overhead.
