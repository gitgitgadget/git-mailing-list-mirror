From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: update-index --index-info producing spurious submodule commits
Date: Fri, 19 Aug 2011 21:15:15 -0500
Message-ID: <20110820021430.GA14281@elie.sbx02827.chicail.wayport.net>
References: <rmivctuv12s.fsf@fnord.ir.bbn.com>
 <7vd3g272tk.fsf@alter.siamese.dyndns.org>
 <rmiliuq2qlg.fsf@fnord.ir.bbn.com>
 <7vpqk2593g.fsf@alter.siamese.dyndns.org>
 <rmi39gxacp1.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Richard Hansen <rhansen@bbn.com>
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 04:18:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qub94-0003RC-B1
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 04:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab1HTCPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 22:15:25 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:59275 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab1HTCPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 22:15:24 -0400
Received: by pzk37 with SMTP id 37so5790609pzk.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=htipSLfAgxC4u3Cw61g89hkuvAyPq62u07OdmbyDWnM=;
        b=TnUIUzX3ul5elZCSDp0wLR2zsLL1G6ZvJwDdaghb86JrfkWXmkdp6DRzjEJD/PMOJI
         ETyrbcl3Fph7kRUmNbV0QirSuflNUT0DEABHUJZQsqTlnoklISJrHul3lYVXPRmMkv0J
         91OCdVfXOphNZDDgLU7XBV01niXDkaVhiTlOw=
Received: by 10.142.195.14 with SMTP id s14mr48027wff.1.1313806524347;
        Fri, 19 Aug 2011 19:15:24 -0700 (PDT)
Received: from elie.sbx02827.chicail.wayport.net ([64.134.196.199])
        by mx.google.com with ESMTPS id g4sm2801624pbj.89.2011.08.19.19.15.22
        (version=SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 19:15:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <rmi39gxacp1.fsf@fnord.ir.bbn.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179749>

Greg Troxel wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> "ls-tree -r HEAD foo" is probably what you meant to say.
>
> Thanks very much for the clue - that works.  The update-index
> documentation should probably say that only blobs (or perhaps commits
> intended to be submodules??) are acceptable, and perhaps say "ls-tree
> -r" instead of ls-tree.

Makes sense.  Please make it so.

By the way, for this particular application I wonder if something like

	git ls-files -z <dir> | git update-index -z --force-remove --stdin
	git read-tree --prefix=<dir>/ <tree>

would be easier.  Or a commit-filter. :)

	tree=$1
	shift
	tree=$(
		git ls-tree -z "$tree" |
		perl -0ne '
			chop;
			my ($info, $name) = split(/\t/, $_, 2);
			if ($name eq "<dir>") {
				printf("040000 tree <good tree>\t<dir>\0");
			} else {
				printf("%s\0", $_);
			}
		' |
		git mktree -z
	)
	git commit-tree "$tree" "$@"

Thanks,
Jonathan
