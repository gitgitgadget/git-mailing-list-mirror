From: John Keeping <john@keeping.me.uk>
Subject: Re: determine name of tag used for checkout when multiple tags exist?
Date: Fri, 4 Sep 2015 08:54:00 +0100
Message-ID: <20150904075400.GA27660@serenity.lan>
References: <CAL3By-8odLE53iBiNATgiCcnK4Ef5uBeH7E6EMB1K7P-oX0oAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jesse Hopkins <jesse.hops@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXlpB-0002Ps-PY
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 09:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbbIDHyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 03:54:12 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34294 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbbIDHyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 03:54:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 537E6CDA55E;
	Fri,  4 Sep 2015 08:54:11 +0100 (BST)
X-Quarantine-ID: <9xnyh3yOesBc>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9xnyh3yOesBc; Fri,  4 Sep 2015 08:54:10 +0100 (BST)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id BCF9FCDA5D1;
	Fri,  4 Sep 2015 08:54:05 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAL3By-8odLE53iBiNATgiCcnK4Ef5uBeH7E6EMB1K7P-oX0oAQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277292>

On Thu, Sep 03, 2015 at 08:53:16PM -0600, Jesse Hopkins wrote:
> Looking for suggestions on how to determine the tag that was used to
> checkout a git repo to its associated commit, particularly in the case
> where multiple tags might point to the same commit.
> 
> I've had a look at git-name-rev and git-describe, and both seem useful so
> long as there's only one tag pointing to the commit of interest.  However,
> I'm still coming up to speed on their behavior in the multiple tag case
> (mainly by experimentation).
> 
> It seems to me that when checking out to a tag, Git does not record the
> *name* of the tag anywhere, but rather sets HEAD to the de-referenced
> commit SHA-1.  As far as I can tell, it is not possible to recover the
> original name of the tag in the case of multiple tags on the same commit.
> Is my conclusion correct?
> 
> The reason I ask is that we have a build environment where it is likely
> that multiple tags will get set by various groups in our main 'truth' Git
> repo.  We are using some scripting that would like to know the *name* of
> the tag used for checkout (this has been working well for us so far as long
> as we checkout against branches).
> 
> Is there perhaps some other means of doing a checkout to tag that DOES
> record the name of the tag?  If not, I imagine we might need some external
> means to record the checked out tag, which is not out of the question.

Have you considered looking in the reflog?

When I checkout a tag, "git reflog -1" gives something like:

	989d251 HEAD@{0}: checkout: moving from master to v0.9.2

Since whitespace isn't permitted in tag names you can do something like:

	tag=$(git reflog -1)
	tag=${tag##* }
	git cat-file tag "$tag" >/dev/null 2>&1 || echo "not a tag!"
