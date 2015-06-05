From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] status: give more information during rebase -i
Date: Fri, 05 Jun 2015 10:11:12 -0700
Message-ID: <xmqqpp5arsgf.fsf@gitster.dls.corp.google.com>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<1433368825-24617-3-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<vpqfv67zylq.fsf@anie.imag.fr>
	<xmqqtwunv1bv.fsf@gitster.dls.corp.google.com>
	<261867654.193546.1433522151490.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:11:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0v9M-0001vL-BI
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 19:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbbFERLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 13:11:15 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37491 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbFERLO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 13:11:14 -0400
Received: by igbsb11 with SMTP id sb11so19421581igb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IJcbgahK06D0A90VJ1BCfjVGImT/IE7Dp6FhSXdcv9Q=;
        b=lDWBVv5lWHz0CUQ2+HbuT0DrQ61F49ByA4EhGRz8vKfixTxwAfssPLBV526RLqjRlu
         KU16+hXXUS9SyqTwoep6qT23oFV0/NXfmudORJGms/Fh+AeePanOZFtqA7kTOdtYiiA2
         fPe1u/10A7C7zbTk16VZHOgRuFF6nt6aE9bD4fx/bZIp64+4mSltetr1DuogkmhLZJT3
         pOh20V2Rrbga785A2D6gkKcuZiVMpccX0YSCwhHVQUfEXPa3E89EG3i+IIm0qAs1z0bD
         zlIHLk4PLiQmSfjewxNPW3hr2+5yFi0iI7i++87Hxn6YvqtLljUBK5vRCg+StYiKPpJ7
         dtjw==
X-Received: by 10.50.136.134 with SMTP id qa6mr42444551igb.26.1433524274182;
        Fri, 05 Jun 2015 10:11:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id g1sm3505733iog.4.2015.06.05.10.11.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 10:11:13 -0700 (PDT)
In-Reply-To: <261867654.193546.1433522151490.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Guillaume Pages's message of "Fri, 5 Jun 2015 18:35:51 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270861>

Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> I felt that was not the right way to do so. What do you think of a
> function like that:
>
> /*
>  * Puts nb_commands commands from filename in lines,
>  * returns the total number of commands in the file
>  * ignores comments and empty lines
>  * lines needs to be at least of size nb_commands
>  * part: 0 get last commands
>  * 	 1 get first commands
>  */
>
> int get_commands(char *filename, int nb_commands, char **lines, int part)
>
> Maybe part is not the best word to choose to take the beginning or the end
> of the file. I also hesitate about adding a parameter to ignore or not the 
> comments.

If I were doing the caller of these two functions, then instead of
adding these specialized helpers, I'd probably structure that caller
this way:

	struct strbuf buf = STRBUF_INIT;
	struct string_list have_done = STRING_LIST_INIT_DUP;
	struct string_list yet_to_do = STRING_LIST_INIT_DUP;
	int have_done_nr, yet_to_do_nr;

	strbuf_read_file(&buf, ".../done", 0);
	stripspace(&buf, 1);
        have_done_nr = string_list_split(&have_done, buf.buf, '\n', -1);
	strbuf_release(&buf);

	strbuf_read_file(&buf, ".../todo", 0);
	stripspace(&buf, 1);
        yet_to_do_nr = string_list_split(&yet_to_do, buf.buf, '\n', -1);
	strbuf_release(&buf);

Then have_done.items[have_done_nr - 1].string would be the last one
that we have replayed, and yet_to_do.items[0].string would be the
next one we are going to replay.
