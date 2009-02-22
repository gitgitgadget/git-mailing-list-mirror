From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [PATCH] Popup menu
Date: Sun, 22 Feb 2009 13:15:21 +0100
Message-ID: <2c6b72b30902220415q2d3cfa7dmd5fd584c89acbecc@mail.gmail.com>
References: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 13:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbDGb-00053K-EI
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 13:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbZBVMPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 07:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbZBVMPY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 07:15:24 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:27386 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbZBVMPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 07:15:22 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1552254rvb.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 04:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pk5GOGek/VzkuhFiL1pDBQaLpl9wtDjlcksn1S12yDM=;
        b=cSqpsYJy1iIoLhWZUZI29F0NNrNHbhyMQBa1gcrSd3PN6VulCQlfKzU6NbbScJ/lqp
         FnYCmUf+OmYQ9ldF/mMlg1pCql1QbqThZ/cQLHc9jD3ef/lQOPqCCnHu31/LuIL4VW5v
         b5lN9DuPz2qZgKjPwpDBpQaTUlOD/wYihZxhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wqGJCY8+ZJrNAEqELlH2w0lWNwlncHm8mZwleWliPvsDdKFV1pHjBirFH+KMLF7YBx
         pJEtxOfRC7Sx3RAQMNIyWq7IiaUTuBzLIkrU091HYYvZs0BjKJ2/lZTFRx0UVjQd7TVF
         r7kMI5XQSFivtKgb6pnm7sj+7HUBwOiWKDIgY=
Received: by 10.141.41.12 with SMTP id t12mr1467539rvj.289.1235304921558; Sun, 
	22 Feb 2009 04:15:21 -0800 (PST)
In-Reply-To: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111000>

On Sun, Feb 22, 2009 at 12:40, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Make the menu into a popup window that complements the status prompt.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>
> We should probably consider using the high-level menu and panel features from
> ncurses if we want to do anything more complex.

First of all very cute. I take it as a comment that the menu thing I
added yesterday leaves a lot to be desired. :) I certainly agree it is
limited and would have liked to make it similar to Vim's horizontal
menu, but gave up when it got too complicated.

About using the menu, panel and maybe even the form library: Yes, it
might make sense but then again I had also hoped to maybe at some
point try to get tig running on just the terminfo interface. But I
don't know if there is any compelling reason for doing this anymore,
other than reducing the dependencies a bit.

BTW, the code doesn't handle resizing or background loading (try
starting with `tig --stat` and immediately press 'o'). To fix this I
don't know if it would be better to "rip off" the status window and
use this as the menu window. It would require a few flags to make the
resize code do the right thing.

>  tig.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 115 insertions(+), 2 deletions(-)
>
> diff --git a/tig.c b/tig.c
> index 20a40b9..017b05f 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -6542,6 +6542,100 @@ utf8_length(const char **start, size_t skip, int *width, size_t max_width, int *
> +static void
> +menu_select(int index)
> +{
> +       WINDOW *win = menu.win;
> +       int width = menu.width-2;
> +       if (menu.selected >= 0) {
> +               menu_set_line_attr(menu.selected, LINE_TITLE_FOCUS);
> +       }
> +       if (index >= 0) {
> +               menu_set_line_attr(index, LINE_CURSOR);
> +       }
> +       menu.selected = index;
> +       menu_popup();
> +}
>

tig.c: In function 'menu_select':
tig.c:6629: warning: unused variable 'width'
tig.c:6628: warning: unused variable 'win'

-- 
Jonas Fonseca
