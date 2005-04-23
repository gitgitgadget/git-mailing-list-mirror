From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 11:54:07 -0700
Message-ID: <7voec52uk0.fsf@assigned-by-dhcp.cox.net>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
	<42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>
	<426A4669.7080500@ppp0.net>
	<1114266083.3419.40.camel@localhost.localdomain>
	<426A5BFC.1020507@ppp0.net>
	<1114266907.3419.43.camel@localhost.localdomain>
	<Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
	<20050423175422.GA7100@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261717AbVDWSzz@vger.kernel.org Sat Apr 23 20:55:29 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261717AbVDWSzz@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPPmh-0005J8-Hr
	for glk-linux-kernel@gmane.org; Sat, 23 Apr 2005 20:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVDWSzz (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Sat, 23 Apr 2005 14:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVDWSzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:55:55 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17038 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261703AbVDWSyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:54:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050423185408.LAIR29099.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Apr 2005 14:54:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 23 Apr 2005 11:30:36 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I really want the resulting file to look like

LT> 	commit ....
LT> 	tag ...

LT> 	here goes comment
LT> 	here goes signature

LT> and no headers.

You can use --detach-sign with --armor, like this.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
#!/bin/sh

sq=s/\'/\''\\'\'\'/g
usage="usage: $0  [--signer=...] commit-id tag < message"
while case "$#" in 0) break;; esac
do
 case "$1" in
 -s=*|--s=*|--si=*|--sig=*|--sign=*|--signe=*|--signer=*)
  signer=`expr "$1" : '-[^=]*=\(.*\)'` ;;
 -s|--s|--si|--sig|--sign|--signe|--signer)
  case "$#" in 0 | 1) echo "$usage"; exit 1 ;; esac
  signer="${2?}"
  shift ;;
 --)
  shift
  break ;;
 -*)
  echo "$usage"
  exit 1 ;;
 *)
  break ;;
 esac
 shift
done

case "$#" in 2) echo >&2 "$usage"; exit 1 ;; esac
commit="$1" tag="$2"

case "$signer" in
'') signer_arg='' ;;
?*) signer_arg="--local-user '$(echo "$signer" | sed -e "$sq")'" ;;
esac

tmp=.jit-tag.$$
trap 'rm -f $tmp-*' 0 1 2 3 15
tagblob=$tmp-tagblob
tagsign=$tmp-tagsign

case $(cat-file -t "$commit" 2>/dev/null) in
commit) ;;
*) echo >&2 "$0: $commit is not a commit object"; exit 1 ;;
esac
{
    echo "commit $commit"
    echo "tag $tag"
    case "$signer" in
    '') ;;
    ?*) echo "signer $signer" ;;
    esac
    echo
    tty -s && echo >&2 "Type your tag message and end with ^D."
    cat
} >$tagblob || exit
gpgcmd="gpg $signer_arg -a --output $tagsign --detach-sign $tagblob"
eval "$gpgcmd" || exit
cat $tagblob $tagsign
