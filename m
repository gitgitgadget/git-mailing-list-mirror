From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths
 scanning
Date: Wed, 5 Feb 2014 23:14:27 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140205191427.GA3923@mini.zxlink>
References: <cover.1391430523.git.kirr@mns.spb.ru>
 <c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
 <xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
 <xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
 <20140204163400.GA20436@tugrik.mns.mnsspb.ru>
 <xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
 <20140205165119.GA18558@tugrik.mns.mnsspb.ru>
 <xmqqfvnx5umg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:12:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB7t8-0004YJ-J1
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbaBETLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:11:55 -0500
Received: from forward12.mail.yandex.net ([95.108.130.94]:60944 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaBETLy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:11:54 -0500
Received: from smtp11.mail.yandex.net (smtp11.mail.yandex.net [95.108.130.67])
	by forward12.mail.yandex.net (Yandex) with ESMTP id EE873C220CB;
	Wed,  5 Feb 2014 23:11:49 +0400 (MSK)
Received: from smtp11.mail.yandex.net (localhost [127.0.0.1])
	by smtp11.mail.yandex.net (Yandex) with ESMTP id ABC7F7E0098;
	Wed,  5 Feb 2014 23:11:49 +0400 (MSK)
Received: from unknown (unknown [78.25.120.235])
	by smtp11.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ReBwroaKyu-BlB0fLIQ;
	Wed,  5 Feb 2014 23:11:47 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: c4716e2a-67d4-4bdb-bb7f-46cec7f966cf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1391627509; bh=NyN5lVQX60uw3Uj0NUQVtzJYprLXxhxIaSzMLQ1MmUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=r6c8PHG7NJBQw/iBs/LczaIpgBkzUxuuyGa5Qu+xIlk/H21g4F8jDYJmJdH1h5mZ0
	 fRn40o6cFGoiE7y4x7gesfRl7HWSEve7BehN/95+UDzjZJzgLfYFopR7vpzQEQY1YY
	 vIfhkVMQwTk3gjmcCYdC4fZoRuev48h2lDW5Kr0c=
Authentication-Results: smtp11.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WB7vX-000158-CL; Wed, 05 Feb 2014 23:14:27 +0400
Content-Disposition: inline
In-Reply-To: <xmqqfvnx5umg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241637>

On Wed, Feb 05, 2014 at 09:36:55AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > Only, before I clean things up, I'd like to ask - would the following
> > patch be accepted
> >
> > ---- 8< ---
> > diff --git a/tree-walk.c b/tree-walk.c
> > index 79dba1d..4dc86c7 100644
> > --- a/tree-walk.c
> > +++ b/tree-walk.c
> > @@ -37,7 +37,7 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
> >  
> >  	/* Initialize the descriptor entry */
> >  	desc->entry.path = path;
> > -	desc->entry.mode = mode;
> > +	desc->entry.mode = canon_mode(mode);
> >  	desc->entry.sha1 = (const unsigned char *)(path + len);
> >  }
> >  
> > diff --git a/tree-walk.h b/tree-walk.h
> > index ae04b64..ae7fb3a 100644
> > --- a/tree-walk.h
> > +++ b/tree-walk.h
> > @@ -16,7 +16,7 @@ struct tree_desc {
> >  static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
> >  {
> >  	*pathp = desc->entry.path;
> > -	*modep = canon_mode(desc->entry.mode);
> > +	*modep = desc->entry.mode;
> >  	return desc->entry.sha1;
> >  }
> > ---- 8< ---
> >  
> > ?
> 
> Doesn't desc point into and walks over the data we read from the
> tree object directly?
> 
> We try to keep (tree|commit)->buffer intact and that is done pretty
> deliberately.  While you are walking a tree or parsing a commit,
> somebody else, perhaps called indirectly by a helper function you
> call, may call lookup_object() for the same object, get the copy
> that has already been read and start using it.  This kind of change
> will introduce bugs that are hard to debug unless it is done very
> carefully (e.g. starting from making tree.buffer into a const pointer
> and propagating constness throughout the system), which might not be
> worth the pain.

I agree object data should be immutable for good. The only thing I'm talking
about here is mode, which is parsed from a tree buffer and is stored in
separate field:

        ---- 8< ---- tree-walk.h
        struct name_entry {
                const unsigned char *sha1;
                const char *path;
                unsigned int mode;              <---
        };

        struct tree_desc {
                const void *buffer;
                struct name_entry entry;
                unsigned int size;
        };

        ---- 8< ---- tree-walk.c
        const char *get_mode(const char *str, unsigned int *modep)
        { ... }     /* parses symbolic mode from tree buffer to uint */

        void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size)
        {
                const char *path;
                unsigned int mode, len;

                ...
                path = get_mode(buf, &mode);

                /* Initialize the descriptor entry */
                desc->entry.path = path;
                desc->entry.mode = mode;        <---
                desc->entry.sha1 = (const unsigned char *)(path + len);


so we are not talking about modifying object buffers here. All I'm
asking is about canonicalizing _already_ parsed and copied mode on the
fly.

Does that change anything?


Sorry, if I'm maybe misunderstanding something, and thanks,
Kirill
