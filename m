X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 13:59:10 +0100
Message-ID: <e5bfff550612110459w205cb9b3lf735359012f84f7c@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>
	 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
	 <457D4386.70408@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 12:59:21 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mouhyvh/Fn5hIpNcTAEupF/S+CKp8i8XFpHMObBKGi/4Y4fkFmiuz/ttOnEtBipsh/MQPwCwKkR360xrJHkaPJqUbtPSaRGaoEAZkOmRcG1O9SM4tHwHRuLXi38QzN7YaBqjQ1oCLzLbECDRQb7Q4oxxgd+VJCXCBXwGQaL5dC8=
In-Reply-To: <457D4386.70408@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34000>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtkkW-0006rq-Ng for gcvg-git@gmane.org; Mon, 11 Dec
 2006 13:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762890AbWLKM7N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 07:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762886AbWLKM7M
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 07:59:12 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:33015 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762890AbWLKM7L (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 07:59:11 -0500
Received: by py-out-1112.google.com with SMTP id a29so910335pyi for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 04:59:11 -0800 (PST)
Received: by 10.35.77.1 with SMTP id e1mr3924307pyl.1165841950859; Mon, 11
 Dec 2006 04:59:10 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Mon, 11 Dec 2006 04:59:10 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
Sender: git-owner@vger.kernel.org

On 12/11/06, Andreas Ericsson <ae@op5.se> wrote:
> Marco Costalba wrote:
> > On 12/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >>
> >> Why don't you use the pipe and standard read()?
> >>
> >> Even if you use "popen()" and get a "FILE *" back, you can still do
> >>
> >>         int fd = fileno(file);
> >>
> >> and use the raw IO capabilities.
> >>
> >> The thing is, temporary files can actually be faster under Linux just
> >> because the Linux page-cache simply kicks ass. But it's not going to be
> >> _that_ big of a difference, and you need all that crazy "wait for
> >> rev-list
> >> to finish" and the "clean up temp-file on errors" etc crap, so there's no
> >> way it's a better solution.
> >>
> >
> > Two things.
> >
> > - memory use: the next natural step with files is, instead of loading
> > the file content in memory and *keep it there*, we could load one
> > chunk at a time, index the chunk and discard. At the end we keep in
> > memory only indexing info to quickly get to the data when needed, but
> > the big part of data stay on the file.
> >
>
> memory usage vs speed tradeoff. Since qgit is a pure user-app, I think
> it's safe to opt for the memory hungry option. If people run it on too
> lowbie hardware they'll just have to make do with other ways of viewing
> the DAG or shutting down some other programs.
>
> > - This is probably my ignorance, but experimenting with popen() I
> > found I could not know *when* git-rev-list ends because both feof()
> > and ferror() give 0 after a fread() with git-rev-list already defunct.
> > Not having a reference to the process (it is hidden behind popen() ),
> > I had to check for 0 bytes read after a successful read (to avoid
> > racing in case I ask the pipe before the first data it's ready) to
> > know that job is finished and call pclose().
> >
>
> (coding in MUA, so highly untested)
>

Thanks Andreas, I will do some tests with your code. But at first
sight I fail to see (I'm not an expert on this tough ;-)  ) where is
the difference from using popen() and fileno() to get the file
descriptors.

Thanks
