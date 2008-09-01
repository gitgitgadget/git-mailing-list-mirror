From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/1] fast-import: show a warning for non-existent files.
Date: Tue, 2 Sep 2008 00:58:59 +0300
Message-ID: <94a0d4530809011458r25f73f49web2c3ae601a5544d@mail.gmail.com>
References: <1220275214-6178-1-git-send-email-felipe.contreras@gmail.com>
	 <7vwshvvgap.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 00:00:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaHRO-0008Rv-FN
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 00:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbYIAV7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 17:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYIAV7A
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 17:59:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:62188 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYIAV7A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 17:59:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1975192rvb.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YvHB/DeDkNdOkvop5h6rz5qG3YsfcagdednwgI1Hg08=;
        b=nZ01d908Xd5vcLo4esGXdPfrNkE/nGleZMuYnWru8csAh/vJdsZkRoVv96zPGne/8G
         9q7VAIL8M+BiRua1qwallYon8wPn5GYru1fXzXj8qc2/UUm/Shzz/pxx1PZgwZWC7WVP
         3joSbqhISJ6uP9JeEqsNcm5Go2euc7/oAQau4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CJavWQPkI4cj1i0nncKFGp633ROVnv98p5YixDl3cGbD6X18aq7aOArq2sEqegUHDG
         CCUI0VpcldT0DMcb8JljNZqsF2trPLxIdwd7uEeB/KrXUgubuEv0EYcRxYclChH7IgHi
         NS5pU2g9EL0PCnt2LhWPuHFTuohIBg7/h1fpA=
Received: by 10.141.132.8 with SMTP id j8mr3693907rvn.297.1220306339272;
        Mon, 01 Sep 2008 14:58:59 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Mon, 1 Sep 2008 14:58:59 -0700 (PDT)
In-Reply-To: <7vwshvvgap.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94616>

On Mon, Sep 1, 2008 at 10:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This is useful in certain SCMs like monotone, where each 'merge revision' has
>> the changes of all the micro-branches merged. So it appears as duplicated commands.
>
> The patch appears to add warning to when you try to 'D'elete something
> that should not exist in the revision, whose moral equivalents are
> implemented in the codepath to deal with 'R'enaming and 'C'opying an
> non-existent path.
>
> But instead of making it die(), it merely warns, and even worse, you are
> demoting an existing die() in Rename/Copy codepath to mere warning
> unconditionally.  Why?

Right, I tried to do two things at once. I thought adding the code in
'D'elete in a separate branch was too much separation for such a
trivial thing.

> "This" that begins your proposed commit log message needs to be clarified,
> but I am guessing that you are defending your change to demote existing
> error check to die on inconsistent input to a mere warning.  I do not find
> it a particularly good defending argument.  It sounds more like you are
> papering over bugs in _one_ broken converter that produces and feeds an
> incorrect input to fast-import, breaking a safety valve for everybody else.

In monotone you can have something like:

 A
/ \
B D
| |
C E
\ /
 F

If you do a 'delete foo' in B, and a 'delete bar' in F, you will get
this stored in the merge revision (F):

old_revision [C]
delete "foo"
delete "bar"

old_revision [E]
delete "bar"

All the changes of the merged branches are stored again in the merge revision.

I guess ideally my converter should check which changes appear on both
branches, and only apply those. Of course, only on revisions that are
merges.
That complicates the code quite a lot. I tried it and it didn't work
quite well (I did something wrong).

So I tried to workaround this in fast-import, and it's simple, and it works.

<snip/>

-- 
Felipe Contreras
