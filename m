From: Tait <git.git@t41t.com>
Subject: Re: using gvim as editor on Windows
Date: Mon, 8 Mar 2010 18:45:23 -0800
Message-ID: <20100309024523.GU2480@ece.pdx.edu>
References: <20100306070628.GM2480@ece.pdx.edu> <201003061317.38422.markus.heidelberg@web.de> <20100308185439.GO2480@ece.pdx.edu> <201003090032.10037.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyUA-0001Do-Bq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab0CICp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 21:45:26 -0500
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:36527 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab0CICp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 21:45:26 -0500
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o292jNIR026654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Mar 2010 18:45:23 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o292jNKX022201;
	Mon, 8 Mar 2010 18:45:23 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o292jN3B022195;
	Mon, 8 Mar 2010 18:45:23 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <201003090032.10037.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ehlo.cat.pdx.edu [131.252.208.106]); Mon, 08 Mar 2010 18:45:23 -0800 (PST)
X-Spam-Status: No, score=-1.0 required=6.0 tests=WCODE_3 autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ehlo.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at ehlo.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141794>

> First of all: do you have the problems in cmd.exe or Git Bash or both?

cmd.exe

I've never used git bash until now, but the behavior is the same there.

> > Does calling the .exe directly work for you? If I call gvim.exe directly
> > (with or without -f -- it doesn't matter), it opens a new file called
> > $@.
> 
> I don't know where the $@ should come from.

It comes from line 33 of editor.c, in launch_editor().
if (strcmp(editor, ":")) {
    /* ... */
    if (strcspn(editor, "$ \t'") != len) {
        /* there are specials */
        strbuf_addf(&arg0, "%s \"$@\"", editor);
        args[i++] = "sh";
        args[i++] = "-c";
        args[i++] = arg0.buf;
    }
    args[i++] = editor;
    args[i++] = path;
    args[i] = NULL;
    /* ... */
}

It looks like this was added to detect EDITOR=: but it also
manages to catch Windows paths. I'm not familiar with the EDITOR=:
convention. What is that supposed to indicate? Can we narrow the
detection to that specific case, or does a : anywhere in EDITOR need
to be handled this way?

Rebase doesn't use launch_editor, instead just calling the editor
directly. Coming up with a combination of quoting and escaping that
can pass both cases will be difficult or impossible.

It appears that e97c9a removed the code above from editor.c, but 
it's still present in prepare_shell_cmd() with even more legal 
filename characters like = and ;.

Thanks for the help Markus.

Tait
