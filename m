From: "David Frech" <david@nimblemachines.com>
Subject: Re: challenges using fast-import and svn
Date: Mon, 2 Jul 2007 16:28:25 -0700
Message-ID: <7154c5c60707021628t14735e94gc8958670a328be79@mail.gmail.com>
References: <7154c5c60707021226k3a7b82fcl7558cfc66d61dde@mail.gmail.com>
	 <20070702222400.GB4495@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:28:33 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5VJm-0002Gf-HP
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbXGBX22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755451AbXGBX22
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:28:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:25872 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbXGBX21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:28:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2533755wah
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 16:28:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VvtMswMTIKfIaQWq5ANWEGgLEKUCyQWylh18sEIPeOAqVvxxM7clUmg7qzVb4etubjh4zYqBruVuQnRHVx1CWIJCd61QQfenOfTxbw+qwB45D1Nlpptx5i92deZsHhlJcdExzEfrczqT5cbCjjFTtcoWQsA/EPmWN1CKozor1/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DnzM0/g+pdnEQVa911UDdsqDcxSzJdNpA2ekmSryF9t5cBvJ7cJ2nmGCPikM9wSlKtd+RglMLraGwtt8eTGc1Ok26tgcxG09ja82ICC3pBbyJrN0IUJ0advo04K+RTsfiYrnSy0eV9H1Y2fLrXOizfmQyvkaTs7BnD3yHEuqV/U=
Received: by 10.114.156.1 with SMTP id d1mr5592944wae.1183418905607;
        Mon, 02 Jul 2007 16:28:25 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Mon, 2 Jul 2007 16:28:25 -0700 (PDT)
In-Reply-To: <20070702222400.GB4495@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 427d7183cfc31b02
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51430>

On 7/2/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> David Frech <nimblemachines@gmail.com> wrote:
> > However, there are issues. I don't currently track branch copies
> > correctly, so branches start out with no history, rather than the with
> > the history of the branch they are copied from; and handling deletes
> > is tricky.
>
> Branches are easy to create from the right branch in fast-import,
> but its hard with the SVN dump file to know where it starts from.
>
> One trick folks have used in the past is to assign a mark in
> fast-import for each SVN revision.  Marks are very cheap and make
> it easy to reference a commit in a from command when you need to
> make a new branch.  You can just use the SVN revision number you
> get from the SVN dump file.

I think I know how to do this. I'm already using marks for each commit.


> > Here is the problem: if a file or directory is deleted in svn, the
> > dumpfile shows simply this:
> >
> > Node-path: trunk/project/file-or-directory
> > Node-action: delete
> >
> > In the case of a file, I can simply feed a "D" command to fast-import;
> > but if I'm deleting a whole directory, my code knows nothing about
> > what files exist in that directory. Is fast-import smart about this?
> > Will it barf if given a directory argument rather than a file for "D"
> > commands?
>
> I just read the code again.  You can delete an entire subdirectory
> just by sending a D command for that subdirectory, assuming you
> don't end the name with a '/'.  So you should be able to just do:
>
>   D file-or-directory
>
> and whatever file-or-directory is, it goes away.  If you were to
> send a trailing '/':
>
>   D file-or-directory/
>
> its likely bad things will happen because fast-import will try to
> remove the file or directory named "" (yes, empty string) in the
> subdirectory called "file-or-directory" but leave the subdirectory.

This is great! I'll update the code and see what happens...


> So I guess this means a documentation update for the D command
> would be a good idea?

Sounds good to me. Right now it really implies "this only works on files".

Thanks for the snappy reply, and thanks again for writing fast-import!
It was a pleasure to use.

> --
> Shawn.
>

- David

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
