From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make sure diff-helper can tell rename/copy in the new
 diff-raw format.
Date: Mon, 23 May 2005 12:03:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:00:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaI9t-0002AB-CT
	for gcvg-git@gmane.org; Mon, 23 May 2005 21:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVEWTBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 15:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVEWTBh
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 15:01:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:10135 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261899AbVEWTBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 15:01:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4NJ1FjA009027
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 12:01:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4NJ1FYm013488;
	Mon, 23 May 2005 12:01:15 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Junio C Hamano wrote:
> 
> Human readable form should omit two->path and later fields
> altogether if one->path == two->path, so the above becomes:
> 
> in-place edit  :100644 100644 bcd1234... 0123456... file0
> copy-edit      :100644 100644 abcd123... 1234567... file1 file2 C 68
> rename-edit    :100644 100644 abcd123... 1234567... file1 file3 R 86
> create         :000000 100644 0000000... 1234567... file4
> delete         :100644 000000 1234567... 0000000... file5
> unmerged       :000000 000000 0000000... 0000000... file6

I'm ok with that format, although I'd actually prefer the "what happened"  
thing to come before the pathnames in the "fixed size" section, something
like

in-place edit  :100644 100644 bcd1234... 0123456... M file0
copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
create         :000000 100644 0000000... 1234567... N file4
delete         :100644 000000 1234567... 0000000... D file5
unmerged       :000000 000000 0000000... 0000000... U file6

because having it there makes it just easier to parse, and means that we 
can add "reasons" later without having to worry about ambiguities with 
filenames. It means, for example, that the chacter that describes what 
that line does _always_ comes at the same byte offset in the line. That's 
just very convenient for everybody.

(In the above, I left the "similarity index" thing in, but it's not
important for the algorithm, and you could leave it out. It's nice for
debugging, and the major reason to not have it is the fact that it makes 
for non-constant format offsets for the first filename).

			Linus
