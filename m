From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Wed, 01 Jul 2015 13:39:49 -0700
Message-ID: <xmqq4mln8ve2.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<xmqq8uaz8vjb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:39:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAOnU-0007et-Uh
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 22:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbbGAUjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 16:39:53 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32938 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbbGAUjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 16:39:52 -0400
Received: by ieqy10 with SMTP id y10so43232840ieq.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oYwMvgSNI75Qw5TBFOvsmJSDtXudgEUkv3x8oc9aU+I=;
        b=tLgPoLL0W5f6TMRyo46Sc2gt7ZBRu+upKkVDqztRFJXSNsVJwsdlndtUUOsJBft0e4
         zeMJ9rTSwrET8qxo5QhvsBIJDNrrL1Gg+vomXbR9sFSPwZdR3Gyp0SyfESG9C+HIDPg1
         Uaqo4sy4wCguj4nTD9kiVjExma8IRU0T4yNZMaFcFQQ3NQU+OCrLQ7qysJUxFZPkF65j
         7RMbNheZpH7h0oHLKyzmIamZJ0DFmtAobYss/lv8w7K3AvCSlaSCFAN0FNCsCKUDoXWJ
         XfKL9CGF0BUWZWNnrbCXiS5LXKCUICy6uTGzRkf5SkN+GZ4foiMe0o8uUewELBoexqpt
         WKJw==
X-Received: by 10.43.89.133 with SMTP id be5mr7254658icc.2.1435783191269;
        Wed, 01 Jul 2015 13:39:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id u38sm2220571ioi.0.2015.07.01.13.39.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 13:39:50 -0700 (PDT)
In-Reply-To: <xmqq8uaz8vjb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jul 2015 13:36:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273197>

Junio C Hamano <gitster@pobox.com> writes:

>> I am moderately negative about this; wouldn't it make the end result
>> cleaner to fix the implementation?
>
> I think that something like this should be sufficient.  As the
> receiving end, we must not complain if there is no terminator.
> ...

And the change we are *not* going to make, but I made temporarily
only for testing, on the sending side to violate our "sender SHOULD
terminate with LF" rule would look like this:

There is a slight complication on sending an empty line without any
termination, though ;-)  The reader that calls packet_read() cannot
tell such a payload from a flush packet, I think.

*That* may be something we want to document.

diff --git a/send-pack.c b/send-pack.c
index 2a64fec..1a743db 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -273,9 +273,11 @@ static int generate_push_cert(struct strbuf *req_buf,
 
 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
 	for (cp = cert.buf; cp < cert.buf + cert.len; cp = np) {
+		int len;
 		np = next_line(cp, cert.buf + cert.len - cp);
+		len = (np <= cp + 1) ? 1 : (np - cp - 1);
 		packet_buf_write(req_buf,
-				 "%.*s", (int)(np - cp), cp);
+				 "%.*s", len, cp);
 	}
 	packet_buf_write(req_buf, "push-cert-end\n");
 
