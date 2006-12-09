X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 9 Dec 2006 14:56:28 +1300
Message-ID: <46a038f90612081756w1ab4609epcb4a2cbd9f4d8205@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
	 <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>
	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
	 <45798FE2.9040502@zytor.com>
	 <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
	 <457998C8.3050601@garzik.org>
	 <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 01:56:37 +0000 (UTC)
Cc: "Jeff Garzik" <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kL5XH7M5wJi7AeNuwjH16HPNtQ4TFiwTwHJj94SGL9UoV3YLom6w/dMhv06h94nNR+uAeGZROWrQrUiGWBNY/bAtabIGrYV3/Ngms/Vq3UTlE8teyEbj7L7cUimASGcQZo/0DiC4ncqQgJkAgEEaX6HYNRADHy7ooDo3fa3ydNY=
In-Reply-To: <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33788>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsrS5-0002e8-Sb for gcvg-git@gmane.org; Sat, 09 Dec
 2006 02:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947748AbWLIB4b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 20:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1948042AbWLIB4b
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 20:56:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:13215 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947748AbWLIB4a (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 20:56:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1292929nfa for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 17:56:29 -0800 (PST)
Received: by 10.48.220.12 with SMTP id s12mr6318446nfg.1165629388812; Fri, 08
 Dec 2006 17:56:28 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Fri, 8 Dec 2006 17:56:28 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Actually, just looking at the examples, it looks like memcached is
> fundamentally flawed, exactly the same way Apache mod_cache is
> fundamentally flawed.

I don't know if fundamentally flawed but (having used memcached) I
don't think it's a big win for this at all.

We can make gitweb to detect mod_perl and a few smarter things if it
is running inside of it. In fact, we can (ab)use mod_perl and perl
facilities a bit to do some serialization which will be a big win for
some pages. What we need for that is to set a sensible the ETag and
use some IPC to announce/check if other apache/modperl processes are
preparing content for the same ETag. The first-process-to-announce a
given ETag can then write it to a common temp directory (atomically -
write to a temp-name and move to the expected name) while other
processes wait, polling for the file. Once the file is in place the
latecomers can just serve the content of the file and exit.

(I am calling the "state we are serving" identifier ETag because I
think we should also set it as the ETag in the HTTP headers, so well
be able to check the ETag of future requests for staleness - all we
need is a ref lookup, and if the SHA1 matches, we are sorted). So
having this 'unique request identifier' doubles up nicely...

The ETag should probably be:
 - SHA1+displaytype+args for pages that display an object identified by SHA1
 - refname+SHA!+displaytype+args for pages that display something
identified by a ref
 - SHA1(names and sha1s of all refs) for the summary page

> You can't have a cache architecture where the client just does a "get",
> like memcached does. You need to have a "read-for-fill" operation, which
> says:

You _could_ make do with a convention of polling for "entryname" and
"workingon-entryname" and if "workingon-entryname" is set to 1, you
can expect entryname to be filled real soon now. However, memcached is
completely memorybound, so it is only nice for really small stuff or
for a large server farm which has gobs of spare ram.

(Note that memcached does have timeouts which means that the
'workingon' value could have a short timeout in case the request is
cancelled or the process dies - the nasty bit in the above plan would
be the polling.)

> I still don't understand why apache doesn't do it. I guess it wants to be
> stateless or something.

Apache doesn't do it because most web applications don't use the HTTP
procol correctly - specially when it comes to the idempotency of GET.
So in 99% of the cases, web apps serve truly different pages for the
same GET request, depending on your cookie, IP address, time-of-day,
etc.

Most websites deal with very little traffic, so this isn't a problem.
And many large sites that serve a lot of traffic from a dynamic web
app want to be serving custom ads, let you login and see your
personalised toolbar, etc,etc, so this wouldn't work for them either.

So in practice, serialising speculatively on GET requests for the same
URL has very little payoff except for static content. And that's quite
fast anyway.... specially if the underlying OS is smokin' fast ;-)

cheers,



