From: Michael Edgar <adgar@google.com>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Wed, 10 Jun 2015 16:25:45 -0400
Message-ID: <CALkbG6+Xqw+giW3msUKYx4odFv+2GAi=C2t2d=6VjuFp0xpO0w@mail.gmail.com>
References: <1433961320-1366-1-git-send-email-adgar@google.com> <20150610190512.GB22800@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 22:26:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2mZi-0007Dn-HI
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 22:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933764AbbFJU0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 16:26:09 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36902 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbbFJU0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 16:26:07 -0400
Received: by igbsb11 with SMTP id sb11so41501119igb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qXNQECAIZzapZsHQg6+Z5UzcvcPIAk3lzqdl4hpWjrY=;
        b=EydIDN/caXwGtMpyiaWTCbmHgOe1ZX++RDJIjUOXhXQceGSntkj6z38UGmpzwfeVXA
         kgvJfa9AzB1McoJpavtzTIiIaJXu0kbwov/uJIhdMEvTiuQ0j+X10ZgpHQO0SJr+AwZ3
         icaiHL4cs9aZz28ERETWBVnlO631hQPYgaqiSV+4JQumys7VS5jFJPrj4rPZO0xJj4hn
         b77j8XfURr1IZnCEJPiY79m2iPnrE4EKBmhrqpZn6FtAHn+jZdN90FEt0bj+l2j/aMRA
         iNDfO7UtYLCrKX5u8/ZhKPiFjye3QFJd1o2CLaAzR4L8d9IqfUPPHaHDRx/nyk8OCAYR
         PMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=qXNQECAIZzapZsHQg6+Z5UzcvcPIAk3lzqdl4hpWjrY=;
        b=Ouc8cQhPfF4f16L9pjbwxk5HoGGeoLSdv7cpYeem80u72I7R0ZiI6yUgasPAzs3lIa
         FbyLUiz+UZJFBFuhvINKLsiwIPs7PJQoTnskSnOLqR9bYot6ryVrB3yZjvpP31NTk4A/
         W+BUVdZhLxt2zOGfVoy081MCAjgVWyiYdK6ETCtD8xojViOhZodrClJEgdpj8qbpHIpb
         DLXK4LDmV8mGzbxSxCqpeJRXFoSxv+/sSnbRUcDc0Mjm49JnKNPmT1F+uAGX2mL8EkMa
         eQaG8ZYd3oukFoG65JYDoD3asmMoVtrRPjzHjjJTDyHm5AdIgU/LGZwN8PcThlMb9Ds4
         M7xw==
X-Gm-Message-State: ALoCoQlka5x/oSdxdZlA0CcqGIRqcTgLQgwct7Hh8SOAGBi3EpOUkbg2AwnxWEjWIodgFxjQWoLO
X-Received: by 10.42.99.70 with SMTP id v6mr6698614icn.1.1433967966423; Wed,
 10 Jun 2015 13:26:06 -0700 (PDT)
Received: by 10.64.112.65 with HTTP; Wed, 10 Jun 2015 13:25:45 -0700 (PDT)
In-Reply-To: <20150610190512.GB22800@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271350>

> On Wed, Jun 10, 2015 at 3:05 PM, Jeff King <peff@peff.net> wrote:
> I see that do_fetch_pack checks server_supports("shallow"). Is that
> enough to cover all fetch cases? And if it is, why does it not cover the
> matching clone cases?
> -Peff

Great question. I determined that the do_fetch_pack logic doesn't work for
clones because it also checks is_repository_shallow(), which looks for the
.git/shallow file (or the alternate file).

I considered changing clone to create an empty .git/shallow file or alternate,
but it turns out that an empty shallow file is treated as no shallow file at
all. Since at this stage in cloning we have nothing to put in the shallow file,
it seemed like any other fix would require more substantial changes.
