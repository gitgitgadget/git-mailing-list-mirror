From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 07:45:00 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901280738430.3123@localhost.localdomain>
References: <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com> <7vvds0z1c1.fsf@gitster.siamese.dyndns.org> <7vk58gz04l.fsf@gitster.siamese.dyndns.org> <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org> <20090128044150.GI1321@spearce.org>
 <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org> <7vvdrzvpwd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 16:47:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSCdv-0003cw-RG
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 16:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbZA1Ppp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 10:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbZA1Ppp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 10:45:45 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33454 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750943AbZA1Ppp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 10:45:45 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0SFj1Jt013500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Jan 2009 07:45:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0SFj0lj021658;
	Wed, 28 Jan 2009 07:45:01 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vvdrzvpwd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107543>



On Tue, 27 Jan 2009, Junio C Hamano wrote:
> 
>  - When digging deeper into the ancestry chain of a commit that is already
>    painted as UNINTERESTING, in order to paint its parents UNINTERESTING,
>    we barfed if parse_parent() for a parent commit object failed.  We can
>    ignore such a parent commit object.

Wouldn't it be better to still mark it UNINTERESTING too?

> @@ -480,7 +483,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
>  			struct commit *p = parent->item;
>  			parent = parent->next;
>  			if (parse_commit(p) < 0)
> -				return -1;
> +				continue;
>  			p->object.flags |= UNINTERESTING;
>  			if (p->parents)
>  				mark_parents_uninteresting(p);

IOW, move that

	p->object.flags |= UNINTERESTING;

to before parse_commit(). That's assuming 'parent' is never NULL, of 
course.

Side note: parse_commit() is still going to print out the error message 
if the object is missing ("Could not read %s"). I guess that's fine, but 
if you really want to make this a "not an error at all" condition...

		Linus
