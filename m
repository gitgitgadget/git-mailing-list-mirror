From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH v2] Let mailsplit and mailinfo handle mails with CRLF
 line-endings
Date: Tue, 04 Aug 2009 16:29:54 -0500
Message-ID: <H9KDJzU0XgndJHC8J4OETn7kxYhGP3gl0YJPR0low0hfIHjZOUsoxw@cipher.nrlssc.navy.mil>
References: <4A7735B0.2040703@zytor.com> <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com> <7v7hxk5b4y.fsf@alter.siamese.dyndns.org> <20090804172638.GA15136@blimp.localdomain> <20090804210327.GA23747@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:30:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRaG-0005LE-IY
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbZHDVaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932908AbZHDVaA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:30:00 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47377 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbZHDVaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:30:00 -0400
Received: by mail.nrlssc.navy.mil id n74LTt4X002690; Tue, 4 Aug 2009 16:29:56 -0500
In-Reply-To: <20090804210327.GA23747@blimp.localdomain>
X-OriginalArrivalTime: 04 Aug 2009 21:29:55.0194 (UTC) FILETIME=[B598E5A0:01CA154A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124817>

Alex Riesen wrote:
> Noticed by H. Peter Anvin.
> 
> It is not that uncommon to have mails with DOS line-ending,
> notably Thunderbird and web mailers like Gmail (when saving
> what they call "original" message).
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> 
> Corrected bug with unconditonal last (or very long) line shortening if
> it contains a CR in next-to-last character. Noticed by Sverre Rabbelier.
> 
> It should also handle the case mentioned by Brandon Casey.
> 
>  builtin-mailsplit.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
> index ad5f6b5..48285a0 100644
> --- a/builtin-mailsplit.c
> +++ b/builtin-mailsplit.c
> @@ -58,6 +58,8 @@ int read_line_with_nul(char *buf, int size, FILE *in)
>  		if (c == '\n' || len + 1 >= size)
>  			break;
>  	}
> +	if (c == '\n' && len > 1 && buf[len - 2] == '\r')
> +		buf[--len - 1] = '\n';
>  	buf[len] = '\0';
>  
>  	return len;

What if \r lands at character 99 and \n is at character 100?  If buf has
exactly 100 characters available for writing.  Wouldn't the '\r' be stored
into buf, but not the '\n'?  Then the 'for' loop would terminate since len + 1
would be >= size and the code above would test whether c == '\n', and it
would not, so the '\r' would not be removed from buf as it should be.

At the point where buf has been filled, and the last character read is a '\r',
we can not tell whether the next character is a '\n' or not, so we do not know
if it is a solitary '\r' or whether it is the start of a '\r\n' sequence.  It
seems to me that we must push the '\r' back into the stream and allow the next
call to read_line_with_nul() handle it, or peek to see if the next character
is a '\n'.

Be aware that if we use the version I suggested which pushes the '\r' back
into the input stream, I think we risk an infinite loop if size == 1.  I don't
think that is possible from the current callers though.

-brandon
