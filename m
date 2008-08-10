From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] jgit: create a branch command
Date: Sat, 9 Aug 2008 19:27:13 -0700
Message-ID: <20080810022713.GB22137@spearce.org>
References: <1218261868-6508-1-git-send-email-charleso@charleso.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: charleso@gmail.com, git@vger.kernel.org
To: Charles O'Farrell <charleso@charleso.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 04:28:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS0fJ-0001A4-GO
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 04:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbYHJC1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 22:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbYHJC1O
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 22:27:14 -0400
Received: from george.spearce.org ([209.20.77.23]:57558 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbYHJC1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 22:27:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0ADC438420; Sun, 10 Aug 2008 02:27:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1218261868-6508-1-git-send-email-charleso@charleso.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91800>

Charles O'Farrell <charleso@charleso.org> wrote:
> This command lists the existing branches, highlighting the current branch with an asterisk. Currently only the -r and -a options are supported.
> 
> Signed-off-by: Charles O'Farrell <charleso@charleso.org>

Looks good, thanks.

> diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
> index 1ff5a30..734de3d 100644
> --- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
> +++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
> @@ -1,3 +1,4 @@
> +org.spearce.jgit.pgm.Branch
>  org.spearce.jgit.pgm.DiffTree
>  org.spearce.jgit.pgm.Fetch
>  org.spearce.jgit.pgm.Glog
> diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
> new file mode 100644
> index 0000000..8415fe2
> --- /dev/null
> +++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
> @@ -0,0 +1,83 @@
> +/*
> + * Copyright (C) 2007, Charles O'Farrell <charleso@charleso.org>
> + *
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or
> + * without modification, are permitted provided that the following
> + * conditions are met:
> + *
> + * - Redistributions of source code must retain the above copyright
> + *   notice, this list of conditions and the following disclaimer.
> + *
> + * - Redistributions in binary form must reproduce the above
> + *   copyright notice, this list of conditions and the following
> + *   disclaimer in the documentation and/or other materials provided
> + *   with the distribution.
> + *
> + * - Neither the name of the Git Development Community nor the
> + *   names of its contributors may be used to endorse or promote
> + *   products derived from this software without specific prior
> + *   written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> + * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
> + * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> + * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> + * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +package org.spearce.jgit.pgm;
> +
> +import java.util.Map;
> +import java.util.TreeSet;
> +
> +import org.kohsuke.args4j.Option;
> +import org.spearce.jgit.lib.Constants;
> +import org.spearce.jgit.lib.Ref;
> +
> +@Command(common = true, usage = "List, create, or delete branches")
> +class Branch extends TextBuiltin {
> +
> +	@Option(name = "--remote", aliases = { "-r" }, usage = "act on remote-tracking branches")
> +	boolean remote = false;
> +
> +	@Option(name = "--all", aliases = { "-a" }, usage = "list both remote-tracking and local branches")
> +	boolean all = false;
> +
> +	@Override
> +	protected void run() throws Exception {
> +		Map<String, Ref> refs = db.getAllRefs();
> +		Ref head = refs.get(Constants.HEAD);
> +		// This can happen if HEAD is stillborn
> +		if (head != null) {
> +			String current = head.getName();
> +			if (current.equals(Constants.HEAD))
> +				printHead("(no branch)", true);
> +			for (String ref : new TreeSet<String>(refs.keySet())) {
> +				if (isHead(ref))
> +					printHead(ref, current.equals(ref));
> +			}
> +		}
> +	}
> +
> +	private boolean isHead(String key) {
> +		return (all || !remote) && key.startsWith(Constants.HEADS_PREFIX)
> +				|| (all || remote) && key.startsWith(Constants.REMOTES_PREFIX);
> +	}
> +
> +	private void printHead(String ref, boolean isCurrent) {
> +		out.print(isCurrent ? '*' : ' ');
> +		out.print(' ');
> +		ref = ref.substring(ref.indexOf('/', 5) + 1);
> +		out.println(ref);
> +	}
> +}

-- 
Shawn.
