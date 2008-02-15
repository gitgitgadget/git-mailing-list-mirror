From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain messages
Date: Fri, 15 Feb 2008 11:35:28 -0500
Message-ID: <76718490802150835i3f56cc03r149b5ecf946bbd58@mail.gmail.com>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.LSU.1.00.0802151035100.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 17:36:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ3Xj-0001hd-1w
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 17:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbYBOQfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 11:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbYBOQfe
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 11:35:34 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:9653 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707AbYBOQfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 11:35:32 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1133222wra.23
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7+UO2q8oPVdGBSf6tgVykUb5SShbZwuMEWSfS1efH7o=;
        b=PwRfeiY7JX8dW0cQ2ed3dVzu4XzeSuGm2y7iY2b9X7bcNX80BQt+iZ9oSJM/cyEKMINiq4WdZfmka/7tgyC3JKxIas2tfDUqbKxao4myBBPROTcipGP/dihszIHBGvN+pF4DLlOJnLgyE/+pmXgOBKBlKNuhuYBy+be6cV0xqeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h/MMUNkYPM1nWoGa5h6IXDoNQTvD6lpGErEiLdOpt1wj3dMF1jmPRu3hQeRAJ9daoLayn2P8r+G+YU6onMfUIKk2gOKAm0mJpozyXn+yYdzn4BYHz8Iprv/Msnh2MjxMX+1ONT34ha+0WE//1M6tCUDuqS2hxdHw7xW9QXjdBe8=
Received: by 10.114.78.1 with SMTP id a1mr3167010wab.14.1203093328802;
        Fri, 15 Feb 2008 08:35:28 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 08:35:28 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802151035100.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73956>

On Fri, Feb 15, 2008 at 5:41 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>  Why not call it "enum message_format"?

It's only applicable to text/plain messages. Then again, this will be
set to FORMAT_NONE for non-text/plain messages so I guess that's just as
good a name.

BTW, since all I care about is format=flowed, I could just as easily use
an int and call it something like message_is_flowed. This would actually
simplify the code a bit but I was trying to follow the existing code
which uses an enum for message_type that could similarly have been an
int called message_type_is_text.

>  Why not call it "enum message_is_delsp"?

Sure, my reasoning is same as above.

>  > @@ -193,6 +200,18 @@ static int handle_content_type(char *line)
>  >
>  >       if (strcasestr(line, "text/") == NULL)
>  >                message_type = TYPE_OTHER;
>  > +     else if (strcasestr(line, "text/plain")) {
>  > +             char attr[256];
>  > +             if (slurp_attr(line, "format=", attr) && !strcasecmp(attr, "flowed")) {
>  > +                     tp_format = FORMAT_FLOWED;
>  > +                     if (slurp_attr(line, "delsp=", attr) && !strcasecmp(attr, "yes"))
>  > +                             tp_delsp = DELSP_YES;
>  > +                     else
>  > +                             tp_delsp = DELSP_NO;
>  > +             }
>  > +             else
>  > +                     tp_format = FORMAT_FIXED;
>
>  Does that mean that the format is only set if the content type is
>  "text/plain"?

tp_format is initially set to FORMAT_NONE. Only for text/plain is it
them set to FORMAT_FIXED or FORMAT_FLOWED. Again, though, all I care
about is format=flowed so I could be using an int called
message_is_flowed but was following the enum message_type example.

>  > +     if (tp_format == FORMAT_FLOWED && !!strcmp(line, "-- \n")) {
>
>  The !! is unnecessary; please skip it.

Heh. I'd never seen that before I started perusing the git code, I was
just following along. But looking more carefully now I see that the
other code only does that if it's assigning to an int. I see that it's
not needed in a boolean context.

>  How about using strchrnul()?

Cool. I'd never heard of it.

>  > +                     if (cp > line && *cp == '\n' && *(cp-1) == ' ') {
>  > +                             if (tp_delsp == DELSP_YES)
>  > +                                     *(cp-1) = '\0';
>  > +                             else
>  > +                                     *cp = '\0';
>  > +                     }
>
>  Or maybe
>                                 cp[0 - (tp_delsp == DELSP_YES)] = '\0';
>
>  But maybe that is too cute.

Heh, I think that's too clever by half.

>  But another thing struck me here: why setting *cp = '\0'; only if *(cp-1)
>  == ' ', even if tp_delsp != DELSP_YES?

" \n$" indicates the line is flowed, meaning the MUA added the '\n' to
the line and we need to remove it. The next question is whether the
space before the '\n' was also inserted by the MUA. If DELSP_YES, it
was, so we want to remove it, else it was an existing space that we want
to keep.

>  > @@ -818,6 +857,7 @@ static void handle_body(void)
>  >
>  >               switch (transfer_encoding) {
>  >               case TE_BASE64:
>  > +             case TE_QP:
>  >               {
>  >                       char *op = line;
>
>  Did that just slip in, or was this intended.  If the latter, is this
>  related to format=flawed, or is it a bug fix in its own right?

It was intended. The patch doesn't have enough context to have included
this comment inside the TE_BASE64 case:

	/* this is a decoded line that may contain
	 * multiple new lines.  Pass only one chunk
	 * at a time to handle_filter()
	 */

It turns out that decoding QP can also cause a decoded line to contain
extra newlines. So it's a bug fix, but I'm not sure it mattered before.
I'll break it out into a separate patch though to make that clear. And I
know I should add a test first for that fix, but ugh, figuring out the
test case for a one-line code change is painful.

Thanks for the comments, I'll follow up with a revised patch.

j.
