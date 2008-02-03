From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH RESEND] Avoid a useless prefix lookup in strbuf_expand()
Date: Sun, 3 Feb 2008 23:22:36 +0100
Message-ID: <e5bfff550802031422q7ac72ee4ra53bb4152e34ea29@mail.gmail.com>
References: <1201950593-6119-1-git-send-email-mcostalba@gmail.com>
	 <7vsl09u2oz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLnF5-00029x-1E
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYBCWWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYBCWWj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:22:39 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:10481 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbYBCWWi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:22:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1312493rvb.1
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ocad2u49/jkInkARU53TY/rpv4WidoFLPaLRUQtKVAs=;
        b=xFWRlrMsIFixaf+BXvxQlXf3Aoxd439w6rrCPcYkjkhAUnAsbQCxAh69Ijz3SCt3X1DEqTULITOncf6bMvcys4hYwVgwWtAaXe9g2y5Tjij5F17Fu6KJUwcY9LWdTZD0366YG6wKfGDsNpzpDQDPKrxQdczT11rzlMgxemhIY6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XaXK9rl0uMQuuZuVsTn1P8l6haZfdipiKEMw6DRAoRouMhorTfcKuCZ0UNP42rJm2E7z6eBY7QX0WJ5Z4Uo72pes7RRvHLZL6OgKgaF5CVpsTgNqXRTDCVRwci0ROMuI2ENSUWo9/m7HF81hWYgnGS1xR4b6wGleNvHVsdyvbBY=
Received: by 10.140.133.16 with SMTP id g16mr4211232rvd.231.1202077356879;
        Sun, 03 Feb 2008 14:22:36 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 3 Feb 2008 14:22:36 -0800 (PST)
In-Reply-To: <7vsl09u2oz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72411>

On Feb 3, 2008 10:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Marco Costalba <mcostalba@gmail.com> writes:
>
> >
> > -static void format_person_part(struct strbuf *sb, char part,
> > +/* returns placeholder length or 0 if placeholder is not known */
>
> That "return placeholder length" is a bit confusing, and I suspect
> the reason may be because the interface is misdesigned.
>
> This function gets only a single character "part" and adds the
> matching information to sb if found, otherwise it doesn't, so
> the only possible return values are 0 or 2.
>
> Wouldn't it be much cleaner if this returned a bool that says "I
> found and substituted that 'part' you asked me to handle"?
>

It happens that _currently_ placeholders that start with 'a' or 'c'
have length of 2 chars, so return value can be only 0 or 2, but this
is by accident, the return value is really the length of parsed
placeholder. Indeed if you see the return value of the caller
format_commit_item() is also the length of the parsed placeholder and
so should be our format_person_part() whom return value is forwarded
by caller:

from format_commit_item()

	case 'a':	/* author ... */
		return format_person_part(sb, placeholder[1],
		                   msg + c->author.off, c->author.len);



> >       /*
> >        * If it does not even have a '<' and '>', that is
> >        * quite a bogus commit author and we discard it;
> > @@ -301,65 +303,72 @@ static void format_person_part(struct strbuf *sb, char part,
> >        * which means start (beginning of email address) must
> >        * be strictly below len.
> >        */
> > -     start = end + 1;
> > -     if (start >= len - 1)
> > -             return;
> > -     while (end > 0 && isspace(msg[end - 1]))
> > -             end--;
>
> The comment you can see in the context seems to refer to the
> logic implemented by the part you are rewriting.  Don't you need
> to update it?

Why? if I had written

end_of_data = (end > len - 1);

instead of

end_of_data = (end >= len - 1);

I agree with you comment would have been obsoleted but is not the case.

>
> > +     end_of_data = (end >= len - 1);
> > +
>
> The variable name "end_of_data" is unclear.  What does this
> boolean mean?  The line is without address and timestamp?
> The item you are parsing is not properly terminated?
>

It means "we have nothing more to parse here" and we _could_ return
now but we keep on because we need to know if the part placeholder is
valid or is unkown, so we really need to go through following switch
statement before to return with a correct return value.


> >       if (part == 'n') {      /* name */
> > -             strbuf_add(sb, msg, end);
> > -             return;
> > +             if (!end_of_data) {
> > +                     while (end > 0 && isspace(msg[end - 1]))
> > +                             end--;
> > +                     strbuf_add(sb, msg, end);
> > +             }
> > +             return 2;
> >       }
> > +     start = ++end; /* save email start position */
>
> What happens if end_of_data was already true in this case, I
> have to wonder...  Language lawyers may point out that the
> result of ++end would be undefined, which I do not personally
> care about in this case, but this feels dirty if not wrong.
>

Could be dirty, but is not wrong because when end_of_data flag as is
set as is the case, any use of 'end' variable is skipped, only the
following swicth statement is evaluated with the only purpose to
compute a valid return value.


Thanks for your review
Marco
