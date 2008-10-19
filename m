From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH v2] Fix testcase failure when extended attributes are
	in use
Date: Sun, 19 Oct 2008 08:24:19 -0400
Message-ID: <20081019122419.GA2015@riemann.deskinm.fdns.net>
References: <20081011154107.GA14994@riemann.deskinm.fdns.net> <20081014021016.GB14994@riemann.deskinm.fdns.net> <7vbpxig4fb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, heikki.orsila@iki.fi
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 07:33:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrXPn-0002Fz-7T
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 14:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYJSM1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 08:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYJSM1o
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 08:27:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:57659 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYJSM1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 08:27:43 -0400
Received: by yx-out-2324.google.com with SMTP id 8so225855yxm.1
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=ksA5RsQod6GTYbDJ6dMSh1eMxy3Jno85liqU9IQ7jxs=;
        b=SvQxShwxJAuH5LNF97TCdGNgT1V72OlUEehJlit9J1Y9/oh4Z7Z2mCgMqqLf0sy50U
         tHo/q0MXwBw4UZTEJ5gMYlfIn7uo3fnNfBGdBxSggt2q1XzGWiCeFw98ibO7Bipz+T+A
         TMINzmxoA/L0Kc3PFcZwjqgR08yEBWtBzYL5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=MqDyozwuz2L6DeaMFOj/nFRG+2ijDtbFeiH0WC2bfNv7nsnnI1WXDRQIEgpKnLNOGR
         AoRzOVausfTCBPRgqPn3Rb0QLw2AMsbqBoS6o2y8Qr1HoBBORlfLbJmUc+BAw+lRHxOk
         y7EGWJOtKDbfup49S3iXWAaxBsgvsnT742Ay4=
Received: by 10.150.122.13 with SMTP id u13mr9647095ybc.185.1224419262300;
        Sun, 19 Oct 2008 05:27:42 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id n29sm9415144elf.5.2008.10.19.05.27.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 05:27:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbpxig4fb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98614>

On Fri, Oct 17, 2008 at 04:58:16PM -0700, Junio C Hamano wrote:
> With 8ed0a74 (t1301-shared-repo.sh: don't let a default ACL interfere with
> the test, 2008-10-16) applied is this still needed, or can I drop it from
> my review box?

Apologies for a tardy response, was out of town and away from keyboard for a
day.
 
This patch is still needed, as my and Matt's patch are solving two different
issues with t1301.  As he pointed out in the thread regarding his patch, the
issue was that the testcase was intended to specifically test Git's interaction
with permissions set via the umask, but a default ACL on the 'trash directory'
could interfere with this, since they'd override the umask settings.  Remove
the ACL, no problem.

My patch, on the other hand, is to deal with 'ls' output in case a file has
certain filesystem extended attributes.  These could be e.g. POSIX ACLs, or a
SELinux security context, or perhaps others.  If such an extended attribute is
present, 'ls -l' will print permissions with a '+' appended, e.g.
-rw-r--r--+
Instead of
-rw-r--r--
However, t1301 reads permissions output by ls for several tests, and compares
them to string representations such as that above.  Without removing the '+',
if present, the strings will not match.  Furthermore, since this occurs for
other filesystem extended attributes, and not just ACLs, it is not possible to
simply strip all extended attributes from the file in question (with SELinux,
the kernel won't let you remove a file's security context anyway).

For what it's worth, I've experienced this failure on my Ubuntu 8.04 laptop
with SELinux permissive mode, so it's possible ls behaves slightly differently
on other systems; I've not been able to determine this one way or another.
However, I see no harm in accounting for this situation in the general case,
since the typical output of ls on other systems will not be affected nor
modified with this patch.

Hope that helps,
Deskin Miller
