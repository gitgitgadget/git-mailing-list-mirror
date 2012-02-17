From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Identify Commit ID from an Extracted Source Snapshot
Date: Fri, 17 Feb 2012 01:14:57 +0100
Message-ID: <4F3D9C01.5000402@elegosoft.com>
References: <BEDA323D25EF6045A68DAB9FD91A0BF123A85B38@DB3PRD0402MB118.eurprd04.prod.outlook.com> <4F3D8A7C.2020400@elegosoft.com> <20120216235240.GA20779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Walmsley <james@fullfat-fs.co.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 01:16:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyBUo-0006hl-Nu
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 01:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab2BQAQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 19:16:14 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58513 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503Ab2BQAQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 19:16:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 4B560DE8D2;
	Fri, 17 Feb 2012 01:16:13 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYFnfdyXi5z1; Fri, 17 Feb 2012 01:16:13 +0100 (CET)
Received: from [192.168.1.101] (g231216233.adsl.alicedsl.de [92.231.216.233])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 036D3DE8D1;
	Fri, 17 Feb 2012 01:16:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120212 Thunderbird/10.0.1
In-Reply-To: <20120216235240.GA20779@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190927>

On 02/17/2012 12:53 AM, Jonathan Nieder wrote:
> Michael Schubert wrote:
> 
>> If your question is more like "how do I tell git to find out where
>> this old code fits in my history and eventually place it there",
>> the answer is: you cannot do it. No VCS will do this and especially
>> not Git.
> 
> Wouldn't it be possible to add the tags you want by walking through
> the commit log to find a matching commit for each tarball?

I read the question like "How do I insert / prepend my zipped
*pre-VCS* version (in)to my Git history in an automated fashion".

> For example:
> 
> 	# Usage: "GIT_DIR=<repository> tag-tars <tarballs>"
> 	# Arguments should be tarballs containing releases in
> 	# reverse-chronological order.
> 	# Should be run in an empty directory, which will be
> 	# used as a workspace.
> 
> 	# save stdin
> 	exec 3<&0
> 
> 	GIT_DIR=$(git rev-parse --resolve-git-dir "$GIT_DIR") || exit 1
> 	GIT_INDEX_FILE=$GIT_DIR/index.tag-tars
> 	export GIT_INDEX_FILE
> 
> 	if test -n "$(git ls-files -c -o | head -1)"
> 	then
> 		echo >&2 'fatal: I need an empty directory to work with'
> 		exit 1
> 	fi
> 
> 	for tar
> 	do
> 		# empty workspace
> 		git ls-files | xargs rm -f --
> 		rm -f "$GIT_INDEX_FILE"
> 
> 		# get tree name for tarball
> 		tar --strip-components=1 -xf "$tar"
> 		git ls-files -o | git update-index --add --stdin
> 		tree=$(git write-tree)
> 
> 		# tag the first commit found matching that tree, if any
> 		git rev-list master |
> 		while read cmit
> 		do
> 			if git diff-tree --quiet $cmit $tree
> 			then
> 				git tag -a ${tar%%.*} $cmit <&3
> 				break
> 			fi
> 		done
> 	done
> 
> Variation using --numstat and a path filter to find the closest commit
> ignoring some files instead of an exact match left as an exercise to
> the reader.

Nice, thanks!
