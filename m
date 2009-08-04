From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Let mailsplit and mailinfo handle mails with CRLF 	line-endings
Date: Tue, 04 Aug 2009 13:50:28 -0500
Message-ID: <pUtiIFYWaIGcw7mPKZiIk4XSCpgEimhFB1QSpwG5P0mtMWR_ZefDdg@cipher.nrlssc.navy.mil>
References: <4A7735B0.2040703@zytor.com> <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com> 	<7v7hxk5b4y.fsf@alter.siamese.dyndns.org> <20090804172638.GA15136@blimp.localdomain> <fabb9a1e0908041034y1a43fdf6nae14ec106a82f00c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 20:50:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYP5z-0000mz-Ro
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 20:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbZHDSug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 14:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933281AbZHDSuf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 14:50:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42495 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933256AbZHDSuf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 14:50:35 -0400
Received: by mail.nrlssc.navy.mil id n74IoUiY013704; Tue, 4 Aug 2009 13:50:30 -0500
In-Reply-To: <fabb9a1e0908041034y1a43fdf6nae14ec106a82f00c@mail.gmail.com>
X-OriginalArrivalTime: 04 Aug 2009 18:50:29.0246 (UTC) FILETIME=[6FD911E0:01CA1534]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124801>

Sverre Rabbelier wrote:
> Heya,
> 
> On Tue, Aug 4, 2009 at 10:26, Alex Riesen<raa.lkml@gmail.com> wrote:
>>        }
>> +       if (len > 1 && buf[len - 2] == '\r')
>> +               buf[--len - 1] = '\n';
>>        buf[len] = '\0';
> 
> How about something like:
> 
> +       if (len > 1 && buf[len - 2] == '\r' && (buf[len - 1] == '\n'
> || buf[len - 1] == '\0'))
> +               buf[--len - 1] = '\n';
> 
> To make sure that we're not erasing a \r somewhere in the middle of the content?

You may want to push the \r back into the buffer if it is the last character read
too.  We may reach the limit of size characters without finding a \n, and so we
can't tell whether the last \r we read was a solitary \r or whether it is the
beginning of \r\n sequence.

So maybe we need something like this after the 'for' loop instead:


   if (c == '\n') {
   	if (len > 1 && buf[len - 2] == '\r')
		buf[--len - 1] = '\n';
   } else if (c == '\r') {
	ungetc(c, in);
	len--;
   }

-brandon
