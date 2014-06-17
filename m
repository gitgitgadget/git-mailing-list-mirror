From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 1/3] add strnncmp() function
Date: Tue, 17 Jun 2014 11:09:59 +0200
Message-ID: <CABPQNSZ7Vhn1Pz4j0R5twg+P-UzOG6xfw7fNqp0JO_Sh5t3CiA@mail.gmail.com>
References: <cover.1402990051.git.jmmahler@gmail.com> <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:10:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwpPg-00054c-9l
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 11:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbaFQJKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 05:10:40 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:41775 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199AbaFQJKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 05:10:39 -0400
Received: by mail-ig0-f179.google.com with SMTP id r2so3957687igi.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QEFdS2tpsp1UW2JJFmu3SjOhhyr+jnyPwDrTKdpKVQY=;
        b=TqyIUKTX7q91oHWS09stiYNG3Iuv8Uqm29puU2/0rgyr8R07Rg5QMmTgnfw9O0qS8a
         3NqPnvCdsAJYFt3Yg4wsxJvWYwC8+Ny3hEqbc5fvlsWKmkwQ7U6Mxwso88mqYTRdAjLK
         20lCC1wohrw2zNE1l+BGE6USslQbdbWcOscvkVxTdzft/SAHeaB9NKeQVnVArJy7vHL6
         lQ58qCg6TY6/l51xfjKikSXxdey4zc+lEWB6gaqlAJZ/S5xSlmgHfScBZuLL8rr9TIRp
         LSwgWXB6S9AbW6burRA9S5TmF5jgKBB7AR5at8piez++ySNxGs2L8gAc+FR03dOvPk9h
         yofw==
X-Received: by 10.50.153.11 with SMTP id vc11mr30966995igb.24.1402996239117;
 Tue, 17 Jun 2014 02:10:39 -0700 (PDT)
Received: by 10.64.227.43 with HTTP; Tue, 17 Jun 2014 02:09:59 -0700 (PDT)
In-Reply-To: <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251854>

On Tue, Jun 17, 2014 at 9:34 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> Add a strnncmp() function which behaves like strncmp() except it takes
> the length of both strings instead of just one.  It behaves the same as
> strncmp() up to the minimum common length between the strings.  When the
> strings are identical up to this minimum common length, the length
> difference is returned.
>
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  strbuf.c | 9 +++++++++
>  strbuf.h | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index ac62982..4eb7954 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -600,3 +600,12 @@ char *xstrdup_tolower(const char *string)
>         result[i] = '\0';
>         return result;
>  }
> +
> +int strnncmp(const char *a, int len_a, const char *b, int len_b)
> +{
> +       int min_len = (len_a < len_b) ? len_a : len_b;
> +       int cmp = strncmp(a, b, min_len);
> +       if (cmp)
> +               return cmp;
> +       return (len_a - len_b);
> +}

Using a name that sounds like it's from the stdlib makes me cringe a
little bit. Names that start with "str" reserved for stdlib[1][2], but
we already ignore this for strbuf (and perhaps some other functions).
However, in this case it doesn't seem *that* unlikely that we might
collide with some stdlib-extensions.

[1]: http://pubs.opengroup.org/onlinepubs/007904975/functions/xsh_chap02_02.html#tag_02_02_02
[2]: http://www.gnu.org/software/libc/manual/html_node/Reserved-Names.html
