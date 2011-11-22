From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH] run-command.c: Accept EACCES as command not found
Date: Tue, 22 Nov 2011 10:31:48 +0100
Message-ID: <CAH6sp9MxbDhQ3RiA6jO1fswAZX3R6C2fv0gzJdpGp432ovWsjQ@mail.gmail.com>
References: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
	<7vbos5f7ix.fsf@alter.siamese.dyndns.org>
	<op.v5bjtk1r0aolir@keputer>
	<7v62idf2vy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 10:39:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSmpL-0000Nh-2N
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 10:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab1KVJje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Nov 2011 04:39:34 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:57579 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005Ab1KVJjc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2011 04:39:32 -0500
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Nov 2011 04:39:32 EST
Received: by qadb14 with SMTP id b14so138303qad.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 01:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LSB4V82yItMOoIVmaRi86qdEUaKeLPHhZoLpnxTZHY8=;
        b=uZm0BQOXF0oLx20WW/Y7R2D9BXME6ZuABVei6w+qpApRvAMHnaPxJpEkF9M+jJl8ij
         kxo7ByCm5nFdPnnMGOp3O1uVzYkKLvHySgyDRlVhK+rW3P7gutU+e7m++2s6sshDkVH7
         usGAYveLP5tNE1EfZ8xlfzfMn+Wi7Ig3yNML0=
Received: by 10.224.217.66 with SMTP id hl2mr2425586qab.84.1321954308895; Tue,
 22 Nov 2011 01:31:48 -0800 (PST)
Received: by 10.224.86.11 with HTTP; Tue, 22 Nov 2011 01:31:48 -0800 (PST)
In-Reply-To: <7v62idf2vy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185778>

On Tue, Nov 22, 2011 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:

> Imagine you did not have alias.aliasedinit in ~/.gitconfig but had a
> script called $(pwd)/searchpath/git-aliasedinit which we would fail t=
o
> execute. What message would we get in that case? Currently I think we=
 get
> permission denied.

Correct.

> Would we get the same with your patch, or something that does not hin=
t
> at all that there is a permission problem?

Nope. That would be just as confusing and inarguably incorrect at that
-- bash differentiates between commands that exist, but cannot be
executed due to permissions (access denied) and paths that cannot be
read (they are ignored in the search).


> See also the "tangent" part of
>
> =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/1=
71755
>
> and the discussion that follows it. I do not think we reached any
> conclusion nor a patch.

There's no black-on-white conclusion there. I get the impression that
no one really has an idea of what they want when encountering EACCES.
Git has to do what's reasonable to provide the user with information.
Currently I think it does too little. Jonathan N. gave the option of
optionally using libexplain[1]. It's pretty verbose and accurate:

fatal: cannot exec 'git-frotz': execvp(pathname =3D "git-frotz", argv =3D
["git-frotz"]) failed, Permission denied (13, EACCES) because the
process does not have search permission to the pathname
"/home/frans/devsw/searchpath" directory, the process effective UID
1000 "frans" matches the directory owner UID 1000 "frans" and the
owner permission mode is "r--", and the process is not privileged
(does not have the DAC_READ_SEARCH capability): Success

I wouldn't be in favor of adding the dependency just to enable users
to track down PATH issues though. Also, I think "Cannot access
/home/frans/devsw/searchpath" would just as well do the trick.

=46or Jonathan's example[2] libexplain doesn't have a clear answer eith=
er:
fatal: cannot exec 'git-frotz': execvp(pathname =3D "git-frotz", argv =3D
["git-frotz"]) failed, Permission denied (13, EACCES): Permission
denied

If git is going to do some diagnostics on why the execvp returned
EACCES, it can still give a few hints. Most of the more likely options
are then ruled out.

=46rans

[1] http://article.gmane.org/gmane.comp.version-control.git/171860
[2] http://article.gmane.org/gmane.comp.version-control.git/171848
