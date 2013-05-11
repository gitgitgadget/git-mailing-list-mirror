From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Misusing git: trimming old commits
Date: Sat, 11 May 2013 12:56:54 -0400
Message-ID: <CACPiFCK3b2Ohr1rNSkxa2LFwVOo+w+NQ6D6AXwwHifQo_Lcp_g@mail.gmail.com>
References: <CACPiFC+XKVzNk2fm4beer0xD6yBnVW6QXCrSFm2w8T2r68xGvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 11 18:57:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbD6n-0001Cl-Em
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab3EKQ5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:57:16 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:36193 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3EKQ5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:57:15 -0400
Received: by mail-qe0-f51.google.com with SMTP id x7so2982221qeu.38
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=M/V8o/QcwoGSE+3iclLCgJvuHaqME3jWh5sJf+6savE=;
        b=rz/C4xYvauB2e0Z5aBwgbkp8+t2msUaxZn5QTxdhoUEBsNGS7uU9MyBqP48wAGORCj
         LB79n8Pnquf6Uo8IWJbzpuQrsdFX5GU42ConeKE7ewThjIOnlDdm/UgCoSZgTkBXmLpg
         AjFXLYBVLxAVJcZh6nMCM+gAc1LB2yUAxjqaT51lqy+pVGtASlCq3gIRjaIj05QZlhDe
         Evot7ulknfUZFlTVxo4UYBgq7LXGp2VvFnE7S4DHPS2x0IwAKJfTlC6stbSc/PHwi+gO
         dzpWVTO6LEHN/84XcLrM2oXXc8zXlYvEdacVSpeF81LLVsjR8v+MIwM8C4JAFlbuEN7w
         ULLg==
X-Received: by 10.49.3.6 with SMTP id 6mr17545606qey.64.1368291434794; Sat, 11
 May 2013 09:57:14 -0700 (PDT)
Received: by 10.49.96.201 with HTTP; Sat, 11 May 2013 09:56:54 -0700 (PDT)
In-Reply-To: <CACPiFC+XKVzNk2fm4beer0xD6yBnVW6QXCrSFm2w8T2r68xGvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223995>

On Thu, May 9, 2013 at 11:40 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> With the exaction of the final destination, I want to expire reports
> that are old and successfully transferred.

OK, that took some effort to make work. Make sure you are not using
reflogs (or that reflogs are promptly expired).

# right after a successful push of all heads to the receiving server...
for head in $(git branch|sed 's/^..//'); do
    # FIXME period
    graft_sha1=$(git log --until=one.month.ago -n1 --pretty=format:%H ${head})
    if [[ -z "$graft_sha1" ]]; then
        # nothing to prune
        continue
    fi
    # is it already grafted?
    if grep -q "^${graft_sha1} " "${GIT_DIR}/info/grafts" &>/dev/null ; then
        # don't duplicate the graft
        continue
    fi
    some_grafted='true'
    # prep empty commit
    # skip git read-tree --empty, we get the same with
    export GIT_INDEX_FILE=/tmp/ppg-emptytree.$$
    empty_tree="$(git write-tree)"
    rm ${GIT_INDEX_FILE}
    unset GIT_INDEX_FILE
    empty_commit=$(git commit-tree -m empty ${empty_tree})
    echo "${graft_sha1} ${empty_commit}" >> ${GIT_DIR}/info/grafts
done

if [[ -z "$some_grafted" ]]; then
    # nothing to do
    exit 0
fi

# ppg-repack makes the unreachable objects "loose"
# (it is git-repack hacked to remove --keep-true-parents),
# git prune --expire actually deletes them
$PPG_EXEC_PATH/ppg-repack -AFfd
git prune --expire=now

### Cleanup stale grafts
# current grafts points are reachable,
# pruned graft points (made obsolete by a newer graft)
# cannot be retrieved and git cat-file exit code is 128
touch ${GIT_DIR}/info/grafts.tmp.$$
while read line; do
    graftpoint=$(echo "${line}" | cut -d' ' -f1)
    if git cat-file commit ${graftpoint} &>/dev/null ; then
        echo ${line} >> ${GIT_DIR}/info/grafts.tmp.$$
    fi
done < "${GIT_DIR}/info/grafts"

if [ -s ${GIT_DIR}/info/grafts.tmp.$$ ]; then
    mv ${GIT_DIR}/info/grafts.tmp.$$ ${GIT_DIR}/info/grafts
fi

Perhaps it helps someone else trying to run git as a spooler :-)

cheers,



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
