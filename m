From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Identify Commit ID from an Extracted Source Snapshot
Date: Thu, 16 Feb 2012 17:53:08 -0600
Message-ID: <20120216235240.GA20779@burratino>
References: <BEDA323D25EF6045A68DAB9FD91A0BF123A85B38@DB3PRD0402MB118.eurprd04.prod.outlook.com>
 <4F3D8A7C.2020400@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Walmsley <james@fullfat-fs.co.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 00:53:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyB8s-0003Y4-OC
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 00:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab2BPXxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 18:53:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47980 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab2BPXxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 18:53:31 -0500
Received: by iacb35 with SMTP id b35so3582856iac.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 15:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZQLfSvZWlHT4I5rsaMjCwvG59AEVE62RwbhzAvDVXtc=;
        b=I+XGNEcUJAR+X6unzCQOqqkbOyeY0PdIlUNJZi0ojZoN1HcvQsV6TS9Z6P8De1w0z4
         HL1rxPsTwnoPm9aav8Jfxi4agQW9XxVuhaJtszQxxyO4x0QgPpVB0BElLvMP+SJEXm2k
         Ym1jcm8PJcyXEBqZboiWi6+iI8+RCZ4d+eMUw=
Received: by 10.50.203.98 with SMTP id kp2mr5889423igc.5.1329436410451;
        Thu, 16 Feb 2012 15:53:30 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z22sm12965867ibg.5.2012.02.16.15.53.29
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Feb 2012 15:53:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F3D8A7C.2020400@elegosoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190924>

Michael Schubert wrote:

> If your question is more like "how do I tell git to find out where
> this old code fits in my history and eventually place it there",
> the answer is: you cannot do it. No VCS will do this and especially
> not Git.

Wouldn't it be possible to add the tags you want by walking through
the commit log to find a matching commit for each tarball?

For example:

	# Usage: "GIT_DIR=<repository> tag-tars <tarballs>"
	# Arguments should be tarballs containing releases in
	# reverse-chronological order.
	# Should be run in an empty directory, which will be
	# used as a workspace.

	# save stdin
	exec 3<&0

	GIT_DIR=$(git rev-parse --resolve-git-dir "$GIT_DIR") || exit 1
	GIT_INDEX_FILE=$GIT_DIR/index.tag-tars
	export GIT_INDEX_FILE

	if test -n "$(git ls-files -c -o | head -1)"
	then
		echo >&2 'fatal: I need an empty directory to work with'
		exit 1
	fi

	for tar
	do
		# empty workspace
		git ls-files | xargs rm -f --
		rm -f "$GIT_INDEX_FILE"

		# get tree name for tarball
		tar --strip-components=1 -xf "$tar"
		git ls-files -o | git update-index --add --stdin
		tree=$(git write-tree)

		# tag the first commit found matching that tree, if any
		git rev-list master |
		while read cmit
		do
			if git diff-tree --quiet $cmit $tree
			then
				git tag -a ${tar%%.*} $cmit <&3
				break
			fi
		done
	done

Variation using --numstat and a path filter to find the closest commit
ignoring some files instead of an exact match left as an exercise to
the reader.

Hope that helps,
Jonathan
