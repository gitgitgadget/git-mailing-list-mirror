From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [msysGit] Re: Need your help with MinGW Issue 17: --color options don't work (produce garbage)
Date: Wed, 15 Aug 2007 09:31:21 +0100
Message-ID: <3f4fd2640708150131o7578c2efy806891fc3def7429@mail.gmail.com>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>
	 <3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>
	 <a1bbc6950708150103v35330b47o781fb5d74e3d9aef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 10:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILEHp-0008WI-5O
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 10:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981AbXHOIbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbXHOIbY
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 04:31:24 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:9455 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbXHOIbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 04:31:22 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1668380rvb
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 01:31:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ViG7uuiwK6kXNbXmWfjvZbTAsyhPxxeqTG/9bsFr9Va+6XtKn39I3uSqUpXw7Ta+XsNxqOq7g8YrjrACRDiaydQbAATfJkZ+8p72lmjwGUSJ4dFq/qKWLV9CWuo3Xdh6xGm8/iWBrrXZsMbVNa6m3/iL6gBKOSabHHZJS4QBZFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FekMjIRI5DQ3jw9zaQ/xZGdQcwBJcbeYZ5GiQcJm8J9DX/VeS/HodG1RxW0ZL1M2AXser31SLz4CR1TTGRe8dzIFKqBMDAUyxBTvBNptPk201BeyzjKhYBp7PSbEeGrwwnnDmSij3k+QRpqD8bZRhlHmlBYP92GDVhs2toGFSio=
Received: by 10.141.88.3 with SMTP id q3mr92522rvl.1187166681190;
        Wed, 15 Aug 2007 01:31:21 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Wed, 15 Aug 2007 01:31:21 -0700 (PDT)
In-Reply-To: <a1bbc6950708150103v35330b47o781fb5d74e3d9aef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55888>

On 15/08/07, Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
> On 8/15/07, Reece Dunn <msclrhd@googlemail.com> wrote:
> >
> > On 15/08/07, Dmitry Kakurin wrote:
> > > Here are the facts:
> > >
> > > 'git branch --color' produces garbage:
> > > $ git branch --color
> > >   devel←[m
> > >   dima←[m
> > >   dmitryk←[m
> > > * ←[32mmaster←[m
> > >   mob←[m
> > >   next←[m
> > >
> > > 'git branch --color | cat' produces expected colored output.
> > >
> > > I've traced it down to printf statement in gdb and it sends the right
> > > esc-sequence.
> > > Where should I look next?
> >
> > Windows doesn't recognise the *nix printf colour codes.
> >
> > Piping through cat will be going through cygwin/mingw emulation,
> > translating the colour codes to the correct API calls.
>
> That's my question. If there is a way to build cat.exe to do this kind
> of emulation under MinGW then I should be able to do the same for
> git.exe.
> I hope I just need to #define something while building Git.
> But what is it?

You will need to implement cat (or something similar) on MinGW that
will process the *nix colour codes and then pass that to
SetConsoleTextAttributes. For example:

    int ch = 0;
    while(( ch = getch()) != EOF )
    {
        if( /*ch is part of a colour sequence*/ )
        {
            SetConsoleTextAttribute( GetStdHandle(...),
win_color_from_color_sequence(...));
        }
        else putc( ch );
    }

I don't believe that MinGW has got this working for cat, that is why
one that supports colours on Windows needs to be written.

- Reece
