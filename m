From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn: mangle refnames forbidden in git
Date: Thu, 8 Jul 2010 03:43:57 -0500
Message-ID: <20100708084356.GA29856@burratino>
References: <4BE3249B.7050100@theblacksun.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Torsten Schmutzler <git-ts@theblacksun.eu>
X-From: git-owner@vger.kernel.org Thu Jul 08 10:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWmiv-0004tQ-Ph
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 10:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab0GHIoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 04:44:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34972 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab0GHIon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 04:44:43 -0400
Received: by iwn7 with SMTP id 7so669321iwn.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Q1ynGHRywH1In3m7ItbmjXxxWx1evP2tqC36deSIoQk=;
        b=jm30CAoakvGY23gXqay9gQ1eu/GN/z7cHolfhC4Plvs1q2fLSClZRgNNGoex5eBaxM
         Nb0lJ+FMbqqWLT5wbKk8DNWOczB/53iFGlJwWF+e+DtSEJ6XcdcVxGnqyO62Qkwrwnr7
         KPeGdxxqpc5JEGjmIGinHfUyTEw8DPT+Hs+s0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nFssQBoAMst3tkWQIswZBtutUbr2r5uZOQJ242Wkx5oyDKAwCSbw1OCuGfP7gVFhS3
         X7cSszwFtD47l+bniwU3nqHyX3kGes779JZXCKcZBQWRFeDKUyPTNLvruMeVw1JUp2zQ
         uszxkXEpVEU/+MKiTPHdZR3OFZnov51vdeheI=
Received: by 10.231.157.73 with SMTP id a9mr8377038ibx.123.1278578682431;
        Thu, 08 Jul 2010 01:44:42 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm33108738ibh.4.2010.07.08.01.44.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 01:44:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE3249B.7050100@theblacksun.eu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150549>

t9118-git-svn-funky-branch-names.sh fails for me:

 [...]
 3402a8497588142722deb77f6e4f42b6caaabc85
 refs/remotes/not-a%40{0}reflog
 fatal: ambiguous argument 'refs/remotes/not-a%40{0}reflog': unknown revision or path not in the working tree.
 Use '--' to separate paths from revisions
 not ok - 2 test clone with funky branch names

More precisely, the failure occurs in the

 	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
			"$svnrepo/pr ject/branches/not-a@{0}reflog" &&

line in that test: I think svn is handling the @ itself here.

 $ svnadmin create /tmp/foo
 $ svn checkout file:///tmp/foo wc
 Checked out revision 0.
 $ echo hello >wc/source
 $ (cd wc && svn add source)
 A         source
 $ (cd wc && svn commit -m one)
 Adding         source
 Transmitting file data .
 Committed revision 1.
 $ svn cp -m reflog file:///tmp/foo/source 'file:///tmp/foo/not-a@{0}reflog'
 Committed revision 2.
 $ (cd wc && svn update)
 A    not-a
 Updated to revision 2.

 $ svn --version
 svn, version 1.6.12 (r955767)
    compiled Jun 21 2010, 20:24:54
 [...]

Ideas?
