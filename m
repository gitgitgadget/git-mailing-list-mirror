From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Sat, 22 Jan 2011 13:18:01 -0600
Message-ID: <20110122191801.GB13023@burratino>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
 <7vtyh4smer.fsf@alter.siamese.dyndns.org>
 <20110119214827.GA31733@burratino>
 <20110120045046.GB9493@kytes>
 <1295531623.4298.26.camel@drew-northup.unet.maine.edu>
 <20110122092416.GA7827@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 22 20:18:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pgiym-0003OY-Vt
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 20:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab1AVTSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jan 2011 14:18:25 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49394 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab1AVTSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jan 2011 14:18:24 -0500
Received: by yxt3 with SMTP id 3so870457yxt.19
        for <git@vger.kernel.org>; Sat, 22 Jan 2011 11:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QCbQ9daByflKENVIqytE7ASC+j0LHxqcSntlWxyuz6M=;
        b=dPQO87kqS/le6BLFFfjsV91m8irKjdCvn9H8Vyrja/MR9UZLjeaCJY8qPNK2702M6r
         hpbJJ2jyNZxjDpWIgJXF6thxhDSSEyulSGuBdoye2bRmaReWnTANVaANmtzyxJIa58WG
         kYhoPT29MFQ895m69hAui9bKGhaAY0uO91ess=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vLzjkqJKwpdny1fiGgnm/rLnLHAGUOpxFnQkJfUfnSo9SlvVpVggP5gqOj0JQhnGgD
         tlDI8zh0k9+WkcPl+G1JpxDK+cE9J7ANhYg+FdQW0Krvw3XbVFrxfZqIqOt13bphm914
         3LG/pzceprIiTstmB7t/A6Fh55bzoQCl014BE=
Received: by 10.151.18.19 with SMTP id v19mr2394768ybi.428.1295723903462;
        Sat, 22 Jan 2011 11:18:23 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id k1sm7148684ybj.0.2011.01.22.11.18.20
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 22 Jan 2011 11:18:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110122092416.GA7827@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165414>

Ramkumar Ramachandra wrote:

> Agreed. I wouldn't like to introduce an extra dependency either. I was
> talking about using it for prototyping- if the final version includes
> an extra dependency, it's unlikely to get merged into git.git :) The
> final design will probably use an in-memory B+ tree, but I haven't
> thought about that hard enough.

Immediate reaction:

Please no.  There is a value to simplicity.

As you mention, the final form is a way off, so as long as people are
careful not to get locked into bad implementation decisions, I think
it is okay.  I have refrained from nitpicking the implementation so
far because the design and interface are not obvious yet.

In this particular case, I am dreaming that we will discover a hidden
"mkdir -p" node-action in the dumpfile format so the list of
directories will not be needed. ;-)

Re Junio's critique:

is it possible to use

1) a table with callbacks?  See the source code to unifdef for
   inspiration.

2) separate code paths for different input states?  fast-import.c
   does this.

3) separate "parsing" and "acting" code?  That can open the door to a
   little paralellism, though not necessarily enough to matter.

	parser                              actor

	read a chunk
	determine the first "thing to do"
	                                    pick up the first "thing to do"
	                                    do it
	determine the next "thing to do"
	                                    pick up the next "thing to do"
	                                    do it

   There is potential parallelism because the parser can keep
   chugging along if the actor is blocked, say, writing its
   output to the network.

   Syntactically: the actor function (write_dump) calls the parser
   function (next_command) to ask what to do next.  If wanted, a later
   refactoring could make that parser function just grab an action off
   of a queue, while the parser proper runs in the background.
  
   And of course if the "thing to do" data structure is simple enough,
   this can also make the code easier to read.

I mention these ideas because some of them (especially #2) could make
the prototyping a lot easier as well as resulting in code that is
easier to review.

Re error handling:

Writing robust code (e.g., checking for errors) is also a lot easier
when done from the start.  The svn-fe error handling is known to be a
problem (see BUGS in contrib/svn-fe/svn-fe.txt).  So yes, I also
consider avoiding segfaults and deadlocks and catching parse errors to
be worthwhile things.

Thanks.
Jonathan
