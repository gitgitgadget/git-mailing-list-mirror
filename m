From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Tue, 4 Mar 2014 06:37:25 +0700
Message-ID: <CACsJy8ASBeravdk67pbOJbrFUbwg21JwYcLtSbDDMJOu9-F=yA@mail.gmail.com>
References: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
 <xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com> <xmqq61nuoqd5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Siddharth Goel <siddharth98391@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:38:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcQq-00057R-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbaCCXh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:37:56 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:53458 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254AbaCCXh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:37:56 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so216991qcy.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+sPNhrOyCzUZ3HAV9KGG+2tC6fE71fM54w0hdVnmkXo=;
        b=tYnQKm/1vcl/F6rB5ecjIIePZDGpU7oJqOhTmT8t+UtuhZHC7fuCOtPFaKGBpCYV7H
         oQwymLy34aE0zb50YycO902FwQXjUIFP+CHQQom5Nzn8aTp08Mhe6UYlxoI1EGpalbmP
         +RrrhCAayxukNXMyleObU7h27zMA1gOYBQL7Vi5MGto3dbyyU0CwUuaSekX42FAdIt0G
         GFUybZ4huT0EwsVmilBLJ+eIEBpHmxvDvoPizNMEBiAN3C12xcH2I+sQl/v3qR3R10i0
         RQPWsr7Q0Bk/EzQjI7FdIUvlX6yg1WtZwfu+VAtCT1xjZytwZDdSBv26/3nSdu2052FV
         j0lQ==
X-Received: by 10.224.36.129 with SMTP id t1mr6341793qad.88.1393889875582;
 Mon, 03 Mar 2014 15:37:55 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 3 Mar 2014 15:37:25 -0800 (PST)
In-Reply-To: <xmqq61nuoqd5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243311>

On Tue, Mar 4, 2014 at 5:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cbd86c3..68ffaef 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,14 @@ extern int suffixcmp(const char *str, const char *suffix);
>
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {
> -       size_t len = strlen(prefix);
> -       return strncmp(str, prefix, len) ? NULL : str + len;

Just a note. gcc does optimize strlen("abcdef") to 6, and with that
information at compile time built-in strncmp might do better.

> +       while (1) {
> +               if (!*prefix)
> +                       return str;
> +               if (*str != *prefix)
> +                       return NULL;
> +               prefix++;
> +               str++;
> +       }
>  }
>
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
-- 
Duy
