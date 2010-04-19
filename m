From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [QUESTION] or [BUG] Could not stash new bin files
Date: Mon, 19 Apr 2010 04:35:23 -0500
Message-ID: <20100419093523.GA26342@progeny.tock>
References: <p2rc8485ef11004190119q590aea5dy516bdc3d222ebb51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Arnauld Van Muysewinkel <arnauldvm@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 11:35:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3nO6-0004e0-VR
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 11:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab0DSJfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 05:35:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49761 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab0DSJfP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 05:35:15 -0400
Received: by pwj9 with SMTP id 9so3154629pwj.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1+ShickEHkDtKCz4G/cGy4Jao3WHNcko9N3SFJ1M9Wo=;
        b=Qd6XR3iY45IlcK66yFlAVE4Skb8s6RQGI9lkr/0ExLG5rWiDL8xTFFZ+Oq+KcGZORx
         +aITCZ1qeZ8HB91QuETkoOKrZ1vwYy5eweS/kjfq8BmZv6jh6WThap3Zffm51kHdkxzi
         hysYD2K5Z3dxNc7scy65GQ0Znw8ZIkDnIlcEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rJQnLjc42PBxKExxyzQckN7BN8Jedy49xVoVEhR3jhoWYz599Ic9OMDfCoIvS/csqw
         rtMaNBq+i8A25m5ZQwk04lS56XfwvrlWhsuhrxnOzunr6xwlFiDzyZ1vBemhRJzX96Id
         RF47CbMG2zuZ71qNz8MB9vRz8IsPJclukb9r8=
Received: by 10.114.214.26 with SMTP id m26mr3468857wag.204.1271669714590;
        Mon, 19 Apr 2010 02:35:14 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4847118iwn.2.2010.04.19.02.35.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 02:35:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <p2rc8485ef11004190119q590aea5dy516bdc3d222ebb51@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145286>

Hi Arnauld,

Arnauld Van Muysewinkel wrote:

>     $ git add -N XXX/src/jrxml/*.xls
>     $ git stash save --keep-index "Improving performance of views"
>     XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-new.xls: not added ye=
t
>     XXX/src/jrxml/SubCellMatrixCompared-EXPLAIN-old.xls: not added ye=
t
>     fatal: git-write-tree: error building trees

Yes, this is a known problem [1].

To explain this requires a bit of a digression into how =E2=80=98git st=
ash=E2=80=99
works.  It is a neat script (in commit f2c66ed1, when it was added, it
was only 160 lines or so), especially because it uses ordinary git
commits and reflogs to maintain its data.  You have probably seen what
it looks like in gitk.  A particular stashed version looks like this:

                        index
                       /     \
  history ... --- HEAD ------- work tree

and these are all ordinary commits.

An unsolved problem with this data structure is that it does not store
information that can be stored in the index but not a commit.  This is
the case for the CE_INTENT_TO_ADD bit [2], and that it cannot be used
in commits is very deliberate: trying to commit immediately after an
add -N is almost certainly a sign of a mistake.  See 331fcb598 (git
add --intent-to-add: do not let an empty blob be committed by
accident, 2008-11-28) and the preceding commits for more on this.

One workaround is to make sure the intent-to-add bit is not set when
stashing from such a state.  For example, you can =E2=80=98git add=E2=80=
=99 the file,
or =E2=80=98git rm --cached=E2=80=99 it [3].

I suspect the correct fix would be to use the commit message for the
index commit to record the intent to add.

[...]
> Specificities:
>=20
> * I have a file in the index that I do not want to stash

Could you explain this further?  The stash currently saves everything
about the current state (except files not in the index nor HEAD).

> * The two new files are binary files

Hope that helps,
Jonathan

[1] See, for example, this discussion:
http://thread.gmane.org/gmane.comp.version-control.git/127290

[2] CE_VALID and CE_SKIP_WORKTREE also, but I suspect no one is
worried about making stash track them.

[3] If you use git rm and then stash, watch out for the following bug.
http://thread.gmane.org/gmane.comp.version-control.git/145228
