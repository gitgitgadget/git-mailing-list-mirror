From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: socket_perror() "bug"?
Date: Wed, 2 Apr 2014 20:05:01 -0300
Message-ID: <CACnwZYf30KLVLkaB4mNrW12DHwrf=RT7H-DBNvQYs0y6RqVGLw@mail.gmail.com>
References: <CACnwZYc2py4dxehg2=gnnPLxwJaRqXYTLQvC1O7YuoqAWsZ0Tg@mail.gmail.com>
	<xmqqy4zq3xek.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVecl-000348-3g
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933514AbaDBXFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 19:05:04 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36060 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933486AbaDBXFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 19:05:03 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so850617qae.5
        for <git@vger.kernel.org>; Wed, 02 Apr 2014 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zMcK+0O1hj3ljAKe/CK3UDqJUfBTs0iQ2w3j+jN3dR0=;
        b=RX/MMwQpxY5stpQieE1WvzEtUo8fvP1ydUqRM/9qx68a8rVLqtfsSn+LF5SOjuLSka
         FbeYcxQ1QcXNQV059HN4ciPj9O4TqUWpd1VgQZsC0Wwbb4OjTZ0Lah5FV26DIa0V4cTU
         jIIhEQ/VnT9JgFlOtJZADKd/gaj+PabqcYZkdZTanoaUpXCXZMzPtqzrixCSPZGnYpF3
         ewj8P8ZZGe6urv5JtDwf16JnwK0U3dWj1Iz6wHVosphKLuVCAxayelsS6nA+TMcTNttg
         XmlmPRYsjkPQihE1GfGiaZTi2UHvT5VHEjOg01d+YbaboR5uY/ukAKqnxGspGn71HwQc
         jd9g==
X-Received: by 10.140.39.240 with SMTP id v103mr3449176qgv.77.1396479901526;
 Wed, 02 Apr 2014 16:05:01 -0700 (PDT)
Received: by 10.224.195.138 with HTTP; Wed, 2 Apr 2014 16:05:01 -0700 (PDT)
In-Reply-To: <xmqqy4zq3xek.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245695>

On Mon, Mar 31, 2014 at 5:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> In imap-send.c:socket_perror() we pass |func| as a parameter, which I
>> think it is the name of the function that "called" socket_perror, or
>> the name of the function which generated an error.
>>
>> But at line 184 and 187 it always assume it was SSL_connect.
>>
>> Should we instead call perror() and ssl_socket_error() with func?
>
> Looks that way to me, at least from a cursory look.
Would you accept such a patch?

diff --git a/imap-send.c b/imap-send.c
index 0bc6f7f..bb04768 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -181,10 +181,10 @@ static void socket_perror(const char *func,
struct imap_socket *sock, int ret)
                case SSL_ERROR_NONE:
                        break;
                case SSL_ERROR_SYSCALL:
-                       perror("SSL_connect");
+                       perror(func);
                        break;
                default:
-                       ssl_socket_perror("SSL_connect");
+                       ssl_socket_perror(func);
                        break;
                }
        } else

--
Thiago Farina
