From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH (BUGFIX)] Respect core.autocrlf in combined diff
Date: Sun, 24 Aug 2008 13:21:57 +0400
Organization: TEPKOM
Message-ID: <200808241321.58791.angavrilov@gmail.com>
References: <200808232321.21795.angavrilov@gmail.com> <7vy72nurw0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 11:23:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXBof-00038l-1S
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 11:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbYHXJWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 05:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbYHXJWP
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 05:22:15 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:61771 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYHXJWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 05:22:14 -0400
Received: by fk-out-0910.google.com with SMTP id 18so731634fkq.5
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9xdIiNvwIY/Xt4lyHzaJt0q08UuZmq+ksdA4mZz8vFE=;
        b=jRBOD5H6TgEpqshMGLmWCsoCfQFlnq0sYeuf5B9OfafbdHSOSqVnbzbZa2Md8kOZ3O
         0Rz7uv039SMmmcUQqhsodRwZSH712/JVguK+iz46swAYtcXc5QsayzBa9FaGJz7/ZGGN
         8c+L14QqF8Yfa8d4tQ6SYfVPUJ4G7aeCfxQj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ey7de4YqPjA1hFgg4cyAUzd7nPbJ3cg/dSFVvTz4olXQL3KL0Fn+NZ7jP5syczSk54
         T8B/0mOacdRi/MFMRNtImloQ+2qh17alEoYBV0+XIum9/YmReEwRQKnIK0V1VbkWeZ07
         20T/QuB4GTJxJYplYHxP/w045S85P2t0m1Pos=
Received: by 10.181.27.7 with SMTP id e7mr1586740bkj.17.1219569732267;
        Sun, 24 Aug 2008 02:22:12 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id k29sm3133455fkk.2.2008.08.24.02.22.11
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 02:22:11 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <7vy72nurw0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93525>

On Sunday 24 August 2008 05:24:31 Junio C Hamano wrote:
> Alexander Gavrilov <angavrilov@gmail.com> writes:
> 
> > 		...
> > 		git commit -m aaa
> > 		git config core.autocrlf true
> > 		git merge b
> >
> > 	Then look at the output of git diff.
> 
> Come to think of it, this test sequence is totally bogus, isn't it?
> 
> After making the "aaa" commit, you change core.autocrlf setting, which
> means that at that point your work tree is invalid and needs to be checked
> out with the right crlf.
> 

Yes, it is more correct to reset after changing that parameter, but since
merge overwrites the file anyway, I took a shortcut. I first noticed the
problem on Windows, where autocrlf was turned on from the beginning.


By the way, am I right that currently the only way to get properly CRLFed
versions of all stages is to do something like this:

mv -f $path "$path.BACKUP"
git checkout-index -f --stage=1 $path
mv -f $path "$path.BASE"
git checkout-index -f --stage=2 $path
mv -f $path "$path.LOCAL"
git checkout-index -f --stage=3 $path
mv -f $path "$path.REMOTE"
cp -f "$path.BACKUP" $path


git-mergetool does it like this, but it produces LF files:

    base_present   && git cat-file blob ":1:$prefix$MERGED" >"$BASE" 2>/dev/null
    local_present  && git cat-file blob ":2:$prefix$MERGED" >"$LOCAL" 2>/dev/null
    remote_present && git cat-file blob ":3:$prefix$MERGED" >"$REMOTE" 2>/dev/null


Alexander
