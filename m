From: Sergei Organov <osv@javad.com>
Subject: Plumbing to rename a ref?
Date: Fri, 23 May 2014 14:11:55 +0400
Message-ID: <87ha4golck.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 12:12:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnmSL-0000Hr-5q
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbaEWKL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 06:11:59 -0400
Received: from mail.javad.com ([54.86.164.124]:57776 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbaEWKL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:11:58 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 3DD55617FB
	for <git@vger.kernel.org>; Fri, 23 May 2014 10:11:57 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1WnmSB-0007HC-AH
	for git@vger.kernel.org; Fri, 23 May 2014 14:11:55 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249978>

Hello,

After convertion of a project from CVS to git, I'd like to rename some
references in the created git repository (before it's published, so no
problems here). Is there a plumbing that would do:

git rename-ref <old_name> <new_name>

for me?

For reference, the (ugly) solution I currrently use is:

# Renamve branches/tags for brevity.
#
# e.g.: version-3-5-branch -> v3.5-branch
#

sed_cmd='sed "s/version-/v/g" | sed "s/\([0-9]\)-\([0-9]\)/\1.\2/g" | sed "s/\([0-9]\)-\([0-9]\)/\1.\2/g"'

if [ -f "packed-refs" ]; then
    rm -rf "packed-refs.new"
    cat "packed-refs" | eval "$sed_cmd" > "packed-refs.new" && mv "packed-refs.new" "packed-refs"
fi

git for-each-ref --format="%(refname)" |
while read -r; do
    ref="$REPLY"
    if [ -f "$ref" ]; then
        new_ref=`echo "$ref" | eval "$sed_cmd"`
        if [ "$ref" != "$new_ref" ]; then
            echo "$ref -> $new_ref"
            mv "$ref" "$new_ref"
        fi
    fi
done

-- Sergey.
