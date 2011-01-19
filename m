From: Jonathan Nieder <jrnieder@gmail.com>
Subject: checkout to other directory (Re: [PATCH 3/3] setup: always honor
 GIT_WORK_TREE and core.worktree)
Date: Wed, 19 Jan 2011 14:52:57 -0600
Message-ID: <20110119205257.GA31029@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino>
 <20110119124230.GD23222@burratino>
 <4D373296.6030101@seznam.cz>
 <7v4o94u26f.fsf@alter.siamese.dyndns.org>
 <4D374B04.80500@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Jan 19 21:54:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pff2X-0001oz-6N
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 21:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab1ASUx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 15:53:56 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55624 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab1ASUxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 15:53:55 -0500
Received: by eye27 with SMTP id 27so779288eye.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 12:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=cabKr+UH7w/lc6m/0CK1NqmueL36/JXRtOd1LQ8AAQE=;
        b=o0XhmQAoGHXXnbcu1KKBeiZIk2txai3OzqeLcZ5//15MRyur8rwM9FZay85FskQpbO
         GRcJtqAx7I+er4fUtt7oXz7Ev6Ar4aOkNnv3ZCzG21POZ5tzRfnwesZ1eJWMjQtoD3IV
         UbbXwVGa+SwgB6p2lurlSw86yzO6aala+blkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fuR15BfCxdQ1YwbI/w2eRNyr5uj+g3jNGmteqs849Xj7iOncaiHhxS+LDm8ulCR995
         IjHv5MFY7N/ZZk1+41Fqn1wRhm6bmk6qXJ2CFkfjrjfvemnNPr7sipyJkYpfDgR8nRNj
         OsCZNi3jsX15Nh1yrPZT/4hJnz5MheDHdmTZQ=
Received: by 10.227.133.16 with SMTP id d16mr1450963wbt.145.1295470392126;
        Wed, 19 Jan 2011 12:53:12 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id 7sm3854355wet.24.2011.01.19.12.53.10
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 12:53:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D374B04.80500@seznam.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165293>

Maaartin wrote:

> Actually I did mostly something like
>
> git --work-tree /tmp/somewhere checkout somebranch -- .
>   && winmerge . /tmp/somewhere
>
> at root of my normal work tree as a poor man's replacement for
>
> git difftool somebranch
>
> This is probably no good idea as it mixes up the index.

Right.  I think the simplest (and usual) method is something like

	rm -fr /tmp/somewhere &&
	mkdir -p /tmp/somewhere &&
	git archive somebranch | (cd /tmp/somewhere && tar -xf -)

But suppose that the tracked tree is very big, so that re-creating
/tmp/somewhere each time is expensive.  Then you can do

	(
		GIT_DIR=$(pwd)/.git &&
		GIT_INDEX_FILE=$(pwd)/.git/somewhere-index &&
		export GIT_DIR GIT_INDEX_FILE &&

		cd /tmp/somewhere &&
		git update-index --refresh -q &&
		git read-tree --reset -m -u somebranch
	)

The state of /tmp/somewhere is remembered in the somewhere-index file.

In practice, I tend to use something closer to the following:

	sh /usr/share/doc/git/contrib/git-new-workdir repo /tmp/somewhere &&
	(
		cd /tmp/somewhere &&
		git checkout somebranch^0
	)

See [1] for caveats and future directions.

[1] http://thread.gmane.org/gmane.comp.version-control.git/150559
