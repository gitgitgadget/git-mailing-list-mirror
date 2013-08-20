From: Jeff King <peff@peff.net>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Tue, 20 Aug 2013 10:33:06 -0400
Message-ID: <20130820143306.GC32370@sigill.intra.peff.net>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
 <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
 <166132E40AA54EE387BA9B4558823C55@PhilipOakley>
 <CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	"Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:33:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmzj-0002RL-Ex
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab3HTOdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:33:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:37796 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab3HTOdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:33:10 -0400
Received: (qmail 22215 invoked by uid 102); 20 Aug 2013 14:33:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 09:33:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 10:33:06 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232606>

On Tue, Aug 20, 2013 at 01:15:02AM +0200, Erik Faye-Lund wrote:

> This one seems real, although it's quite theoretical. It should only happen
> in cases where the log-message contains "%1", the initial malloc passed and
> reallocing two more bytes failed.
> 
> However, what's much more of a disaster: "pos" is used after the call to
> realloc might have moved the memory!

Yeah, agreed on both counts.

> I guess something like this should fix both issues. Sorry about the
> lack of indentation, it seems Gmail has regressed, and the old compose
> mode is somehow gone... (also sorry for triple-posting to some of you,
> Gmail seems particularly broken today)
> 
> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index d015e43..0641f4e 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -43,11 +43,14 @@ void syslog(int priority, const char *fmt, ...)
>   va_end(ap);
> 
>   while ((pos = strstr(str, "%1")) != NULL) {
> - str = realloc(str, ++str_len + 1);
> - if (!str) {
> + char *tmp = realloc(str, ++str_len + 1);
> + if (!tmp) {
>   warning("realloc failed: '%s'", strerror(errno));
> + free(str);
>   return;
>   }
> + pos = tmp + (pos - str);
> + str = tmp;
>   memmove(pos + 2, pos + 1, strlen(pos));
>   pos[1] = ' ';
>   }

Yes, that looks like the right solution. You could also convert "pos" to
an integer index rather than a pointer (but then you end up adding it it
to the pointer in the memmove call, which is probably just as ugly).

-Peff
