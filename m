X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Fri, 15 Dec 2006 21:41:28 +0100
Message-ID: <e5bfff550612151241pd11f49eqd1666ce0b33855b6@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <200612112128.06485.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612111238560.3515@woody.osdl.org>
	 <200612112154.56166.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612111258050.3515@woody.osdl.org>
	 <e5bfff550612151045q5782e1f2j8686ccab24dbf566@mail.gmail.com>
	 <Pine.LNX.4.64.0612151118270.3849@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 20:41:40 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=To7AcA0ospxtBkQF2rWbf2YgD4Ac+5DY/BjJrsEwWwK3gh2VQ394HD9bgfBZEaf0QoSLQC3UvTsnT7uLP9ZSV4COtFRHLUXA5htShToucoN2WRjhtTl7sq/Ezy68mN+1M8bDdof/HXavJWffa6YKPAFzoZQw9h0m2St+JVziUk4=
In-Reply-To: <Pine.LNX.4.64.0612151118270.3849@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34547>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvJs4-00051r-V4 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 21:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753438AbWLOUla (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 15:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbWLOUla
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 15:41:30 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:40837 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753438AbWLOUl3 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 15:41:29 -0500
Received: by py-out-1112.google.com with SMTP id a29so499571pyi for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 12:41:29 -0800 (PST)
Received: by 10.35.89.10 with SMTP id r10mr2320100pyl.1166215288953; Fri, 15
 Dec 2006 12:41:28 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Fri, 15 Dec 2006 12:41:28 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/15/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 15 Dec 2006, Marco Costalba wrote:
> >
> > Warmed-up cache
> > QProcess 7632ms (500ms data read interval)
> > QProcess 7972ms (100ms data read interval)
>
> Why do you even bother posting numbers, when multiple people have told you
> that the numbers you post are meaningless?
>
> As long as you throttle the writer by not reading data in a timely fashion
> (by using poll() or select() in the main loop and reading when it's
> available), and you continue to talk about "data read intervals", all your
> numbers are CRAP.
>

QProcess implementation is like this FWIK (from
qt-x11-free-3.3.4/src/kernel/qprocess_unix.cpp):

The SIGCHLD handler writes to a socket to tell the manager that
something happened. Then in  QProcessManager::sigchldHnd() data is read by

process->socketRead( proc->socketStdout );


In QProcess::socketRead() a call to C function read() is done to get
4KB of data:

const int basize = 4096;
QByteArray *ba = new QByteArray( basize );
n = ::read( fd, ba->data(), basize );


The pointer ba is then appended to a pointer list.

This happens _ALWAYS_ indipendently of _how_ the application calls the
Qt library for reading.

When application read recieved data with QProcess::readStdout(), then
data stored in buffers pointed by the pointer list is memcpy() to a
temporary array that is the return value of QProcess::readStdout().
See in qt-x11-free-3.3.4/src/kernel/qprocess.cpp:

QByteArray QProcess::readStdout()
{
    if ( readStdoutCalled ) {
	return QByteArray();
    }
    readStdoutCalled = TRUE;
    QMembuf *buf = membufStdout();
    readStdoutCalled = FALSE;

    return buf->readAll();  // here a memcpy() is involved
}


So it' true that we use a timeout, but only to trigger a memcpy() from
Qt internal library buffers that, instead are feeded as soon as
possible by Qt implementation.

IOW the timely select() is already done by Qt library. We just read
what has been already received and stored.

   Marco

