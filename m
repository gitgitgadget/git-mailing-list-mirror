From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Create a new commit from patches without using any worktree?
Date: Wed, 27 Oct 2010 11:07:54 +0200
Message-ID: <4CC7EBEA.9070804@viscovery.net>
References: <AANLkTi=Xi13_0+bC-TVRP3uVDmGWVdM3a708=SSzCR88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 11:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB1zJ-0003gt-HK
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 11:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab0J0JH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 05:07:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5967 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752636Ab0J0JH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 05:07:58 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PB1z9-0008MG-48; Wed, 27 Oct 2010 11:07:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D67771660F;
	Wed, 27 Oct 2010 11:07:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.11) Gecko/20101013 Thunderbird/3.1.5
In-Reply-To: <AANLkTi=Xi13_0+bC-TVRP3uVDmGWVdM3a708=SSzCR88@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160031>

Am 10/27/2010 3:49, schrieb Klas Lindberg:
> Is there any way to record a new commit based on contents in a patch
> without going through a worktree?

This script may be a starter. It takes a commit on the command line
instead of a patch, but it processes that commit as a patch ("diff-tree -p"),
so the script should be easy to adapt.

-- Hannes

-- 8< --
#!/bin/sh

OPTIONS_SPEC="\
git post to-ref [from-rev]
--
"
. git-sh-setup

while test $# != 0
do
	case "$1" in
	--)	shift; break;;
	-*)	usage;;
	*)	break;;
	esac
	shift
done

FROM=$(git rev-parse --verify --symbolic-full-name "$1") || exit
shift
if test $# = 0; then
	set -- HEAD
fi
test $# = 1 || usage

# populate a temporary index
tmpidx=$GIT_DIR/index-post-$$
git read-tree --index-output="$tmpidx" "$FROM" || exit
GIT_INDEX_FILE=$tmpidx
export GIT_INDEX_FILE
trap 'rm -f "$tmpidx"' 0 1 2 15

git diff-tree -p -M -C "$@" | git apply --cached || exit

newtree=$(git write-tree) &&
newrev=$(
	eval "$(get_author_ident_from_commit "$1")"
	git-cat-file commit "$1" | sed -e '1,/^$/d' |
	git commit-tree $newtree -p "$FROM"
) || exit

if git check-ref-format "$FROM"
then
	set_reflog_action post
	subject=$(git log --no-walk --pretty=%s "$newrev") &&
	git update-ref -m "$GIT_REFLOG_ACTION: $subject" "$FROM" $newrev || exit
fi
if test -z "$GIT_QUIET"
then
	git rev-list -1 --oneline $newrev
fi
