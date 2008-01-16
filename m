From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 20:22:11 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
 <alpine.LNX.1.00.0801152256480.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:23:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzo5-0003gW-Rj
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757447AbYAPEWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYAPEWu
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:22:50 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40208 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363AbYAPEWt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 23:22:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G4MCkF009367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 20:22:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G4MBxe020017;
	Tue, 15 Jan 2008 20:22:11 -0800
In-Reply-To: <alpine.LNX.1.00.0801152256480.13593@iabervon.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.218 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70623>



On Tue, 15 Jan 2008, Daniel Barkalow wrote:
> 
> I don't think --no-prefix is sufficient for submodules; it means that 
> git-apply will accidentally remove exactly one level, but if your 
> submodule is two directory levels down, it won't work, and having the 
> effective prefixes be "gitweb" and "gitweb" is a little hackish. You'd 
> really want to generate a -p1 patch whose root is shifted from the actual 
> project root, not a -p0 patch or -p2 patch or something.

.. and this is *exactly* what

	cd gitweb
	git diff --src-prefix=a/gitweb/ --dst-prefix=b/gitweb/ 

would do (obviously people wouldn't do this by hand - it would be 
something that is done by the "git diff" hitting a subproject).

The point is, Junio's patch suggestion tied that prefix together with the 
"gitness" of the patch, so Junio's patch would have broken the above: git 
would decide that since it's not a standard -p1 prefix, it's not a git 
diff, so it shouldn't have "--git" in it.

That's why tying "--git" together with any prefix handling is wrong: 
because it's a totally different issue. It's true that "git-apply" right 
now doesn't understand these things, but assuming we want to teach 
git-apply to apply to subprojects eventually (we do, don't we?) we'll 
eventually have to teach it.

			Linus
