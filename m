From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3] builtin/apply: handle parse_binary() failure
Date: Thu, 31 Mar 2016 18:26:26 -0400
Message-ID: <CAP8UFD2vx17KDf5HgSYYZudbXiq7CYDg0=hXbJuJrLp9QDfJUg@mail.gmail.com>
References: <1458304241-537-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:26:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1all33-0003Oe-0s
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbcCaW0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:26:30 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33833 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbcCaW02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:26:28 -0400
Received: by mail-wm0-f51.google.com with SMTP id p65so2915126wmp.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 15:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=D7oeyWYXtLRKneUx1o4ZM8fDxgEehnBEOuczlDy+Owc=;
        b=RtwXaQf5F9O21111SOE738B/gYH9OIhpcTz+YuGp3ijSEeZnCa8F7FbxZvBDCxtOmO
         lwPkzxMigCW4JO0O3jL0QKc5Hh0rRCwfyTmyUOSqVTiE8N4TsPkqueyumQPzZWPZX/Hl
         TtW7npAWwbOkA1vab7jLZF92DOtUofo3+bcN38/sugNptOqdTWL9VBnrJYRCi5SOGLDd
         VcRxGFdgneIWO4BcL9voZdU7jwG3a8xrq2efqfG8uqzOBmdTiPK0OZW2rsNLH8+NJtFT
         WIcqfIuud0PNjsQJqq+q/xDJTI3GbL4PO6kywfhR01S6D8IuIyOAbIXuUXbwauD2eKyU
         /IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=D7oeyWYXtLRKneUx1o4ZM8fDxgEehnBEOuczlDy+Owc=;
        b=M9jho8ZNDXVmDfhGSNdd5mvjqDPcfNNK5uqvA5zMYdgyakimAbpYC0T9VEjlpw+C23
         +5fiRGM9kGdpvJzE9dkjTJpRWVf3chJQVa/nwixAyDJlBLI7srakuOymn0CB4B2F5lFQ
         /bZqIFdTLLCgDS8GibafVXhc2yWTxAMZb26yPP8Egr08tcjnBkZVd6l3h15vjPyGreHl
         WapUm7Sw+CE9+DNM/6lb9IcqwZolNmyI0/a5U5SC6Ttomt3guH9j5lvMup9hgIQJ951p
         rCEP69MKsRzghwGMMgkRIGTCo1oUwHPC8fXNm1UUKziyRj3XKarTbJswvYqT1P0hjz2s
         iD7A==
X-Gm-Message-State: AD7BkJJ4w5M3yxps7foaTrQh4nrUcFyskI4P6MGv0Audue6mgv9JAZKstkPQgYGcnP/qS2nY8nZFGcpsV1VchQ==
X-Received: by 10.28.180.9 with SMTP id d9mr98583wmf.62.1459463186879; Thu, 31
 Mar 2016 15:26:26 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Thu, 31 Mar 2016 15:26:26 -0700 (PDT)
In-Reply-To: <1458304241-537-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290480>

On Fri, Mar 18, 2016 at 1:30 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> In parse_binary() there is:
>
>         forward = parse_binary_hunk(&buffer, &size, &status, &used);
>         if (!forward && !status)
>                 /* there has to be one hunk (forward hunk) */
>                 return error(_("unrecognized binary patch at line %d"), linenr-1);
>
> so parse_binary() can return -1, because that's what error() returns.
>
> Also parse_binary_hunk() sets "status" to -1 in case of error and
> parse_binary() does "if (status) return status;".
>
> In this case parse_chunk() should not add -1 to the patchsize it computes.
> It is better for future libification efforts to make it just return -1.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Only the title of the patch changed in this version compared to v2.

It looks like this patch is not in pu. Maybe it has fallen through the cracks?
