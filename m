From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [RFC PATCH] Support gitlinks in fast-import/export.
Date: Fri, 18 Jul 2008 22:34:46 +0400
Organization: TEPKOM
Message-ID: <200807182234.47363.angavrilov@gmail.com>
References: <200807182103.37272.angavrilov@gmail.com> <alpine.DEB.1.00.0807181810400.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJuoF-0003QG-RU
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 20:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYGRSfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 14:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbYGRSfE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 14:35:04 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:40548 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbYGRSfB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 14:35:01 -0400
Received: by fk-out-0910.google.com with SMTP id 18so307464fkq.5
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sKvwkBVFXJE4KP/UWzXHJzEV/B56rGsHpXl+uH2ATGQ=;
        b=DiJpi0wnlLMRHyK6m5jPiDcegHFeFbcM/vogGY8H0I11Fl41eEQEJuPalfLs38zKNM
         lwg5rjqoVUlbjOyfPn1r4yY0BNdwvfACoSMAdLJmHRuL0z9zTsqGUIQ0gkVa2FYR25k3
         /cJhcJHNU97UssOABz6yaV9T61S+lhst4xAlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xFE5424dOlke8k/P5tLwWeLt2XG7fmflL5kjNtlzs5HdX2J7b2Qdhqs91m/7411NJ1
         Gbjefdg0JpRU3ywC7uIQOi2/FgI0UvG4kqIkxdM18emhTRtpofbykZdiOEztzp6Z8i7G
         gUEM0reyiwrvogKF3PNaiBEK/8GXO/aJOGg20=
Received: by 10.86.60.15 with SMTP id i15mr783041fga.43.1216406099873;
        Fri, 18 Jul 2008 11:34:59 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 4sm2870992fgg.9.2008.07.18.11.34.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 11:34:58 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807181810400.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89071>

Hello,

On Friday 18 July 2008 21:36:26 Johannes Schindelin wrote:
> > 	What I'm unsure of is, should fast-export try to reuse commit
> > 	marks for gitlinks where it happened to recognize the object,
> > 	or always output the SHA as it is stored in the tree?
 
> Are they commit marks?  No.  So they should be handled as marks, just as 
> those for blobs and trees.
> 
> (They are commit marks in the _submodule_, but that does not matter here.)

Well, I was thinking of that unlikely case when the master module and the submodule
are in the same repository and are exported together. But probably it is best to just
output the SHA after all.

> >  	for (i = 0; i < diff_queued_diff.nr; i++)
> > -		handle_object(diff_queued_diff.queue[i]->two->sha1);
> > +		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
> > +			handle_object(diff_queued_diff.queue[i]->two->sha1);
> 
> Why?  You do not want to export changes in the submodules?

handle_object opens the sha as a blob and outputs it. As gitlinks aren't blobs, it won't work.
And if the submodule is in a separate repository, there is nothing to open anyway.

Simultaneously reading commits from the submodule repository is a whole different level
of complexity. I'm afraid I'm not up to it yet.

> > diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> > index d0a462f..14b1549 100644
> > --- a/builtin-fast-export.c
> > +++ b/builtin-fast-export.c
> > @@ -123,8 +123,19 @@ static void show_filemodify(struct diff_queue_struct *q,
> >  			printf("D %s\n", spec->path);
> >  		else {
> >  			struct object *object = lookup_object(spec->sha1);
> > -			printf("M %06o :%d %s\n", spec->mode,
> > -			       get_object_mark(object), spec->path);
> > +			int mark = object ? get_object_mark(object) : 0;
> 
> As I said, that looks wrong.  Maybe we have to fake objects for the 
> gitlinks.

I tried to avoid faking blobs and stick to the interface of the M command itself.

> > @@ -1900,7 +1901,16 @@ static void file_change_m(struct branch *b)
> >  		p = uq.buf;
> >  	}
> >  
> > -	if (inline_data) {
> > +	if (S_ISGITLINK(mode)) {
> > +		if (inline_data)
> > +			die("Git links cannot be specified 'inline': %s",
> > +				command_buf.buf);
> > +		else if (oe) {
> > +			if (oe->type != OBJ_COMMIT)
> > +				die("Not a commit (actually a %s): %s",
> > +					typename(oe->type), command_buf.buf);
> 
> How is that supposed to work?  Do I understand correctly that you require 
> the user to construct a commit object for the gitlink?  That would be 
> actively wrong.

There are three forms of the M command:

M mode inline some/path
...some data...

M mode :mark some/path

M mode SHA some/path

For usual files the mark must be created by the 'blob' command,
and the SHA must refer to an existing blob. This hunk makes fast-import
require for gitlinks a commit mark instead, and accept the SHA without
checking (as it is expected to be in another repository).

> Oh, and your patch lacks test cases that demonstrate how you envisage the 
> whole thing to work.

Ok, I'll make some tests tomorrow. For now, this is an example of output from
my test repository:

...
blob
mark :16
data 41
[submodule "sub"]
        path = sub
        url = sub

commit refs/heads/master
mark :17
author Alexander Gavrilov <angavrilov@gmail.com> 1216360728 +0400
committer Alexander Gavrilov <angavrilov@gmail.com> 1216360728 +0400
data 4
sub
from :15
M 100644 :16 .gitmodules
M 160000 d6317bc6e2597bf74ae199514a54e25775b0d20d sub


Alexander
