From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 07/26] mailinfo: move global "line" into mailinfo() function
Date: Wed, 14 Oct 2015 13:27:38 -0700
Message-ID: <CAGZ79kYuvV68P4HWpr+XCnp3DJufAGnWc7HugddkNToSiRm5XQ@mail.gmail.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444778207-859-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:27:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSeK-0008O5-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbbJNU1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:27:42 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36328 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbbJNU1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:27:38 -0400
Received: by ykey125 with SMTP id y125so58903133yke.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jLXxwwddjKOLY7N6kEoOzkIQfkI+dNWm7r/SAViSCpw=;
        b=oHe/xmc56W296g68NqVcZrirtd6b9Z6B2OiBviNs0xZ7F0bKnZ4VPcjNDtE/MQcA2P
         MAVEprpC87vczTXERiLOVOfHlAjAMDiSRBOIgkaoT9nswO1a6GDz0IRVg+adpwzhAX3N
         RL1Kh/CRXCpdAUhmQ/e5MSGIV4tZArfC1o6uHxnS2lDwC1dLtwKRqomoipMa7ZznhVNC
         tKY7feLaTUpJHt8R64tDFVUWccCF7D9FEjAT2VHpQndoBsN8W8yxqOj0/Bz5oRr9Gsm2
         GqN7ZNrD6IUjW748PcQhBmv5dnZtlPD6lveAdkOvOY0PjrNUuQK1nJn6x1vjAyeQITC5
         V+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jLXxwwddjKOLY7N6kEoOzkIQfkI+dNWm7r/SAViSCpw=;
        b=Ja+8NQLBmHL3fBSIvDKc+86LqWXPageZ1gRwu4TNWTuqGvrU6FZsTdDnlUgXtb4Eqy
         nm5nNgK1qTGFyh0ZMgixwAdtL2mmnsJ94FPhjNPKU6KX2ECl+2OytxRF3n+/Anqjqi20
         n4ZRs7/5mDvTyAPTg2uA9mQ0jO5f4c/s59k0OxY3PhFDecFTx2D8DoNQK/57mjLLWSKZ
         +MJUdUYhM0bKkibMU8/pA9pdBNmEZpOhFg3izcIWdornVpPqv2I4ACdmpBoHGDSuHKyX
         inc+1ciu/ILEVj0DIIg5rFz5CZl94pV4ZsxKu6IhDqqia246rP46PN06/L1V0sVTzccw
         CIXg==
X-Gm-Message-State: ALoCoQm4JgLbhm6Y4UoRum1t0VvEOK4kIPJ6Q+1B9YXr3QXb63399Kgq0luE1joRFOsz9y6eRikg
X-Received: by 10.13.199.133 with SMTP id j127mr3809433ywd.176.1444854458285;
 Wed, 14 Oct 2015 13:27:38 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 14 Oct 2015 13:27:38 -0700 (PDT)
In-Reply-To: <1444778207-859-8-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279592>

On Tue, Oct 13, 2015 at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The mailinfo() function is the only one that wants the "line_global"
> to be directly touchable.  Note that handle_body() has to be passed
> this strbuf so that it sees the "first line of the input" after the
> loop in this function processes the headers.  It feels a bit dirty
> that handle_body() then keeps reusing this strbuf to read more lines
> and does its processing, but that is how the code is structured now.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Ok, that is exactly what I thought about squashing into patch 6.
A separate patch will do too.
