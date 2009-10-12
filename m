From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] disallow refs containing successive slashes
Date: Sun, 11 Oct 2009 19:31:15 -0500
Message-ID: <20091012003115.GA5782@progeny.tock>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <4AD1B6A4.8060405@web.de>
 <7vbpkdwyo2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 02:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx8nb-0005L9-M2
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 02:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbZJLAXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 20:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbZJLAX3
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 20:23:29 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:54803 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbZJLAX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 20:23:29 -0400
Received: by ywh6 with SMTP id 6so7758012ywh.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7AW/bCDFNJ1Og6WI+EjuxfuwRDj9FGU6L1KcQ2YgQqk=;
        b=PF07Ss39tJEPk8bo+4MztFMfmy/P4fCwFOFSx/Lz6IHF1AMXpjAUVyHydAUWZEh/vl
         5+9i2mHE02DwfrY35qE8UJ74whbqPKQ0bSgf1AElT1dLuS3nsiwSgEDHKHXkLdClQuJ5
         V6ABjlkv7xtXJiVpVgGQmCm+TrXkKZ4wQlzUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bb8mEuAf3dngYFWf3lFnj7aKpjdpO0sxv5rB/HsZafH35sqLShzxWAdRo1R0N1l7Q0
         n5T+P2t2T7SkEyeM3AWwS5vN+KBD8Ek/QdZQxrVM+LHEQHwGohFP6JF+Y41Ag3YK/Y01
         cDdKWExXL6PWzIz8A7KFLz7QigNpZzRCcPERo=
Received: by 10.151.28.10 with SMTP id f10mr8882798ybj.323.1255306972857;
        Sun, 11 Oct 2009 17:22:52 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm257783gxk.3.2009.10.11.17.22.51
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 17:22:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbpkdwyo2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129966>

Junio C Hamano wrote:
 
> When the users make typoes (e.g. /foo//bar) you can accept the only sane
> correction (e.g. foo/bar) instead of rejecting, since the only thing the
> user can do after getting such a rejection is to correct it to that
> corrected name (e.g. foo/bar) himself and re-issue the command anyway.
> You can push the "hassle" down to the user, or you can fix the tool to
> remove the hassle from the user.

Yes, making check-ref-format stricter without changing its users to
massage their input would be a regression.

The problem Jens described is a git-gui bug.  In lib/branch_delete.tcl,
line 57, the list of deletable branches is populated as follows:

	foreach h [load_all_heads] {
		if {$h ne $current_branch} {
			$w_heads insert end $h
		}
	}

Since slashes coalesce, a user-supplied new branch name is not canonical
and checking "$h eq $current_branch" does not actually check if they are
the same branch.  git-gui should be using the branch name as output by
"git check-ref-format --branch" after the branch is created.

But what about other scripts that assume each branch has only one
possible name?  Maybe they could be forced to fix up the name early on
by making check-ref-format reject names with "//" in them and providing
a "git check-ref-format --print" to help.

Upside: scripts would complain loudly instead of failing subtly on input
with extra slashes if they forget to use "git check-ref-format --print"
when appropriate.  Downside: users, including the 22 callers of
check_ref_format() in git, would have to be checked and probably changed
to avoid regressions.

Never having made that typo, I find it hard to consider such a change
worth the trouble, but it sounds doable.

Regards,
Jonathan
