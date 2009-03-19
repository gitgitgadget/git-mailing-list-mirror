From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Method invokes inefficient new String(String)
	constructor
Date: Thu, 19 Mar 2009 09:01:02 -0700
Message-ID: <20090319160102.GQ23521@spearce.org>
References: <49C20D4E.5020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 17:04:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkKi7-000647-UY
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 17:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbZCSQBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 12:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbZCSQBF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 12:01:05 -0400
Received: from george.spearce.org ([209.20.77.23]:54108 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZCSQBE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 12:01:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3C34738221; Thu, 19 Mar 2009 16:01:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49C20D4E.5020203@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113787>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> From FindBugs:
> Using the java.lang.String(String) constructor wastes memory because
> the object so constructed will be functionally indistinguishable from
> the String passed as a parameter. Just use the argument String directly.
> 
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
>  .../src/org/spearce/jgit/lib/RefDatabase.java      |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> index 87f26bf..49da538 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> @@ -447,7 +447,7 @@ private synchronized void refreshPackedRefs() {
>  
>  					final int sp = p.indexOf(' ');
>  					final ObjectId id = ObjectId.fromString(p.substring(0, sp));
> -					final String name = new String(p.substring(sp + 1));
> +					final String name = p.substring(sp + 1);
>  					last = new Ref(Ref.Storage.PACKED, name, name, id);
>  					newPackedRefs.put(last.getName(), last);

I had a specific reason for forcing a new String object here.

The line in question, p, is from the packed-refs file and
contains the entire SHA-1 in hex form at the beginning of it.
We've converted that into binary as an ObjectId, it uses 1/4 the
space of the string portion.

The Ref object, its ObjectId, and its name string, are going to be
cached in a Map, probably long-term.  We're better off shedding the
80 bytes of memory used to hold the hex SHA-1 then risk substring()
deciding its "faster" to reuse the char[] then to make a copy of it.

-- 
Shawn.
