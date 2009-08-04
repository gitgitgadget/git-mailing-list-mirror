From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH v2] Let mailsplit and mailinfo handle mails with CRLF
 	line-endings
Date: Tue, 04 Aug 2009 17:23:37 -0500
Message-ID: <wRnQVVBBRdMB02QMyBKhevKFGLitcB-E36esB_Ar_XFs9upXB_szkQ@cipher.nrlssc.navy.mil>
References: <4A7735B0.2040703@zytor.com> <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com> <7v7hxk5b4y.fsf@alter.siamese.dyndns.org> <20090804172638.GA15136@blimp.localdomain> <20090804210327.GA23747@blimp.localdomain> <H9KDJzU0XgndJHC8J4OETn7kxYhGP3gl0YJPR0low0hfIHjZOUsoxw@cipher.nrlssc.navy.mil> <81b0412b0908041458w7e76854bn96c4cb71a5e91e74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYSQ9-0000dd-Bh
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 00:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933508AbZHDWXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 18:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933500AbZHDWXl
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 18:23:41 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39919 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933492AbZHDWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 18:23:40 -0400
Received: by mail.nrlssc.navy.mil id n74MNb2D008748; Tue, 4 Aug 2009 17:23:38 -0500
In-Reply-To: <81b0412b0908041458w7e76854bn96c4cb71a5e91e74@mail.gmail.com>
X-OriginalArrivalTime: 04 Aug 2009 22:23:37.0833 (UTC) FILETIME=[36709590:01CA1552]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124829>

Alex Riesen wrote:
> On Tue, Aug 4, 2009 at 23:29, Brandon
> Casey<brandon.casey.ctr@nrlssc.navy.mil> wrote:
>> Alex Riesen wrote:
>>> +     if (c == '\n' && len > 1 && buf[len - 2] == '\r')
>>> +             buf[--len - 1] = '\n';
>>>       buf[len] = '\0';
>>>
>>>       return len;
>> What if \r lands at character 99 and \n is at character 100?  If buf has
>> exactly 100 characters available for writing. ...
> 
> Ah, yes. You're right.
> 
> I have strong dislike towards unget, though. How about this, instead:
> 
> int read_line_with_nul(char *buf, int size, FILE *in)
> {
> 	int len = 0, c;
> 
> 	while (len < size) {
> 		c = getc(in);
> 		if (c == EOF)
> 			break;
> 		buf[len++] = c;
> 		if (c == '\n')
> 			break;
> 		else if (len == size)
> 			c = 0;
> 	}
> 	if (c == '\n' && len > 1 && buf[len - 2] == '\r')
> 		buf[--len - 1] = '\n';
> 	buf[len] = '\0';
> 
> 	return len;
> }


I don't see how this solves the problem.  Still if the buffer is filled,
and the last character read is '\r', and the next character that has not
yet been read is '\n', then the '\r' will erroneously be returned in buf.

Plus, I think you'll have a problem at buf[len] = '\0' if the loop runs to
completion and len == size.

-brandon
