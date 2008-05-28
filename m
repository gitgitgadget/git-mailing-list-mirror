From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Re: setup_git_directory_gently contract question?
Date: Wed, 28 May 2008 10:14:15 +0300
Message-ID: <8e04b5820805280014m6fc635tf91ae20d9b9a5c91@mail.gmail.com>
References: <8e04b5820805270710v3a06e5c2if2dcf3b94ef40c1f@mail.gmail.com>
	 <7vmymbz7on.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 09:15:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1FsM-0003BT-OL
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 09:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbYE1HOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 03:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbYE1HOS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 03:14:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:48430 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYE1HOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 03:14:18 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3376963rvb.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kStytpJ9MSrhiRZ31qVfLeH6Y/hrF6gZK3Xwra66XkQ=;
        b=ofsNfqt1iwf/blECi+IZka3KXoWPDFw8X+E3HrjcXZUb8nEn8FSgjbnNEJXWQIESOCVAEdhmpLto1tM9FsTRgyPvkFF8lpsphYFv8/X+qkGN9vdyNz4EaNJKcxvvyDsfweQnnro6MaoqHKVa2fn4GLy0fcIf3KUEQL9rCkL1KPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W21xoiHwode54F3N5dL7yFrPiyXgmCsWZtc0jST/uxqSv1+c1nosbSnLwl5t2ro1HFa/cZYtvXOeSVSV2i2IaVjxUkEejq76jgnp2wcSbTGglFfQ1tU8REx/Y+3fVXVbe1Mt3FP3e2LDUyThyCiNfECXajnk5nKzk29NWWbmdBY=
Received: by 10.140.139.3 with SMTP id m3mr970196rvd.244.1211958855667;
        Wed, 28 May 2008 00:14:15 -0700 (PDT)
Received: by 10.141.37.3 with HTTP; Wed, 28 May 2008 00:14:15 -0700 (PDT)
In-Reply-To: <7vmymbz7on.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83074>

On Wed, May 28, 2008 at 1:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com> writes:
>
>>     Is the function setup_git_directory_gently supposed to change the
>> current working directory, or should it keep the initial one?
>>     What is the meaning of nongit_ok?
>
> Most commands that work from subdirectory use setup_git_directory()
> interface, because major parts of the guts of the git internal want you to
> be at the top of the work tree (e.g. so that you grab a path out of the
> index, and be able to open(2) or lstat(2) that path).  A normal sequence
> for a command is: (1) use setup_git_directory() to learn "prefix", (2) use
> get_pathspec() and/or prefix_path() to add "prefix" to the paths given
> from the command to make it a path relative to the work tree, (3) do its
> thing.  setup_git_directory() chdir's up to the top of the work tree for
> this reason.
>
> Some commands can optionally work from even outside a git repository, but
> they would want to operate the same way as other comands, when they are
> started within a git repository.  In such a case, you use "gently"
> variant, and give a pointer to int to store an additional return value to
> signal you if you are inside a git repository or outside.
>
>  * When NULL is given as nongit_ok to gently(), it does not behave gentle
>   at all.  Outside a git repository it dies loudly.
>
>  * If you are inside a git repository, it behaves pretty much the same as
>   setup_git_directory().  "*nongit_ok" is set to zero to signal that you
>   are inside a git repository.
>
>  * If you are outside a git repository, *nongit_ok is set to non-zero so
>   that the caller can tell that it is not in any git repository's work
>   tree.  There is no need to chdir (nor a sensible place to chdir to) in
>   this case, so it doesn't.
>
> The caller thinks of the parameter as "are we operating in non-git mode?"
> boolean, and the callee (i.e. setup_git_directory_gently()) thinks of it
> as "is it ok to be called outside a git repository?" (if it is NULL, the
> caller expects to be inside a repository and wants it to barf otherwise).
> That is why caller's variable are often called "int nongit", and the
> callee's parameter is called "int *nongit_ok".

    Thank you for your complete answer.

    I would propose that these comments to be added to the
Documentation/technical/... directory, (or in the setup.c file), so
that further developers will have this information.

    Thanks again,
    Ciprian.
