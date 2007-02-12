From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 15:25:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121514500.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702121505560.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkXs-0006k8-SM
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbXBLXZM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbXBLXZM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:25:12 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47028 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030479AbXBLXZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:25:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1CNP1hB030186
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Feb 2007 15:25:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1CNP0fB015138;
	Mon, 12 Feb 2007 15:25:01 -0800
In-Reply-To: <Pine.LNX.4.64.0702121505560.8424@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.424 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39455>



On Mon, 12 Feb 2007, Linus Torvalds wrote:
> 
> But it shouldn't be a problem. We'll always know which one matters: the 
> index case is always about pure stat information (and has no meaning 
> outside of that, really - after all, it's no different from st_mode etc, 
> and we actually keep it in a special binary format that is endian-safe!) 
> and the "real object" case is always about the *data* we use to compare 
> with.

In fact, for git-update-index, I think it's *literally* as easy as just 
changing "index_fd()" to convert the buffer on-the-fly as needed, before 
we actually call "write_sha1_file()" or "hash_sha1_file()".

So we'd just need to pass in the information about whether it's binary or 
not, and then do something like

	@@ -2091,6 +2091,10 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, con
	 
	 	if (!type)
	 		type = blob_type;
	+#ifndef __UNIX__
	+	if (text && !strcmp(type, blob_type))
	+		convert_crlf_to_lf(&buf, &size);
	+#endif
	 	if (write_object)
	 		ret = write_sha1_file(buf, size, type, sha1);
	 	else

and that would take care of a lot of things (yeah, I'd not do it that way 
in practice, but really doesn't look that nasty - it's actually much 
nastier to have to look up the text/binary type in the first place).

Something similar looks to be true in diff generation. The core "compare 
two SHA1's at a time" doesn't need any changes, but the code that actually 
reads in the temporary file from disk obviously does. But even that is 
just _one_ point, afaik - diff_populate_filespec()":

	@@ -1362,6 +1362,10 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
	 		if (fd < 0)
	 			goto err_empty;
	 		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
	+#ifndef __UNIX__
	+		if (text)
	+			convert_crlf_to_lf(&s->data, &s->size);
	+#endif
	 		close(fd);
	 		s->should_munmap = 1;
	 	}

(and again, that's not real code, it would also need to change the 
"should_munmap" flag to indicate the state of the _new_ "data" thing.

		Linus
