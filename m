From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Implement git commit as a builtin.
Date: Wed, 18 Jul 2007 23:27:42 +0200
Message-ID: <1b46aba20707181427y12bd8b62pe30df61219e7c1f7@mail.gmail.com>
References: <11847863792344-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 23:27:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBH3i-0004lE-92
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 23:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbXGRV1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Jul 2007 17:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbXGRV1n
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 17:27:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:34295 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbXGRV1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 17:27:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so379373wah
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 14:27:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YzlMtna1hTIB7otsqdGJPADRYtzDwUFUjeV7I4+BSGm9YPF5MdFY4RmWXlgyrdPcH1Fv+z16xzmVh9rMrgyqE7sMTsig16GqtBm3IFJFJG0vY606jxKxGHPcNSqZlVP0ec/7/e8cujwiVLgZAsMJbDM0ukYvVaGnze6SXLFobOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iyaeVpgWKwcWqbDW+nswZK/ybGsV1GbUOZpnObYuueM5FYJHuJg+lzxYkiNOqtDCOZ7FPNbeMMb5e6OUT2ZQ2MjeZ8kWEORV1J41sXXGneWc43DswzRqAnhjfN9oMcEXGpFVCjbW5G5cXQ5mlysYmqu++5f2tLNq13G6KNWpWj0=
Received: by 10.114.103.1 with SMTP id a1mr1892831wac.1184794062351;
        Wed, 18 Jul 2007 14:27:42 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Wed, 18 Jul 2007 14:27:41 -0700 (PDT)
In-Reply-To: <11847863792344-git-send-email-krh@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52900>

2007/7/18, Kristian H=F8gsberg <krh@redhat.com>:
> +       if (buffer) {
> +               len =3D strip_lines(buffer, len);
> +
> +               if (fwrite(buffer, 1, len, fp) < len)
> +                       die("could not write commit template: %s\n",
> +                           strerror(errno));
> +       }
=2E...
> +       len =3D strip_lines(buffer, len);
> +
> +       if (message_is_empty(buffer, len))
> +               die("* no commit message?  aborting commit.");
> +

Hi Kristian, you could call to the new stripspace() function
in builtin-stripspace.c, to reduce code in your file. The only
thing you should consider is that the new stripspace()
removes always the last '\n' in the file (if any), so you have to
add it when you need.

I sent a patch to change the name of read_pipe with read_fd
(not accepted yet), and to terminate the buffer with NUL
(although perhaps you don't need that), and to allow the
function to receive buffer NULL or size 0.
Your version was a lot different, therefore you would
need to set buffer and size before calling it
and free the buffer if reading failed after that:
http://article.gmane.org/gmane.comp.version-control.git/52835

Now I need to create the new file editor.c to group at
least three functions related with reading and editing text.
Those also will reduce the size of your code and also
can be reused from builtin-tag.c: launch_editor,
read_path (as read_file someone said), and stripspace.

The first problem now should be how to write a version for
launch_editor() which both builtins (yours and mine) could share,
because the references in your launch_editor() related to commits,
removed already in my version for git-tag.

I did this job trying to make easier your porting by moving
those parts shared with builtin-tag.c outside your code
and generating discussion on them, so you
can concentrate just in the specific parts and reuse
the rest. I hope those can help you.

---
Carlos Rica
