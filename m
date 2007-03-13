From: "Don Zickus" <dzickus@gmail.com>
Subject: Re: [PATCH 2/5] add the ability to select more email header fields to output
Date: Mon, 12 Mar 2007 21:21:25 -0400
Message-ID: <68948ca0703121821h72f6c08ak9f38cae40240ac59@mail.gmail.com>
References: <11737291282223-git-send-email-dzickus@redhat.com>
	 <11737291281648-git-send-email-dzickus@redhat.com>
	 <7vveh6nes9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Don Zickus" <dzickus@redhat.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 02:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQvhm-0005Ly-6y
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 02:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbXCMBVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 21:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbXCMBVb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 21:21:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:40265 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbXCMBVa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 21:21:30 -0400
Received: by ug-out-1314.google.com with SMTP id 44so76151uga
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 18:21:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mlIQcVNcsEKIgGthv0iSvZRGsrBvOzjard77C4IE2+pY35fot2gP84XbvDxNP7nkOe2tzfJJJTBfb4KTwIMTGkSCNiPvXMPn8Mboil7PDRmI1FE8jFOsBOgu1RH0SnMSVzmlqZyS3MChiGj+0ovrNjaPrlzZQVHV3CtOvA++lu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sWP6b/Td3H46DELnTjxNmfi8x1Bc+xjAHzhd9H3pwh45ZyZF4aJqwEIHoTxvxWnd8KrvA25iexqO0ZAnO/sVbsib3BVC068uwVz1nfwhcK9zu6wX9HMzxWSffBC1m1g4yITl6w4JtpZv8/7pRFZWNRncbAKFtd5ZR/ZbI5PV0RU=
Received: by 10.115.78.1 with SMTP id f1mr2184248wal.1173748885449;
        Mon, 12 Mar 2007 18:21:25 -0700 (PDT)
Received: by 10.114.159.18 with HTTP; Mon, 12 Mar 2007 18:21:25 -0700 (PDT)
In-Reply-To: <7vveh6nes9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42104>

On 3/12/07, Junio C Hamano <junkio@cox.net> wrote:
> Don Zickus <dzickus@redhat.com> writes:
>
> > This is useful when scripts need more than just the basic email headers to
> > parse.  By specifying the "-x=" option, one can search and output any header
> > field they want.
>
> It probably is useful, but that is rather difficult to judge,
> unless you have a specific use in the scripts (am/applymox).

I have my own custom clone of git-am I am using to extract the
Message-id, In-Reply-To, and References fields.  For awhile I had the
fields hardcoded in my version of git-mailinfo.  But instead of
maintaining it, I was hoping I could push it upstream.  One less thing
to maintain on my own.  :-)

>
> > @@ -870,6 +871,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
> >       def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
> >       metainfo_charset = def_charset;
> >
> > +     for (top=0; header[top]; top++){ ; }
> > +
> >       while (1 < argc && argv[1][0] == '-') {
> >               if (!strcmp(argv[1], "-k"))
> >                       keep_subject = 1;
> > @@ -879,7 +882,10 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
> >                       metainfo_charset = NULL;
> >               else if (!prefixcmp(argv[1], "--encoding="))
> >                       metainfo_charset = argv[1] + 11;
> > -             else
> > +             else if (!prefixcmp(argv[1], "-x=")) {
> > +                     header[top] = xmalloc(256*sizeof(char));
> > +                     strncpy(header[top++], argv[1]+3, 256);
>
> Return "-ETOOMANYEXTRAHEADERSHEADERS" when top overflows,
> perhaps?

yup.  i'll fix that.

>
> You seem to omit SP around '=' in initializers (the first part
> of for loop and "typename var=init" at the beginning of block)
> but not in an assignment expression used as a freestanding
> statement.  Is this recommended by some coding style I am not
> aware of, or it it just your habit?  It is somewhat irritating

mainly habit.  I don't have a preference.  I'll clean up what I find and repost.

> to my eyes, although they might be syntactically different class
> and you might be using one from the other consistently (but in
> [1/5] some SP around '=' in assignments are omitted, and there
> does not seem to be any such consistency).
>
> And a micronit on [1/5] in the series.  I do not think "less
> than zero" comment applies to what is being done, and I do not
> think it needs to be explained what the code is doing by
> checking return value from strcasestr() with NULL.
>
> +       char boundary[256];
> +
> +       /* the only time this return less than zero is when
> +          /line/ does not contain "text/"
>          */
> -       if (strcasestr(line, "boundary=")) {
> -               fprintf(stderr, "Not handling nested multipart message.\n");
> -               exit(1);
> +       if (strcasestr(line, "text/") == NULL)
> +                message_type = TYPE_OTHER;
>

oops.  left over comment from old code.  I'll clean that up.

Cheers,
Don
