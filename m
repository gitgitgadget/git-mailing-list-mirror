From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 3/4] The git config file is case insensitive
Date: Sun, 12 Oct 2008 19:36:36 -0700
Message-ID: <20081013023636.GK4856@spearce.org>
References: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com> <1223851860-13068-2-git-send-email-robin.rosenberg@dewire.com> <1223851860-13068-3-git-send-email-robin.rosenberg@dewire.com> <1223851860-13068-4-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 04:37:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpDJf-0002XF-7j
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 04:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbYJMCgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 22:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbYJMCgh
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 22:36:37 -0400
Received: from george.spearce.org ([209.20.77.23]:35858 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbYJMCgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 22:36:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3C78B3835F; Mon, 13 Oct 2008 02:36:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223851860-13068-4-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98075>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> index 45c2f8a..7a34cde 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> @@ -682,7 +683,12 @@ public void load() throws IOException {
>  
>  	private void clear() {
>  		entries = new ArrayList<Entry>();
> -		byName = new HashMap<String, Object>();
> +		byName = new TreeMap<String, Object>(new Comparator<String>() {
> +
> +			public int compare(String o1, String o2) {
> +				return o1.compareToIgnoreCase(o2);
> +			}
> +		});
>  	}

This isn't necessary.  Everyone who does a get or a put against the
byName map already is forming a lower case key string.  I'd rather
keep the lookup O(1) than O(log N), especially if the code has a
ton of .toLowerCase() calls in it to normalize the keys.

If you are going to change it to a TreeMap with a custom Comparator
then maybe we should cleanup the code that operates on byName so it
can use the original input strings, instead of the .toLowerCase()
forms.

For now I'm going to apply your patch without this one hunk.  If you
want to switch to a TreeMap lets also cleanup the get/put calls.
  
-- 
Shawn.
